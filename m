From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 1/3] snd-usb-caiaq: only warn once on streaming
	errors
Date: Wed, 18 Mar 2009 11:03:53 +0100
Message-ID: <1237370635-27728-2-git-send-email-daniel@caiaq.de>
References: <1237370635-27728-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A9211038CF
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 11:04:05 +0100 (CET)
In-Reply-To: <1237370635-27728-1-git-send-email-daniel@caiaq.de>
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
List-Id: alsa-devel@alsa-project.org

Limit the number of printed warnings to one in case of streaming errors.
printk() happens to be expensive, especially in code called as often as
here.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/caiaq/caiaq-audio.c  |    4 +++-
 sound/usb/caiaq/caiaq-device.h |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/usb/caiaq/caiaq-audio.c b/sound/usb/caiaq/caiaq-audio.c
index fc6d571..577b112 100644
--- a/sound/usb/caiaq/caiaq-audio.c
+++ b/sound/usb/caiaq/caiaq-audio.c
@@ -114,6 +114,7 @@ static int stream_start(struct snd_usb_caiaqdev *dev)
 	dev->output_panic = 0;
 	dev->first_packet = 1;
 	dev->streaming = 1;
+	dev->warned = 0;
 
 	for (i = 0; i < N_URBS; i++) {
 		ret = usb_submit_urb(dev->data_urbs_in[i], GFP_ATOMIC);
@@ -406,10 +407,11 @@ static void read_in_urb(struct snd_usb_caiaqdev *dev,
 		break;
 	}
 
-	if (dev->input_panic || dev->output_panic) {
+	if ((dev->input_panic || dev->output_panic) && !dev->warned) {
 		debug("streaming error detected %s %s\n", 
 				dev->input_panic ? "(input)" : "",
 				dev->output_panic ? "(output)" : "");
+		dev->warned = 1;
 	}
 }
 
diff --git a/sound/usb/caiaq/caiaq-device.h b/sound/usb/caiaq/caiaq-device.h
index 3edd94d..4aa8631 100644
--- a/sound/usb/caiaq/caiaq-device.h
+++ b/sound/usb/caiaq/caiaq-device.h
@@ -90,7 +90,7 @@ struct snd_usb_caiaqdev {
 	int audio_out_buf_pos[MAX_STREAMS];
 	int period_in_count[MAX_STREAMS];
 	int period_out_count[MAX_STREAMS];
-	int input_panic, output_panic;
+	int input_panic, output_panic, warned;
 	char *audio_in_buf, *audio_out_buf;
 	unsigned int samplerates;
 
-- 
1.6.2
