From: Petr Nosek <petr.nosek@gmail.com>
Subject: no sound in laptop ASUS UX362FA - repair
Date: Sat, 27 Apr 2019 16:07:51 +0100
Message-ID: <CAAqJ6B_FQK=nPHsxwOq4c0YsoBrxaX7gD0QC0L1T0cUVwcAmTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B95E8F80CAB
 for <alsa-devel@alsa-project.org>; Sat, 27 Apr 2019 17:08:04 +0200 (CEST)
Received: by mail-wr1-x441.google.com with SMTP id v16so6310535wrp.1
 for <alsa-devel@alsa-project.org>; Sat, 27 Apr 2019 08:08:04 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

  I bought laptop ASUS UX362FA:
https://www.asus.com/2-in-1-PCs/ASUS-ZenBook-Flip-13-UX362FA/

  The sound didn't work. I was looking for solution and I found this
article:
https://forum.manjaro.org/t/alc294-analog-audio-card-detected-but-no-sound-internaly-or-headphones/54089/29

  So I added this line into (
https://github.com/torvalds/linux/blob/master/sound/pci/hda/patch_realtek.c
):

  SND_PCI_QUIRK(0x1043, 0x13e1, "ASUS UX362FA", ALC294_FIXUP_ASUS_SPK),

  behind this line: SND_PCI_QUIRK(0x1043, 0x10a1, "ASUS UX391UA",
ALC294_FIXUP_ASUS_SPK)

   And recompile kernel and it works. I'm sending this report for others,
who have the same problem with this laptop version. Please add this repair
to kernel for the others.

  Thank you.

   my hwinfo:

root@zenbook:~$ hwinfo --sound
15: PCI 1f.3: 0403 Audio device
  [Created at pci.378]
  Unique ID: nS1_.jsQALdVXpeB
  SysFS ID: /devices/pci0000:00/0000:00:1f.3
  SysFS BusID: 0000:00:1f.3
  Hardware Class: sound
  Model: "Intel Audio device"
  Vendor: pci 0x8086 "Intel Corporation"
  Device: pci 0x9dc8
  SubVendor: pci 0x1043 "ASUSTeK Computer Inc."
  SubDevice: pci 0x13e1
  Revision: 0x30
  Driver: "snd_hda_intel"
  Driver Modules: "snd_hda_intel"
  Memory Range: 0xb1218000-0xb121bfff (rw,non-prefetchable)
  Memory Range: 0xb1000000-0xb10fffff (rw,non-prefetchable)
  IRQ: 127 (100 events)
  Module Alias: "pci:v00008086d00009DC8sv00001043sd000013E1bc04sc03i80"
  Driver Info #0:
    Driver Status: snd_hda_intel is active
    Driver Activation Cmd: "modprobe snd_hda_intel"
  Driver Info #1:
    Driver Status: snd_soc_skl is active
    Driver Activation Cmd: "modprobe snd_soc_skl"
  Config Status: cfg=new, avail=yes, need=no, active=unknown


For repairing it is neccessary to compile kernel. I'm sending solution for
other and if is it possible, please add it in ubuntu kernel.

I reported bug (and solution) also there:
https://bugzilla.kernel.org/show_bug.cgi?id=203443



additional information:

root@zenbook:~$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description: Ubuntu 18.10
Release: 18.10
Codename: cosmic

root@zenbook:~$ uname -a
Linux zenbook 4.20.10-custom #1 SMP Sat Apr 6 21:21:30 CEST 2019 x86_64
x86_64 x86_64 GNU/Linux

kernel compiled and patched from this source:
https://kernel.ubuntu.com/~kernel-ppa/mainline/v4.20/

and added line:

  SND_PCI_QUIRK(0x1043, 0x13e1, "ASUS UX362FA", ALC294_FIXUP_ASUS_SPK),

into /sound/pci/hda/patch_realtek.c file


Petr
