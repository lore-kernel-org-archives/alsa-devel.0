From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: hda/jack - Also add jack kctls for
 Conexant codecs
Date: Thu, 22 Dec 2011 14:29:45 +0000
Message-ID: <20111222142944.GA4546@opensource.wolfsonmicro.com>
References: <1324390985-3496-1-git-send-email-david.henningsson@canonical.com>
	<s5hvcpbgvpm.wl%tiwai@suse.de>
	<20111220235813.GA13529@sirena.org.uk>
	<s5hr4zydm0m.wl%tiwai@suse.de>
	<20111222122155.GN4546@opensource.wolfsonmicro.com>
	<s5h4nwsd82a.wl%tiwai@suse.de>
	<20111222141251.GV4546@opensource.wolfsonmicro.com>
	<s5hy5u4bseb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 62986103DA6
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 15:29:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy5u4bseb.wl%tiwai@suse.de>
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

On Thu, Dec 22, 2011 at 03:19:40PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Once we've got a userspace interface we're pretty much stuck with it...

> Yes, but this is no new interface.  It uses the existing control API.

In terms of system calls it's not new but once you start saying "jacks
will appear as controls called X with type Y" or whatever that's also an
interface built on top of the raw interface which applications can start
relying on.  I'd call the entire ALSA control naming standard an
interface for example.

> > Supporting multiple objects on a single jack is a very basic requirement
> > in order to support headsets (which exist on PCs as well, the MacBooks
> > for example) - we can usually distinguish between at least headset and
> > headphone.

> Interesting.  This can be a single jack connected to multiple pins, so
> the codec sees two individual detection points.  So, if we want to
> expose pins, it'd become different from the jack representation.
> Hmm...

At the hardware level this is often a single detection point with
multiple values - a common technique for distinguishing a headphone is
that it's a microphone that's had the button shorted ever since it was
plugged in.  With all the different techniques for this stuff you end up
with a N:M mapping between jacks and detection methods and the same
again for things reported.
