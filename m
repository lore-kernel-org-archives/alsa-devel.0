From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH 1/2] ASoC: cs42l56: Fix stereo channel register
	assignment for Headphone and LineOut volume mixers
Date: Thu, 17 Jul 2014 13:16:54 -0500
Message-ID: <1405621015-29017-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F1AD26556F
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 20:14:24 +0200 (CEST)
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
Cc: paul.handrigan@cirrus.com, Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgirdwood@gmail.com, ryan.harvey@cirrus.com
List-Id: alsa-devel@alsa-project.org

Stereo Headphone and LineOut volume mixers are now attached to HPA+HPB, LOA+LOB.

Reported-by: Ryan Harvey <ryan.harvey@cirrus.com>
Signed-off-by: Ryan Harvey <ryan.harvey@cirrus.com>
Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l56.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index e5ef223..48162ee 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -453,9 +453,9 @@ static const struct snd_kcontrol_new cs42l56_snd_controls[] = {
 	SOC_DOUBLE("ADC Boost Switch", CS42L56_GAIN_BIAS_CTL, 3, 2, 1, 1),
 
 	SOC_DOUBLE_R_SX_TLV("Headphone Volume", CS42L56_HPA_VOLUME,
-			      CS42L56_HPA_VOLUME, 0, 0x44, 0x55, hl_tlv),
+			      CS42L56_HPB_VOLUME, 0, 0x44, 0x55, hl_tlv),
 	SOC_DOUBLE_R_SX_TLV("LineOut Volume", CS42L56_LOA_VOLUME,
-			      CS42L56_LOA_VOLUME, 0, 0x44, 0x55, hl_tlv),
+			      CS42L56_LOB_VOLUME, 0, 0x44, 0x55, hl_tlv),
 
 	SOC_SINGLE_TLV("Bass Shelving Volume", CS42L56_TONE_CTL,
 			0, 0x00, 1, tone_tlv),
-- 
1.7.9.5
