From: Misael Lopez <mlopez@sta.samsung.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add supply for audio
	serial	interface control
Date: Thu, 11 Feb 2010 14:03:41 -0600
Message-ID: <9357A55138006545BB696D907C4EDB481467DBC8C1@staex7mb1.telecom.sna.samsung.com>
References: <1265721844-5065-1-git-send-email-peter.ujfalusi@nokia.com>
	<201002091530.13119.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cuda1.sta.samsung.com (mailedge.sta.samsung.com [63.166.115.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 077EE2448A
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 21:04:30 +0100 (CET)
In-Reply-To: <201002091530.13119.peter.ujfalusi@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "hnagalla@ti.com" <hnagalla@ti.com>, "jorge.candelaria@ti.com" <jorge.candelaria@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "jy0922.shim@samsung.com" <jy0922.shim@samsung.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> Hello,
> =

> On Tuesday 09 February 2010 15:24:04 Ujfalusi Peter (Nokia-
> D/Tampere) wrote:
> > The serial interface (TDM/I2S) for the audio block have been
> > constantly enabled.
> > Introduce a new DAPM_SUPPLY for handling the AIF_EN bit, so
> > the interface is only enabled, when there is a need for it.
> > For example when only the analog loopback is enabled, there
> > is no need to keep the serial interface active.
> >
> > I have added the persons who contributed to the Voice path
> > of twl4030 codec driver, so they might have the ability
> > to test this patch, and send an update for the Voice path,
> > if it is necessary
> =

> I meant to place this part after the ---, so this should not be
> part of the
> commit message. Sorry about that, should I resend it?
> Also, it seams that the email address for Misael Lopez at TI is
> no longer
> active...

My TI email is not longer active. And I don't have any hardware
available to test that, but I have a couple of comments.

IIRC the AIF_EN bit only enables the Audio (HiFi) port (I2S/TDM) of
twl4030, so the changes doesn't break anything in voice path.
OTOH, a similar strategy needs to be followed for Voice path but
using VIF_EN bit of Voice Interface register.

-Misa

> --
> P=E9ter
> =

> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > ---
> >
> > This patch has been tested in OPTION 1 mode, where the Voice
> > path is not in use.
> > I have looked for dependencies in the Voice path regarding to
> > the Audio interface enable bit, but I have not found any.
> > If someone could test, if the Voice path also needs the AIF_EN
> > bit set, than please send a patch, which adds this new supply
> > to the DAPM rule for the Voice path.
> >
> >  sound/soc/codecs/twl4030.c |   14 +++++++++++++-
> >  1 files changed, 13 insertions(+), 1 deletions(-)
> >
> > diff --git a/sound/soc/codecs/twl4030.c
> b/sound/soc/codecs/twl4030.c
> > index b32aeb3..277862e 100644
> > --- a/sound/soc/codecs/twl4030.c
> > +++ b/sound/soc/codecs/twl4030.c
> > @@ -55,7 +55,7 @@ static const u8
> twl4030_reg[TWL4030_CACHEREGNUM] =3D {
> >  	0x0c, /* REG_ATXR1PGA		(0xB)	*/
> >  	0x00, /* REG_AVTXL2PGA		(0xC)	*/
> >  	0x00, /* REG_AVTXR2PGA		(0xD)	*/
> > -	0x01, /* REG_AUDIO_IF		(0xE)	*/
> > +	0x00, /* REG_AUDIO_IF		(0xE)	*/
> >  	0x00, /* REG_VOICE_IF		(0xF)	*/
> >  	0x00, /* REG_ARXR1PGA		(0x10)	*/
> >  	0x00, /* REG_ARXL1PGA		(0x11)	*/
> > @@ -1203,6 +1203,8 @@ static const struct snd_soc_dapm_widget
> >  twl4030_dapm_widgets[] =3D { SND_SOC_DAPM_SUPPLY("APLL Enable",
> >  SND_SOC_NOPM, 0, 0, apll_event,
> >  SND_SOC_DAPM_PRE_PMU|SND_SOC_DAPM_POST_PMD),
> >
> > +	SND_SOC_DAPM_SUPPLY("AIF Enable", TWL4030_REG_AUDIO_IF, 0,
> 0, NULL, 0),
> > +
> >  	/* Output MIXER controls */
> >  	/* Earpiece */
> >  	SND_SOC_DAPM_MIXER("Earpiece Mixer", SND_SOC_NOPM, 0, 0,
> > @@ -1337,6 +1339,11 @@ static const struct snd_soc_dapm_route
> intercon[] =3D
> >  { {"Digital L2 Playback Mixer", NULL, "APLL Enable"},
> >  	{"Digital Voice Playback Mixer", NULL, "APLL Enable"},
> >
> > +	{"Digital R1 Playback Mixer", NULL, "AIF Enable"},
> > +	{"Digital L1 Playback Mixer", NULL, "AIF Enable"},
> > +	{"Digital R2 Playback Mixer", NULL, "AIF Enable"},
> > +	{"Digital L2 Playback Mixer", NULL, "AIF Enable"},
> > +
> >  	{"Analog L1 Playback Mixer", NULL, "Digital L1 Playback
> Mixer"},
> >  	{"Analog R1 Playback Mixer", NULL, "Digital R1 Playback
> Mixer"},
> >  	{"Analog L2 Playback Mixer", NULL, "Digital L2 Playback
> Mixer"},
> > @@ -1455,6 +1462,11 @@ static const struct snd_soc_dapm_route
> intercon[] =3D
> >  { {"ADC Virtual Left2", NULL, "APLL Enable"},
> >  	{"ADC Virtual Right2", NULL, "APLL Enable"},
> >
> > +	{"ADC Virtual Left1", NULL, "AIF Enable"},
> > +	{"ADC Virtual Right1", NULL, "AIF Enable"},
> > +	{"ADC Virtual Left2", NULL, "AIF Enable"},
> > +	{"ADC Virtual Right2", NULL, "AIF Enable"},
> > +
> >  	/* Analog bypass routes */
> >  	{"Right1 Analog Loopback", "Switch", "Analog Right"},
> >  	{"Left1 Analog Loopback", "Switch", "Analog Left"},
> >
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
