From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Fix power switching support for DAPM_SWITCH
	widgets.
Date: Tue, 20 Nov 2007 09:25:32 +0000
Message-ID: <1195550746-6892-10-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-9-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E8EC0249E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 10:45:29 +0100 (CET)
In-Reply-To: <1195550746-6892-9-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: liam.girdwood@opensource.wolfsonmicro.com, Liam Girdwood <liam@localhost.localdomain>, Milan plzik <milan.plzik@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam@localhost.localdomain>

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
1.5.3.5
