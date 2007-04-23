From: "Jeffrey Arbuckle" <jbarbuc@gmail.com>
Subject: partial fix for bug #2708: [ALSA - driver] PCI -
	hda-intel
Date: Sun, 22 Apr 2007 20:29:35 -0600
Message-ID: <8114c7980704221929i3e8300ebu6fa2d0ddb38c884@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_141917_7780395.1177295375239"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.237])
	by alsa0.perex.cz (Postfix) with ESMTP id 87D79245EF
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2007 04:29:39 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id m59so1241218wrm
	for <alsa-devel@alsa-project.org>; Sun, 22 Apr 2007 19:29:36 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

------=_Part_141917_7780395.1177295375239
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using alsa-driver-1.0.14rc3 with an iMac Core2 Duo 24" results in audio only
available through the headphones.  Additionally the sound is very low, even
at
the highest mixer setting.

This problem is very similar to the bug recently fixed in 1.0.14rc2 with the
audio
on the MacPro.   I was able to make a patch that applies the same fix for
the MacPro
to my iMac.   The patch fixes the audio so that the built in speakers work
normally,
but now the headphones do not work at all.   Obviously some more work is
needed
on this.

The patch I've attached just adds my device's' PCI SSID to an existing
switch statement.

I am willing to provide some more testing if necessary.



Here is my systems info:

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 02)
        Subsystem: Realtek Semiconductor Co., Ltd. Unknown device 0885
        Flags: bus master, fast devsel, latency 0, IRQ 21
        Memory at 92400000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0

# cat /proc/asound/card0/codec#0
Codec: Realtek ALC885
Address: 0
Vendor Id: 0x10ec0885
Subsystem Id: 0x106b1000
Revision Id: 0x100103

# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.14rc3.
Compiled on Apr 22 2007 for kernel 2.6.20-15-generic (SMP).

------=_Part_141917_7780395.1177295375239
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_141917_7780395.1177295375239--
