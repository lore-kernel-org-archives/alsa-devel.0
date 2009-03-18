From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [2.6.30][topic/asoc][PATCH 1/2] ASoC: OMAP: N810: Mark
	not connected input pins
Date: Wed, 18 Mar 2009 16:46:53 +0200
Message-ID: <1237387614-27295-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id A852E1038DC
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 15:47:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/n810.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 86471fd..f203221 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -254,6 +254,11 @@ static int n810_aic33_init(struct snd_soc_codec *codec)
 	snd_soc_dapm_nc_pin(codec, "MONO_LOUT");
 	snd_soc_dapm_nc_pin(codec, "HPLCOM");
 	snd_soc_dapm_nc_pin(codec, "HPRCOM");
+	snd_soc_dapm_nc_pin(codec, "MIC3L");
+	snd_soc_dapm_nc_pin(codec, "MIC3R");
+	snd_soc_dapm_nc_pin(codec, "LINE1R");
+	snd_soc_dapm_nc_pin(codec, "LINE2L");
+	snd_soc_dapm_nc_pin(codec, "LINE2R");
 
 	/* Add N810 specific controls */
 	err = snd_soc_add_controls(codec, aic33_n810_controls,
-- 
1.6.2
