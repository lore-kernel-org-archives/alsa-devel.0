From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 05/10] ASoC: tlv320aic32x4: Use correct shift
	definition for DATALEN bits
Date: Tue, 12 Dec 2017 16:43:06 -0600
Message-ID: <20171212224311.24045-5-afd@ti.com>
References: <20171212224311.24045-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 92E492677B0
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 23:43:14 +0100 (CET)
In-Reply-To: <20171212224311.24045-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F .
 Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

Setting the DATALEN bit field requires shifting our value by 4. Setting
the OSR value of the PLL divider also requires a shift by 4. Currently
the code abuses this fact and uses the shift for the divider register to
set the data-length register. Fix this here by using the definition meant
for this register.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 01e65d768cab..b3b1ca96bb69 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -722,15 +722,20 @@ static int aic32x4_hw_params(struct snd_pcm_substream *substream,
 	data = data & ~(3 << 4);
 	switch (params_width(params)) {
 	case 16:
+		data |= (AIC32X4_WORD_LEN_16BITS <<
+			 AIC32X4_IFACE1_DATALEN_SHIFT);
 		break;
 	case 20:
-		data |= (AIC32X4_WORD_LEN_20BITS << AIC32X4_DOSRMSB_SHIFT);
+		data |= (AIC32X4_WORD_LEN_20BITS <<
+			 AIC32X4_IFACE1_DATALEN_SHIFT);
 		break;
 	case 24:
-		data |= (AIC32X4_WORD_LEN_24BITS << AIC32X4_DOSRMSB_SHIFT);
+		data |= (AIC32X4_WORD_LEN_24BITS <<
+			 AIC32X4_IFACE1_DATALEN_SHIFT);
 		break;
 	case 32:
-		data |= (AIC32X4_WORD_LEN_32BITS << AIC32X4_DOSRMSB_SHIFT);
+		data |= (AIC32X4_WORD_LEN_32BITS <<
+			 AIC32X4_IFACE1_DATALEN_SHIFT);
 		break;
 	}
 	snd_soc_write(codec, AIC32X4_IFACE1, data);
-- 
2.15.0
