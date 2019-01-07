From: Yizhuo <yzhai003@ucr.edu>
Subject: [PATCH] ASoC: rt274: Variable "buf" in function
	rt274_jack_detect() could be uninitialized
Date: Mon,  7 Jan 2019 12:12:32 -0800
Message-ID: <20190107201232.19464-1-yzhai003@ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.ucr.edu (mx1.ucr.edu [138.23.248.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E78C26699F
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 21:13:32 +0100 (CET)
Received: by mail-pf1-f199.google.com with SMTP id p15so977895pfk.7
 for <alsa-devel@alsa-project.org>; Mon, 07 Jan 2019 12:12:54 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: csong@cs.ucr.edu, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, zhiyunq@cs.ucr.edu, Liam Girdwood <lgirdwood@gmail.com>, Yizhuo <yzhai003@ucr.edu>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

In function rt274_jack_detect(), local variable "buf" could
be uninitialized if function regmap_read() returns -EINVAL.
However, it will be used to calculate "hp" and "mic" and
make their value unpredictable while those value are used
in the caller. This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 sound/soc/codecs/rt274.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index 8f92e5c4dd9d..332a3e955bdb 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -353,6 +353,7 @@ static void rt274_index_sync(struct snd_soc_codec *codec)
 static int rt274_jack_detect(struct rt274_priv *rt274, bool *hp, bool *mic)
 {
 	unsigned int buf;
+	int ret;
 
 	*hp = false;
 	*mic = false;
@@ -360,9 +361,15 @@ static int rt274_jack_detect(struct rt274_priv *rt274, bool *hp, bool *mic)
 	if (!rt274->codec)
 		return -EINVAL;
 
-	regmap_read(rt274->regmap, RT274_GET_HP_SENSE, &buf);
+	ret = regmap_read(rt274->regmap, RT274_GET_HP_SENSE, &buf);
+	if (ret)
+		return ret;
+
 	*hp = buf & 0x80000000;
-	regmap_read(rt274->regmap, RT274_GET_MIC_SENSE, &buf);
+	ret = regmap_read(rt274->regmap, RT274_GET_MIC_SENSE, &buf);
+	if (ret)
+		return ret;
+
 	*mic = buf & 0x80000000;
 
 	pr_debug("*hp = %d *mic = %d\n", *hp, *mic);
-- 
2.17.1
