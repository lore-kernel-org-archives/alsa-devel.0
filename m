From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Trying to support hda-intel ALC883_CLEVO
Date: Thu, 19 Apr 2007 07:54:49 -0700
Message-ID: <1176994489.21521.21.camel@razman.gruemaster.com>
References: <4626ECCA.8020705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id C2C612457A
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Apr 2007 16:54:55 +0200 (CEST)
In-Reply-To: <4626ECCA.8020705@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pablo N. Hess" <pablonhess@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Could you download and run
http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh and post the
resulting link?  This script will dump information on your system that
we can use to debug this.

Also, for the alc883 in the current code (without your patch), could you
try loading with "model=laptop-eapd"?  Try with the most recent snapshot
from here: ftp://ftp.suse.com/pub/projects/alsa/snapshot/

Tobin

On Thu, 2007-04-19 at 01:15 -0300, Pablo N. Hess wrote:

> I have a Clevo M600 notebook, which comes with Realtek's HDA Intel audio 
> chip. 'lspci -vn' says:
> 
> 00:1b.0 0403: 8086:27d8 (rev 02)
>          Subsystem: 1558:0660
>          Flags: bus master, fast devsel, latency 0, IRQ 16
>          Memory at 6c340000 (64-bit, non-prefetchable) [size=16K]
>          Capabilities: [50] Power Management version 2
>          Capabilities: [60] Message Signalled Interrupts: 64bit+ 
> Queue=0/0 Enable-
>          Capabilities: [70] Express Unknown type IRQ 0
>          Capabilities: [100] Virtual Channel
>          Capabilities: [130] Unknown (5)
> 
> 
> Linux 2.6.20 (Gentoo's gentoo-sources-2.6.20r4) recognizes it as an 
> ALC883 chip, but no parameter combination would make the sound work 
> properly (and that includes 'model=clevo'). As this module ships, no 
> output would come from the built-in speakers, and the headphone volume 
> was miserably low.
> 
> patch_realtek.c supports vendor=1558 device=0660, but only as a ALC880 
> chip. However, mine *is* an ALC883 vendor=1558 device=0660.
> 
> After copying the ALC880_CLEVO support code lines into a new 
> ALC883_CLEVO (and changing every occurence of ALC880 to ALC883 in that 
> new code block), recompiling the kernel and loading the snd-hda-intel 
> with model=clevo, almost everything started working fine. I mean, sound 
> comes as perfectly as it can through the built-in speakers, and the 
> built-in mic also outputs its sound through these speakers.
> 
> However, I can't capture anything. Alsamixer shows no capture device at 
> all (although all playback devices appear to be present).
> 
> This is very strange to me, as the built-in mic really *does* output its 
> sound through the speakers.
> 
> As you can probably see, I don't know anything about sound chips. I just 
> did what seemed understandable (to me) to add proper support for my 
> ALC883_CLEVO device.
> 
> Thank you very much if you can help me solve this issue, as I really 
> need to speak with my family and girlfriend far, far away.
> 
> Cheers,
> Pablo Hess
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
