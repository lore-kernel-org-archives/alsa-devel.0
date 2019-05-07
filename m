From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH 1/3] ASoC: mediatek: mt6358: initialize setting
	when ramping volume
Date: Tue,  7 May 2019 18:12:18 +0800
Message-ID: <20190507101220.182466-2-tzungbi@google.com>
References: <20190507101220.182466-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw1-xc49.google.com (mail-yw1-xc49.google.com
 [IPv6:2607:f8b0:4864:20::c49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CDB67F89682
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 12:12:56 +0200 (CEST)
Received: by mail-yw1-xc49.google.com with SMTP id b189so18017483ywa.19
 for <alsa-devel@alsa-project.org>; Tue, 07 May 2019 03:12:56 -0700 (PDT)
In-Reply-To: <20190507101220.182466-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, tiwai@suse.com
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

Mt6358 ramps up from the smallest volume (i.e. -10dB) to target dB when
opening and ramps down from target dB to mute (i.e. -40dB) when closing.
If target is equal to -10dB when opening, headset_volume_ramp() simply
leaves current setting (which may not be -10dB) unchanged.

Execute the loop at least once to initialize the setting to the
starting point (i.e. from).

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/codecs/mt6358.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/mt6358.c b/sound/soc/codecs/mt6358.c
index d4c4fee6d3d9..96547ae50a5d 100644
--- a/sound/soc/codecs/mt6358.c
+++ b/sound/soc/codecs/mt6358.c
@@ -405,10 +405,9 @@ static bool is_valid_hp_pga_idx(int reg_idx)
 	       reg_idx == DL_GAIN_N_40DB;
 }
 
-static void headset_volume_ramp(struct mt6358_priv *priv,
-				int from, int to)
+static void headset_volume_ramp(struct mt6358_priv *priv, int from, int to)
 {
-	int offset = 0, count = 1, reg_idx;
+	int offset = 0, count = 0, reg_idx;
 
 	if (!is_valid_hp_pga_idx(from) || !is_valid_hp_pga_idx(to))
 		dev_warn(priv->dev, "%s(), volume index is not valid, from %d, to %d\n",
@@ -422,7 +421,7 @@ static void headset_volume_ramp(struct mt6358_priv *priv,
 	else
 		offset = from - to;
 
-	while (offset > 0) {
+	while (offset >= 0) {
 		if (to > from)
 			reg_idx = from + count;
 		else
-- 
2.21.0.1020.gf2820cf01a-goog
