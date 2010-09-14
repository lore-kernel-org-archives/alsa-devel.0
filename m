From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Fwd: Microphone not working on PCI ID 8086:3b56
Date: Wed, 15 Sep 2010 06:59:27 +0800
Message-ID: <AANLkTik68HBrRA9x2zGL9y9PUq5BvkEY0zLCWY8Ld6jf@mail.gmail.com>
References: <Pine.LNX.4.64.1009150615510.4515@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A993E10388B
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Sep 2010 00:59:27 +0200 (CEST)
Received: by wyb32 with SMTP id 32so7801341wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2010 15:59:27 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009150615510.4515@boston.corp.fedex.com>
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

Hi,

I'm having problem getting the microphone to work on the Lenovo X201s,
but the audio output is working fine.


It's showing up as:

00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset
High Definition Audio (rev 06)
=A0 =A0 =A0 =A0[00:1b.0 0403: 8086:3b56 (rev 06)]


# uname -s
Linux boston 2.6.36-rc4 #57 SMP PREEMPT Tue Sep 14 05:12:21 EDT 2010
x86_64 GNU/Linux


# cat /proc/asound/devices
=A00: [ 0] =A0 : control
=A016: [ 0- 0]: digital audio playback
=A024: [ 0- 0]: digital audio capture
=A033: =A0 =A0 =A0 =A0: timer
160: [ 5] =A0 : control


# cat /proc/asound/pcm
00-00: CONEXANT Analog : CONEXANT Analog : playback 1 : capture 1


# dmesg
thinkpad_acpi: Console audio control enabled, mode: override (read/write)
input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/inpu=
t6
HDA Intel 0000:00:1b.0: PCI INT B -> GSI 17 (level, low) -> IRQ 17
HDA Intel 0000:00:1b.0: irq 45 for MSI/MSI-X
HDA Intel 0000:00:1b.0: setting latency timer to 64
hda-codec: No codec parser is available
ALSA device list:
=A0#0: HDA Intel at 0xf2520000 irq 45
=A0#5: ThinkPad Console Audio Control at EC reg 0x30, fw 6QHT29WW-1.10



I've alsa-plugins-1.0.23, alsa-utils-1.0.23, alsa-lib-1.0.23 installed.

alsamixer is showing Capture at 100%, Analog Mic Boost at 40db and
Digital at 100, but captured using "arecord" or "rec" and then
playback is all just dead silence!

Any pointers on how to make this work would be very much appreciated.


Thanks,
Jeff
