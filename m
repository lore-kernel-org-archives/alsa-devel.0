From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 08/12] ASoC: wm_adsp: Factor out parsing of
	firmware ID header
Date: Tue, 19 Mar 2019 11:52:11 +0000
Message-ID: <20190319115215.22960-9-ckeepax@opensource.cirrus.com>
References: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41CDCF896FD
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 12:52:18 +0100 (CET)
In-Reply-To: <20190319115215.22960-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, david.rhodes@cirrus.com
List-Id: alsa-devel@alsa-project.org

There is no need to duplicate this code for both ADSP1 and 2 as the
handling is exactly the same.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index fb252762f23ce..acb57dd2c2ad7 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1982,6 +1982,18 @@ static void wm_adsp_free_alg_regions(struct wm_adsp *dsp)
 	}
 }
 
+static void wmfw_parse_id_header(struct wm_adsp *dsp,
+				 struct wmfw_id_hdr *fw, int nalgs)
+{
+	dsp->fw_id = be32_to_cpu(fw->id);
+	dsp->fw_id_version = be32_to_cpu(fw->ver);
+
+	adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
+		  dsp->fw_id, (dsp->fw_id_version & 0xff0000) >> 16,
+		  (dsp->fw_id_version & 0xff00) >> 8, dsp->fw_id_version & 0xff,
+		  nalgs);
+}
+
 static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 {
 	struct wmfw_adsp1_id_hdr adsp1_id;
@@ -2005,13 +2017,8 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 	}
 
 	n_algs = be32_to_cpu(adsp1_id.n_algs);
-	dsp->fw_id = be32_to_cpu(adsp1_id.fw.id);
-	adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
-		  dsp->fw_id,
-		  (be32_to_cpu(adsp1_id.fw.ver) & 0xff0000) >> 16,
-		  (be32_to_cpu(adsp1_id.fw.ver) & 0xff00) >> 8,
-		  be32_to_cpu(adsp1_id.fw.ver) & 0xff,
-		  n_algs);
+
+	wmfw_parse_id_header(dsp, &adsp1_id.fw, n_algs);
 
 	alg_region = wm_adsp_create_region(dsp, WMFW_ADSP1_ZM,
 					   adsp1_id.fw.id, adsp1_id.zm);
@@ -2111,14 +2118,8 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 	}
 
 	n_algs = be32_to_cpu(adsp2_id.n_algs);
-	dsp->fw_id = be32_to_cpu(adsp2_id.fw.id);
-	dsp->fw_id_version = be32_to_cpu(adsp2_id.fw.ver);
-	adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
-		  dsp->fw_id,
-		  (dsp->fw_id_version & 0xff0000) >> 16,
-		  (dsp->fw_id_version & 0xff00) >> 8,
-		  dsp->fw_id_version & 0xff,
-		  n_algs);
+
+	wmfw_parse_id_header(dsp, &adsp2_id.fw, n_algs);
 
 	alg_region = wm_adsp_create_region(dsp, WMFW_ADSP2_XM,
 					   adsp2_id.fw.id, adsp2_id.xm);
-- 
2.11.0
