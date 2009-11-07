From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 6/6] ASoC/mpc5200: Add fudge factor to value
	reported by	.pointer()
Date: Sat, 07 Nov 2009 01:34:55 -0700
Message-ID: <20091107083448.18908.80366.stgit@angua>
References: <20091107081631.18908.82921.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f184.google.com (mail-pz0-f184.google.com
	[209.85.222.184])
	by alsa0.perex.cz (Postfix) with ESMTP id AA98F1039B2
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 09:34:58 +0100 (CET)
Received: by mail-pz0-f184.google.com with SMTP id 14so1164676pzk.23
	for <alsa-devel@alsa-project.org>; Sat, 07 Nov 2009 00:34:58 -0800 (PST)
In-Reply-To: <20091107081631.18908.82921.stgit@angua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
Cc: lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

ALSA playback seems to be more reliable if the .pointer() hook reports
a value slightly into the period, rather than right on the period
boundary.  This patch adds a fudge factor of 1/4 the period size
to better estimate the actual position of the DMA engine in the
audio buffer.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/mpc5200_dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index 9c88e15..ee5a606 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -297,7 +297,7 @@ psc_dma_pointer(struct snd_pcm_substream *substream)
 	else
 		s = &psc_dma->playback;
 
-	count = s->period_current * s->period_bytes;
+	count = (s->period_current * s->period_bytes) + (s->period_bytes >> 2);
 
 	return bytes_to_frames(substream->runtime, count);
 }
