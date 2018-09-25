From: Matt Flax <flatmax@flatmax.org>
Subject: [PATCH v2] ASoC: cs4265: Add a MIC pre. route
Date: Tue, 25 Sep 2018 16:40:18 +1000
Message-ID: <20180925064018.5484-1-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B22E2677FE
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2018 08:40:24 +0200 (CEST)
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
Cc: brian.austin@cirrus.com, broonie@kernel.org, ckeepax@opensource.cirrus.com, paul.handrigan@cirrus.com, Matt Flax <flatmax@flatmax.org>
List-Id: alsa-devel@alsa-project.org

The cs4265 driver is missing a microphone preamp enable.
This patch enables/disables the microphone preamp when mic
selection is made using the kcontrol.

Signed-off-by: Matt Flax <flatmax@flatmax.org>

---
v2: Removed duplicate MIC lines.
---
 sound/soc/codecs/cs4265.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index 275677de..4e55ac46 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -221,10 +221,11 @@ static const struct snd_soc_dapm_route cs4265_audio_map[] = {
 	{"LINEOUTR", NULL, "DAC"},
 	{"SPDIFOUT", NULL, "SPDIF"},
 
+	{"Pre-amp MIC", NULL, "MICL"},
+	{"Pre-amp MIC", NULL, "MICR"},
+	{"ADC Mux", "MIC", "Pre-amp MIC"},
 	{"ADC Mux", "LINEIN", "LINEINL"},
 	{"ADC Mux", "LINEIN", "LINEINR"},
-	{"ADC Mux", "MIC", "MICL"},
-	{"ADC Mux", "MIC", "MICR"},
 	{"ADC", NULL, "ADC Mux"},
 	{"DOUT", NULL, "ADC"},
 	{"DAI1 Capture", NULL, "DOUT"},
-- 
2.17.1
