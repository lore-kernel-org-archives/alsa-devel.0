From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH V2 1/4] regmap: cache: Add "was_reset" argument to regcache_sync_region()
Date: Sat, 25 Apr 2015 13:27:13 +0200
Message-ID: <553B7A11.7040706@metafoo.de>
References: <1429915008-22015-1-git-send-email-cernekee@chromium.org> <1429915008-22015-2-git-send-email-cernekee@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429915008-22015-2-git-send-email-cernekee@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>, lgirdwood@gmail.com, broonie@kernel.org
Cc: dgreid@chromium.org, abrestic@chromium.org, olofj@chromium.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 04/25/2015 12:36 AM, Kevin Cernekee wrote:
> regcache_sync() and regcache_sync_region() currently assume that the
> hardware has just emerged from a clean reset, and that all registers are
> in their default states.  But that isn't the only possibility; the device
> may have been in a different state in which the registers were
> inaccessible but have retained their contents, e.g. clock gating.
>
> So we will extend the more versatile of the two functions,
> regcache_sync_region(), to let the caller decide what assumptions should
> be made.
>
> One driver that can benefit from this is adau1977, which has hacks to
> overwrite the registers that regcache_sync() might have missed.

The issue with the adau1977 is slightly different, there is only one single 
register which is not affected, so we need special handling for that 
register. For all other registers the default behavior of regcache_sync() is 
correct.

> Also, the powerdown pin on tas571x does not reset the register contents
> either, so a similar feature will be required by that driver.
>
> This commit just adds the new argument by changing the function
> declarations and call sites, but doesn't wire it up yet.

I think a better approach is to introduce a new flag internally, similar to 
the cache_dirty flag. Set both this new flag and cache_dirty when 
regcache_mark_dirty() is called. But only cache_dirty when a write is 
performed when the regmap is marked as cache only. Now in regcache_sync() 
and friends check this new flag and only when it is set skip registers which 
match the default. At the end of regcache_sync() clear both flags.

[...]
> @@ -600,7 +605,8 @@ static bool regcache_reg_present(unsigned long *cache_present, unsigned int idx)
>   static int regcache_sync_block_single(struct regmap *map, void *block,
>   				      unsigned long *cache_present,
>   				      unsigned int block_base,
> -				      unsigned int start, unsigned int end)
> +				      unsigned int start, unsigned int end,
> +				      bool was_reset)
>   {
>   	unsigned int i, regtmp, val;
>   	int ret;
> @@ -614,10 +620,12 @@ static int regcache_sync_block_single(struct regmap *map, void *block,
>
>   		val = regcache_get_val(map, block, i);
>
> -		/* Is this the hardware default?  If so skip. */
> -		ret = regcache_lookup_reg(map, regtmp);
> -		if (ret >= 0 && val == map->reg_defaults[ret].def)
> -			continue;
> +		if (was_reset) {
> +			/* Is this the hardware default?  If so skip. */
> +			ret = regcache_lookup_reg(map, regtmp);
> +			if (ret >= 0 && val == map->reg_defaults[ret].def)
> +				continue;
> +		}

Probably factor the check whether wee need to sync or not into a helper 
function, that can be used here and below in sync_block_raw().

[...]
> @@ -689,14 +697,17 @@ static int regcache_sync_block_raw(struct regmap *map, void *block,
>
>   		val = regcache_get_val(map, block, i);
>
> -		/* Is this the hardware default?  If so skip. */
> -		ret = regcache_lookup_reg(map, regtmp);
> -		if (ret >= 0 && val == map->reg_defaults[ret].def) {
> -			ret = regcache_sync_block_raw_flush(map, &data,
> -							    base, regtmp);
> -			if (ret != 0)
> -				return ret;
> -			continue;
> +		if (was_reset) {
> +			/* Is this the hardware default?  If so skip. */
> +			ret = regcache_lookup_reg(map, regtmp);
> +			if (ret >= 0 && val == map->reg_defaults[ret].def) {
> +				ret = regcache_sync_block_raw_flush(map, &data,
> +								    base,
> +								    regtmp);
> +				if (ret != 0)
> +					return ret;
> +				continue;
> +			}
>   		}
>
[...]
