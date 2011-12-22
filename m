From: linux@audioscience.com
Subject: [PATCH 05/21] Use snd_pcm_debug_name to get substream
	name.
Date: Thu, 22 Dec 2011 13:38:35 +1300
Message-ID: <1324514331-22570-6-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 15553103BF2
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:04 +0100 (CET)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LWK00D3EXTHNQ40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 22 Dec 2011 13:39:24 +1300 (NZDT)
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
 sound/pci/asihpi/asihpi.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index cf5baa2..d150d4f 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -904,7 +904,9 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 static int snd_card_asihpi_playback_ioctl(struct snd_pcm_substream *substream,
 					  unsigned int cmd, void *arg)
 {
-	snd_printddd(KERN_INFO "P%d ioctl %d\n", substream->number, cmd);
+	char name[16];
+	snd_pcm_debug_name(substream, name, sizeof(name));
+	snd_printddd(KERN_INFO "%s ioctl %d\n", name, cmd);
 	return snd_pcm_lib_ioctl(substream, cmd, arg);
 }
 
@@ -929,9 +931,11 @@ snd_card_asihpi_playback_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
 	snd_pcm_uframes_t ptr;
+	char name[16];
+	snd_pcm_debug_name(substream, name, sizeof(name));
 
 	ptr = bytes_to_frames(runtime, dpcm->pcm_buf_dma_ofs  % dpcm->buffer_bytes);
-	snd_printddd("P%d pointer = 0x%04lx\n", substream->number, (unsigned long)ptr);
+	snd_printddd("%s pointer = 0x%04lx\n", name, (unsigned long)ptr);
 	return ptr;
 }
 
-- 
1.7.0.4
