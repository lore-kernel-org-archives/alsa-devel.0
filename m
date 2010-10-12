From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add WM8962 microphone bias control
Date: Tue, 12 Oct 2010 19:37:17 +0100
Message-ID: <1286908637-10424-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F263B1037F1
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 20:37:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We unconditionally require SYSCLK since while only microphone detection
specifically requires SYSCLK any actual use case would enable it via
some other means but microphone detection may have nothing active other
than the bias itself.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index e5009d0..894d0cd 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2566,6 +2566,8 @@ static const struct snd_soc_dapm_route wm8962_intercon[] = {
 	{ "MIXINR", "IN3R Switch", "IN3R" },
 	{ "MIXINR", "PGA Switch", "INPGAR" },
 
+	{ "MICBIAS", NULL, "SYSCLK" },
+
 	{ "ADCL", NULL, "SYSCLK" },
 	{ "ADCL", NULL, "TOCLK" },
 	{ "ADCL", NULL, "MIXINL" },
-- 
1.7.1
