From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/3] ASoC: max98090: Fix digital microphone
Date: Mon, 24 Nov 2014 15:32:35 +0200
Message-ID: <1416835957-14153-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 327692604FE
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 14:33:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Commit e409dfbfccf9 ("ASoC: dapm: Add a few supply widget sanity checks")
broke digital microphone support in max98090.c:

max98090 i2c-193C9890:00: Conditional paths are not supported for supply widgets (DMICL_ENA -> [DMIC] -> DMIC Mux)
max98090 i2c-193C9890:00: ASoC: no dapm match for DMICL_ENA --> DMIC --> DMIC Mux
max98090 i2c-193C9890:00: ASoC: Failed to add route DMICL_ENA -> DMIC -> DMIC Mux
max98090 i2c-193C9890:00: Conditional paths are not supported for supply widgets (DMICR_ENA -> [DMIC] -> DMIC Mux)
max98090 i2c-193C9890:00: ASoC: no dapm match for DMICR_ENA --> DMIC --> DMIC Mux
max98090 i2c-193C9890:00: ASoC: Failed to add route DMICR_ENA -> DMIC -> DMIC Mux

Problem is partially caused by commit f69e3caa9e18 ("ASoC: max98090: Enable
both DMIC channels also when using mono configuration") which connects
"DMICL_ENA" and "DMICR_ENA" supply widgets to "DMIC Mux".

Fix the breakage by reverting f69e3caa9e18 and then by adding additional
"DMICR_ENA" to "DMICL" and "DMICL_ENA" to "DMICR" cross-connections. This
disconnects these supply widgets from the mux and makes sure that both DMIC
data channels are still enabled together.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/max98090.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 2ad381c4ec57..19258a910974 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1311,6 +1311,10 @@ static const struct snd_soc_dapm_route max98090_dapm_routes[] = {
 	{"MIC1 Input", NULL, "MIC1"},
 	{"MIC2 Input", NULL, "MIC2"},
 
+	{"DMICL", NULL, "DMICL_ENA"},
+	{"DMICL", NULL, "DMICR_ENA"},
+	{"DMICR", NULL, "DMICL_ENA"},
+	{"DMICR", NULL, "DMICR_ENA"},
 	{"DMICL", NULL, "AHPF"},
 	{"DMICR", NULL, "AHPF"},
 
@@ -1368,8 +1372,6 @@ static const struct snd_soc_dapm_route max98090_dapm_routes[] = {
 	{"DMIC Mux", "ADC", "ADCR"},
 	{"DMIC Mux", "DMIC", "DMICL"},
 	{"DMIC Mux", "DMIC", "DMICR"},
-	{"DMIC Mux", "DMIC", "DMICL_ENA"},
-	{"DMIC Mux", "DMIC", "DMICR_ENA"},
 
 	{"LBENL Mux", "Normal", "DMIC Mux"},
 	{"LBENL Mux", "Loopback", "LTENL Mux"},
-- 
2.1.3
