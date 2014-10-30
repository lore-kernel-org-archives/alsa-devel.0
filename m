From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/14] ASoC: wm9713: Use virtual control
	instead of virtual register
Date: Thu, 30 Oct 2014 21:01:10 +0100
Message-ID: <1414699271-22797-14-git-send-email-lars@metafoo.de>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id B9B31265453
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 21:01:22 +0100 (CET)
In-Reply-To: <1414699271-22797-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The wm9713 currently implements the virtual control for the Mic B Source MUX
using a virtual register. Replace this by using SOC_ENUM_SINGLE_VIRT().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9713.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 2704783..ac13fc8 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -59,13 +59,12 @@ static const u16 wm9713_reg[] = {
 	0x0000, 0x0000, 0x0000, 0x0000,
 	0x0000, 0x0000, 0x0000, 0x0006,
 	0x0001, 0x0000, 0x574d, 0x4c13,
-	0x0000, 0x0000, 0x0000
+	0x0000, 0x0000
 };
 
 /* virtual HP mixers regs */
 #define HPL_MIXER	0x80
 #define HPR_MIXER	0x82
-#define MICB_MUX	0x82
 
 static const char *wm9713_mic_mixer[] = {"Stereo", "Mic 1", "Mic 2", "Mute"};
 static const char *wm9713_rec_mux[] = {"Stereo", "Left", "Right", "Mute"};
@@ -110,7 +109,7 @@ SOC_ENUM_SINGLE(AC97_REC_GAIN_MIC, 10, 8, wm9713_dac_inv), /* dac invert 2 15 */
 SOC_ENUM_SINGLE(AC97_GENERAL_PURPOSE, 15, 2, wm9713_bass), /* bass control 16 */
 SOC_ENUM_SINGLE(AC97_PCI_SVID, 5, 2, wm9713_ng_type), /* noise gate type 17 */
 SOC_ENUM_SINGLE(AC97_3D_CONTROL, 12, 3, wm9713_mic_select), /* mic selection 18 */
-SOC_ENUM_SINGLE(MICB_MUX, 0, 2, wm9713_micb_select), /* mic selection 19 */
+SOC_ENUM_SINGLE_VIRT(2, wm9713_micb_select), /* mic selection 19 */
 };
 
 static const DECLARE_TLV_DB_SCALE(out_tlv, -4650, 150, 0);
-- 
1.8.0
