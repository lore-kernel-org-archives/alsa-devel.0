From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH] ASoC: DaVinci: pcm,
	don't play 1st sound period twice
Date: Tue,  7 Jul 2009 17:36:06 -0700
Message-ID: <1247013366-32737-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-03.inet.qwest.net (mpls-qmqp-03.inet.qwest.net
	[63.231.195.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 310D5244EE
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 02:36:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: davinci-linux-open-source@linux.davincidsp.com, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Update the dma link with correct data as soon as
the master channel has copied it. Otherwise, the
1st period will play twice.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-pcm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index a059965..8fd0c3c 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -206,6 +206,7 @@ static int davinci_pcm_prepare(struct snd_pcm_substream *substream)
 	/* Copy self-linked parameter RAM entry into master channel */
 	edma_read_slot(prtd->slave_lch, &temp);
 	edma_write_slot(prtd->master_lch, &temp);
+	davinci_pcm_enqueue_dma(substream);
 
 	return 0;
 }
-- 
1.5.6.3
