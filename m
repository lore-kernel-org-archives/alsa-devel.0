From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH] ASoC: img: parallel out: Add missing
	initialiser
Date: Tue, 10 Nov 2015 14:09:35 +0000
Message-ID: <1447164575-32593-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 120332651E4
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 15:21:54 +0100 (CET)
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
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, James Hartley <James.Hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

Add missing initialiser for control_set variable
in img_prl_out_set_fmt

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
---
 sound/soc/img/img-parallel-out.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/img/img-parallel-out.c b/sound/soc/img/img-parallel-out.c
index beda18b..c1610a0 100644
--- a/sound/soc/img/img-parallel-out.c
+++ b/sound/soc/img/img-parallel-out.c
@@ -154,7 +154,7 @@ static int img_prl_out_hw_params(struct snd_pcm_substream *substream,
 static int img_prl_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct img_prl_out *prl = snd_soc_dai_get_drvdata(dai);
-	u32 reg, control_set;
+	u32 reg, control_set = 0;
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
-- 
2.1.4
