From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] ASoC: max98090: Enable both DMIC channels
	also when using mono configuration
Date: Fri, 26 Sep 2014 16:25:37 +0300
Message-ID: <1411737938-29903-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CC732604CC
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 15:25:50 +0200 (CEST)
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
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

According to MAX98090 specification "Digital microphone clock (DMC) is
enabled once both data channels are enabled.". Therefore both digital
microphone data channels must be enabled also when using mono microphone
configuration.

Fix this by moving "DMICL_ENA" and "DMICR_ENA" supply widgets from "DMICL"
and "DMICR" inputs to "DMIC Mux" in order to enable both data channels
whenever there is active mono or stereo digital microphone input path.

Use of "DMICL" and "DMICR" inputs are retained for informative source and in
case the driver would find use for exact digital microphone configuration in
the future.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
for-next, only byt-max98090 uses DMIC and I noticed this after disabling
unused codec pins.
---
 sound/soc/codecs/max98090.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index f2a3f30a5d9f..d519294f57c7 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1311,8 +1311,6 @@ static const struct snd_soc_dapm_route max98090_dapm_routes[] = {
 	{"MIC1 Input", NULL, "MIC1"},
 	{"MIC2 Input", NULL, "MIC2"},
 
-	{"DMICL", NULL, "DMICL_ENA"},
-	{"DMICR", NULL, "DMICR_ENA"},
 	{"DMICL", NULL, "AHPF"},
 	{"DMICR", NULL, "AHPF"},
 
@@ -1370,6 +1368,8 @@ static const struct snd_soc_dapm_route max98090_dapm_routes[] = {
 	{"DMIC Mux", "ADC", "ADCR"},
 	{"DMIC Mux", "DMIC", "DMICL"},
 	{"DMIC Mux", "DMIC", "DMICR"},
+	{"DMIC Mux", "DMIC", "DMICL_ENA"},
+	{"DMIC Mux", "DMIC", "DMICR_ENA"},
 
 	{"LBENL Mux", "Normal", "DMIC Mux"},
 	{"LBENL Mux", "Loopback", "LTENL Mux"},
-- 
2.1.0
