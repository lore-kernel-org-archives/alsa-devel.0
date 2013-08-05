From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH 1/2] ASoC: cs42l52: Reorder Min/Max and update
 to SX_TLV for Beep Volume
Date: Mon, 5 Aug 2013 15:08:47 -0500
Message-ID: <alpine.DEB.2.10.1308051508140.5288@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AD0B42651BE
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 22:08:31 +0200 (CEST)
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
Cc: brian.austin@cirrus.com, broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

Beep Volume Min/Max was backwards.
Change to SOC_SONGLE_SX_TLV for correct volume representation

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
  sound/soc/codecs/cs42l52.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 987f728..ee25f32 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -451,7 +451,7 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
  	SOC_ENUM("Beep Pitch", beep_pitch_enum),
  	SOC_ENUM("Beep on Time", beep_ontime_enum),
  	SOC_ENUM("Beep off Time", beep_offtime_enum),
-	SOC_SINGLE_TLV("Beep Volume", CS42L52_BEEP_VOL, 0, 0x1f, 0x07, hl_tlv),
+	SOC_SINGLE_SX_TLV("Beep Volume", CS42L52_BEEP_VOL, 0, 0x07, 0x1f, hl_tlv),
  	SOC_SINGLE("Beep Mixer Switch", CS42L52_BEEP_TONE_CTL, 5, 1, 1),
  	SOC_ENUM("Beep Treble Corner Freq", beep_treble_enum),
  	SOC_ENUM("Beep Bass Corner Freq", beep_bass_enum),
-- 
1.7.10.4
