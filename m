From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5102: Apply a SYSCLK patch for later
	revs
Date: Wed,  6 Mar 2013 14:20:21 +0800
Message-ID: <1362550821-14859-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 91EAD265327
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 07:28:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Evaluation has identified some performance improvements to the device.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index deb1097..cef288c 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -573,6 +573,13 @@ static const struct reg_default wm5102_sysclk_reva_patch[] = {
 	{ 0x025e, 0x0112 },
 };
 
+static const struct reg_default wm5102_sysclk_revb_patch[] = {
+	{ 0x3081, 0x08FE },
+	{ 0x3083, 0x00ED },
+	{ 0x30C1, 0x08FE },
+	{ 0x30C3, 0x00ED },
+};
+
 static int wm5102_sysclk_ev(struct snd_soc_dapm_widget *w,
 			    struct snd_kcontrol *kcontrol, int event)
 {
@@ -587,6 +594,10 @@ static int wm5102_sysclk_ev(struct snd_soc_dapm_widget *w,
 		patch = wm5102_sysclk_reva_patch;
 		patch_size = ARRAY_SIZE(wm5102_sysclk_reva_patch);
 		break;
+	default:
+		patch = wm5102_sysclk_revb_patch;
+		patch_size = ARRAY_SIZE(wm5102_sysclk_revb_patch);
+		break;
 	}
 
 	switch (event) {
-- 
1.7.10.4
