From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Alsa Driver Development - General Concepts
Date: Wed, 26 Nov 2008 16:06:58 +0000
Message-ID: <200811261606.58772.maillist@superlative.org>
References: <42406.12.4.27.248.1227714506.squirrel@www.lil-voodoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from virtuser.com (unknown [77.92.93.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 19DD8246DC
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 17:07:02 +0100 (CET)
In-Reply-To: <42406.12.4.27.248.1227714506.squirrel@www.lil-voodoo.co.uk>
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
To: alsa-devel@alsa-project.org
Cc: karl@lil-voodoo.co.uk
List-Id: alsa-devel@alsa-project.org

On Wednesday 26 November 2008 15:48:26 karl@lil-voodoo.co.uk wrote:
> Hi,
>
> I've got a couple of audio/midi devices knocking around that I'd quite
> like to add ALSA support for (for use in Linux sequencers/DAWs) so I've
> been reading up on Linux device drivers and Alsa driver development.
>
> I do have a programming background but unfortunately, I'm a little
> confused on a couple of points and I was hoping someone wouldn't mind
> helping me out.

I know the feeling. I'm just starting out on this too.

>
> I'm kind of basing my thoughts on the idea that I have a USB device which
> is not recognised by the kernel and does not expose a known midi interface
> (so requires a completely new Alsa driver?). The goal would be for this
> device to be usable in Linux midi sequencers.

I would be careful on what you mean by "not recognised by the kernel". In a 
typical distro the "recognition" is not done by the kernel, but by some 
external utility which scans the hardware and attempts to associate the 
devices with drivers. Things like kudzu, harddrake, hotplugging and udev are 
things to research here.

It's entirely possible that the existing alsa modules are compatible with your 
equipment, but that they are not recognised by whatever utility your distro 
uses. It may simply require adding the USB vid/pid to the appropriate config 
files.

Of coure you can probably exeriment by loading the modules manually to see if 
they work.

>
> - How does the Alsa driver communicate with the hardware? Would I need to
> write a Kernel driver (e.g. a character device) for the Alsa driver to
> talk to?
>

Err, dunno, but as you're looking at developing a usb device driver, looking 
at the snd-usb-audio driver code might be a good place to start.

It may well be that a small patch to this code is all that is required, rather 
than developing a new driver from scratch.

Cheers,

-- 
Keith A. Milner
