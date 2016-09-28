From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 3/3] ASoC: wm8960: remove usage of obsoleted
	TLV-related macro
Date: Wed, 28 Sep 2016 09:29:21 +0900
Message-ID: <1475022561-5968-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1475022561-5968-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 3BA66266A02
 for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2016 02:29:27 +0200 (CEST)
In-Reply-To: <1475022561-5968-1-git-send-email-o-takashi@sakamocchi.jp>
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

TLV_DB_RANGE_HEAD macro was obsoleted by commit bf1d1c9b6179 ("ALSA: tlv:
add DECLARE_TLV_DB_RANGE()").

This commit removes usage of the macro, with the obsoleting macro renamed
to SNDRV_CTL_TLVD_DECLARE_DB_RANGE().

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/soc/codecs/wm8960.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index d7f444f..3d8c756 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -226,11 +226,10 @@ static const DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);
 static const DECLARE_TLV_DB_SCALE(bypass_tlv, -2100, 300, 0);
 static const DECLARE_TLV_DB_SCALE(out_tlv, -12100, 100, 1);
 static const DECLARE_TLV_DB_SCALE(lineinboost_tlv, -1500, 300, 1);
-static const unsigned int micboost_tlv[] = {
-	TLV_DB_RANGE_HEAD(2),
+static const SNDRV_CTL_TLVD_DECLARE_DB_RANGE(micboost_tlv,
 	0, 1, TLV_DB_SCALE_ITEM(0, 1300, 0),
 	2, 3, TLV_DB_SCALE_ITEM(2000, 900, 0),
-};
+);
 
 static const struct snd_kcontrol_new wm8960_snd_controls[] = {
 SOC_DOUBLE_R_TLV("Capture Volume", WM8960_LINVOL, WM8960_RINVOL,
-- 
2.7.4
