From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ASoC: mc13783: Fix of_node_put() call with
	uninitialized object
Date: Tue,  7 Oct 2014 18:19:51 +0200
Message-ID: <1412698794-25536-2-git-send-email-tiwai@suse.de>
References: <1412698794-25536-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A154626057F
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 18:20:14 +0200 (CEST)
In-Reply-To: <1412698794-25536-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The commit [a28d167fbbef: ASoC: mc13783: Add missing of_node_put]
fixed the leak of OF node, but it calls of_node_put() unconditionally
at error path where the passed pointer might be uninitialized.  It was
caught by a compiler warning:
 sound/soc/codecs/mc13783.c:787:13: warning: 'np' may be used uninitialized in this function [-Wuninitialized]

This patch adds the NULL initialization properly for fixing this.

Fixes: a28d167fbbef ('ASoC: mc13783: Add missing of_node_put')
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/mc13783.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 388f90a597fa..f54fdf6fc20d 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -749,7 +749,7 @@ static int __init mc13783_codec_probe(struct platform_device *pdev)
 {
 	struct mc13783_priv *priv;
 	struct mc13xxx_codec_platform_data *pdata = pdev->dev.platform_data;
-	struct device_node *np;
+	struct device_node *np = NULL;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-- 
2.1.2
