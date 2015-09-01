From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: au1x: psc-i2s: Fix unused variable 'ret'
	warning
Date: Tue, 01 Sep 2015 14:50:15 +0800
Message-ID: <1441090215.22437.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 6578A261AA1
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2015 08:50:20 +0200 (CEST)
Received: by pacgr6 with SMTP id gr6so15466284pac.3
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 23:50:20 -0700 (PDT)
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
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fix below build warning:
sound/soc/au1x/psc-i2s.c: In function 'au1xpsc_i2s_drvprobe':
sound/soc/au1x/psc-i2s.c:299:6: warning: unused variable 'ret' [-Wunused-variable]

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/au1x/psc-i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index 38e853a..0bf9d62 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -296,7 +296,6 @@ static int au1xpsc_i2s_drvprobe(struct platform_device *pdev)
 {
 	struct resource *iores, *dmares;
 	unsigned long sel;
-	int ret;
 	struct au1xpsc_audio_data *wd;
 
 	wd = devm_kzalloc(&pdev->dev, sizeof(struct au1xpsc_audio_data),
-- 
2.1.0
