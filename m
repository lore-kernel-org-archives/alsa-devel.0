From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5110: Unregister compressed platform
	when driver is removed
Date: Thu, 21 Jan 2016 14:41:12 +0000
Message-ID: <1453387272-3674-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id A821526062B
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 15:41:17 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The driver was not unregistering the compressed platform in
wm5110_remove(). If the codec is built as a module, this would
lead to a NULL pointer deref if the module was unloaded and then
re-probed.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 6088d30..97c0f1e 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2382,6 +2382,7 @@ error:
 
 static int wm5110_remove(struct platform_device *pdev)
 {
+	snd_soc_unregister_platform(&pdev->dev);
 	snd_soc_unregister_codec(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
1.9.1
