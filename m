From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: UCM questions
Date: Fri, 21 Jan 2011 11:37:44 +0000
Message-ID: <20110121113744.GA18682@sirena.org.uk>
References: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DFCB8103A9C
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 12:37:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 20, 2011 at 04:06:55PM -0600, pl bossart wrote:
> Hello all,
> I've been looking at the UCM code in
> git://git.alsa-project.org/alsa-lib.git branch ucm. Looks both
> simple/powerfl/useful, still I have a couple of questions (most likely
> for Liam and Mark):

CCing in Liam so he sees this.  Below are my initial thoughts but Liam
can give better answers.

> - how would a USB device be handled? An audio use case is defined by a
> verb and device parameter. My understanding is for a USB headset used
> for music playback, we would still use the 'HiFi' verb, but then we
> would need a 'USB' device added in include/use-case.h ? Then how would

The device/use case names there are just defaults, systems can add their
own.  The default set of use cases and devices are likely to handle
most cases but there's going to be a dependence on the system
integration.

> I make a difference between a USB headset and USB speakers?

You'd probably need to handle identifying the different classes USB
devices in whatever owns the use case configuration for the system.
I'm not sure that's been looked at in much detail, USB host support is
fairly unusual in the embedded systems this targets.

> - same question for remote displays/display port.

A similar thing applies here - I'd imagine many applications would make
the decision to use a display output based partly on use case.

> - how useful is the notion of 'card list'? Seems to me that the verbs
> are the main entry points, and the notion of card is abstracted away.
> For a given use case, the application can query the string containing
> the device name. Or I am misled and verbs are only related to a given
> card?
> - If I want to enable a camcorder use case, possibly with multiple
> microphones, do I still use the 'HiFi' verb? Or do we need a new verb
> for capture cases? I don't see any mics as capture devices hence the
> question.

I'd suggest that'd either be the HiFi verb or a new verb.

> - how would IEC-formatted data be handled for HDMI/SPDIF? It could be
> a different physical device for PCM and IEC-formatted data, and you
> would need to enable IEC-related switches in the alsa controls. Or
> would a modifier be more appropriate to provide additional information
> on the content type?

I'd guess modifier.

> - has anyone generated a typical configuration file for USB and
> HDAudio? I only see an OMAP conf.

Someone asked this at LPC as well - my thought there is that probably
PC systems would be happier trying to work without explicit use case
configuration as they are currently.
