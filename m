From: John Bonesio <bones@secretlab.ca>
Subject: [PATCH] ASoC: MPC5200: Changed how appl_ptr is
	initialized
Date: Tue, 28 Jul 2009 22:26:51 -0700
Message-ID: <20090729052608.20653.62429.stgit@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f188.google.com (mail-pz0-f188.google.com
	[209.85.222.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 5819F103842
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 07:27:01 +0200 (CEST)
Received: by pzk26 with SMTP id 26so352266pzk.16
	for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2009 22:27:00 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, Jon Smirl <jonsmirl@gmail.com>, Eric Millbrandt <emillbrandt@dekaresearch.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I've been working in the ALSA SOC area for the MPC5200. I've noticed that
in the routine psc_dma_trigger() in sound/soc/fsl/mpc5200_dma.c there are
times when the computed value for s->appl_ptr ends up wrapping negative. This
occurs when
    s->runtime->control->appl_ptr
is less than
    runtime->period_size * runtime->periods

It seemed like this would occur at then of the data stream or when the data
stream is small (smaller than runtime->period_size * runtime->periods).

As far as I can tell, s->appl_ptr is supposed to be the previous value of
s->runtime->control->appl_ptr, so the driver can send out the right number
of bytes (from previous appl_ptr to current appl_ptr) to avoid pops and clicks
at the end of the audio.

So it appears the assumption in this code is wrong, that the previous
s->runtime->control->appl_ptr is always
rumtime->period_size * runtime->periods bytes prior to the current
s->runtime->control->appl_ptr.

I took out this code and instead added code to intialize s->appl_ptr to 0
in psc_dma_open().

Does this fix seem right?

- John

The computation for appl_ptr in the trigger() routine made a bad assumption
when the stream is at the end of the file and there is not
(periods * period_size) bytes remaining in the data.

This causes playback issues when the total stream size is less than this
amount, as the s->appl_ptr wrapps negative and the data is never played.

Signed-off-by: John Bonesio <bones@secretlab.ca>
---

 sound/soc/fsl/mpc5200_dma.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
index b2eba27..cfe0ea4 100644
--- a/sound/soc/fsl/mpc5200_dma.c
+++ b/sound/soc/fsl/mpc5200_dma.c
@@ -181,8 +181,6 @@ static int psc_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		 * end of stream and not over running it.
 		 */
 		s->runtime = runtime;
-		s->appl_ptr = s->runtime->control->appl_ptr -
-				(runtime->period_size * runtime->periods);
 
 		/* Fill up the bestcomm bd queue and enable DMA.
 		 * This will begin filling the PSC's fifo.
@@ -287,6 +285,7 @@ static int psc_dma_open(struct snd_pcm_substream *substream)
 	}
 
 	s->stream = substream;
+	s->appl_ptr = 0;
 	return 0;
 }
