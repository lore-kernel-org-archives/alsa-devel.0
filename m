From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda - add ALC889 quick id for Intel Los Lunas
 2 desktop reference board
Date: Wed, 21 Dec 2011 10:20:20 +0800
Message-ID: <20111221022020.GA20195@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id C23DF1038C3
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 03:30:26 +0100 (CET)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/alc882_quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- linux.orig/sound/pci/hda/alc882_quirks.c	2011-12-20 14:16:51.880000058 +0800
+++ linux/sound/pci/hda/alc882_quirks.c	2011-12-20 14:16:58.740000115 +0800
@@ -2955,6 +2955,7 @@ static const struct snd_pci_quirk alc882
 	SND_PCI_QUIRK(0x8086, 0x0002, "DG33FBC", ALC883_3ST_6ch_INTEL),
 	SND_PCI_QUIRK(0x8086, 0x2503, "82801H", ALC883_MITAC),
 	SND_PCI_QUIRK(0x8086, 0x0022, "DX58SO", ALC889_INTEL),
+	SND_PCI_QUIRK(0x8086, 0x7270, "Intel Los Lunas 2", ALC889_INTEL),
 	SND_PCI_QUIRK(0x8086, 0x0021, "Intel IbexPeak", ALC889A_INTEL),
 	SND_PCI_QUIRK(0x8086, 0x3b56, "Intel IbexPeak", ALC889A_INTEL),
 	SND_PCI_QUIRK(0x8086, 0xd601, "D102GGC", ALC882_6ST_DIG),
