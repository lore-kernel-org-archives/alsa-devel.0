From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ASoC: rt5645: add fallback case for jack
 detection support
Date: Wed, 3 Jan 2018 23:20:38 +0100
Message-ID: <6b845088-9900-789c-1137-811321e23252@redhat.com>
References: <20180103184241.11690-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 775D12676A9
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 23:20:40 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id g130so21937916wme.0
 for <alsa-devel@alsa-project.org>; Wed, 03 Jan 2018 14:20:40 -0800 (PST)
In-Reply-To: <20180103184241.11690-1-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 03-01-18 19:42, Pierre-Louis Bossart wrote:
> Commit 78f5605c0329 ("ASoC: rt5645: cleanup DMI matching code") did a
> lot of useful cleanups, but the logic is a bit flawed: if there is no
> DMI match on an ACPI machine, the code reads non-existent properties.

Reading non existent properties is not a problem, notice that the check
only checks if one of the properties is present, the others may still
be unset, which is fine, then the code reading the properties will leave
everything 0 / false.
> Re-add previous code that checked for the existence of those
> properties and a fallback mode to enable jd-mode3 if there is no
> pdata, device property or quirk. This will help avoid having to add
> new DMI quirks when only the jd-mode is needed for headset playback.

Note I do think that defaulting to jd_mode = 3 is a good idea,
I just believe that the commit message wrongly give the impression
that reading non-existent props is a problem.

> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Bard Liao <bardliao@realtek.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   sound/soc/codecs/rt5645.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> index ebc4f5970f24..476020445f65 100644
> --- a/sound/soc/codecs/rt5645.c
> +++ b/sound/soc/codecs/rt5645.c
> @@ -3687,6 +3687,17 @@ static const struct dmi_system_id dmi_platform_data[] = {
>   	{ }
>   };
>   
> +static bool rt5645_check_dp(struct device *dev)
> +{
> +	if (device_property_present(dev, "realtek,in2-differential") ||
> +	    device_property_present(dev, "realtek,dmic1-data-pin") ||
> +	    device_property_present(dev, "realtek,dmic2-data-pin") ||
> +	    device_property_present(dev, "realtek,jd-mode"))
> +		return true;
> +
> +	return false;
> +}
> +
>   static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct device *dev)
>   {
>   	rt5645->pdata.in2_diff = device_property_read_bool(dev,
> @@ -3727,8 +3738,10 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
>   
>   	if (pdata)
>   		rt5645->pdata = *pdata;
> -	else
> +	else if (rt5645_check_dp(&i2c->dev))
>   		rt5645_parse_dt(rt5645, &i2c->dev);
> +	else
> +		rt5645->pdata = jd_mode3_platform_data;

How about:

		rt5645->pdata.jd_mode = 3;

instead and remove jd_mode3_platform_data and the 2 dmi table entries
pointing to it ?

Regards,

Hans



>   
>   	if (quirk != -1) {
>   		rt5645->pdata.in2_diff = QUIRK_IN2_DIFF(quirk);
> 
