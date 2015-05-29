From: yang.a.fang@intel.com
Subject: [PATCH v3 1/3] ASoC: max98090: read micbias from
	device property
Date: Fri, 29 May 2015 11:56:10 -0700
Message-ID: <1432925772-117760-1-git-send-email-yang.a.fang@intel.com>
References: <1432836048-102175-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E81AA2668BE
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 20:57:00 +0200 (CEST)
In-Reply-To: <1432836048-102175-1-git-send-email-yang.a.fang@intel.com>
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
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, denny.iriawan@intel.com, "Fang,
 Yang A" <yang.a.fang@intel.com>, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

This patch reads max98090 micbias from acpi or dt

Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 .../devicetree/bindings/sound/max98090.txt         |    6 ++++++
 sound/soc/codecs/max98090.c                        |   13 ++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/max98090.txt b/Documentation/devicetree/bindings/sound/max98090.txt
index aa802a2..4e3be66 100644
--- a/Documentation/devicetree/bindings/sound/max98090.txt
+++ b/Documentation/devicetree/bindings/sound/max98090.txt
@@ -18,6 +18,12 @@ Optional properties:
 
 - maxim,dmic-freq: Frequency at which to clock DMIC
 
+- maxim,micbias: Micbias voltage applies to the analog mic, valid voltages value are:
+	0 - 2.2v
+	1 - 2.55v
+	2 - 2.4v
+	3 - 2.8v
+
 Pins on the device (for linking into audio routes):
 
   * MIC1
diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index c230626..679f0a0 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2419,6 +2419,8 @@ static int max98090_probe(struct snd_soc_codec *codec)
 	struct max98090_cdata *cdata;
 	enum max98090_type devtype;
 	int ret = 0;
+	int err;
+	unsigned int micbias;
 
 	dev_dbg(codec->dev, "max98090_probe\n");
 
@@ -2503,8 +2505,17 @@ static int max98090_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, M98090_REG_BIAS_CONTROL,
 		M98090_VCM_MODE_MASK);
 
+	err = device_property_read_u32(codec->dev, "maxim,micbias", &micbias);
+	if (err) {
+		micbias = M98090_MBVSEL_2V8;
+		dev_info(codec->dev, "use default 2.8v micbias\n");
+	} else if (micbias < M98090_MBVSEL_2V2 || micbias > M98090_MBVSEL_2V8) {
+		dev_err(codec->dev, "micbias out of range 0x%x\n", micbias);
+		micbias = M98090_MBVSEL_2V8;
+	}
+
 	snd_soc_update_bits(codec, M98090_REG_MIC_BIAS_VOLTAGE,
-		M98090_MBVSEL_MASK, M98090_MBVSEL_2V8);
+		M98090_MBVSEL_MASK, micbias);
 
 	max98090_add_widgets(codec);
 
-- 
1.7.9.5
