From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: simple-card: Add pm callbacks to
	platform driver
Date: Mon, 9 May 2016 13:38:10 +0300
Message-ID: <1462790290-5346-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 440B526062E
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 12:38:18 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Set snd_soc_pm_ops for the pm ops to make sure that the ASoC level of PM
operations are going to happen. This is needed to get suspend/resume
working correctly when the audio is using simple-card.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Mark,

we have moved most of the TI boards to use simple-card and I have noticed that
we have quite bad regression because of it caused by simple-card not having the
pm ops configured. This will render audio to not recover after suspend/resume
when the audio IP is loosing context.

Regards,
Peter

 sound/soc/generic/simple-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index c6111e7a6d93..52a1e1ff3c62 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -658,6 +658,7 @@ MODULE_DEVICE_TABLE(of, asoc_simple_of_match);
 static struct platform_driver asoc_simple_card = {
 	.driver = {
 		.name = "asoc-simple-card",
+		.pm = &snd_soc_pm_ops,
 		.of_match_table = asoc_simple_of_match,
 	},
 	.probe = asoc_simple_card_probe,
-- 
2.8.1
