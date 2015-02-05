From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt286: Fix potencial crash in jd
	function
Date: Thu, 5 Feb 2015 16:40:33 +0800
Message-ID: <1423125634-8367-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id BB6F026050B
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 09:40:48 +0100 (CET)
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
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

We assign rt286->codec in rt286_probe. If rt286_jack_detect is
invoked before rt286_probe, rt286->codec will be NULL and cause
a kernel panic.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 2eafbcf..3d69cb4 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -306,6 +306,8 @@ static int rt286_jack_detect(struct rt286_priv *rt286, bool *hp, bool *mic)
 	*hp = false;
 	*mic = false;
 
+	if (!rt286->codec)
+		return -EINVAL;
 	if (rt286->pdata.cbj_en) {
 		regmap_read(rt286->regmap, RT286_GET_HP_SENSE, &buf);
 		*hp = buf & 0x80000000;
-- 
1.8.1.1.439.g50a6b54
