From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: Moving sound/* to drivers/ ?
Date: Thu, 22 May 2008 17:50:29 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0805221735570.9332@fbirervta.pbzchgretzou.qr>
References: <s5hzlqjz74d.wl%tiwai@suse.de> <4834B252.1080700@garzik.org> <4834B5E2.3040301@keyaccess.nl> <s5hy7623fqs.wl%tiwai@suse.de> <alpine.LNX.1.10.0805221052050.971@fbirervta.pbzchgretzou.qr>
 <alpine.LFD.1.10.0805220758000.3081@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755316AbYEVPum@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.10.0805220758000.3081@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


On Thursday 2008-05-22 17:04, Linus Torvalds wrote:
>On Thu, 22 May 2008, Jan Engelhardt wrote:
>> 
>> I am in favor of keeping /sound around with the
>> non-hardware-dependent code, much like /block does with regard to
>> /drivers/block.
>
>I'd personally *much* rather have just one subdirectory.
>[...] BUT:
> - perhaps more importantly, it's totally different from 'sound' in that 
>   the block/ and drivers/block/ maintainership is actually *separate*.
>[...]
>So I'd personally much rather see just one drivers/sound/ than have this 
>split up.

Surveille et rapport.

I took a look at how FreeBSD does this, just for comparison.
They have a single ${src}/dev/sound, but also no split "net" otoh
afaics. As always, if you think Linux should have a drivers/sound/,
just direct your lieutenants to do so.
