From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 2/2] ASoC: mxs-sgtl5000: Do not print error on
	probe deferral
Date: Wed, 17 Jan 2018 13:46:21 -0200
Message-ID: <1516203981-6333-2-git-send-email-fabio.estevam@nxp.com>
References: <1516203981-6333-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0041.outbound.protection.outlook.com [104.47.34.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 016DC26708E
 for <alsa-devel@alsa-project.org>; Wed, 17 Jan 2018 16:46:32 +0100 (CET)
In-Reply-To: <1516203981-6333-1-git-send-email-fabio.estevam@nxp.com>
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Probe deferral may happen, so do not print an error message in this
case.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/mxs/mxs-sgtl5000.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index b593f76..2b3f240 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -163,8 +163,9 @@ static int mxs_sgtl5000_probe(struct platform_device *pdev)
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
-			ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
+				ret);
 		return ret;
 	}
 
-- 
2.7.4
