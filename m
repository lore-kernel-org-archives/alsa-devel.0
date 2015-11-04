From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Apply pin fixup for HP ProBook
	6550b
Date: Wed,  4 Nov 2015 22:41:48 +0100
Message-ID: <1446673308-15659-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 36A9326073E
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 22:41:50 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D8054AAF4
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 21:41:31 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

HP ProBook 6550b needs the same pin fixup applied to other HP B-series
laptops with docks for making its headphone and dock headphone jacks
working properly.  We just need to add the codec SSID to the list.

Bugzilla: https://bugzilla.kernel.org/attachment.cgi?id=191971
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 08a0f6a35cca..826122d8acee 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -702,6 +702,7 @@ static bool hp_bnb2011_with_dock(struct hda_codec *codec)
 static bool hp_blike_system(u32 subsystem_id)
 {
 	switch (subsystem_id) {
+	case 0x103c1473: /* HP ProBook 6550b */
 	case 0x103c1520:
 	case 0x103c1521:
 	case 0x103c1523:
-- 
2.6.2
