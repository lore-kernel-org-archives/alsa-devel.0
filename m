From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 05/17] ASoC: Ux500: Minor coding layout changes
Date: Fri, 24 Aug 2012 15:01:41 +0100
Message-ID: <1345816913-4113-6-git-send-email-lee.jones@linaro.org>
References: <1345816913-4113-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id D0954265D9A
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2012 16:02:20 +0200 (CEST)
Received: by mail-wg0-f51.google.com with SMTP id ed3so1060503wgb.20
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2012 07:02:20 -0700 (PDT)
In-Reply-To: <1345816913-4113-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, roger.xr.nilsson@stericsson.com, broonie@opensource.wolfsonmicro.com, STEricsson_nomadik_linux@list.st.com, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

Includes removal of duplicate debug print affirming entry into
the probe function, an unnecessary line break of a coding line
<80 chars and a white space change (unintentional tab).

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/mop500.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index 6840df7..356611d 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -88,8 +88,6 @@ static int __devinit mop500_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	pr_debug("%s: Enter.\n", __func__);
-
 	dev_dbg(&pdev->dev, "%s: Enter.\n", __func__);
 
 	mop500_card.dev = &pdev->dev;
@@ -117,8 +115,7 @@ static int __devinit mop500_probe(struct platform_device *pdev)
 	ret = snd_soc_register_card(&mop500_card);
 	if (ret)
 		dev_err(&pdev->dev,
-			"Error: snd_soc_register_card failed (%d)!\n",
-			ret);
+			"Error: snd_soc_register_card failed (%d)!\n", ret);
 
 	return ret;
 }
@@ -131,7 +128,7 @@ static int __devexit mop500_remove(struct platform_device *pdev)
 
 	snd_soc_unregister_card(mop500_card);
 	mop500_ab8500_remove(mop500_card);
-	
+
 	return 0;
 }
 
-- 
1.7.9.5
