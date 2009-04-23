From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 01/21] ASoC: Fix warning in wm9705
Date: Thu, 23 Apr 2009 20:55:35 +0100
Message-ID: <1240516555-22249-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 43F2810389B
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:56:03 +0200 (CEST)
In-Reply-To: <20090423195420.GA20863@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>

I notice that the fixes were merged, minus one:

sound/soc/codecs/wm9705.c: At top level:
sound/soc/codecs/wm9705.c:445: warning: initialization from incompatible pointer type

so you might find this trivial patch useful.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9705.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 6e23a81..c2d1a7a 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -318,7 +318,7 @@ static int wm9705_reset(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int wm9705_soc_suspend(struct platform_device *pdev)
+static int wm9705_soc_suspend(struct platform_device *pdev, pm_message_t msg)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->card->codec;
-- 
1.5.6.3
