From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: RFC: Jack-detection control elements on HD-audio
Date: Fri, 19 Jun 2009 10:53:22 +0100
Message-ID: <20090619095322.GC5270@sirena.org.uk>
References: <s5hk538ejj4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E40D10389A
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 11:53:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk538ejj4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 19, 2009 at 10:04:47AM +0200, Takashi Iwai wrote:

> yet another thing I've worked recently on is a bit more generalized
> framework for jack-sense reporting for HD-audio.  This supersedes the
> existing jack-sense reporting via the input layer.  In addition, it
> gives the corresponding control elements.

It'd be nice to keep the input API interface as well - one of the
reasons I carried on with the existing input interface was that the
existing userspace stuff I found was using the input API in one way or
another.  In the embedded space it appears to have often been convenient
for people to read jack sense from a GPIO as part of a GPIO keyboard
they're already using which was part of the reason it was never really
joined up with ALSA in the past.

I suspect that which interface is more convenient will depend on what
the application responding to the events is doing.  For system-wide
things that aren't focused on audio being able to use the general input
API makes some sense, while for audio-focused applications that are
already using ALSA sitting within the ALSA APIs is useful.  This sort of
system wide thing is probably more common in the embedded space, though
HAL/DeviceKit do similar things in the desktop space for other kinds of
hardware.

Perhaps rather than superceeding the existing ABI it'd make sense to
have something in user space as either a plugin or part of the library
which remaps things into a more ALSA framework?  I confess I've no idea
what sort of work is involved in doing that; it may be simpler to just
provide two ABIs.

> For example, you'll have "Jack HP-Out" (or a bit more verbose like
> "Jack HP-Out at Ext Rear") control via control API as well as other
> mixer controls.  This can notify when a jack is plugged/unplugged.

Including the colours (where reported) is often very helpful for
figuring out what's what.  The pictures manufacturers seem fond of using
for describing the jack functions aren't always models of clarity to the
general user.
