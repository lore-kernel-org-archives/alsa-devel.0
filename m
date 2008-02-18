From: Jiang zhe <zhe.jiang@intel.com>
Subject: Re: unable to get alsa configured on Acer Aspire 1640Z
Date: Mon, 18 Feb 2008 09:51:05 +0800
Message-ID: <1203299465.3308.4.camel@localhost.localdomain>
References: <20080217171832.GI7750@mulinocarletti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E4F82439E
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 02:51:53 +0100 (CET)
In-Reply-To: <20080217171832.GI7750@mulinocarletti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Lyons <richard@the-place.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-02-18 at 01:18 +0800, Richard Lyons wrote:
> Hi,
> 
> I hope this is the right place to report this.
> 
> Computer: laptop Acer Aspire 1640Z
> 
> distro: Debian etch
> kernel: 2.6.17
> 
> lspci
> 00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
> Family) High Definition Audio Controller (rev 04)
> 
> lspci -nv
> 00:1b.0 0403: 8086:2668 (rev 04)
>         Subsystem: 1025:009e
>         Flags: bus master, fast devsel, latency 0, IRQ 177
>         Memory at d000c000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
> Queue=0/0 Enable-
>         Capabilities: [70] Express Unknown type IRQ 0
>         Capabilities: [100] Virtual Channel
>         Capabilities: [130] Unknown (5)
> 
> I've tried model=acer and acer-aspire to no avail.
> 
> I notice in dmesg after trying 'modprobe snd-hda-intel model=acer'
> this:
>     hda_codec: Unknown model for ALC882, trying auto-probe from
> BIOS...
> 
> but alsamixer shows:
>     Card: HDA Intel
>     Chip: Realtek ALC883
> at the top.
> 
> There seems to be uncertainty about which model number, 882 or 883.

Your kernel is 2.6.17. Its alsa driver is too older.
It didn't provide patch_alc883 for ALC883 codec, but used the
patch_alc882 for it.  AND there is no "model acer" in it.

I suggest that you try latest alsa driver.
Does model=acer or acer-aspire work?


> I wonder if this is the source of the difficulty.
> 
> HTH
> 
> --
> richard Lyons
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 
