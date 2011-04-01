From: linux@audioscience.com
Subject: [snd-asihpi 3/8] More forgiving handling of card
 playback drained status.
Date: Fri, 01 Apr 2011 15:59:47 +1300
Message-ID: <1301626792-13705-4-git-send-email-linux@audioscience.com>
References: <1301626792-13705-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1301626792-13705-1-git-send-email-linux@audioscience.com>
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

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/asihpi.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index 434342f..a5226e3 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -165,6 +165,7 @@ struct snd_card_asihpi_pcm {
 	unsigned int pcm_buf_host_rw_ofs; /* Host R/W pos */
 	unsigned int pcm_buf_dma_ofs;	/* DMA R/W offset in buffer */
 	unsigned int pcm_buf_elapsed_dma_ofs;	/* DMA R/W offset in buffer */
+	unsigned int drained_count;
 	struct snd_pcm_substream *substream;
 	u32 h_stream;
 	struct hpi_format format;
@@ -592,6 +593,7 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 			if (substream->stream != s->stream)
 				continue;
 
+			ds->drained_count = 0;
 			if ((s->stream == SNDRV_PCM_STREAM_PLAYBACK) &&
 				(card->support_mmap)) {
 				/* How do I know how much valid data is present
@@ -771,12 +773,18 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 				    (on_card_bytes < ds->pcm_buf_host_rw_ofs)) {
 					hpi_handle_error(hpi_stream_start(ds->h_stream));
 					snd_printdd("P%d start\n", s->number);
+					ds->drained_count = 0;
 				}
 			} else if (state == HPI_STATE_DRAINED) {
 				snd_printd(KERN_WARNING "P%d drained\n",
 						s->number);
-				/*snd_pcm_stop(s, SNDRV_PCM_STATE_XRUN);
-				continue; */
+				ds->drained_count++;
+				if (ds->drained_count > 2) {
+					snd_pcm_stop(s, SNDRV_PCM_STATE_XRUN);
+					continue;
+				}
+			} else {
+				ds->drained_count = 0;
 			}
 		} else
 			pcm_buf_dma_ofs = bytes_avail + ds->pcm_buf_host_rw_ofs;
-- 
1.7.0.4
