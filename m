From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH] ASoC: cs42l52: Fixes for Beep Volume kcontrol
	(fwd)
Date: Mon, 5 Aug 2013 10:53:31 -0500
Message-ID: <alpine.DEB.2.10.1308051050270.5288@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 by alsa0.perex.cz (Postfix) with ESMTP id B0D8A265096
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 17:53:12 +0200 (CEST)
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
Cc: broonie@kernel.org, lars@metafoo.de, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch reorders the min/max values for BEEP Volume.
Also changes SOC_SINGLE_TLV to SOC_SINGLE_SX_TLV
Add DB_SCALE beep_tlv for volume control

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
  sound/soc/codecs/cs42l52.c |    5 ++++-
  1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 0f6f481..66d1e42 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -193,6 +193,8 @@ static DECLARE_TLV_DB_SCALE(mic_tlv, 1600, 100, 0);

  static DECLARE_TLV_DB_SCALE(pga_tlv, -600, 50, 0);

+static DECLARE_TLV_DB_SCALE(beep_tlv, -5600, 200, 0);
+
  static const unsigned int limiter_tlv[] = {
  	TLV_DB_RANGE_HEAD(2),
  	0, 2, TLV_DB_SCALE_ITEM(-3000, 600, 0),
@@ -449,7 +451,8 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
  	SOC_ENUM("Beep Pitch", beep_pitch_enum),
  	SOC_ENUM("Beep on Time", beep_ontime_enum),
  	SOC_ENUM("Beep off Time", beep_offtime_enum),
-	SOC_SINGLE_TLV("Beep Volume", CS42L52_BEEP_VOL, 0, 0x1f, 0x07, hl_tlv),
+	SOC_SINGLE_SX_TLV("Beep Volume",
+		       CS42L52_BEEP_VOL, 0, 0x07, 0x1f, beep_tlv),
  	SOC_SINGLE("Beep Mixer Switch", CS42L52_BEEP_TONE_CTL, 5, 1, 1),
  	SOC_ENUM("Beep Treble Corner Freq", beep_treble_enum),
  	SOC_ENUM("Beep Bass Corner Freq", beep_bass_enum),
-- 
1.7.10.4
