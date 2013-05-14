From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/11] ASoC: mop500_ab8500: Staticize non
	exported functions
Date: Tue, 14 May 2013 22:19:54 +0200
Message-ID: <1368562797-10440-8-git-send-email-lars@metafoo.de>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-208.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id DA789260857
 for <alsa-devel@alsa-project.org>; Tue, 14 May 2013 22:20:27 +0200 (CEST)
In-Reply-To: <1368562797-10440-1-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Fabio Baltieri <fabio.baltieri@linaro.org>
List-Id: alsa-devel@alsa-project.org

The mop500_ab8500_startup(), the mop500_ab8500_shutdown() and the
mop500_ab8500_hw_params() function are not used outside of mop500_ab8500, so
make them static.

Cc: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: Fabio Baltieri <fabio.baltieri@linaro.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/ux500/mop500_ab8500.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/ux500/mop500_ab8500.c b/sound/soc/ux500/mop500_ab8500.c
index 44e25a2..884a362 100644
--- a/sound/soc/ux500/mop500_ab8500.c
+++ b/sound/soc/ux500/mop500_ab8500.c
@@ -183,7 +183,7 @@ static struct snd_kcontrol_new mop500_ab8500_ctrls[] = {
 
 /* ASoC */
 
-int mop500_ab8500_startup(struct snd_pcm_substream *substream)
+static int mop500_ab8500_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 
@@ -192,7 +192,7 @@ int mop500_ab8500_startup(struct snd_pcm_substream *substream)
 				snd_soc_card_get_drvdata(rtd->card));
 }
 
-void mop500_ab8500_shutdown(struct snd_pcm_substream *substream)
+static void mop500_ab8500_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct device *dev = rtd->card->dev;
@@ -206,7 +206,7 @@ void mop500_ab8500_shutdown(struct snd_pcm_substream *substream)
 		rx_slots = DEF_RX_SLOTS;
 }
 
-int mop500_ab8500_hw_params(struct snd_pcm_substream *substream,
+static int mop500_ab8500_hw_params(struct snd_pcm_substream *substream,
 			struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-- 
1.8.0
