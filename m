From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH] replace logical- by bit-and in
 alc_subsystem_id(), sound/pci/hda/patch_realtek.c
Date: Mon, 28 Jan 2008 14:35:39 +0100
Message-ID: <479DDA2B.3030406@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out3.tiscali.nl (smtp-out3.tiscali.nl [195.241.79.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 90C1D103848
	for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2008 14:35:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@suse.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This was found in linus' git tree, am I right here?
--
replace logical- by bit-and

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1c50278..0a13c53 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -739,7 +739,7 @@ static void alc_subsystem_id(struct hda_codec *codec,
 	/* check sum */
 	tmp = 0;
 	for (i = 1; i < 16; i++) {
-		if ((ass >> i) && 1)
+		if ((ass >> i) & 1)
 			tmp++;
 	}
 	if (((ass >> 16) & 0xf) != tmp)
