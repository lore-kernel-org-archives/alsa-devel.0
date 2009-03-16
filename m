From: Emmanuel Chanel <emmanuelchanel@gmail.com>
Subject: Re: My PC has 6GB memory but the limitation of the
 alsa-driver is 4GB.
Date: Mon, 16 Mar 2009 22:18:03 +0900
Message-ID: <1237209483.13649.3.camel@localhost.localdomain>
References: <1237056610.21086.72.camel@localhost.localdomain>
	<fd3eb9bf0903141235v1878ae03h8e51b8bcebb4c87d@mail.gmail.com>
	<1237061065.2581.3.camel@localhost.localdomain>
	<1237093356.3501.45.camel@localhost.localdomain>
	<s5hocw2rl9y.wl%tiwai@suse.de>
	<1237197183.3501.64.camel@localhost.localdomain>
	<s5hocw1rdoq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 2910010382E
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 14:18:09 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id u3so975200tia.8
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 06:18:08 -0700 (PDT)
In-Reply-To: <s5hocw1rdoq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ok. I could patch.
I did 
$ ./configure --with-debug=verbose
$ make
$ su -c 'make install'

The result is below and it's not detected on alsa. Pulse's Volume
Control says no hardware devices but "Null Sound Output".

[root@star1 ~]# date -R
Mon, 16 Mar 2009 22:11:14 +0900
[root@star1 ~]# modprobe snd_hda_intel
[root@star1 ~]# tail /var/log/messages
Mar 16 22:03:50 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:924: hda_codec: no AFG or MFG node found
Mar 16 22:03:50 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1297: hda-intel: no codecs initialized
Mar 16 22:03:50 star1 kernel: HDA Intel 0000:00:14.2: PCI INT A disabled
Mar 16 22:11:22 star1 kernel: HDA Intel 0000:00:14.2: PCI INT A -> GSI
16 (level, low) -> IRQ 16
Mar 16 22:11:22 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:2228: chipset global capabilities = 0x4401
Mar 16 22:11:22 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:786: codec_mask = 0x8
Mar 16 22:11:22 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1214: hda_intel: codec #3 probed OK
Mar 16 22:11:22 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_codec.c:924: hda_codec: no AFG or MFG node found
Mar 16 22:11:22 star1 kernel:
ALSA /home/emmanuel/Softwares/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:1297: hda-intel: no codecs initialized
Mar 16 22:11:22 star1 kernel: HDA Intel 0000:00:14.2: PCI INT A disabled
[root@star1 ~]# lspci |grep -i "multi\|audio\|040[0-3]"
00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)

-- 
Emmanuel Chanel <emmanuelchanel@gmail.com>
