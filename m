From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 4/7] ASoC: Intel: bytcr_rt5651: Revert "Fix
	DMIC map headsetmic mapping"
Date: Sun, 30 Dec 2018 00:00:22 +0100
Message-ID: <20181229230025.21949-5-hdegoede@redhat.com>
References: <20181229230025.21949-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 8953A267A65
 for <alsa-devel@alsa-project.org>; Sun, 30 Dec 2018 00:00:38 +0100 (CET)
In-Reply-To: <20181229230025.21949-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, flove@realtek.com, shumingf@realtek.com, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit 37c7401e8c1f ("ASoC: Intel: bytcr_rt5651: Fix DMIC map
headsetmic mapping"), changed the headsetmic mapping from IN3P to IN2P,
this was based on the observation that all bytcr_rt5651 devices I have
access to (7 devices) where all using IN3P for the headsetmic. This was
an attempt to unifify / simplify the mapping, but it was wrong.

None of those devices was actually using a digital internal mic. Now I've
access to a Point of View TAB-P1006W-232 (v1.0) tabler, which does use a
DMIC and it does have its headsetmic connected to IN2P, showing that the
original mapping was correct, so this commit reverts the change changing
the mapping back to IN2P.

Fixes: 37c7401e8c1f ("ASoC: Intel: bytcr_rt5651: Fix DMIC map ... mapping")
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index e528995668b7..0ed844f2ad01 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -266,7 +266,7 @@ static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
 static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic_map[] = {
 	{"DMIC L1", NULL, "Internal Mic"},
 	{"DMIC R1", NULL, "Internal Mic"},
-	{"IN3P", NULL, "Headset Mic"},
+	{"IN2P", NULL, "Headset Mic"},
 };
 
 static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_map[] = {
-- 
2.20.1
