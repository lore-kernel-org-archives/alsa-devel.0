From: Emmanuel Chanel <emmanuelchanel@gmail.com>
Subject: Fedora 10 x86_64 alsa problem: Realtek ALC889A Audio
 Codec(ATI azalia) not detected on alsa
Date: Sun, 15 Mar 2009 03:50:10 +0900
Message-ID: <1237056610.21086.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 32E4E244D1
	for <alsa-devel@alsa-project.org>; Sat, 14 Mar 2009 19:50:13 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id u3so576475tia.8
	for <alsa-devel@alsa-project.org>; Sat, 14 Mar 2009 11:50:11 -0700 (PDT)
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

I wrote this on
https://bugzilla.redhat.com/show_bug.cgi?id=489828
I've used the driver of kernel package. And Mr. Jaroslav Kysela replied me that I could try snapshot source. (Thx, Mr. Jaroslav Kysela.
And on #alsa on Freenode, Thingol and gnubien advised me much. Thank you!)
But I couldn't get sound back none of both: stable(alsa-driver-1.0.19) and snapshot (alsa-driver-1.0.19.34.g70f78.363.g0ec3b).
My alsa info is on
http://www.alsa-project.org/db/?f=af6a6e787d4bd5212bf766bf5d09fda1ab5e2300
I use desktop. Its mother board is GA-MA69H-S3H . The soundcard is
onboard. Realtek ALC889A Audio Codec.
# lspci |grep -i "multi\|audio\|040[0-3]"
# Audio device: ATI Technologies Inc SB600 Azalia (Intel HDA)
When I installed stable release of alsa-driver --with-debug=verbose ,
dmesg says
HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
ALSA /home/emmanuel/Softwares/alsa-driver-1.0.19/pci/hda/hda_intel.c:2218: chipset global capabilities = 0x4401
ALSA /home/emmanuel/Softwares/alsa-driver-1.0.19/pci/hda/hda_intel.c:786: codec_mask = 0x8
ALSA /home/emmanuel/Softwares/alsa-driver-1.0.19/pci/hda/hda_intel.c:1214: hda_intel: codec #3 probed OK
ALSA /home/emmanuel/Softwares/alsa-driver-1.0.19/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:788: hda_codec: no AFG or MFG node found
ALSA /home/emmanuel/Softwares/alsa-driver-1.0.19/pci/hda/hda_intel.c:1298: hda-intel: no codecs initialized
HDA Intel 0000:00:14.2: PCI INT A disabled

-- 
Emmanuel Chanel <emmanuelchanel@gmail.com>
