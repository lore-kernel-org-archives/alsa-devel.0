From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: txx9: Add __exit_p at necessary place
Date: Mon, 03 Oct 2011 09:38:32 +0800
Message-ID: <1317605912.2588.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 04E76103888
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 03:38:42 +0200 (CEST)
Received: by gyg4 with SMTP id 4so3424306gyg.38
	for <alsa-devel@alsa-project.org>; Sun, 02 Oct 2011 18:38:42 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We have __exit annotation for txx9aclc_generic_remove(),
thus add __devexit_p to wrap it.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/txx9/txx9aclc-generic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc-generic.c b/sound/soc/txx9/txx9aclc-generic.c
index 6770e71..9b5e283 100644
--- a/sound/soc/txx9/txx9aclc-generic.c
+++ b/sound/soc/txx9/txx9aclc-generic.c
@@ -62,7 +62,7 @@ static int __exit txx9aclc_generic_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver txx9aclc_generic_driver = {
-	.remove = txx9aclc_generic_remove,
+	.remove = __exit_p(txx9aclc_generic_remove),
 	.driver = {
 		.name = "txx9aclc-generic",
 		.owner = THIS_MODULE,
-- 
1.7.4.1
