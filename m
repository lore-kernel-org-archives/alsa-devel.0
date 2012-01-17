From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Wait for WM8993 FLL to stabilise
Date: Tue, 17 Jan 2012 16:47:49 +0000
Message-ID: <1326818870-10206-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E24C4103A2F
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 17:47:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Ensure the FLL is locked before we return from set_fll().

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8993.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 36562ed..69f5491 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -542,6 +542,12 @@ static int _wm8993_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	/* Enable the FLL */
 	snd_soc_write(codec, WM8993_FLL_CONTROL_1, reg1 | WM8993_FLL_ENA);
 
+	/* Both overestimates */
+	if (Fref < 1000000)
+		msleep(3);
+	else
+		msleep(1);
+
 	dev_dbg(codec->dev, "FLL enabled at %dHz->%dHz\n", Fref, Fout);
 
 	wm8993->fll_fref = Fref;
-- 
1.7.7.3
