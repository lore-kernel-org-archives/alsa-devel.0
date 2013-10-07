From: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
Subject: Re: [PATCH v2] ALSA: snd-usb-usx2y: remove bogus frame
	checks
Date: Mon, 7 Oct 2013 17:20:29 +0100
Message-ID: <1715855.gPWHk3iGiy@arial>
References: <1380728990-8443-1-git-send-email-zonque@gmail.com>
 <s5ha9ildrge.wl%tiwai@suse.de> <5252D48D.5060608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hillend.cent.gla.ac.uk (hillend.cent.gla.ac.uk [130.209.16.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DE05265160
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 18:25:15 +0200 (CEST)
In-Reply-To: <5252D48D.5060608@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Guido Aulisi <guido.aulisi@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Monday 07 October 2013 16:34:37 you wrote:
> On 07.10.2013 17:35, Takashi Iwai wrote:
> > At Mon, 07 Oct 2013 17:11:44 +0200,
> > 
> > Daniel Mack wrote:
> >> On 07.10.2013 16:58, Dr Nicholas J Bailey wrote:
> >>> For me, this patch alone fails in much the same way (possibly exactly
> >>> the same way) as before the previous patch.
> >>> 
> >>> From audacity (probably not much use unless you know the source code...
> >>> I
> >> 
> >>> don't):
> >> [...]
> >> 
> >>> nick@arial:/usr/src$ dmesg | tail
> >>> [  111.667015] usb 2-1.6.4: New USB device strings: Mfr=0, Product=0,
> >>> SerialNumber=0
> >>> [  114.707156] Sequence Error!(hcd_frame=3 ep=8in;wait=1024,frame=0).
> >>> [  114.707156] Most probably some urb of usb-frame 1024 is still
> >>> missing.
> >> 
> >> You certainly haven't booted a kernel which contains the patch we're
> >> talking about here. The only occurance of the error message you quote
> >> was removed by this patch, so a patched kernel can't possibly produce
> >> what you see in your logs.
> > 
> > Nicholas booted a kernel without your fix patch but only with my patch
> > to disable the -EPIPE check, in order to see whether the latter alone
> > suffices or not.  So he's testing with a right kernel :)
> 
> Oh, so *I* was referring to the wrong patch then.
> Apologies for causing confusion :)
> 
> 
> Daniel

That's cool, Daniel. Actually, I've not written anything for the kernel since 
1.x (it was an intravascular ultrasound board my PhD student built - it was a 
hardware project and the sorfware was never distributed). Things have changed 
a *lot* since then, and I never used make-dpkg before this, so please keep on 
checking I do the right thing!

The only thing I *might* have screwed up is that both the kernels are called 
3.10.11 as far as uname -a is concerned, but are in separate debs. So the 
patch which took out

	static void usX2Y_error_sequence(
		struct usX2Ydev *usX2Y,
		struct snd_usX2Y_substream *subs, struct urb *urb)

and the bit about

	if (likely((urb->start_frame & 0xFFFF) == (usX2Y->wait_iso_frame & 
0xFFFF)))
		subs->completed_urb = urb;
	else {
		usX2Y_error_sequence(usX2Y, subs, urb);
		return;
	}

are in a deb called

	linux-image-3.10.11_3.10.11.TASCAM.2_i386.deb

and the one with Takashi's cpp directive /only/ based on a fresh source tree 
from the debian source package is in

	linux-image-3.10.11_3.10.11.TASCAM.3_i386.deb

I'm installing the package I want to play with, and there's a message to say I 
should reboot ASAP because of potential module conflicts, and that when I do 
the machine will recompute the mod deps for me, so I do, and that's that.

Probably a bit of a hack, but I don't think it's stupidly wrong (unless you 
know different).

Bottom line is:
	TASCAM.2 works with no complaints;
	TASCAM.3 (with just the #if 0...#endif and no other changes to 3.10.11) 
gives the stalls and dmesg messages.

The only other thing I changed was the processor. I selected core2 because I 
thought it would be nice to have a custom kernel for once :)

I hope I've not been wasting your time.

Nick/.
