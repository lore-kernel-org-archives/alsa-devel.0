From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 07/17] Fix power switching support for
	DAPM_SWITCH widgets.
Date: Thu, 10 Jan 2008 13:17:05 +0000
Message-ID: <1199971035-13553-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1199971035-13553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	by alsa0.perex.cz (Postfix) with ESMTP id 52BC62457A
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 14:17:18 +0100 (CET)
In-Reply-To: <1199971035-13553-6-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Milan plzik <milan.plzik@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Milan plzik <milan.plzik@gmail.com>

Signed-off-by: Milan plzik <milan.plzik@gmail.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d5d3c17..e8d7fae 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -692,7 +692,7 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 	return 0;
 }
 
-/* test and update the power status of a mixer widget */
+/* test and update the power status of a mixer or switch widget */
 static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 				   struct snd_kcontrol *kcontrol, int reg,
 				   int val_mask, int val, int invert)
@@ -700,7 +700,8 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
 	struct snd_soc_dapm_path *path;
 	int found = 0;
 
-	if (widget->id != snd_soc_dapm_mixer)
+	if (widget->id != snd_soc_dapm_mixer &&
+	    widget->id != snd_soc_dapm_switch)
 		return -ENODEV;
 
 	if (!snd_soc_test_bits(widget->codec, reg, val_mask, val))
-- 
1.5.3.8
