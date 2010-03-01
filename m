From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Mon, 1 Mar 2010 12:21:54 +0800
Message-ID: <4f3252891002282021s4ccbdf10l5a2a29a039e54759@mail.gmail.com>
References: <4B7A5268.5050704@ladisch.de>
	<20100216143200.GB25489@tango.0pointer.de>
	<20100216144047.GB10586@sirena.org.uk>
	<20100216154015.GA612@tango.0pointer.de>
	<alpine.LNX.2.00.1002161711400.28127@eeebox2.perex-int.cz>
	<20100216210703.GA18109@tango.0pointer.de>
	<20100216223938.GA23623@sirena.org.uk>
	<20100216224212.GA1486@tango.0pointer.de>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f199.google.com (mail-pz0-f199.google.com
	[209.85.222.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 30E35245BB
	for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2010 05:21:57 +0100 (CET)
Received: by pzk37 with SMTP id 37so1657803pzk.7
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 20:21:55 -0800 (PST)
In-Reply-To: <20100216235658.GA6766@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/17 Lennart Poettering <mznyfn@0pointer.de>

> On Tue, 16.02.10 23:38, Mark Brown (broonie@opensource.wolfsonmicro.com)
> wrote:
>
> >
> > On Tue, Feb 16, 2010 at 11:42:12PM +0100, Lennart Poettering wrote:
> > > On Tue, 16.02.10 22:39, Mark Brown (
> broonie@opensource.wolfsonmicro.com) wrote:
> >
> > > > Typically the DACs and ADCs will have a full scale signal at line
> > > > reference level - it should generally be a good approximation with
> > > > nothing else to go on.
> >
> > > "line reference level"? What is that?
> >
> > As I understand it (and bear in mind that I'm a software rather than
> > electrical engineer) it's not 100% fixed, though since the actual result
> > depends very much on what it's connected to an absolute answer isn't as
> > important as it might be.  1V RMS is very standard in consumer stuff at
> > least.
> >
> > If you could frame exactly the information that you're looking for then
> > I should be able to ask a few people who are electrical engineers and
> > get a more coherent answer for you.   I guess you're looking at trying
> > to have PulseAudio set sensible levels by default?
>
> Nah. I actually don't need this value for PulseAudio. In PulseAudio I
> chose to shift all scales so that maximum amplification becomes 0 dB,
> so that the UIs are similar to how most hifi racks do it, and which I
> think is a nice, easy and understandable logic. That way my volume
> scales range from -inf dB to 0 dB in all cases, regardless of the
> hardware/drivers in use. Of course, that means that ALSA's own 0dB is
> not directly visible on the scale. Because it might be sometimes
> useful to know where it is, we export that position as "base volume"
> and the UIs show it with a little marker at the side.
>

The -inf dB is the level determined by the state of the mute switch.

The actual resolution of the codec depend on the number of step and the
resolution of each step


But PA also did not provide dB information to alsa application through
alsa-pulse plugin

amixer -D pulse
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 65536
  Mono:
  Front Left: Playback 65536 [100%] [on]
  Front Right: Playback 65536 [100%] [on]

Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch cswitch-joined

  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 65536
  Front Left: Capture 65536 [100%] [on]
  Front Right: Capture 65536 [100%] [on]
