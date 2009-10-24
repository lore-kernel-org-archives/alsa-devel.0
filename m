From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 2/3] snd-usb-caiaq: Lock on stream start/unpause
Date: Sat, 24 Oct 2009 12:59:36 +0100
Message-ID: <1256385577-4175-2-git-send-email-mark@pogo.org.uk>
References: <alpine.NEB.2.01.0910241233570.26979@jrf.vwaro.pbz>
	<1256385577-4175-1-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mailout.ijneb.com [212.13.201.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 1755810380A
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Oct 2009 13:59:39 +0200 (CEST)
In-Reply-To: <1256385577-4175-1-git-send-email-mark@pogo.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix a bug which can result in white noise from the driver after stream
start or unpause.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
Acked-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/caiaq/audio.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index e76017c..86b2c3b 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -62,10 +62,14 @@ static void
 activate_substream(struct snd_usb_caiaqdev *dev,
 	           struct snd_pcm_substream *sub)
 {
+	spin_lock(&dev->spinlock);
+
 	if (sub->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		dev->sub_playback[sub->number] = sub;
 	else
 		dev->sub_capture[sub->number] = sub;
+
+	spin_unlock(&dev->spinlock);
 }
 
 static void
-- 
1.6.4.4
