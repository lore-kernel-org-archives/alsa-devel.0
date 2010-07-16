From: Raffaele Recalcati <lamiaposta71-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] ASoC: soc-core: soc_pcm_ops dynamically allocated
Date: Fri, 16 Jul 2010 16:46:57 +0200
Message-ID: <1279291619-5081-2-git-send-email-lamiaposta71@gmail.com>
References: <1279291619-5081-1-git-send-email-lamiaposta71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1279291619-5081-1-git-send-email-lamiaposta71-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Eero Nurkkala <ext-eero.nurkkala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Davide Bonfanti <davide.bonfanti-nfoefbsQIRSonA0d6jMUrA@public.gmane.org>

    If soc_pcm_ops is statically allocated, more than one call to soc_new_pcm
    cause operations overwrite. The problem is overcome usyng dynamic
    allocation.

    Signed-off-by: Davide Bonfanti <davide.bonfanti-nfoefbsQIRSonA0d6jMUrA@public.gmane.org>
    Signed-off-by: Raffaele Recalcati <raffaele.recalcati-nfoefbsQIRSonA0d6jMUrA@public.gmane.org>
---
 sound/soc/soc-core.c |   38 +++++++++++++++++---------------------
 1 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ad7f952..6500686 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -801,17 +801,6 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	}
 	return 0;
 }
-
-/* ASoC PCM operations */
-static struct snd_pcm_ops soc_pcm_ops = {
-	.open		= soc_pcm_open,
-	.close		= soc_codec_close,
-	.hw_params	= soc_pcm_hw_params,
-	.hw_free	= soc_pcm_hw_free,
-	.prepare	= soc_pcm_prepare,
-	.trigger	= soc_pcm_trigger,
-};
-
 #ifdef CONFIG_PM
 /* powers down audio subsystem for suspend */
 static int soc_suspend(struct device *dev)
@@ -1306,6 +1295,7 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 	struct snd_pcm *pcm;
 	char new_name[64];
 	int ret = 0, playback = 0, capture = 0;
+	struct snd_pcm_ops *soc_pcm_ops;
 
 	rtd = kzalloc(sizeof(struct snd_soc_pcm_runtime), GFP_KERNEL);
 	if (rtd == NULL)
@@ -1335,19 +1325,25 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 
 	dai_link->pcm = pcm;
 	pcm->private_data = rtd;
-	soc_pcm_ops.mmap = platform->pcm_ops->mmap;
-	soc_pcm_ops.pointer = platform->pcm_ops->pointer;
-	soc_pcm_ops.ioctl = platform->pcm_ops->ioctl;
-	soc_pcm_ops.copy = platform->pcm_ops->copy;
-	soc_pcm_ops.silence = platform->pcm_ops->silence;
-	soc_pcm_ops.ack = platform->pcm_ops->ack;
-	soc_pcm_ops.page = platform->pcm_ops->page;
+	soc_pcm_ops = kmalloc(sizeof(struct snd_pcm_ops), GFP_KERNEL);
+	soc_pcm_ops->open		= soc_pcm_open;
+	soc_pcm_ops->close		= soc_codec_close;
+	soc_pcm_ops->hw_params	= soc_pcm_hw_params;
+	soc_pcm_ops->hw_free	= soc_pcm_hw_free;
+	soc_pcm_ops->prepare	= soc_pcm_prepare;
+	soc_pcm_ops->trigger	= soc_pcm_trigger;
+	soc_pcm_ops->mmap = platform->pcm_ops->mmap;
+	soc_pcm_ops->pointer = platform->pcm_ops->pointer;
+	soc_pcm_ops->ioctl = platform->pcm_ops->ioctl;
+	soc_pcm_ops->copy = platform->pcm_ops->copy;
+	soc_pcm_ops->silence = platform->pcm_ops->silence;
+	soc_pcm_ops->ack = platform->pcm_ops->ack;
+	soc_pcm_ops->page = platform->pcm_ops->page;
 
 	if (playback)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &soc_pcm_ops);
-
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, soc_pcm_ops);
 	if (capture)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &soc_pcm_ops);
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, soc_pcm_ops);
 
 	ret = platform->pcm_new(codec->card, codec_dai, pcm);
 	if (ret < 0) {
-- 
1.7.0.4
