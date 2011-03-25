From: linux@audioscience.com
Subject: [PATCH 2/3] Improve non-busmaster adapter operation.
Date: Fri, 25 Mar 2011 15:25:47 +1300
Message-ID: <1301019948-3539-2-git-send-email-linux@audioscience.com>
References: <1301019948-3539-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1301019948-3539-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Make playback silence callback a no-op, card automatically outputs
silence when written data runs out.
Increasing update interval and thus minimum period avoids xrun on startup
or because of timer jitter.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/asihpi.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index 22606e3..c90d77a 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -1012,6 +1012,7 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 		card->update_interval_frames);
+
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 		card->update_interval_frames * 2, UINT_MAX);
 
@@ -1054,7 +1055,7 @@ static int snd_card_asihpi_playback_copy(struct snd_pcm_substream *substream,
 	hpi_handle_error(hpi_outstream_write_buf(dpcm->h_stream,
 				runtime->dma_area, len, &dpcm->format));
 
-	dpcm->pcm_buf_host_rw_ofs = dpcm->pcm_buf_host_rw_ofs + len;
+	dpcm->pcm_buf_host_rw_ofs += len;
 
 	return 0;
 }
@@ -1064,16 +1065,11 @@ static int snd_card_asihpi_playback_silence(struct snd_pcm_substream *
 					    snd_pcm_uframes_t pos,
 					    snd_pcm_uframes_t count)
 {
-	unsigned int len;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
-
-	len = frames_to_bytes(runtime, count);
-	VPRINTK1(KERN_INFO "playback silence  %u bytes\n", len);
-
-	memset(runtime->dma_area, 0, len);
-	hpi_handle_error(hpi_outstream_write_buf(dpcm->h_stream,
-				runtime->dma_area, len, &dpcm->format));
+	/* Usually writes silence to DMA buffer, which should be overwritten
+	by real audio later.  Our fifos cannot be overwritten, and are not
+	free-running DMAs. Silence is output on fifo underflow.
+	This callback is still required to allow the copy callback to be used.
+	*/
 	return 0;
 }
 
@@ -2885,6 +2881,9 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 	if (err)
 		asihpi->update_interval_frames = 512;
 
+	if (!asihpi->support_mmap)
+		asihpi->update_interval_frames *= 2;
+
 	hpi_handle_error(hpi_instream_open(asihpi->adapter_index,
 			     0, &h_stream));
 
-- 
1.7.0.4
