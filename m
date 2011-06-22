From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Wed, 22 Jun 2011 12:48:26 +0100
Message-ID: <20110622114826.GD18726@opensource.wolfsonmicro.com>
References: <4DFF4D15.6050809@canonical.com>
	<20110620170739.GD32056@opensource.wolfsonmicro.com>
	<4DFF973A.1080404@canonical.com>
	<20110620234053.GA1905@opensource.wolfsonmicro.com>
	<4E008A63.5080403@canonical.com>
	<20110621123908.GA25980@opensource.wolfsonmicro.com>
	<4E01C847.7060505@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7CF9224655
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 13:48:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E01C847.7060505@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 12:47:35PM +0200, David Henningsson wrote:
> On 2011-06-21 14:39, Mark Brown wrote:
> >On Tue, Jun 21, 2011 at 02:11:15PM +0200, David Henningsson wrote:

[Using the parent device to work out if a jack is an audio jack.]
> If you have a better idea about how to determine if a SW_VIDEOOUT
> jack is actually an audio jack or not, let me know.

I'd have done this by checking for any audio capabilities - if the jack
can detect an audio input or output then it's an audio capable jack.

> >It does sound like we need some input from the udev and more general
> >userspace stack people about how this stuff is usually handled.

> I was hoping for Lennart or Kay to answer here as they are more
> "udev and general userspace stack people" than I am, but lacking

Yes, me too.  Kay, does any of this ring any bells from a udev point of
view?

> that, I can only notice that on my machine, the only processes
> listening to /dev/input files are upowerd (for the lid switch) and
> Xorg (for everything else). [1] Acpid seems to be able to listen to
> these events too, but does not seem to do that on my machine (as
> determined by "sudo fuser -v").

Hrm, right.  So upowerd is an example of a little daemon running as root
which provides an interface to the applications running as users
separately to the X server, and it was added recently too so it should
be an example of current best practice.  However with the lid there is
an additional motivation for doing this as a system daemon as we need to
do power handling even when there is nobody logged in which is less of
an issue for audio especially with the current model we have.

> Xorg can only handle keypresses and mouse events, and AFAICT don't
> care about switch events, so, if the way things are usually handled
> is to add another u-audiojack-d just to forward events to
> pulseaudio, I would prefer giving the user access to the relevant
> input devices directly, out of pure simplicity.

I tend to agree.  I think my preferences would be to open up access to
input (or possibly just switch) devices in general, or if there's a good
reason not to do that then do the daemon thing.
