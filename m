From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH V3 1/4] regmap: Use regcache_mark_dirty() to indicate
 power loss or reset
Date: Mon, 04 May 2015 08:38:21 +0200
Message-ID: <554713DD.4020006@metafoo.de>
References: <1430697619-22773-1-git-send-email-cernekee@chromium.org> <1430697619-22773-2-git-send-email-cernekee@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430697619-22773-2-git-send-email-cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 05/04/2015 02:00 AM, Kevin Cernekee wrote:
> Existing regmap users call regcache_mark_dirty() as part of the
> suspend/resume sequence, to tell regcache that non-default values need to
> be resynced post-resume.  Add an internal "no_sync_defaults" regmap flag
> to remember this state, so that regcache_sync() can differentiate between
> these two cases:
>
> 1) HW was reset, so any cache values that match map->reg_defaults can be
> safely skipped.  On some chips there are a lot of registers in the
> reg_defaults list, so this optimization speeds things up quite a bit.
>
> 2) HW was not reset (maybe it was just clock-gated), so if we cached
> any writes, they should be sent to the hardware regardless of whether
> they match the HW default.  Currently this will write out all values in
> the regcache, since we don't maintain per-register dirty bits.
>
> Suggested-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>   drivers/base/regmap/internal.h |  3 +++
>   drivers/base/regmap/regcache.c | 61 ++++++++++++++++++++++++++++--------------
>   2 files changed, 44 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
> index a13587b5c2be..b2b2849fc6d3 100644
> --- a/drivers/base/regmap/internal.h
> +++ b/drivers/base/regmap/internal.h
> @@ -131,7 +131,10 @@ struct regmap {
>   	struct reg_default *reg_defaults;
>   	const void *reg_defaults_raw;
>   	void *cache;
> +	/* if set, the cache contains newer data than the HW */
>   	u32 cache_dirty;
> +	/* if set, the HW registers are known to match map->reg_defaults */
> +	bool no_sync_defaults;
>
>   	struct reg_default *patch;
>   	int patch_regs;
> diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
> index 7eb7b3b98794..63af3103d0c6 100644
> --- a/drivers/base/regmap/regcache.c
> +++ b/drivers/base/regmap/regcache.c
> @@ -253,6 +253,9 @@ static int regcache_default_sync(struct regmap *map, unsigned int min,
>   				 unsigned int max)
>   {
>   	unsigned int reg;
> +	bool no_sync_defaults = map->no_sync_defaults;
> +
> +	map->no_sync_defaults = false;

This needs to be done at the end in regcache_sync(), the same place where 
dirty is set to false.

>
>   	for (reg = min; reg <= max; reg += map->reg_stride) {
>   		unsigned int val;
> @@ -266,10 +269,12 @@ static int regcache_default_sync(struct regmap *map, unsigned int min,
>   		if (ret)
>   			return ret;
>
> -		/* Is this the hardware default?  If so skip. */
> -		ret = regcache_lookup_reg(map, reg);
> -		if (ret >= 0 && val == map->reg_defaults[ret].def)
> -			continue;
> +		if (no_sync_defaults) {
> +			/* Is this the hardware default?  If so skip. */
> +			ret = regcache_lookup_reg(map, reg);
> +			if (ret >= 0 && val == map->reg_defaults[ret].def)
> +				continue;
> +		}

This should go into a helper function regacache_reg_needs_sync() so it can 
be reused at the other places where the same logic is needed.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
