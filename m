From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: DAPM: Allow update_bits use 32 bits reg
Date: Thu, 17 Apr 2014 20:12:56 +0800
Message-ID: <1397736776-7569-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C88752652C5
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 14:13:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

This patch change reg's type from unsigned short to int.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c8a780d..f4ba7b4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -426,7 +426,7 @@ static void soc_dapm_async_complete(struct snd_soc_dapm_context *dapm)
 }
 
 static int soc_widget_update_bits_locked(struct snd_soc_dapm_widget *w,
-	unsigned short reg, unsigned int mask, unsigned int value)
+	int reg, unsigned int mask, unsigned int value)
 {
 	bool change;
 	unsigned int old, new;
-- 
1.8.1.1.439.g50a6b54
