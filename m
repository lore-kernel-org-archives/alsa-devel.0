From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Report error code when failing to add
	controls
Date: Mon, 20 Sep 2010 19:15:51 +0100
Message-ID: <1285006551-24084-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 130E024405
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 20:15:54 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Helps with diagnostics.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8d8c5cd..7c64e03 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1983,8 +1983,8 @@ int snd_soc_add_controls(struct snd_soc_codec *codec,
 		const struct snd_kcontrol_new *control = &controls[i];
 		err = snd_ctl_add(card, snd_soc_cnew(control, codec, NULL));
 		if (err < 0) {
-			dev_err(codec->dev, "%s: Failed to add %s\n",
-				codec->name, control->name);
+			dev_err(codec->dev, "%s: Failed to add %s: %d\n",
+				codec->name, control->name, err);
 			return err;
 		}
 	}
-- 
1.7.1
