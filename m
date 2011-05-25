From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH] ASoC: davinci-pcm: comments for the conversion
	to BATCH mode
Date: Wed, 25 May 2011 09:27:22 -0400
Message-ID: <1306330042-16714-1-git-send-email-bengardiner@nanometrics.ca>
References: <4DDCD16C.1080702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76])
	by alsa0.perex.cz (Postfix) with ESMTP id 567BA10380F
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 15:27:30 +0200 (CEST)
Received: by mail-yw0-f47.google.com with SMTP id 8so3206310ywg.6
	for <alsa-devel@alsa-project.org>; Wed, 25 May 2011 06:27:24 -0700 (PDT)
In-Reply-To: <4DDCD16C.1080702@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
Cc: Steven Faludi <stevenfaludi@nanometrics.ca>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

In the previous commit 'ASoC: davinci-pcm: convert to BATCH mode', the phase
offset of 2 was mentioned in the commit message but not well commented in the
source.

Add descriptive comments of the phase offset with and without ping-pong
buffers enabled.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>

---
 sound/soc/davinci/davinci-pcm.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index fa8fc61..c9e0320 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -605,6 +605,18 @@ static int davinci_pcm_prepare(struct snd_pcm_substream *substream)
 		print_buf_info(prtd->asp_link[0], "asp_link[0]");
 		print_buf_info(prtd->asp_link[1], "asp_link[1]");
 
+		/*
+		 * There is a phase offset of 2 periods between the position
+		 * used by dma setup and the position reported in the pointer
+		 * function.
+		 *
+		 * The phase offset, when not using ping-pong buffers, is due to
+		 * the two consecutive calls to davinci_pcm_enqueue_dma() below.
+		 *
+		 * Whereas here, with ping-pong buffers, the phase is due to
+		 * there being an entire buffer transfer complete before the
+		 * first dma completion event triggers davinci_pcm_dma_irq().
+		 */
 		davinci_pcm_period_elapsed(substream);
 		davinci_pcm_period_elapsed(substream);
 
@@ -631,6 +643,13 @@ davinci_pcm_pointer(struct snd_pcm_substream *substream)
 	int asp_count;
 	unsigned int period_size = snd_pcm_lib_period_bytes(substream);
 
+	/*
+	 * There is a phase offset of 2 periods between the position used by dma
+	 * setup and the position reported in the pointer function. Either +2 in
+	 * the dma setup or -2 here in the pointer function (with wrapping,
+	 * both) accounts for this offset -- choose the latter since it makes
+	 * the first-time setup clearer.
+	 */
 	spin_lock(&prtd->lock);
 	asp_count = prtd->period - 2;
 	spin_unlock(&prtd->lock);
-- 
1.7.4.1
