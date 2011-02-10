From: linux@audioscience.com
Subject: [PATCH 27/28] Fix outstream start trigger for non-mmap
	adapters.
Date: Thu, 10 Feb 2011 17:26:20 +1300
Message-ID: <1297311981-30448-28-git-send-email-linux@audioscience.com>
References: <1297311981-30448-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1297311981-30448-1-git-send-email-linux@audioscience.com>
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
 pci/asihpi/asihpi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index b2c0c8a..c0ae94f 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -632,7 +632,8 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 		VPRINTK1(KERN_INFO "start\n");
 		/* start the master stream */
 		snd_card_asihpi_pcm_timer_start(substream);
-		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		if ((substream->stream == SNDRV_PCM_STREAM_CAPTURE) ||
+			!card->support_mmap)
 			hpi_handle_error(hpi_stream_start(dpcm->h_stream));
 		break;
 
-- 
1.7.0.4
