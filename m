From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda/realtek - Add support of ALC231
	codec
Date: Tue, 26 Nov 2013 09:41:11 +0100
Message-ID: <1385455272-13202-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 05A512608A2
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 09:41:13 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CDEE0A7B44
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 09:41:12 +0100 (CET)
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

From: Kailang Yang <kailang@realtek.com>

It's compatible with ALC269.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5e42059f10a1..60973fd6eb82 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5175,6 +5175,7 @@ static int patch_alc680(struct hda_codec *codec)
  */
 static const struct hda_codec_preset snd_hda_preset_realtek[] = {
 	{ .id = 0x10ec0221, .name = "ALC221", .patch = patch_alc269 },
+	{ .id = 0x10ec0231, .name = "ALC231", .patch = patch_alc269 },
 	{ .id = 0x10ec0233, .name = "ALC233", .patch = patch_alc269 },
 	{ .id = 0x10ec0255, .name = "ALC255", .patch = patch_alc269 },
 	{ .id = 0x10ec0260, .name = "ALC260", .patch = patch_alc260 },
-- 
1.8.4.3
