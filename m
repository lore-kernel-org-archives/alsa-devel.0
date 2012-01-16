From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8983: Remove useless snd_kcontrol
Date: Mon, 16 Jan 2012 10:44:13 +0000
Message-ID: <1326710653-16853-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C6613246AC
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 11:44:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

This must be a leftover from a previous driver.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8983.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index 17f04ec..7053880 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -249,9 +249,6 @@ static const char *eq5_cutoff_text[] = {
 static const SOC_ENUM_SINGLE_DECL(eq5_cutoff, WM8983_EQ5_HIGH_SHELF, 5,
 				  eq5_cutoff_text);
 
-static const char *speaker_mode_text[] = { "Class A/B", "Class D" };
-static const SOC_ENUM_SINGLE_DECL(speaker_mode, 0x17, 8, speaker_mode_text);
-
 static const char *depth_3d_text[] = {
 	"Off",
 	"6.67%",
@@ -369,8 +366,6 @@ static const struct snd_kcontrol_new wm8983_snd_controls[] = {
 	SOC_SINGLE_TLV("EQ5 Volume", WM8983_EQ5_HIGH_SHELF, 0, 24, 1, eq_tlv),
 
 	SOC_ENUM("3D Depth", depth_3d),
-
-	SOC_ENUM("Speaker Mode", speaker_mode)
 };
 
 static const struct snd_kcontrol_new left_out_mixer[] = {
-- 
1.7.8.3
