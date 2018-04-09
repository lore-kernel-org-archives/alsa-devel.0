From: Robert Rosengren <robert.rosengren@axis.com>
Subject: [PATCH v2 2/2] ASoC: adau17x1: Do not reload dsp-fw if
	samplerate has not changed
Date: Mon,  9 Apr 2018 15:13:36 +0200
Message-ID: <20180409131336.21990-2-robert.rosengren@axis.com>
References: <20180409131336.21990-1-robert.rosengren@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D02B2673D9
 for <alsa-devel@alsa-project.org>; Mon,  9 Apr 2018 15:14:03 +0200 (CEST)
In-Reply-To: <20180409131336.21990-1-robert.rosengren@axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Robert Rosengren <robertr@axis.com>, Danny Smith <dannys@axis.com>
List-Id: alsa-devel@alsa-project.org

From: Danny Smith <dannys@axis.com>

Reloading fw causes an audiable popping sound, we can avoid this
by not reloading if the samplerate is the same as before.

Signed-off-by: Danny Smith <dannys@axis.com>
Signed-off-by: Robert Rosengren <robert.rosengren@axis.com>
---
 sound/soc/codecs/adau17x1.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 12bf24c26818..ae41edd1c406 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -843,6 +843,15 @@ int adau17x1_setup_firmware(struct snd_soc_component *component,
 	struct adau *adau = snd_soc_component_get_drvdata(component);
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
+	/* Check if sample rate is the same as before. If it is there is no
+	 * point in performing the below steps as the call to
+	 * sigmadsp_setup(...) will return directly when it finds the sample
+	 * rate to be the same as before. By checking this we can prevent an
+	 * audiable popping noise which occours when toggling DSP_RUN.
+	 */
+	if (adau->sigmadsp->current_samplerate == rate)
+		return 0;
+
 	snd_soc_dapm_mutex_lock(dapm);
 
 	ret = regmap_read(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, &dspsr);
-- 
2.11.0
