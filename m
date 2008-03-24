From: Jiang zhe <zhe.jiang@intel.com>
Subject: [PATCH]PCI quirk for MSI laptop
Date: Mon, 24 Mar 2008 13:45:43 +0800
Message-ID: <1206337543.4680.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-l9EXUcm/iFMut8rjXLBu"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id C36F31037F8
	for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2008 06:47:35 +0100 (CET)
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
Cc: tiwai@suse.de, zhe.jiang@intel.com
List-Id: alsa-devel@alsa-project.org


--=-l9EXUcm/iFMut8rjXLBu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Please refer to [0003848] on the alsa mantis.
This patch adds the pci quirk and Mic-Int controller.

Thanks!

Signed-off-by: Jiang zhe <zhe.jiang@intel.com>

--=-l9EXUcm/iFMut8rjXLBu
Content-Disposition: attachment; filename=3848-alc888-msi.patch
Content-Type: text/x-patch; name=3848-alc888-msi.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- alsa-driver-hg20080318/alsa-kernel/pci/hda/patch_realtek.c	2008-03-15 09:00:07.000000000 +0800
+++ b/alsa-kernel/pci/hda/patch_realtek.c	2008-03-19 15:59:05.000000000 +0800
@@ -6864,6 +6864,9 @@ static struct snd_kcontrol_new alc883_ta
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Int Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_MUTE("Int Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x08, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x08, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x09, 0x0, HDA_INPUT),
@@ -7761,6 +7764,7 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x1462, 0x0349, "MSI", ALC883_TARGA_2ch_DIG),
 	SND_PCI_QUIRK(0x1462, 0x040d, "MSI", ALC883_TARGA_2ch_DIG),
 	SND_PCI_QUIRK(0x1462, 0x0579, "MSI", ALC883_TARGA_2ch_DIG),
+	SND_PCI_QUIRK(0x1462, 0x2fb3, "MSI", ALC883_TARGA_2ch_DIG),
 	SND_PCI_QUIRK(0x1462, 0x3729, "MSI S420", ALC883_TARGA_DIG),
 	SND_PCI_QUIRK(0x1462, 0x3783, "NEC S970", ALC883_TARGA_DIG),
 	SND_PCI_QUIRK(0x1462, 0x3b7f, "MSI", ALC883_TARGA_2ch_DIG),

--=-l9EXUcm/iFMut8rjXLBu
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-l9EXUcm/iFMut8rjXLBu--
