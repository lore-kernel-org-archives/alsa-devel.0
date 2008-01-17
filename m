From: Jiang zhe <zhe.jiang@intel.com>
Subject: A Weird issue on Gigabyte board
Date: Thu, 17 Jan 2008 16:44:07 +0800
Message-ID: <1200559447.30641.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 489F22467A
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 09:43:20 +0100 (CET)
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

I meet with a weird issue.
Please refer to the bug 0003674 on bugtrack.alsa-project.org.

It use alc889 codec but the codec vendor id is 0885.

With the alsa-driver-hg20080110.tar.bz2, it works well with option
"model=6stack-dig".

But after I simply added the this line into the alc882_cfg_tbl[]:
SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte P35-DS3R", ALC882_6ST_DIG),

The dmesg still show "hda_codec: Unknown model for ALC882, trying
auto-probe from BIOS...". and driver will crash.

With this patch, even loading it with option "model=6stack-dig" doesn't
help, driver will still crash.

I found a line in the dmesg:
"hda_intel: azx_get_response timeout, switching to polling mode: last
cmd=0xbe0f0009."
The Cad is 0xb.

The codec_mask can change from 0x4 to 0x1:
alsa-kernel/pci/hda/hda_intel.c:732: codec_mask = 0x4
alsa-kernel/pci/hda/hda_intel.c:732: codec_mask = 0x1

The os is kubuntu,kernel version is 2.6.22-14.

Here is some dmesg info:
[ 36.934143]
ALSA /home/matt/Data/alsa-driver-hg20080110/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:732: codec_mask = 0x4
[ 36.935975] hda-codec: In the pacth_alc882,board_config is -1
[ 36.935976] hda_codec: Unknown model for ALC882, trying auto-probe from
BIOS...
[ 36.936469]
ALSA /home/matt/Data/alsa-driver-hg20080110/pci/hda/hda_codec.c:2794:
autoconfig: line_outs=4 (0x14/0x15/0x16/0x17/0x0)
[ 36.936471]
ALSA /home/matt/Data/alsa-driver-hg20080110/pci/hda/hda_codec.c:2798:
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[ 36.936473]
ALSA /home/matt/Data/alsa-driver-hg20080110/pci/hda/hda_codec.c:2802:
hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[ 36.936476]
ALSA /home/matt/Data/alsa-driver-hg20080110/pci/hda/hda_codec.c:2810:
inputs: mic=0x18, fmic=0x19, line=0x1a, fline=0x0, cd=0x0, aux=0x0
[ 37.935491]
ALSA /home/matt/Data/alsa-driver-hg20080110/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:581: hda_intel: azx_get_response timeout, switching to polling mode: last cmd=0xe1cf0009
[ 38.936857]
ALSA /home/matt/Data/alsa-driver-hg20080110/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:588: hda_intel: azx_get_response timeout, switching to single_cmd mode: last cmd=0xe1cf0009
[ 38.936937]
ALSA /home/matt/Data/alsa-driver-hg20080110/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:644: hda-intel: get_response timeout: IRS=0x1
[ 38.936940]
ALSA /home/matt/Data/alsa-driver-hg20080110/pci/hda/hda_codec.c:2065:
BUG? (info->nid)
[ 38.936946] [<f8c19bc0>] snd_hda_build_pcms+0x1e0/0x220 [snd_hda_intel]
[ 38.936962] [<f8c1598c>] azx_probe+0x71c/0xa50 [snd_hda_intel]
[ 38.936974] [<f8c14850>] azx_send_cmd+0x0/0x130 [snd_hda_intel]
[ 38.936981] [<f8c14980>] azx_get_response+0x0/0x200 [snd_hda_intel]
[ 38.936991] [<f8c146c0>] azx_power_notify+0x0/0x70 [snd_hda_intel]
[ 38.937002] [<c0209a66>] pci_device_probe+0x56/0x80
[ 38.937008] [<c026110e>] driver_probe_device+0x8e/0x190
[ 38.937013] [<c026137e>] __driver_attach+0x9e/0xa0
[ 38.937017] [<c02604fb>] bus_for_each_dev+0x3b/0x60
[ 38.937022] [<c0260f86>] driver_attach+0x16/0x20
[ 38.937024] [<c02612e0>] __driver_attach+0x0/0xa0
[ 38.937026] [<c02608ca>] bus_add_driver+0x8a/0x1b0
[ 38.937031] [<c0209c13>] __pci_register_driver+0x53/0xa0
[ 38.937035] [<c014a7d1>] sys_init_module+0x151/0x1a00
[ 38.937038] [<c01fb39f>] prio_tree_insert+0x1f/0x250
[ 38.937052] [<c01041d2>] sysenter_past_esp+0x6b/0xa9
[ 38.937058] =======================
[ 38.937097] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[ 38.937102] HDA Intel: probe of 0000:00:1b.0 failed with error -22
[ 38.937124] ACPI: PCI Interrupt 0000:01:00.1[B] -> GSI 17 (level, low)
-> IRQ 23
[ 38.937134] PCI: Setting latency timer of device 0000:01:00.1 to 64
[ 38.952813]
ALSA /home/matt/Data/alsa-driver-hg20080110/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:732: codec_mask = 0x1
