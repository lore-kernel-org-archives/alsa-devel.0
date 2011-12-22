From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: hda/jack - Also add jack kctls for
 Conexant codecs
Date: Thu, 22 Dec 2011 14:12:51 +0000
Message-ID: <20111222141251.GV4546@opensource.wolfsonmicro.com>
References: <1324390985-3496-1-git-send-email-david.henningsson@canonical.com>
	<s5hvcpbgvpm.wl%tiwai@suse.de>
	<20111220235813.GA13529@sirena.org.uk>
	<s5hr4zydm0m.wl%tiwai@suse.de>
	<20111222122155.GN4546@opensource.wolfsonmicro.com>
	<s5h4nwsd82a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0FED7103DA8
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 15:12:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h4nwsd82a.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 22, 2011 at 02:55:57PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > A pure addition can still cause problems as we roll out the same
> > interface into other drivers, for example if there's assumptions that
> > aren't generally true.

> In later future, yes.  But I was talking about 3.3 kernel.

Once we've got a userspace interface we're pretty much stuck with it...

> > I'm guessing that as this is just a simple boolean each jack will have a
> > series of controls like "Headset Jack Headphone" and "Headset Jack
> > Microphone" or whatever and userspace should match them all together in
> > the same way that it does for Volume and Switch controls?

> My current assumption is so, too.  OTOH, if a single jack must provide
> several values inevitably, it may take an integer or an enum, in
> theory.  But I think (and hope) this wouldn't happen.

Supporting multiple objects on a single jack is a very basic requirement
in order to support headsets (which exist on PCs as well, the MacBooks
for example) - we can usually distinguish between at least headset and
headphone.  I think if we're going to do this via a single multi-state
control rather than a series of booleans it'd need to be an enum for
usability ("an object of type 2!"), Android uses integers and it's
pretty miserable for usability.

> >  That sounds
> > like it'll work well, we just need to define some strings for standard
> > jacks and conections.

> Yeah.  Unfortunately this standardization isn't always trivial,
> especially when multiple jacks are present with the same type...

I was thinking more about the things you might detect rather than the
jacks, that's a much more tractable problem.

> My idea is to give some association between this jack kctl and another
> kctl, in a simple way like TLV.  But it's likely a new year's dream.

Associating the jacks with the audio routes is definitely a separate
problem.
