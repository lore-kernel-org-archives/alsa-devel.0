From: Robert Hancock <hancockrwd@gmail.com>
Subject: VIA HDA patch problem (was [PATCH 17/31] HDA
	patch_via.c: Add second S/PDIF out control for VT1708S and VT1702.)
Date: Fri, 9 Oct 2009 23:48:01 -0600
Message-ID: <51f3faa70910092248g78dcad83s556cc106047de159@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f198.google.com (mail-iw0-f198.google.com
	[209.85.223.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A27224433
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Oct 2009 07:48:02 +0200 (CEST)
Received: by iwn36 with SMTP id 36so4823873iwn.24
	for <alsa-devel@alsa-project.org>; Fri, 09 Oct 2009 22:48:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Li Bo <liboat@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, HaraldWelte@viatech.com, LoganLi@viatech.com.cn, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

It looks like there's some problem somewhere in the patch set posted
on Oct. 7th that wasn't in the original patch set from the 5th: I
can't open the mixer for the HDA device:

alsamixer -c 1
cannot load mixer controls: Operation not permitted

>From strace:

open("/dev/snd/controlC1", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0x7fff338e57fc) = 0
fcntl(3, F_GETFL)                       = 0x8002 (flags O_RDWR|O_LARGEFILE)
fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK|O_LARGEFILE) = 0
ioctl(3, USBDEVFS_RELEASEINTERFACE, 0x7fff338e5990) = 0
ioctl(3, USBDEVFS_RELEASEINTERFACE, 0x7fff338e5990) = 0
ioctl(3, USBDEVFS_CONNECTINFO, 0x7fff338e5670) = 0
ioctl(3, USBDEVFS_IOCTL, 0x7fff338e4ea0) = -1 EPERM (Operation not permitted)

Presumably something is creating a control that isn't readable, or
writable or something, and this is causing the mixer to fail to load?

Also, with regard to the SPDIF problem I'm seeing on my Asus P7P55D
(VT1828S), I was able to dig up a little bit more info: by using
hda_analyzer to set the ENABLE flag on the Digital Converter, I was
able to get the optical SPDIF port to light up and my receiver
indicates PCM input. Unfortunately there's still no actual audio
coming through on the receiver, just silence. However, obviously that
ENABLE flag is going to have to get set somehow to have any hope of
SPDIF working, and currently it seems like it's not..
