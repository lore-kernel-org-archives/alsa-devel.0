From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: msm8916-wcd-analog: fix
	module autoload
Date: Tue, 3 Oct 2017 21:43:20 +0100
Message-ID: <3e9c07c1-1262-9362-b867-9b0f1da42fc9@linaro.org>
References: <20171003094951.10692-1-nicolas.dechesne@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id DEA692668F0
 for <alsa-devel@alsa-project.org>; Tue,  3 Oct 2017 22:43:22 +0200 (CEST)
Received: by mail-wm0-f41.google.com with SMTP id b189so15158193wmd.4
 for <alsa-devel@alsa-project.org>; Tue, 03 Oct 2017 13:43:22 -0700 (PDT)
In-Reply-To: <20171003094951.10692-1-nicolas.dechesne@linaro.org>
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
To: Nicolas Dechesne <nicolas.dechesne@linaro.org>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 03/10/17 10:49, Nicolas Dechesne wrote:
> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
> 
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
> 
> Before this patch:
> 
> $ modinfo snd_soc_msm8916_analog | grep alias
> $
> 
> After this patch:
> 
> $ modinfo snd_soc_msm8916_analog | grep alias
> alias:          of:N*T*Cqcom,pm8916-wcd-analog-codecC*
> alias:          of:N*T*Cqcom,pm8916-wcd-analog-codec
> 
> Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>

Thanks for the patch

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/codecs/msm8916-wcd-analog.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
> index 549c269acc7d..d79e5b35e003 100644
> --- a/sound/soc/codecs/msm8916-wcd-analog.c
> +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> @@ -1241,6 +1241,8 @@ static const struct of_device_id pm8916_wcd_analog_spmi_match_table[] = {
>   	{ }
>   };
>   
> +MODULE_DEVICE_TABLE(of, pm8916_wcd_analog_spmi_match_table);
> +
>   static struct platform_driver pm8916_wcd_analog_spmi_driver = {
>   	.driver = {
>   		   .name = "qcom,pm8916-wcd-spmi-codec",
> 
