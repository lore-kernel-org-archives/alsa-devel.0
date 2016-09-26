From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] ASOC: wm8991: remove unused variable
Date: Tue, 27 Sep 2016 08:25:28 +0900
Message-ID: <1474932329-10640-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1474932329-10640-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 645D2266949
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This driver has some unused variables. They should be removed.

Fixes: 203db220718c ("ASoC: WM8991: Add initial WM8991 driver")
Cc: patches@opensource.wolfsonmicro.com
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/codecs/wm8991.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 483b953..9d4b607 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -111,14 +111,12 @@ static bool wm8991_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
-static const DECLARE_TLV_DB_LINEAR(rec_mix_tlv, -1500, 600);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(in_pga_tlv, -1650, 150, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(out_mix_tlv, -2100, 300, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(out_pga_tlv,
 	0x00, 0x2f, SNDRV_CTL_TLVD_DB_SCALE_ITEM(SNDRV_CTL_TLVD_DB_GAIN_MUTE, 0, 1),
 	0x30, 0x7f, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-7300, 100, 0),
 );
-static const DECLARE_TLV_DB_LINEAR(out_omix_tlv, -600, 0);
 static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(out_dac_tlv,
 	0x00, 0xbf, SNDRV_CTL_TLVD_DB_SCALE_ITEM(-71625, 375, 1),
 	0xc0, 0xff, SNDRV_CTL_TLVD_DB_SCALE_ITEM(0, 0, 0),
-- 
2.7.4
