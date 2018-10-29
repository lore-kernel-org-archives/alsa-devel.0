From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH 1/2] ASoC: pcm3060: Add control for
	differential output
Date: Mon, 29 Oct 2018 09:59:12 +0100
Message-ID: <20181029085913.17298-1-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from host.euro-space.net (host.euro-space.net [87.117.239.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 58FA52675B8
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2018 09:57:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Kirill Marinushkin <kmarinushkin@birdec.tech>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

DAC may be switched between differential and single-ended output.

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 sound/soc/codecs/pcm3060.c | 9 +++++++++
 sound/soc/codecs/pcm3060.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 494d9d662be8..f792ad637ae4 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -179,6 +179,13 @@ static struct snd_soc_dai_driver pcm3060_dai[] = {
 
 /* dapm */
 
+static const char * const pcm3060_dapm_out_dif_txt[] = {
+	"Differential", "Single-Ended"
+};
+
+static SOC_ENUM_SINGLE_DECL(pcm3060_dapm_out_dif_enum, PCM3060_REG64,
+			    PCM3060_REG_SHIFT_SE, pcm3060_dapm_out_dif_txt);
+
 static DECLARE_TLV_DB_SCALE(pcm3060_dapm_tlv, -10050, 50, 1);
 
 static const struct snd_kcontrol_new pcm3060_dapm_controls[] = {
@@ -195,6 +202,8 @@ static const struct snd_kcontrol_new pcm3060_dapm_controls[] = {
 			       0, pcm3060_dapm_tlv),
 	SOC_DOUBLE("Master Capture Switch", PCM3060_REG73,
 		   PCM3060_REG_SHIFT_MUT11, PCM3060_REG_SHIFT_MUT12, 1, 1),
+
+	SOC_ENUM("DAC Out Differential", pcm3060_dapm_out_dif_enum),
 };
 
 static const struct snd_soc_dapm_widget pcm3060_dapm_widgets[] = {
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index fd89a68aa8a7..32080ff00166 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -38,6 +38,7 @@ int pcm3060_remove(struct device *dev);
 #define PCM3060_REG_ADPSV		0x20
 #define PCM3060_REG_DAPSV		0x10
 #define PCM3060_REG_SE			0x01
+#define PCM3060_REG_SHIFT_SE		0x00
 
 #define PCM3060_REG65			0x41
 #define PCM3060_REG66			0x42
-- 
2.13.6
