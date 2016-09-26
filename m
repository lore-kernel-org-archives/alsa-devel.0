From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] ASOC: stac9766: fix wrong usage of
	DECLARE_TLV_DB_LINEAR()
Date: Tue, 27 Sep 2016 08:25:29 +0900
Message-ID: <1474932329-10640-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1474932329-10640-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 65629266990
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 01:25:34 +0200 (CEST)
In-Reply-To: <1474932329-10640-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As long as reading datasheet of STAC9766/9767, this driver includes wrong
usage of DECLARE_TLV_DB_LINEAR().

In "8.1.2. Master Volume Registers", attenuation of lineout volumes is
represented in 5 bits by -1.5 dB/step from 0 to -46.5 dB. Thus,
'master_tlv' should be dB step representation.

In "8.1.14. Record Gain", gain of volumes is represented in 4 bits by
1.5 dB/step from 0 to 22.5 dB. Thus, 'record_tlv' should be dB step
representation.

In "8.1.5. PC BEEP Volume", attenuation of volume is represented in 4 bits
by -3 dB/step from 0 to 45 dB. Thus, 'beep_tlv' should be dB step
representation.

In "8.1.7. Stereo or Mic Volume" and so on, gain of volumes is represented
in 5 bits by -1.5 dB from 12 to -34.5 dB. Thus, 'mix_tlv' should be dB
step representation.

Totally, current implementation includes misuse of TLV-related macro.

This commit replaces usage of DECLARE_TLV_DB_LINEAR() with
SNDRV_CTL_TLVD_DECLARE_DB_SCALE(), to give proper information to
applications in user land.

Fixes: 3c166c7f1828 ("ASoC: Codec for STAC9766 used on the Efika")
Cc: Jon Smirl <jonsmirl@gmail.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/codecs/stac9766.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 0945c51..a718c653 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -85,10 +85,10 @@ static SOC_ENUM_SINGLE_DECL(stac9766_boost2_enum,
 static SOC_ENUM_SINGLE_DECL(stac9766_stereo_mic_enum,
 			    AC97_STAC_STEREO_MIC, 2, stac9766_stereo_mic);
 
-static const DECLARE_TLV_DB_LINEAR(master_tlv, -4600, 0);
-static const DECLARE_TLV_DB_LINEAR(record_tlv, 0, 2250);
-static const DECLARE_TLV_DB_LINEAR(beep_tlv, -4500, 0);
-static const DECLARE_TLV_DB_LINEAR(mix_tlv, -3450, 1200);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(master_tlv, -4650, 150, 0);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(record_tlv,     0, 150, 0);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(beep_tlv,   -4500, 300, 0);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(mix_tlv,    -3450, 150, 0);
 
 static const struct snd_kcontrol_new stac9766_snd_ac97_controls[] = {
 	SOC_DOUBLE_TLV("Speaker Volume", AC97_MASTER, 8, 0, 31, 1, master_tlv),
-- 
2.7.4
