From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH] ASoC: pcm3168a: Call clk_set_rate in
	pcm3168a_set_dai_sysclk
Date: Thu, 28 Jan 2016 16:54:20 +0000
Message-ID: <1454000060-8407-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id D19A126588B
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2016 17:55:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, "Damien.Horsley" <Damien.Horsley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

Call clk_set_rate in pcm3168a_set_dai_sysclk

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
---
 sound/soc/codecs/pcm3168a.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 44b268a..0c7248a 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -299,10 +299,15 @@ static int pcm3168a_set_dai_sysclk(struct snd_soc_dai *dai,
 				  int clk_id, unsigned int freq, int dir)
 {
 	struct pcm3168a_priv *pcm3168a = snd_soc_codec_get_drvdata(dai->codec);
+	int ret;
 
 	if (freq > PCM1368A_MAX_SYSCLK)
 		return -EINVAL;
 
+	ret = clk_set_rate(pcm3168a->scki, freq);
+	if (ret)
+		return ret;
+
 	pcm3168a->sysclk = freq;
 
 	return 0;
-- 
2.1.4
