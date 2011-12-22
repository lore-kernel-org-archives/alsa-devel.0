From: linux@audioscience.com
Subject: [PATCH 08/21] Only set sync if card supports hardware
	stream grouping.
Date: Thu, 22 Dec 2011 13:38:38 +1300
Message-ID: <1324514331-22570-9-git-send-email-linux@audioscience.com>
References: <1324514331-22570-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 175A6103BF2
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 01:40:09 +0100 (CET)
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
 sound/pci/asihpi/asihpi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 1099a16..fff7c50 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1033,8 +1033,10 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 					SNDRV_PCM_INFO_MMAP |
 					SNDRV_PCM_INFO_MMAP_VALID;
 
-	if (card->support_grouping)
+	if (card->support_grouping) {
 		snd_card_asihpi_playback.info |= SNDRV_PCM_INFO_SYNC_START;
+		snd_pcm_set_sync(substream);
+	}
 
 	/* struct is copied, so can create initializer dynamically */
 	runtime->hw = snd_card_asihpi_playback;
@@ -1051,8 +1053,6 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 		card->update_interval_frames * 2, UINT_MAX);
 
-	snd_pcm_set_sync(substream);
-
 	snd_printdd("playback open\n");
 
 	return 0;
-- 
1.7.0.4
