From: yang.a.fang@intel.com
Subject: [PATCH 1/3] ASoC: max98090: read micbias from device
	property
Date: Tue, 26 May 2015 16:58:04 -0700
Message-ID: <1432684686-14460-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F4922652E6
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 01:58:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, "Fang,
 Yang A" <yang.a.fang@intel.com>, praveen.k.jain@intel.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

This patch reads max98090 micbias from acpi or dt

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/codecs/max98090.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index c230626..27df17e 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2419,6 +2419,8 @@ static int max98090_probe(struct snd_soc_codec *codec)
 	struct max98090_cdata *cdata;
 	enum max98090_type devtype;
 	int ret = 0;
+	int err;
+	unsigned int micbias;
 
 	dev_dbg(codec->dev, "max98090_probe\n");
 
@@ -2503,8 +2505,13 @@ static int max98090_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, M98090_REG_BIAS_CONTROL,
 		M98090_VCM_MODE_MASK);
 
+	err = device_property_read_u32(codec->dev, "max,micbias", &micbias);
+
+	if (err)
+		micbias = M98090_MBVSEL_2V8;
+
 	snd_soc_update_bits(codec, M98090_REG_MIC_BIAS_VOLTAGE,
-		M98090_MBVSEL_MASK, M98090_MBVSEL_2V8);
+		M98090_MBVSEL_MASK, micbias);
 
 	max98090_add_widgets(codec);
 
-- 
1.7.9.5
