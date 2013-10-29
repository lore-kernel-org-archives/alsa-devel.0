From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/10] ALSA: rme96: Return error code in PCM
	copy ops
Date: Tue, 29 Oct 2013 17:00:30 +0100
Message-ID: <1383062433-9388-8-git-send-email-tiwai@suse.de>
References: <1383062433-9388-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F36BF2616B8
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A3629A60CF
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
In-Reply-To: <1383062433-9388-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Just pass the error code returned from copy_from_user_toio() and
copy_to_user_fromio() helpers.

Spotted by coverity CID 114119.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme96.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index bb9ebc5543d7..0236363c301f 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -350,9 +350,8 @@ snd_rme96_playback_copy(struct snd_pcm_substream *substream,
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 	count <<= rme96->playback_frlog;
 	pos <<= rme96->playback_frlog;
-	copy_from_user_toio(rme96->iobase + RME96_IO_PLAY_BUFFER + pos, src,
-			    count);
-	return 0;
+	return copy_from_user_toio(rme96->iobase + RME96_IO_PLAY_BUFFER + pos, src,
+				   count);
 }
 
 static int
@@ -365,9 +364,8 @@ snd_rme96_capture_copy(struct snd_pcm_substream *substream,
 	struct rme96 *rme96 = snd_pcm_substream_chip(substream);
 	count <<= rme96->capture_frlog;
 	pos <<= rme96->capture_frlog;
-	copy_to_user_fromio(dst, rme96->iobase + RME96_IO_REC_BUFFER + pos,
-			    count);
-        return 0;
+	return copy_to_user_fromio(dst, rme96->iobase + RME96_IO_REC_BUFFER + pos,
+				   count);
 }
 
 /*
-- 
1.8.4.1
