From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: TWL4030: Fix for digital loopback gain
	range
Date: Mon, 12 Jul 2010 11:50:06 +0300
Message-ID: <1278924606-5462-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E3B324678
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jul 2010 10:50:39 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

When the gain is configured using dB value it was
not possible to use -24dB since the loopback got
muted instead of -24dB.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 8d36bfa..d7f0048 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -540,10 +540,11 @@ static const struct snd_kcontrol_new twl4030_dapm_abypassl2_control =
 static const struct snd_kcontrol_new twl4030_dapm_abypassv_control =
 	SOC_DAPM_SINGLE("Switch", TWL4030_REG_VDL_APGA_CTL, 2, 1, 0);
 
-/* Digital bypass gain, 0 mutes the bypass */
+/* Digital bypass gain, mute instead of -30dB */
 static const unsigned int twl4030_dapm_dbypass_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
-	0, 3, TLV_DB_SCALE_ITEM(-2400, 0, 1),
+	TLV_DB_RANGE_HEAD(3),
+	0, 1, TLV_DB_SCALE_ITEM(-3000, 600, 1),
+	2, 3, TLV_DB_SCALE_ITEM(-2400, 0, 0),
 	4, 7, TLV_DB_SCALE_ITEM(-1800, 600, 0),
 };
 
-- 
1.7.1
