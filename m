From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] SOUND: Fix txx9aclc.c build
Date: Thu, 28 Jul 2011 12:26:16 +0100
Message-ID: <20110728112616.GA27918@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from linux-mips.org (h5.dl5rb.org.uk [81.2.74.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 66C6010380B
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jul 2011 13:26:21 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@ti.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

552d1ef6b5a98d7b95959d5b139071e3c90cebf1 [ASoC: core - Optimise and refactor
pcm_new() to pass only rtd] breaks compilation of txx9aclc.c:

  CC [M]  sound/soc/txx9/txx9aclc.o
/home/ralf/src/linux/linux-mips/sound/soc/txx9/txx9aclc.c: In function 'txx9aclc_pcm_new':
/home/ralf/src/linux/linux-mips/sound/soc/txx9/txx9aclc.c:318:3: error: 'card' undeclared (first use in this function)
/home/ralf/src/linux/linux-mips/sound/soc/txx9/txx9aclc.c:318:3: note: each undeclared identifier is reported only once for each function it appears in
make[5]: *** [sound/soc/txx9/txx9aclc.o] Error 1

Fixed by providing a definition for card.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 sound/soc/txx9/txx9aclc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 34aa972..3de99af 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -290,6 +290,7 @@ static void txx9aclc_pcm_free_dma_buffers(struct snd_pcm *pcm)
 
 static int txx9aclc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_card *card = rtd->card->snd_card;
 	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	struct platform_device *pdev = to_platform_device(dai->platform->dev);
