From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 06/18] ASoC: TWL4030: DAPM mapping of the
	Headset outputs
Date: Wed, 10 Dec 2008 11:19:47 +0200
Message-ID: <200812101119.47742.peter.ujfalusi@nokia.com>
References: <20081209140101.GA17558@rakim.wolfsonmicro.main>
	<1228831302-17605-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228897664.6799.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F9E8243A3
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 10:20:17 +0100 (CET)
In-Reply-To: <1228897664.6799.3.camel@localhost>
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
To: stanley.miao@windriver.com
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 10 December 2008 10:27:44 ext stanley.miao wrote:
> On Tue, 2008-12-09 at 14:01 +0000, Mark Brown wrote:
> > From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> >
> > Adds DAPM muxing, routing for the Headset outputs.
> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > ---
> >  sound/soc/codecs/twl4030.c |   39
> > +++++++++++++++++++++++++++++++++++++++ 1 files changed, 39
> > insertions(+), 0 deletions(-)
>
> <snip>
>
> >  	SND_SOC_DAPM_ADC("ADCL", "Left Capture", SND_SOC_NOPM, 0, 0),
> >  	SND_SOC_DAPM_ADC("ADCR", "Right Capture", SND_SOC_NOPM, 0, 0),
> > @@ -744,6 +775,12 @@ static const struct snd_soc_dapm_route intercon[] =
=3D
> > { {"PredriveR Mux", "DACR1", "ARXR1_APGA"},
> >  	{"PredriveR Mux", "DACR2", "ARXR2_APGA"},
> >  	{"PredriveR Mux", "DACL2", "ARXL2_APGA"},
> > +	/* HeadsetL */
> > +	{"HeadsetL Mux", "DACL1", "ARXL1_APGA"},
> > +	{"HeadsetL Mux", "DACL2", "ARXL2_APGA"},
>
> The control names "DACR1","DACR2","DACL1","DACL2" have the same name
> with the widgets in the first patch. I suggest you change a different
> name to avoid confusion.

Yes, this can be confusing... I'm thinking of changing either the control =

names like this:
"DACR1" -> "DAC Right1" or "Audio Out R1" or "Out R1"
"DACR2" -> "DAC Right2" or "Audio Out R2" or "Out R1"
...
I think the "DAC Right1" type reflects better the functionality of the mux.=
..

or make the same name change, but with the SND_SOC_DAPM_DAC

>
> Stanley.

-- =

P=E9ter

>
> > +	/* HeadsetR */
> > +	{"HeadsetR Mux", "DACR1", "ARXR1_APGA"},
> > +	{"HeadsetR Mux", "DACR2", "ARXR2_APGA"},
> >
> >  	/* outputs */
> >  	{"OUTL", NULL, "ARXL2_APGA"},
> > @@ -751,6 +788,8 @@ static const struct snd_soc_dapm_route intercon[] =
=3D {
> >  	{"EARPIECE", NULL, "Earpiece Mux"},
> >  	{"PREDRIVEL", NULL, "PredriveL Mux"},
> >  	{"PREDRIVER", NULL, "PredriveR Mux"},
> > +	{"HSOL", NULL, "HeadsetL Mux"},
> > +	{"HSOR", NULL, "HeadsetR Mux"},
> >
> >  	/* inputs */
> >  	{"ADCL", NULL, "INL"},
