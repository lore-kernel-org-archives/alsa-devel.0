From: Colin King <colin.king@canonical.com>
Subject: [PATCH 2/9] ALSA: cs5535audio: remove redundant
	pointer 'dma'
Date: Wed,  1 Aug 2018 11:47:35 +0100
Message-ID: <20180801104742.4328-3-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 6ADBA2676E2
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 12:47:49 +0200 (CEST)
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jaya Kumar <jayakumar.alsa@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Olivier Moysan <olivier.moysan@st.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'dma' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up two clang warnings:
warning: variable 'dma' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/cs5535audio/cs5535audio.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/pci/cs5535audio/cs5535audio.c b/sound/pci/cs5535audio/cs5535audio.c
index de409cda50aa..4590086d9cd8 100644
--- a/sound/pci/cs5535audio/cs5535audio.c
+++ b/sound/pci/cs5535audio/cs5535audio.c
@@ -192,8 +192,6 @@ static void process_bm0_irq(struct cs5535audio *cs5535au)
 	bm_stat = cs_readb(cs5535au, ACC_BM0_STATUS);
 	spin_unlock(&cs5535au->reg_lock);
 	if (bm_stat & EOP) {
-		struct cs5535audio_dma *dma;
-		dma = cs5535au->playback_substream->runtime->private_data;
 		snd_pcm_period_elapsed(cs5535au->playback_substream);
 	} else {
 		dev_err(cs5535au->card->dev,
@@ -208,11 +206,8 @@ static void process_bm1_irq(struct cs5535audio *cs5535au)
 	spin_lock(&cs5535au->reg_lock);
 	bm_stat = cs_readb(cs5535au, ACC_BM1_STATUS);
 	spin_unlock(&cs5535au->reg_lock);
-	if (bm_stat & EOP) {
-		struct cs5535audio_dma *dma;
-		dma = cs5535au->capture_substream->runtime->private_data;
+	if (bm_stat & EOP)
 		snd_pcm_period_elapsed(cs5535au->capture_substream);
-	}
 }
 
 static irqreturn_t snd_cs5535audio_interrupt(int irq, void *dev_id)
-- 
2.17.1
