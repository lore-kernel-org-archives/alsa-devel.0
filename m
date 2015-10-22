From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: rx1950_uda1380: Constify rate
	constraints
Date: Thu, 22 Oct 2015 10:43:22 +0200
Message-ID: <1445503403-22934-2-git-send-email-lars@metafoo.de>
References: <1445503403-22934-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-188.synserver.de
 [212.40.185.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 747742661DE
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 10:43:34 +0200 (CEST)
In-Reply-To: <1445503403-22934-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Zidan Wang <zidan.wang@freescale.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>
List-Id: alsa-devel@alsa-project.org

The rate constraints in this board driver are not modified at runtime, so
make them const.

While we are at it also remove the unnecessary 0 initializer for the mask
field.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/samsung/rx1950_uda1380.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index 35e37c4..fa096ab 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -38,16 +38,15 @@ static int rx1950_hw_params(struct snd_pcm_substream *substream,
 static int rx1950_spk_power(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *kcontrol, int event);
 
-static unsigned int rates[] = {
+static const unsigned int rates[] = {
 	16000,
 	44100,
 	48000,
 };
 
-static struct snd_pcm_hw_constraint_list hw_rates = {
+static const struct snd_pcm_hw_constraint_list hw_rates = {
 	.count = ARRAY_SIZE(rates),
 	.list = rates,
-	.mask = 0,
 };
 
 static struct snd_soc_jack hp_jack;
-- 
2.1.4
