From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: ali5451: fix spelling mistake in
	"ali_capture_preapre"
Date: Sat, 29 Apr 2017 22:52:55 +0100
Message-ID: <20170429215255.11711-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0394C26648D
 for <alsa-devel@alsa-project.org>; Sat, 29 Apr 2017 23:53:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in dev_warn message,
"ali_capture_preapre" should be "ali_capture_prepare"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/ali5451/ali5451.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 92b819e4f729..34bbc2e730a6 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -1339,7 +1339,7 @@ static int snd_ali_prepare(struct snd_pcm_substream *substream)
 		rate = snd_ali_get_spdif_in_rate(codec);
 		if (rate == 0) {
 			dev_warn(codec->card->dev,
-				 "ali_capture_preapre: spdif rate detect err!\n");
+				 "ali_capture_prepare: spdif rate detect err!\n");
 			rate = 48000;
 		}
 		spin_lock_irq(&codec->reg_lock);
-- 
2.11.0
