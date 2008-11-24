From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/9] ASoC: TWL4030: Add CGAIN volume control
Date: Mon, 24 Nov 2008 13:49:36 +0200
Message-ID: <1227527383-22516-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1227527383-22516-1-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 5866924363
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 12:51:24 +0100 (CET)
In-Reply-To: <1227527383-22516-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Add CGAIN (Coarse gain control) to TWL4030 codec.
The range of the CGAIN is:
0 dB to 12 dB in 6 dB steps.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 498c42f..91effd3 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -196,10 +196,20 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
  */
 static DECLARE_TLV_DB_SCALE(master_tlv, -6300, 100, 1);
 
+/*
+ * CGAIN volume control:
+ * 0 dB to 12 dB in 6 dB steps
+ * value 2 and 3 means 12 dB
+ */
+static DECLARE_TLV_DB_SCALE(master_coarse_tlv, 0, 600, 0);
+
 static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Master Playback Volume",
 		 TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
 		0, 0x3f, 0, master_tlv),
+	SOC_DOUBLE_R_TLV("Master PCM Playback Volume",
+		 TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
+		6, 0x2, 0, master_coarse_tlv),
 	SOC_DOUBLE_R("Capture Volume",
 		 TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
 		0, 0x1f, 0),
-- 
1.6.0.3
