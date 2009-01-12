From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] ALSA: hda - add support for Intel DX58SO board
Date: Mon, 12 Jan 2009 09:18:58 +0800
Message-ID: <20090112011858.GA7309@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F7791037ED
	for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 02:19:24 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The Intel DX58SO board works fine with model ALC883_3ST_6ch_INTEL.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- mm.orig/sound/pci/hda/patch_realtek.c
+++ mm/sound/pci/hda/patch_realtek.c
@@ -8522,6 +8522,7 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x1991, 0x5625, "Haier W66", ALC883_HAIER_W66),
 	SND_PCI_QUIRK(0x8086, 0x0001, "DG33BUC", ALC883_3ST_6ch_INTEL),
 	SND_PCI_QUIRK(0x8086, 0x0002, "DG33FBC", ALC883_3ST_6ch_INTEL),
+	SND_PCI_QUIRK(0x8086, 0x0022, "DX58SO", ALC883_3ST_6ch_INTEL),
 	SND_PCI_QUIRK(0x8086, 0xd601, "D102GGC", ALC883_3ST_6ch),
 	{}
 };
