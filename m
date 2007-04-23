From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: partial fix for bug #2708: [ALSA - driver] PCI
	-	hda-intel
Date: Sun, 22 Apr 2007 23:16:56 -0700
Message-ID: <1177309016.4274.4.camel@razman.gruemaster.com>
References: <8114c7980704221929i3e8300ebu6fa2d0ddb38c884@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FD5B247A2
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2007 08:16:57 +0200 (CEST)
In-Reply-To: <8114c7980704221929i3e8300ebu6fa2d0ddb38c884@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jeffrey Arbuckle <jbarbuc@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Could you try a more recent driver version from
ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver ?

There have been a lot of changes since 14rc3 was released, including
some Mac specific changes, although it may not be specific to your
system.

Also, if you could, rebuild 14rc2 with "./configure
--with-cards=hda-intel --with-debug=detect", reload them and test that
headphones work again, and send me the output from "dmesg|fgrep ALSA",
so I can hopefully determine which Node the headphones are on.
Additionally, if you could run
http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh on both 14rc2
and the latest driver for comparison, that would really help.

Thanks,

Tobin Davis

On Sun, 2007-04-22 at 20:29 -0600, Jeffrey Arbuckle wrote:

> Using alsa-driver-1.0.14rc3 with an iMac Core2 Duo 24" results in audio only
> available through the headphones.  Additionally the sound is very low, even
> at
> the highest mixer setting.
> 
> This problem is very similar to the bug recently fixed in 1.0.14rc2 with the
> audio
> on the MacPro.   I was able to make a patch that applies the same fix for
> the MacPro
> to my iMac.   The patch fixes the audio so that the built in speakers work
> normally,
> but now the headphones do not work at all.   Obviously some more work is
> needed
> on this.
> 
> The patch I've attached just adds my device's' PCI SSID to an existing
> switch statement.
> 
> I am willing to provide some more testing if necessary.
> 
> 
> 
> Here is my systems info:
> 
> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition
> Audio Controller (rev 02)
>         Subsystem: Realtek Semiconductor Co., Ltd. Unknown device 0885
>         Flags: bus master, fast devsel, latency 0, IRQ 21
>         Memory at 92400000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
> Queue=0/0 Enable-
>         Capabilities: [70] Express Unknown type IRQ 0
> 
> # cat /proc/asound/card0/codec#0
> Codec: Realtek ALC885
> Address: 0
> Vendor Id: 0x10ec0885
> Subsystem Id: 0x106b1000
> Revision Id: 0x100103
> 
> # cat /proc/asound/version
> Advanced Linux Sound Architecture Driver Version 1.0.14rc3.
> Compiled on Apr 22 2007 for kernel 2.6.20-15-generic (SMP).
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
