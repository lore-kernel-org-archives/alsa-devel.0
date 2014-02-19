From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add QEMU codec vendor ID
Date: Wed, 19 Feb 2014 11:13:01 +0100
Message-ID: <1392804781-9614-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 32B7C2610D7
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 11:13:02 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A145BAC95
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 10:13:01 +0000 (UTC)
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 4be322b0d745..115502783b64 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -67,6 +67,7 @@ static struct hda_vendor_id hda_vendor_ids[] = {
 	{ 0x17e8, "Chrontel" },
 	{ 0x1854, "LG" },
 	{ 0x1aec, "Wolfson Microelectronics" },
+	{ 0x1af4, "QEMU" },
 	{ 0x434d, "C-Media" },
 	{ 0x8086, "Intel" },
 	{ 0x8384, "SigmaTel" },
-- 
1.8.5.2
