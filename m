From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/7] ASoC: Sort specialised mixers and muxes
	together
Date: Mon,  8 Jun 2009 15:28:50 +0100
Message-ID: <1244471333-6485-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090608142734.GA6137@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BDDD824459
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 16:28:57 +0200 (CEST)
In-Reply-To: <20090608142734.GA6137@rakim.wolfsonmicro.main>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The more flexible value muxes and named mixers don't need to be sorted
differently from a power management point of view, they are different
only in terms of the control interface and not in terms of seqencing
behaviour.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 66f07cd..9187db1 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -57,15 +57,15 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_micbias] = 2,
 	[snd_soc_dapm_mic] = 3,
 	[snd_soc_dapm_mux] = 4,
-	[snd_soc_dapm_value_mux] = 5,
-	[snd_soc_dapm_dac] = 6,
-	[snd_soc_dapm_mixer] = 7,
-	[snd_soc_dapm_mixer_named_ctl] = 8,
-	[snd_soc_dapm_pga] = 9,
-	[snd_soc_dapm_adc] = 10,
-	[snd_soc_dapm_hp] = 11,
-	[snd_soc_dapm_spk] = 12,
-	[snd_soc_dapm_post] = 13,
+	[snd_soc_dapm_value_mux] = 4,
+	[snd_soc_dapm_dac] = 5,
+	[snd_soc_dapm_mixer] = 6,
+	[snd_soc_dapm_mixer_named_ctl] = 6,
+	[snd_soc_dapm_pga] = 7,
+	[snd_soc_dapm_adc] = 8,
+	[snd_soc_dapm_hp] = 9,
+	[snd_soc_dapm_spk] = 10,
+	[snd_soc_dapm_post] = 11,
 };
 
 static int dapm_down_seq[] = {
@@ -75,14 +75,14 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_spk] = 3,
 	[snd_soc_dapm_pga] = 4,
 	[snd_soc_dapm_mixer_named_ctl] = 5,
-	[snd_soc_dapm_mixer] = 6,
-	[snd_soc_dapm_dac] = 7,
-	[snd_soc_dapm_mic] = 8,
-	[snd_soc_dapm_micbias] = 9,
-	[snd_soc_dapm_mux] = 10,
-	[snd_soc_dapm_value_mux] = 11,
-	[snd_soc_dapm_supply] = 12,
-	[snd_soc_dapm_post] = 13,
+	[snd_soc_dapm_mixer] = 5,
+	[snd_soc_dapm_dac] = 6,
+	[snd_soc_dapm_mic] = 7,
+	[snd_soc_dapm_micbias] = 8,
+	[snd_soc_dapm_mux] = 9,
+	[snd_soc_dapm_value_mux] = 9,
+	[snd_soc_dapm_supply] = 10,
+	[snd_soc_dapm_post] = 11,
 };
 
 static void pop_wait(u32 pop_time)
-- 
1.6.3.1
