From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 19/22] ASoC: tas2552: Add control for selecting
	DIN source
Date: Thu, 4 Jun 2015 15:22:43 +0300
Message-ID: <1433420571-5421-20-git-send-email-peter.ujfalusi@ti.com>
References: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id D0243266480
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 14:23:39 +0200 (CEST)
In-Reply-To: <1433420571-5421-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'DIN source' enum can be used to select the DIN Source (muted, left, right
or average of left and right channels).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 01230395b61d..64abc932732d 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -556,9 +556,20 @@ static struct snd_soc_dai_driver tas2552_dai[] = {
  */
 static DECLARE_TLV_DB_SCALE(dac_tlv, -7, 100, 0);
 
+static const char * const tas2552_din_source_select[] = {
+	"Muted",
+	"Left",
+	"Right",
+	"Left + Right average",
+};
+static SOC_ENUM_SINGLE_DECL(tas2552_din_source_enum,
+			    TAS2552_CFG_3, 3,
+			    tas2552_din_source_select);
+
 static const struct snd_kcontrol_new tas2552_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Driver Playback Volume",
 			 TAS2552_PGA_GAIN, 0, 0x1f, 0, dac_tlv),
+	SOC_ENUM("DIN source", tas2552_din_source_enum),
 };
 
 static int tas2552_codec_probe(struct snd_soc_codec *codec)
-- 
2.4.2
