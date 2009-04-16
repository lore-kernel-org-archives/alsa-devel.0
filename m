From: Arun KS <arunks@mistralsolutions.com>
Subject: Re: [2.6.30-rc2][PATCH 2/2] ASoC: OMAP: Fix FS
	polarity in OSK5912 machine driver
Date: Thu, 16 Apr 2009 16:54:19 +0530
Message-ID: <dfeb90390904160424x3ba3777i2869ab09826788a5@mail.gmail.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
	<1239792497-31761-3-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 28A9B10392F
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 13:24:20 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id a21so232903tia.8
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 04:24:19 -0700 (PDT)
In-Reply-To: <1239792497-31761-3-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 15, 2009 at 4:18 PM, Jarkko Nikula <jarkko.nikula@nokia.com> wr=
ote:
> Using inverted FS polarity in OSK5912 must be an error since TLV320AIC23
> do not have support for inverted polarities. This is mostly due the hassle
> with the DSP formats in OMAP McBSP DAI and inversion on OMAP side probably
> just made this configuration working at some point.
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Cc: Arun KS <arunks@mistralsolutions.com>
> ---
> =A0sound/soc/omap/osk5912.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
> index a952a4e..a4e149b 100644
> --- a/sound/soc/omap/osk5912.c
> +++ b/sound/soc/omap/osk5912.c
> @@ -62,7 +62,7 @@ static int osk_hw_params(struct snd_pcm_substream *subs=
tream,
> =A0 =A0 =A0 =A0/* Set codec DAI configuration */
> =A0 =A0 =A0 =A0err =3D snd_soc_dai_set_fmt(codec_dai,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SND_SO=
C_DAIFMT_DSP_B |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC=
_DAIFMT_NB_IF |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC=
_DAIFMT_NB_NF |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SND_SO=
C_DAIFMT_CBM_CFM);
> =A0 =A0 =A0 =A0if (err < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "can't set codec DAI confi=
guration\n");
> @@ -72,7 +72,7 @@ static int osk_hw_params(struct snd_pcm_substream *subs=
tream,
> =A0 =A0 =A0 =A0/* Set cpu DAI configuration */
> =A0 =A0 =A0 =A0err =3D snd_soc_dai_set_fmt(cpu_dai,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SND_SO=
C_DAIFMT_DSP_B |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC=
_DAIFMT_NB_IF |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC=
_DAIFMT_NB_NF |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SND_SO=
C_DAIFMT_CBM_CFM);
> =A0 =A0 =A0 =A0if (err < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "can't set cpu DAI configu=
ration\n");
> --
> 1.6.2.1
Tested on osk5912.

Acked-by: Arun KS <arunks@mistralsolutions.com>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
