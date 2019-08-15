From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: tlv320aic23: remove unused variable 'tlv320aic23_rec_src'
Date: Thu, 15 Aug 2019 17:15:34 +0800
Message-ID: <20190815091534.57780-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, allison@lohutok.net, kstewart@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

sound/soc/codecs/tlv320aic23.c:70:29: warning:
 tlv320aic23_rec_src defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/tlv320aic23.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 080a840..f8e2f4b 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -67,8 +67,6 @@ static SOC_ENUM_SINGLE_DECL(rec_src_enum,
 static const struct snd_kcontrol_new tlv320aic23_rec_src_mux_controls =
 SOC_DAPM_ENUM("Input Select", rec_src_enum);
 
-static SOC_ENUM_SINGLE_DECL(tlv320aic23_rec_src,
-			    TLV320AIC23_ANLG, 2, rec_src_text);
 static SOC_ENUM_SINGLE_DECL(tlv320aic23_deemph,
 			    TLV320AIC23_DIGT, 1, deemph_text);
 
-- 
2.7.4
