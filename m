From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/3] ASoC: TWL4030: Enable voice filters
	for voice sidetone
Date: Tue, 23 Jun 2009 08:38:20 +0300
Message-ID: <200906230838.20351.peter.ujfalusi@nokia.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31C@dlee04.ent.ti.com>
	<200906220925.40839.peter.ujfalusi@nokia.com>
	<67059DBF19D7214F9C66BB0EA91BA90E3555FB3B@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id BD2702453D
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 07:38:22 +0200 (CEST)
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E3555FB3B@dlee04.ent.ti.com>
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
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 23 June 2009 04:52:10 ext Lopez Cruz, Misael wrote:
> > On Friday 19 June 2009 12:58:08 ext Mark Brown wrote:
> > > On Fri, Jun 19, 2009 at 03:23:41AM -0500, Lopez Cruz, Misael wrote:
> > > > Digital voice loopback (sidetone) requires voice filters
> > > > to be enabled: VTXL, VTXR, VRX.
> > >
> > > Is it possible to handle this by inserting DAPM widgets for these
> > > filters into the bypass paths and letting DAPM power them up?
> >
> > I think for the Voice interface this is feasible.
>
> I don't see any problem with either voice or HiFi interfaces
> in playback path. I think that by inserting filter widgets between
> Digital and Analog Playback Mixers should be enough. That way
> filters get enabled in digital bypass (as widget will be after
> Digital Playback Mixer) and get disabled in analog bypass (new
> widgets are before Analog Playback Mixer)

I don't think it should be so problematic either.
We have already separated the analog and digital bypasses, so adding widget=
s =

for the digital filters (to the correct places) should not be that difficul=
t..

>
> > > I'm also wondering if with the new bias level management
> > > stuff which keeps the codec in BIAS_ON while any DAPM widgets
> > > are powered some of the bypass mode stuff can be removed
> > > or simplified?
> >
> > I have been wondering about the same, but in the HiFi path it
> > is not that simple. Most probably it is possible to add DAPM
> > widget for the Audio Filter L1/R1 (which is at the moment always
> > enabled), but for the L2/R2 it is not that simple.
>
> Could you please clarify why it's not that simple?
>
> I see more problems in capture path because TXR2, TXL2 paths are
> shared in voice and tdm scenarios.

Also ARXL1 and VRX are shared on the playback case (ARXR1 is only valid for =

Option1).

So we have three bits, which operates differently in Option1 and Option2.
In theory this should not be that big of a problem, but in reality it can =

cause quite interesting cases:
The codec is in Option2.
One starts playback on the Voice interface (VRX).
Than application sets up the audio routing for HeadsetL from AudioL1.
Now if you start an audio playback (which will enable the ARXL1, even if we =

are in Option2), than you stop it: the ARXL1 (which is VRX in Option2) bit =

will be turned off... Now I'm not sure how this will be handled by the ASoC =

core.
What I mean is: One path enabled this bit, than another path also enables t=
he =

same bit, than it disables it. Will the first path notice it? Or will it th=
ink =

that the bit is still enabled?
One thing is sure: we can not use the _same_ widget for the Voice and HiFi =

paths, they have to be different widgets.

I think that is what I meant, when I said that it is not going to be simple.

>
> > Simplifying the twl4030_mute function should be possible at
> > this point, I think, by moving those output mutes as DAPM_PGA_E
> > widgets on the paths. This is in my to-do list... Although I
> > have to check that such a change should not cause any 'clicks'
> > on the outputs.
>
> -Misa

-- =

P=E9ter
