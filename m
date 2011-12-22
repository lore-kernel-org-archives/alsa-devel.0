From: linux@audioscience.com
Subject: [PATCH 07/21] Relax drained check for more reliable
	playback startup.
Date: Thu, 22 Dec 2011 13:38:37 +1300
Message-ID: <1324514331-22570-8-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id B63B0103C11
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:05 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:25 +1300 (NZDT)
In-reply-to: <1324514331-22570-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/asihpi.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index d150d4f..1099a16 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -759,8 +759,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 		if (s->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			pcm_buf_dma_ofs = ds->pcm_buf_host_rw_ofs - bytes_avail;
 			if (state == HPI_STATE_STOPPED) {
-				if ((bytes_avail == 0) &&
-				    (on_card_bytes < ds->pcm_buf_host_rw_ofs)) {
+				if (bytes_avail == 0) {
 					hpi_handle_error(hpi_stream_start(ds->h_stream));
 					snd_printdd("P%d start\n", s->number);
 					ds->drained_count = 0;
@@ -769,7 +768,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 				snd_printd(KERN_WARNING "P%d drained\n",
 						s->number);
 				ds->drained_count++;
-				if (ds->drained_count > 2) {
+				if (ds->drained_count > 20) {
 					snd_pcm_stop(s, SNDRV_PCM_STATE_XRUN);
 					continue;
 				}
-- 
1.7.0.4
