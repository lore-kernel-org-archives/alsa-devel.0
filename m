From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 4/6] ASoC: rt5640: Remove the unused field in
	private data
Date: Fri, 28 Mar 2014 20:28:28 +0800
Message-ID: <1396009710-21324-4-git-send-email-oder_chiou@realtek.com>
References: <1396009710-21324-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 006F62654FC
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 13:29:38 +0100 (CET)
In-Reply-To: <1396009710-21324-1-git-send-email-oder_chiou@realtek.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch removes the unused field in private data.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5640.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index cbd07b5..d7bd525 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -2095,7 +2095,6 @@ struct rt5640_priv {
 	int pll_in;
 	int pll_out;
 
-	int dmic_en;
 	bool hp_mute;
 };
 
-- 
1.8.1.1.439.g50a6b54
