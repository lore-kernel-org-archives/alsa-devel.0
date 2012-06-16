From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: snd-usb: make
	snd_usb_substream_capture_trigger static
Date: Sat, 16 Jun 2012 16:58:04 +0200
Message-ID: <1339858684-31758-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 55F212466F
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jun 2012 16:58:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/pcm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index cdf8b76..ce22f5f 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1147,7 +1147,8 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 	return -EINVAL;
 }
 
-int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream, int cmd)
+static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream,
+					     int cmd)
 {
 	int err;
 	struct snd_usb_substream *subs = substream->runtime->private_data;
-- 
1.7.10.2
