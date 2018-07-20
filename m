From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 3/3] ASoC: rt5631: add Volume to the name of
	volume control
Date: Fri, 20 Jul 2018 09:48:20 +0800
Message-ID: <1532051300-11884-3-git-send-email-bardliao@realtek.com>
References: <1532051300-11884-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 7003126733D
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 03:48:36 +0200 (CEST)
In-Reply-To: <1532051300-11884-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

add Volume to the name of volume control.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5631.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index cf6dce6..e52e467 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -229,10 +229,10 @@ static SOC_ENUM_SINGLE_DECL(rt5631_spk_ratio_enum, RT5631_GEN_PUR_CTRL_REG,
 static const struct snd_kcontrol_new rt5631_snd_controls[] = {
 	/* MIC */
 	SOC_ENUM("MIC1 Mode Control",  rt5631_mic1_mode_enum),
-	SOC_SINGLE_TLV("MIC1 Boost", RT5631_MIC_CTRL_2,
+	SOC_SINGLE_TLV("MIC1 Boost Volume", RT5631_MIC_CTRL_2,
 		RT5631_MIC1_BOOST_SHIFT, 8, 0, mic_bst_tlv),
 	SOC_ENUM("MIC2 Mode Control", rt5631_mic2_mode_enum),
-	SOC_SINGLE_TLV("MIC2 Boost", RT5631_MIC_CTRL_2,
+	SOC_SINGLE_TLV("MIC2 Boost Volume", RT5631_MIC_CTRL_2,
 		RT5631_MIC2_BOOST_SHIFT, 8, 0, mic_bst_tlv),
 	/* MONO IN */
 	SOC_ENUM("MONOIN Mode Control", rt5631_monoin_mode_enum),
-- 
2.7.4
