From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 5/9] ASoC: TWL4030: Add PreDriv outupt mux
	and volume controls
Date: Mon, 24 Nov 2008 16:19:18 +0200
Message-ID: <200811241619.18786.peter.ujfalusi@nokia.com>
References: <1227527383-22516-1-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-6-git-send-email-peter.ujfalusi@nokia.com>
	<20081124134808.GB22394@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id A7CEF24418
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 15:19:31 +0100 (CET)
In-Reply-To: <20081124134808.GB22394@sirena.org.uk>
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
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

On Monday 24 November 2008 15:48:09 ext Mark Brown wrote:
> On Mon, Nov 24, 2008 at 01:49:39PM +0200, Peter Ujfalusi wrote:
> =

> > +static const char *twl4030_predrivl_mix[] =3D {"Off", "Voice", "DACL1",
> > +					    "DACL2", "DACR2"};
> > +static const char *twl4030_predrivr_mix[] =3D {"Off", "Voice", "DACR1",
> > +					    "DACR2", "DACL2"};
> =

> > +static const struct soc_enum twl4030_enum[] =3D {
> =

> I know quite a few existing drivers use an array of enums but please
> don't do this for new code - it doesn't help legibility to have to find
> the enums in the table.

I have seen this approach in several codec code, so I have also implemented
in a same way.
I will change it.
Do you have a pointer, where should I look for existing code?

> =

> > +	SOC_ENUM_SINGLE(TWL4030_REG_PREDL_CTL, 0, 5, twl4030_predrivl_mix),
> > +	SOC_ENUM_SINGLE(TWL4030_REG_PREDR_CTL, 0, 5, twl4030_predrivr_mix),
> > +};
> =

> Is this really an enum?  The fact that it's described as a mixer and
> it's got a series of individual bits for selecting the inputs make it
> sound like it should be possible to enable multiple inputs at once in
> which case this should be a series of switches - see SND_SOC_DAPM_MIXERs
> in other drivers for examples.  If it's really an enum then calling it a
> mux is probably better.

Hmmm, the situation is kind of both...
The selection is done in a bitfield.
Let's take the PREDL, as I used that in the helper function comment:
 bit 0 (0x1): voice_en
 bit 1 (0x2): Audio L1 enable (DACL1)
 bit 2 (0x4): Audio L2 enable (DACL2)
 bit 3 (0x8): Audio R2 enable (DACR2)
The voice path can be enabled/disabled independently from the digital
paths, but only _one_ of the DACL1, DACL2 or DACR2 can be selected at
the time.
On top of that the mute can be performed by setting all four bits to 0.
I don't know actually what that means, but probably than the PreDriv
path will be effectively turned off.
On the side not: the voice path at the moment not in use -> the codec has
to be in different mode to have the voice path enabled. But then lot's of
things will behave differently.
Initially I did not wanted to spread these controls - to make it simple
for myself, but I might separate the voice and DAC mux selections (separated
enable for voice and mux the DACL/Rs selection).

> =

> Another issue is that it might be better to add these as DAPM controls
> now rather than have to move them to be DAPM controls later.  If you use
> SND_SOC_NOPM for the power bit then DAPM won't actually do any power
> control, it'll just expose the control.
> =

> These comments apply to the other patches in the series.
> =


OK, I'll try to move the controls to DAPM, as you suggested.

Thanks,
P=E9ter
