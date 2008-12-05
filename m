From: "naveen krishna ch" <naveenkrishna.ch@gmail.com>
Subject: Re: [PATCH 6/7] ASoC: TWL4030: Add volume controls for
	outputs
Date: Fri, 5 Dec 2008 16:47:36 +0530
Message-ID: <ef0d8a250812050317p400157d0if469811c19bb4fe9@mail.gmail.com>
References: <20081201200703.GA14376@rakim.wolfsonmicro.main>
	<1228162061-14769-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<ef0d8a250812042044n3968719r6eb996897ce90ade@mail.gmail.com>
	<20081205104453.GA308@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B0C7103800
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 12:17:37 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so4205081rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 05 Dec 2008 03:17:36 -0800 (PST)
In-Reply-To: <20081205104453.GA308@rakim.wolfsonmicro.main>
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

On Fri, Dec 5, 2008 at 4:14 PM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Dec 05, 2008 at 10:14:35AM +0530, naveen krishna ch wrote:
>
> > The min and max values are from 0 to 209 and they r repeating for every 4
> > steps
> > Can any one explain this
>
> Does this patch help?
>
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index 3c9fdf2..afda2fc 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -223,7 +223,7 @@ static void twl4030_init_chip(struct snd_soc_codec
> *codec)
>        .put = snd_soc_put_volsw_r2_twl4030, \
>        .private_value = (unsigned long)&(struct soc_mixer_control) \
>                {.reg = reg_left, .rreg = reg_right, .shift = xshift, \
> -               .max = xmax, .invert = xinvert} }
> +                .rshift = xshift, .max = xmax, .invert = xinvert} }
>  #define SOC_SINGLE_TLV_TWL4030(xname, xreg, xshift, xmax, xinvert,
> tlv_array) \
>        SOC_DOUBLE_TLV_TWL4030(xname, xreg, xshift, xshift, xmax, \
>                               xinvert, tlv_array)

I am afraid But it dint help.
The desired affect is repeating itself between 0 to 60 range.



-- 
Thanks,

(: Naveen Krishna Ch :)
