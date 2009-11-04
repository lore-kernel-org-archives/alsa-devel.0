From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] ALSA: hda - Add OLPC XO-1.5 PCI ID
Date: Wed,  4 Nov 2009 10:11:07 +0000 (GMT)
Message-ID: <20091104101107.8A4E59D4044@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mtaout03-winn.ispmail.ntl.com (mtaout03-winn.ispmail.ntl.com
	[81.103.221.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 90FB3103840
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2009 11:11:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, devel@lists.laptop.org
List-Id: alsa-devel@alsa-project.org

The XO-1.5 laptop now has a unique subvendor/subproduct ID, which can
be used to automatically select the correct CXT5066 configuration.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 sound/pci/hda/patch_conexant.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 3fbbc8c..6479e65 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -2325,6 +2325,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
 		      CXT5066_LAPTOP),
 	SND_PCI_QUIRK(0x1028, 0x02f5, "Dell",
 		      CXT5066_DELL_LAPTOP),
+	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT5066_OLPC_XO_1_5),
 	{}
 };
 
-- 
1.6.2.5
