From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: cs47l24: Fixup missing variable typo
Date: Wed, 26 Oct 2016 14:29:27 +0100
Message-ID: <1477488567-25834-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id E108326672F
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 15:29:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Fixes: 31833ead95c2 ("ASoC: arizona: Move request of speaker IRQs into bus probe")
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Apologies for this was a mess up in my test setup missed this one.

Thanks,
Charles

 sound/soc/codecs/cs47l24.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index c5c5a2d..f9e720b 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1313,6 +1313,7 @@ static int cs47l24_probe(struct platform_device *pdev)
 static int cs47l24_remove(struct platform_device *pdev)
 {
 	struct cs47l24_priv *cs47l24 = platform_get_drvdata(pdev);
+	struct arizona *arizona = cs47l24->core.arizona;
 
 	snd_soc_unregister_platform(&pdev->dev);
 	snd_soc_unregister_codec(&pdev->dev);
-- 
2.1.4
