From: <brian.austin@cirrus.com>
Subject: [PATCH 2/2] ASoC: cs42l52: Add new TLV for Beep Volume
Date: Tue, 6 Aug 2013 12:57:22 -0500
Message-ID: <1375811842-12513-2-git-send-email-brian.austin@cirrus.com>
References: <1375811842-12513-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F259261629
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 19:57:04 +0200 (CEST)
In-Reply-To: <1375811842-12513-1-git-send-email-brian.austin@cirrus.com>
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
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

From: Brian Austin <brian.austin@cirrus.com>

CS42L52 Beep control uses 2dB scale from -56dB

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l52.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index ee25f32..1e7d03f 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -195,6 +195,8 @@ static DECLARE_TLV_DB_SCALE(pga_tlv, -600, 50, 0);
 
 static DECLARE_TLV_DB_SCALE(mix_tlv, -50, 50, 0);
 
+static DECLARE_TLV_DB_SCALE(beep_tlv, -56, 200, 0);
+
 static const unsigned int limiter_tlv[] = {
 	TLV_DB_RANGE_HEAD(2),
 	0, 2, TLV_DB_SCALE_ITEM(-3000, 600, 0),
@@ -451,7 +453,8 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
 	SOC_ENUM("Beep Pitch", beep_pitch_enum),
 	SOC_ENUM("Beep on Time", beep_ontime_enum),
 	SOC_ENUM("Beep off Time", beep_offtime_enum),
-	SOC_SINGLE_SX_TLV("Beep Volume", CS42L52_BEEP_VOL, 0, 0x07, 0x1f, hl_tlv),
+	SOC_SINGLE_SX_TLV("Beep Volume", CS42L52_BEEP_VOL, 
+			0, 0x07, 0x1f, beep_tlv),
 	SOC_SINGLE("Beep Mixer Switch", CS42L52_BEEP_TONE_CTL, 5, 1, 1),
 	SOC_ENUM("Beep Treble Corner Freq", beep_treble_enum),
 	SOC_ENUM("Beep Bass Corner Freq", beep_bass_enum),
-- 
1.7.10.4
