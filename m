From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: tlv320dac33: Do not enable the
 codec in init_chip
Date: Tue, 30 Nov 2010 15:45:10 +0000
Message-ID: <1291131910.3293.19.camel@odin>
References: <1291120306-18445-1-git-send-email-peter.ujfalusi@nokia.com>
	<1291120306-18445-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 20C89103983
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 16:45:14 +0100 (CET)
Received: by wyi11 with SMTP id 11so5835241wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 07:45:13 -0800 (PST)
In-Reply-To: <1291120306-18445-2-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-11-30 at 14:31 +0200, Peter Ujfalusi wrote:
> No need to enable the codec at this time.
> The codec will be enabled  later by other events
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
>  sound/soc/codecs/tlv320dac33.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
> index ccb267f..080ec91 100644
> --- a/sound/soc/codecs/tlv320dac33.c
> +++ b/sound/soc/codecs/tlv320dac33.c
> @@ -315,8 +315,6 @@ static void dac33_init_chip(struct snd_soc_codec *codec)
>  	 clock source = internal osc (?) */
>  	dac33_write(codec, DAC33_ANA_VOL_SOFT_STEP_CTRL, DAC33_VOLCLKEN);
>  
> -	dac33_write(codec, DAC33_PWR_CTRL, DAC33_PDNALLB);
> -
>  	/* Restore only selected registers (gains mostly) */
>  	dac33_write(codec, DAC33_LDAC_DIG_VOL_CTRL,
>  		    dac33_read_reg_cache(codec, DAC33_LDAC_DIG_VOL_CTRL));

Both Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
