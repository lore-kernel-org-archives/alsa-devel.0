From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] ASoC: rt5645: add fallback case for
 jack detection support
Date: Thu, 11 Jan 2018 21:13:01 +0100
Message-ID: <9d58699f-1b12-c66f-cae4-7e541884b851@redhat.com>
References: <20180111200511.7541-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
 [209.85.128.195])
 by alsa0.perex.cz (Postfix) with ESMTP id B09E5266E62
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 21:13:03 +0100 (CET)
Received: by mail-wr0-f195.google.com with SMTP id g21so3334376wrb.13
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 12:13:03 -0800 (PST)
In-Reply-To: <20180111200511.7541-1-pierre-louis.bossart@linux.intel.com>
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

On 11-01-18 21:05, Pierre-Louis Bossart wrote:
> Commit 78f5605c0329 ("ASoC: rt5645: cleanup DMI matching code") did a
> lot of useful cleanups. This patch adds a default case to enable
> jack detection if there is no pdata, device property or quirk.
> 
> The chosen jd-mode3 is the most common and should limit the addition
> of new DMI-based quirks. Existing DMI quirks which only set this mode
> are left as is and not removed.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Bard Liao <bardliao@realtek.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> v2: no functional change, only rewrite of the commit message for clarity
> 
>   sound/soc/codecs/rt5645.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> index 789346cb30b9..8f140c8b93ac 100644
> --- a/sound/soc/codecs/rt5645.c
> +++ b/sound/soc/codecs/rt5645.c
> @@ -3739,6 +3739,17 @@ static const struct dmi_system_id dmi_platform_data[] = {
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
> @@ -3779,8 +3790,10 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
>   
>   	if (pdata)
>   		rt5645->pdata = *pdata;
> -	else
> +	else if (rt5645_check_dp(&i2c->dev))
>   		rt5645_parse_dt(rt5645, &i2c->dev);
> +	else
> +		rt5645->pdata = jd_mode3_platform_data;
>   
>   	if (quirk != -1) {
>   		rt5645->pdata.in2_diff = QUIRK_IN2_DIFF(quirk);
> 
