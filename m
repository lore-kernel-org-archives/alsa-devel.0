From: klem.dev@gmail.com
Subject: [PATCH 2/4] ESI W192M: Add TLV Support.
Date: Sat,  5 Oct 2013 15:41:03 +0200
Message-ID: <525016ec.a556b40a.02db.ffff9b70@mx.google.com>
References: <1380980465-5961-1-git-send-email-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1380980465-5961-1-git-send-email-me>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Clement Guedez <klem.dev@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Clement Guedez <klem.dev@gmail.com>

Add TLV support for control value in dB scale for Ego Sys Waveterminal 192M.

Signed-off-by: Clement Guedez <klem.dev@gmail.com>
---
 sound/pci/ice1712/wtm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/pci/ice1712/wtm.c b/sound/pci/ice1712/wtm.c
index b6b650c..d559916 100644
--- a/sound/pci/ice1712/wtm.c
+++ b/sound/pci/ice1712/wtm.c
@@ -29,6 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <sound/core.h>
+#include <sound/tlv.h>
 
 #include "ice1712.h"
 #include "envy24ht.h"
@@ -380,6 +381,10 @@ static int stac9460_mic_sw_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
+
+static const DECLARE_TLV_DB_SCALE(db_scale_dac, -19125, 75, 0);
+static const DECLARE_TLV_DB_SCALE(db_scale_adc, 0, 150, 0);
+
 /*
  * Control tabs
  */
@@ -394,11 +399,14 @@ static struct snd_kcontrol_new stac9640_controls[] = {
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
 		.name = "Master Playback Volume",
 		.info = stac9460_dac_vol_info,
 		.get = stac9460_dac_vol_get,
 		.put = stac9460_dac_vol_put,
 		.private_value = 1,
+		.tlv = { .p = db_scale_dac }
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -419,11 +427,14 @@ static struct snd_kcontrol_new stac9640_controls[] = {
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
 		.name = "DAC Volume",
 		.count = 8,
 		.info = stac9460_dac_vol_info,
 		.get = stac9460_dac_vol_get,
 		.put = stac9460_dac_vol_put,
+		.tlv = { .p = db_scale_dac }
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -435,12 +446,15 @@ static struct snd_kcontrol_new stac9640_controls[] = {
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			   SNDRV_CTL_ELEM_ACCESS_TLV_READ),
 		.name = "ADC Volume",
 		.count = 2,
 		.info = stac9460_adc_vol_info,
 		.get = stac9460_adc_vol_get,
 		.put = stac9460_adc_vol_put,
-
+		.tlv = { .p = db_scale_adc }
 	}
 };
 
-- 
1.8.4.rc3
