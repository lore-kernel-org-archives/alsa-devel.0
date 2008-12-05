From: "naveen krishna ch" <naveenkrishna.ch@gmail.com>
Subject: Re: [PATCH 6/7] ASoC: TWL4030: Add volume controls for
	outputs
Date: Fri, 5 Dec 2008 10:14:35 +0530
Message-ID: <ef0d8a250812042044n3968719r6eb996897ce90ade@mail.gmail.com>
References: <20081201200703.GA14376@rakim.wolfsonmicro.main>
	<1228162061-14769-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 12ED424449
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 05:44:36 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id k29so5192084rvb.0
	for <alsa-devel@alsa-project.org>; Thu, 04 Dec 2008 20:44:35 -0800 (PST)
In-Reply-To: <1228162061-14769-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 2, 2008 at 1:37 AM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
>
> All outputs have dedicated gain controls except the
> HandsFree output.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/twl4030.c |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
>
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index 1dae73a..ffd5120 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -367,6 +367,12 @@ static DECLARE_TLV_DB_SCALE(digital_coarse_tlv, 0,
> 600, 0);
>  static DECLARE_TLV_DB_SCALE(analog_tlv, -2400, 200, 0);
>
>  /*
> + * Gain controls tied to outputs
> + * -6 dB to 6 dB in 6 dB steps (mute instead of -12)
> + */
> +static DECLARE_TLV_DB_SCALE(output_tvl, -1200, 600, 1);
> +
> +/*
>  * Capture gain after the ADCs
>  * from 0 dB to 31 dB in 1 dB steps
>  */
> @@ -395,6 +401,21 @@ static const struct snd_kcontrol_new
> twl4030_snd_controls[] = {
>                TWL4030_REG_ARXL2_APGA_CTL, TWL4030_REG_ARXR2_APGA_CTL,
>                3, 0x12, 1, analog_tlv),
>
> +       /* Separate output gain controls */
> +       SOC_DOUBLE_R_TLV_TWL4030("",
> +               TWL4030_REG_PREDL_CTL, TWL4030_REG_PREDR_CTL,
> +               4, 3, 0, output_tvl),

With this implementation the
#amixer cset numid=16 3
numid=16,iface=MIXER,name='PreDriv Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=209,step=0
  : values=3,3
  | dBscale-min=-12.00dB,step=6.00dB,mute=1
The min and max values are from 0 to 209 and they r repeating for every 4
steps
Can any one explain this


>
> +
> +       SOC_DOUBLE_TLV_TWL4030("Headset Playback Volume",
> +               TWL4030_REG_HS_GAIN_SET, 0, 2, 3, 0, output_tvl),

With this implementation the min and max values seems to be shown like 0 to
60 instead of 0 to 3
and  the range is repeatring between 0 to 60
Means 4 again 0 and 7 a bit max, its repeating..

>
> +
> +       SOC_DOUBLE_R_TLV_TWL4030("Carkit Playback Volume",
> +               TWL4030_REG_PRECKL_CTL, TWL4030_REG_PRECKR_CTL,
> +               4, 3, 0, output_tvl),
> +
> +       SOC_SINGLE_TLV_TWL4030("Earpiece Playback Volume",
> +               TWL4030_REG_EAR_CTL, 4, 3, 0, output_tvl),
> +
>        /* Common capture gain controls */
>        SOC_DOUBLE_R_TLV("Capture Volume",
>                TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
> --
> 1.5.6.5
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



Thanks ,,

(: Naveen Krishna Ch :)
