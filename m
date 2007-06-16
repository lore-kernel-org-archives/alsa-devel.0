From: "Furkan Cayci" <furkanca02@gmail.com>
Subject: Sound problem in Toshiba
Date: Sat, 16 Jun 2007 17:02:52 -0400
Message-ID: <957855860706161402o649cc43fk615534213164e50d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EF711103820
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jun 2007 23:02:53 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id a29so2280751pyi
	for <alsa-devel@alsa-project.org>; Sat, 16 Jun 2007 14:02:53 -0700 (PDT)
Content-Disposition: inline
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

I am using Ubuntu 7.04.
After installing Ubuntu, I could't hear any sound from
my Toshiba Satellite A205-S4577, so I did the things
related with this article;
http://pastebin.ca/522731

After restarting laptop, I didn't take any errors, but there was
no sound again. Then I realized the output of the dmesg.

$ dmesg|grep alsa
[   18.948000] ALSA /home/leonetix/alsa-driver/pci/hda/hda_codec.c:2339:
autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0)
[   18.948000] ALSA /home/leonetix/alsa-driver/pci/hda/hda_codec.c:2343:
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   18.948000] ALSA /home/leonetix/alsa-driver/pci/hda/hda_codec.c:2347:
hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
[   18.948000] ALSA /home/leonetix/alsa-driver/pci/hda/hda_codec.c:2355:
inputs: mic=0x19, fmic=0x18, line=0x0, fline=0x0, cd=0x0, aux=0x0
[   19.672000] ALSA
/home/leonetix/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:244:
si3054: cannot initialize. EXT MID = 0000
[   19.680000] ALSA
/home/leonetix/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:256:
Link Frame Detect(FDT) is not ready (line status: 0000)
[   33.572000] ALSA /home/leonetix/alsa-driver/pci/hda/hda_codec.c:1810:
hda_codec: model 'auto' is selected
[   33.620000] ALSA /home/leonetix/alsa-driver/pci/hda/hda_codec.c:2339:
autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0)
[   33.620000] ALSA /home/leonetix/alsa-driver/pci/hda/hda_codec.c:2343:
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   33.620000] ALSA /home/leonetix/alsa-driver/pci/hda/hda_codec.c:2347:
hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
[   33.620000] ALSA /home/leonetix/alsa-driver/pci/hda/hda_codec.c:2355:
inputs: mic=0x19, fmic=0x18, line=0x0, fline=0x0, cd=0x0, aux=0x0
[   34.360000] ALSA
/home/leonetix/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:244:
si3054: cannot initialize. EXT MID = 0000
[   34.368000] ALSA
/home/leonetix/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:256:
Link Frame Detect(FDT) is not ready (line status: 0000)
-------------------------

So, there is something wrong, but I didn't understand
and I was wondering if you could solve or show a way to do it.

Also, here is the output of lcpci -v
"00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
        Subsystem: Toshiba America Info Systems Unknown device ff10
        Flags: bus master, fast devsel, latency 0, IRQ 21
        Memory at f0b40000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0"

Thanks for your help,
Furkan
