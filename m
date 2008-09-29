From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/6] ASoC: Use snd_soc_dapm_nc_pin() in N810
	machine driver
Date: Mon, 29 Sep 2008 14:44:33 +0100
Message-ID: <1222695873-20252-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080929133951.GA20161@rakim.wolfsonmicro.main>
	<1222695873-20252-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1222695873-20252-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1222695873-20252-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1222695873-20252-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1222695873-20252-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B1C3243A4
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 15:44:35 +0200 (CEST)
In-Reply-To: <1222695873-20252-5-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/n810.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index d166b6b..fae3ad3 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -247,9 +247,9 @@ static int n810_aic33_init(struct snd_soc_codec *codec)
 	int i, err;
 
 	/* Not connected */
-	snd_soc_dapm_disable_pin(codec, "MONO_LOUT");
-	snd_soc_dapm_disable_pin(codec, "HPLCOM");
-	snd_soc_dapm_disable_pin(codec, "HPRCOM");
+	snd_soc_dapm_nc_pin(codec, "MONO_LOUT");
+	snd_soc_dapm_nc_pin(codec, "HPLCOM");
+	snd_soc_dapm_nc_pin(codec, "HPRCOM");
 
 	/* Add N810 specific controls */
 	for (i = 0; i < ARRAY_SIZE(aic33_n810_controls); i++) {
-- 
1.5.6.5
