From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 0/2] soc-dapm or TWL4030: Runtime DAPM
	ordering problem
Date: Mon, 2 Aug 2010 13:59:11 +0300
Message-ID: <201008021359.11636.peter.ujfalusi@nokia.com>
References: <1280732895-29010-1-git-send-email-peter.ujfalusi@nokia.com>
	<2EC9E5A5-E55F-4303-B6EF-2351B9440989@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 453D924417
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 12:59:23 +0200 (CEST)
In-Reply-To: <2EC9E5A5-E55F-4303-B6EF-2351B9440989@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Monday 02 August 2010 13:27:21 ext Mark Brown wrote:
> On 2 Aug 2010, at 08:08, Peter Ujfalusi wrote:
> > I'm facing the following problem with the TWL4030 codec:
> > The order of DAPM register write order different in case, when I start a
> > capture operation after setting up the routing, and when I change the
> > routing during active capture.
> > This is really visible, when I want to record from the digital micropho=
ne
> > interface.
> > =

> > Because of this ordering problem, when during active capture I switch to
> > the digital mic from analog path, the codec would enable analog bias
> > (2.2 volts) to the digital mic for a moment, and than later it will
> > switch to the correct digital mic bias (1.8 volts).
> =

> It'd be really helpful in this section if you could've said what the actu=
al
> problem you see is...

The problem in the TWL4030 codec during active capture: change from analog =

source to digital microphone will momentary apply 2.2V mic bias to the digi=
tal =

microphone instead of the correct 1.8V.

This only happens during active capture. If the change from analog to digit=
al =

mic happens before the capture has been started, than it is fine.

> > Since the twl4030 codec needs several bits in different registers to be
> > changed, when I change between analog and digital input it is not that
> > obvious how to get the correct ordering all the time.
> > =

> > I have two different ways to fix this:
> > A: by reordering how DAPM would handle control changes (patch 1)
> > B: by changing TWL4030 internal DAPM widgets (patch 2)
> =

> ...you even start proposing solutions before describing what they're fixi=
ng
> :)
> =

> Just summarising briefly since I can't see a clear problem statement I
> think what you're saying is that DAPM applies control changes for routing
> before checking for power up changes but for some TWL4030 routes it would
> be more convenient to only write the changes for route setup after
> changing the power state?
> =

> I think this is best handled in TWL4030, or possibly with some sort of
> optional flag in DAPM which TWL4030 and anything else could then use.
> =

> With most things it's safer to implement the route change first -
> especially in the analogue domain route changes tend to introduce DC
> offsets so it's safer to set the route prior to powering up so the offset
> changes don't get amplified. This is also very important when doing DC
> offset correction, obviously there it's important to measure the offset of
> the path you're actually trying to run rather than using whatever path was
> there before.

Sure, but what I'm telling is that we/I have basically two different scenar=
ios =

to fix for pop noise.

A. When the user configures the capture routing, and starts the capture
B. When the user changes the capture routing during active capture (analog =
to =

digital, or back).

The sequences in these case:
A.1 The changes in register(s) are applied based on the DAPM_MUX's enum
      control
A.2 The DAPM power up changes happen for the selected route

B.1 The DAPM power up changes happen for the selected new route
B.2 The changes in register(s) are applied based on the DAPM_MUX's enum
      control

Since the DAPM_MUX does not have any sensible power bit to toggle, just =

selects between the digital or analog path.
But if it would have power bit, than that power would have bee applied in A=
.2 =

or B.1 phase, when the DAPM power up changes are happening.

So we have different sequences, and somehow I need to make sure, that at le=
ast =

I'm not doing any harm to components.

This might be not a problem for others, but since the TWL4030 has quite =

complicated internal routings, and the controls for some of the routings ar=
e =

scattered all around the register table with bits here and there, and =

dependency to other bits, at least I'm not that happy that I need to handle =

things differently...

-- =

P=E9ter
