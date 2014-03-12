From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 01/12] ASoC: ams-delta: Fix compile error
Date: Wed, 12 Mar 2014 15:27:29 +0100
Message-ID: <1394634460-15889-2-git-send-email-lars@metafoo.de>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-175.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id E1788264EED
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 15:27:13 +0100 (CET)
In-Reply-To: <1394634460-15889-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

snd_soc_dapm_mutex_unlock() wants a pointer to the DAPM context, not the CODEC.

Fixes: 03510ca07 ("ASoC: ams-delta: Update locking around use of DAPM pin API")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/omap/ams-delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 5750de1..14718cd 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -327,7 +327,7 @@ static void cx81801_close(struct tty_struct *tty)
 
 	snd_soc_dapm_sync_unlocked(dapm);
 
-	snd_soc_dapm_mutex_unlock(codec);
+	snd_soc_dapm_mutex_unlock(dapm);
 }
 
 /* Line discipline .hangup() */
-- 
1.8.0
