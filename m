From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 05/10] ASoC: Ux500: Match platform by device
	node when booting Device Tree
Date: Tue, 19 Nov 2013 11:07:44 +0000
Message-ID: <1384859269-19801-6-git-send-email-lee.jones@linaro.org>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C4A642615B9
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 12:08:14 +0100 (CET)
Received: by mail-oa0-f51.google.com with SMTP id i7so3404493oag.24
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 03:08:14 -0800 (PST)
In-Reply-To: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
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
Cc: linus.walleij@linaro.org, Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We're getting closer to fully enabling the Ux500 ASoC driver for Device
Tree. When we switch over from using AUXDATA we'll need to match platform
by only Device Tree nodes. In this patch we NULL out the platform_name,
and supply nodes for each platform device.

Cc: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/mop500.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index 178d1ba..b3b66aa 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -91,6 +91,8 @@ static int mop500_of_probe(struct platform_device *pdev,
 	for (i = 0; i < 2; i++) {
 		mop500_dai_links[i].cpu_of_node = msp_np[i];
 		mop500_dai_links[i].cpu_dai_name = NULL;
+		mop500_dai_links[i].platform_of_node = msp_np[i];
+		mop500_dai_links[i].platform_name = NULL;
 		mop500_dai_links[i].codec_of_node = codec_np;
 		mop500_dai_links[i].codec_name = NULL;
 	}
-- 
1.8.1.2
