From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: hdspm: fix spelling mistake "Externel" -> "External"
Date: Mon, 22 Aug 2016 12:50:02 +0100
Message-ID: <20160822115002.10355-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_warn message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/rme9652/hdspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index a4a999a..0e51a00 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1666,7 +1666,7 @@ static int hdspm_set_rate(struct hdspm * hdspm, int rate, int called_internally)
 			    HDSPM_AUTOSYNC_FROM_NONE) {
 
 				dev_warn(hdspm->card->dev,
-					 "Detected no Externel Sync\n");
+					 "Detected no External Sync\n");
 				not_set = 1;
 
 			} else if (rate != external_freq) {
-- 
2.9.3
