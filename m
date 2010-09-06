From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add event variants of the AIF widgets
Date: Mon, 06 Sep 2010 11:33:49 +0100
Message-ID: <1283769229.3078.16.camel@odin>
References: <1283762284-10034-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 898EA24501
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Sep 2010 12:33:52 +0200 (CEST)
Received: by wyb32 with SMTP id 32so4498575wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 06 Sep 2010 03:33:52 -0700 (PDT)
In-Reply-To: <1283762284-10034-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-09-06 at 09:38 +0100, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/sound/soc-dapm.h |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
> index c4a4456..8fd3b41 100644
> --- a/include/sound/soc-dapm.h
> +++ b/include/sound/soc-dapm.h
> @@ -172,9 +172,19 @@
>  #define SND_SOC_DAPM_AIF_IN(wname, stname, wslot, wreg, wshift, winvert) \
>  {	.id = snd_soc_dapm_aif_in, .name = wname, .sname = stname, \
>  	.reg = wreg, .shift = wshift, .invert = winvert }
> +#define SND_SOC_DAPM_AIF_IN_E(wname, stname, wslot, wreg, wshift, winvert, \
> +			      wevent, wflags)				\
> +{	.id = snd_soc_dapm_aif_in, .name = wname, .sname = stname, \
> +	.reg = wreg, .shift = wshift, .invert = winvert, \
> +	.event = wevent, .event_flags = wflags }
>  #define SND_SOC_DAPM_AIF_OUT(wname, stname, wslot, wreg, wshift, winvert) \
>  {	.id = snd_soc_dapm_aif_out, .name = wname, .sname = stname, \
>  	.reg = wreg, .shift = wshift, .invert = winvert }
> +#define SND_SOC_DAPM_AIF_OUT_E(wname, stname, wslot, wreg, wshift, winvert, \
> +			     wevent, wflags)				\
> +{	.id = snd_soc_dapm_aif_out, .name = wname, .sname = stname, \
> +	.reg = wreg, .shift = wshift, .invert = winvert, \
> +	.event = wevent, .event_flags = wflags }
>  #define SND_SOC_DAPM_DAC(wname, stname, wreg, wshift, winvert) \
>  {	.id = snd_soc_dapm_dac, .name = wname, .sname = stname, .reg = wreg, \
>  	.shift = wshift, .invert = winvert}

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
