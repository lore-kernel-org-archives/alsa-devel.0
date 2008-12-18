From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Complain if we fail to create DAPM
	controls
Date: Thu, 18 Dec 2008 17:30:57 +0000
Message-ID: <1229621458-2144-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081218173021.GA25332@rakim.wolfsonmicro.main>
	<1229621458-2144-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1229621458-2144-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 746A81037EB
	for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2008 18:30:59 +0100 (CET)
In-Reply-To: <1229621458-2144-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This should never happen and it's helpful to identify the specific control
that failed when it does happen.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 61d7d85..8863edd 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1320,8 +1320,12 @@ int snd_soc_dapm_new_controls(struct snd_soc_codec *codec,
 
 	for (i = 0; i < num; i++) {
 		ret = snd_soc_dapm_new_control(codec, widget);
-		if (ret < 0)
+		if (ret < 0) {
+			printk(KERN_ERR
+			       "ASoC: Failed to create DAPM control %s: %d\n",
+			       widget->name, ret);
 			return ret;
+		}
 		widget++;
 	}
 	return 0;
-- 
1.5.6.5
