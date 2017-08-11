From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ASoC: blackfin: Use common error handling
 code in sport_create()
Date: Fri, 11 Aug 2017 22:42:20 +0200
Message-ID: <ef3f99a2-7e51-ff07-8e68-3d74495854a9@users.sourceforge.net>
References: <e1ef440e-ed53-92f8-c30c-37c0b42cb351@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 6441E266D12
 for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2017 22:42:26 +0200 (CEST)
In-Reply-To: <e1ef440e-ed53-92f8-c30c-37c0b42cb351@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: adi-buildroot-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Scott Jiang <scott.jiang.linux@gmail.com>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 11 Aug 2017 22:02:47 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/soc/blackfin/bf6xx-sport.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/blackfin/bf6xx-sport.c b/sound/soc/blackfin/bf6xx-sport.c
index 1bc3e0a47a57..fcddebf2558c 100644
--- a/sound/soc/blackfin/bf6xx-sport.c
+++ b/sound/soc/blackfin/bf6xx-sport.c
@@ -394,19 +394,18 @@ struct sport_device *sport_create(struct platform_device *pdev)
 	sport->pdev = pdev;
 
 	ret = sport_get_resource(sport);
-	if (ret) {
-		kfree(sport);
-		return NULL;
-	}
+	if (ret)
+		goto free_data;
 
 	ret = sport_request_resource(sport);
-	if (ret) {
-		kfree(sport);
-		return NULL;
-	}
+	if (ret)
+		goto free_data;
 
 	dev_dbg(dev, "SPORT create success\n");
 	return sport;
+free_data:
+	kfree(sport);
+	return NULL;
 }
 EXPORT_SYMBOL(sport_create);
 
-- 
2.14.0
