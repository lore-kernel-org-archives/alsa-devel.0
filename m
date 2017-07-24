From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5665: add MONOVOL Playback Volume
	control
Date: Mon, 24 Jul 2017 19:11:52 +0800
Message-ID: <1500894712-32034-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 5110B266A0C
 for <alsa-devel@alsa-project.org>; Mon, 24 Jul 2017 13:12:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

MONOVOL Playback Volume is a playback volume control on "MONOVOL MIX".

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 7e64b25..54ace3b 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -1402,6 +1402,9 @@ static const struct snd_kcontrol_new rt5665_snd_controls[] = {
 		RT5665_L_VOL_SFT, 15, 1, snd_soc_get_volsw,
 		rt5665_mono_vol_put, mono_vol_tlv),
 
+	SOC_SINGLE_TLV("MONOVOL Playback Volume", RT5665_MONO_OUT,
+		RT5665_L_VOL_SFT, 39, 1, out_vol_tlv),
+
 	/* Output Volume */
 	SOC_DOUBLE_TLV("OUT Playback Volume", RT5665_LOUT, RT5665_L_VOL_SFT,
 		RT5665_R_VOL_SFT, 39, 1, out_vol_tlv),
-- 
2.7.4
