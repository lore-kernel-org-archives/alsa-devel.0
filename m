From: Kevin Groeneveld <kgroeneveld@lenbrook.com>
Subject: [PATCH] ASOC: fsl_spdif: fix bit order for spdif RX
	channel status
Date: Wed, 23 Sep 2015 10:00:47 -0400
Message-ID: <1443016847-29857-1-git-send-email-kgroeneveld@lenbrook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lenbrook.com (mail.lenbrook.com [206.191.95.214])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CEF6265310
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 16:01:20 +0200 (CEST)
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
Cc: timur@tabi.org, Xiubo.Lee@gmail.com, tiwai@suse.com, nicoleotsuka@gmail.com, Kevin Groeneveld <kgroeneveld@lenbrook.com>
List-Id: alsa-devel@alsa-project.org

The bits within each byte of the hardware registers for the channel status
bits are reversed. Therefore when the channel status is read from the
hardware we need to reverse the bits.

The code which writes the channel status bits for the TX already correctly
reverses the bits. This patch implements similar functionality for the RX.

I have tested this patch running on imx6 using several different SPDIF
source devices.

Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
---
 sound/soc/fsl/fsl_spdif.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index ab729f2..e84e839 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -676,14 +676,14 @@ static int fsl_spdif_capture_get(struct snd_kcontrol *kcontrol,
 		return -EAGAIN;
 
 	regmap_read(regmap, REG_SPDIF_SRCSH, &cstatus);
-	ucontrol->value.iec958.status[0] = (cstatus >> 16) & 0xFF;
-	ucontrol->value.iec958.status[1] = (cstatus >> 8) & 0xFF;
-	ucontrol->value.iec958.status[2] = cstatus & 0xFF;
+	ucontrol->value.iec958.status[0] = bitrev8((cstatus >> 16) & 0xFF);
+	ucontrol->value.iec958.status[1] = bitrev8((cstatus >> 8) & 0xFF);
+	ucontrol->value.iec958.status[2] = bitrev8(cstatus & 0xFF);
 
 	regmap_read(regmap, REG_SPDIF_SRCSL, &cstatus);
-	ucontrol->value.iec958.status[3] = (cstatus >> 16) & 0xFF;
-	ucontrol->value.iec958.status[4] = (cstatus >> 8) & 0xFF;
-	ucontrol->value.iec958.status[5] = cstatus & 0xFF;
+	ucontrol->value.iec958.status[3] = bitrev8((cstatus >> 16) & 0xFF);
+	ucontrol->value.iec958.status[4] = bitrev8((cstatus >> 8) & 0xFF);
+	ucontrol->value.iec958.status[5] = bitrev8(cstatus & 0xFF);
 
 	/* Clear intr */
 	regmap_write(regmap, REG_SPDIF_SIC, INT_CNEW);
-- 
1.7.4.1
