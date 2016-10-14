From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] SoC: mxs-saif: check validity of ids in
	mxs_saif_probe()
Date: Sat, 15 Oct 2016 00:53:36 +0300
Message-ID: <1476482016-27659-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 95F9A261B36
 for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2016 23:53:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: ldv-project@linuxtesting.org, alsa-devel@alsa-project.org, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>
List-Id: alsa-devel@alsa-project.org

There is a check for validity of one of ids in mxs_saif_probe(),
while array dereferece is made by the other id.

The patch adds the check for the second saif id.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 sound/soc/mxs/mxs-saif.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 13631003cb7c..a002ab892772 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -735,6 +735,11 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	else
 		saif->id = ret;
 
+	if (saif->id >= ARRAY_SIZE(mxs_saif)) {
+		dev_err(&pdev->dev, "get wrong saif id\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * If there is no "fsl,saif-master" phandle, it's a saif
 	 * master.  Otherwise, it's a slave and its phandle points
@@ -749,11 +754,11 @@ static int mxs_saif_probe(struct platform_device *pdev)
 			return ret;
 		else
 			saif->master_id = ret;
-	}
 
-	if (saif->master_id >= ARRAY_SIZE(mxs_saif)) {
-		dev_err(&pdev->dev, "get wrong master id\n");
-		return -EINVAL;
+		if (saif->master_id >= ARRAY_SIZE(mxs_saif)) {
+			dev_err(&pdev->dev, "get wrong master id\n");
+			return -EINVAL;
+		}
 	}
 
 	mxs_saif[saif->id] = saif;
-- 
2.7.4
