From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack detection on HDA vs SoC
Date: Sat, 4 Feb 2012 14:02:09 +0000
Message-ID: <20120204140209.GB7438@sirena.org.uk>
References: <CAEUnVG4AGOk4tTC+KKiY_HgXNZs2wx5dD_mOy0vsaYP-ag24jA@mail.gmail.com>
	<20120204132029.GA7438@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F3015243F9
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2012 15:02:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120204132029.GA7438@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 04, 2012 at 01:20:29PM +0000, Mark Brown wrote:
> On Fri, Feb 03, 2012 at 06:01:41PM -0800, Dylan Reid wrote:

> > Is there a plan for the soc code to use the control-based method?

> Not exactly.  I'm expecting that the new interface will be integrated
> into the generic ALSA jack support rather than done as a custom thing in
> the HDA drivers which will mean that anything supporting accessory
> detect will get support, including ASoC.  This stuff should really be
> handled in the core rather than in individual drivers, there's also
> extcon which we'll need to integrate with.

BTW, the core code I'm talking about is that in sound/core/jack.c but I
just noticed we also acquired a sound/core/ctljack.c.

Takashi, we really need to sort this stuff out - it's all getting very
confusing.  We've got two different bits of code with very similar
interfaces on the driver side but totally different application layer
interfaces.  From a driver point of view it's not great to have to tell
the core the same thing twice and from an application point of view we
don't have any consistency.

Looking at the code I don't understand why ctljack is done separately to
the rest of the accessory detection - surely we should just have the
snd_jack code create a control for each thing that can be reported?  I
can't immediately see a problem with just putting a "Headphone Jack" or
whatever the naming convention is for these controls on the end of the
name that we were given for the base jack (probably support that being
empty).
