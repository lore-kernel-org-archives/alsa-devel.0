From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ALSA: nm256: constify snd_ac97_res_table
Date: Thu, 24 Aug 2017 11:55:28 +0530
Message-ID: <7aada04a5e083b027a5b846c0429aa6385c0ae1e.1503555844.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_ac97_res_table are not supposed to change at runtime. All functions
working with snd_ac97_res_table provided by <sound/ac97_codec.h> work with
const snd_ac97_res_table. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/pci/nm256/nm256.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 0ef8054..b97f4ea 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1271,7 +1271,7 @@ static int nm256_ac97_idx(unsigned short reg)
 }
 
 /* static resolution table */
-static struct snd_ac97_res_table nm256_res_table[] = {
+static const struct snd_ac97_res_table nm256_res_table[] = {
 	{ AC97_MASTER, 0x1f1f },
 	{ AC97_HEADPHONE, 0x1f1f },
 	{ AC97_MASTER_MONO, 0x001f },
-- 
1.9.1
