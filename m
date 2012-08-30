From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] ALSA: snd-usb: use list_for_each_safe for
	endpoint resources
Date: Thu, 30 Aug 2012 17:11:17 -0400
Message-ID: <20120830211116.15374.52284.stgit@mj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from c60.cesmail.net (c60.cesmail.net [216.154.195.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 19E50265DC7
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 23:11:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_usb_endpoint_free() frees the structure that contains its argument.

Signed-off-by: Pavel Roskin <proski@gnu.org>
Cc: stable@vger.kernel.org
---

 sound/usb/card.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index d5b5c33..4a469f0 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -553,7 +553,7 @@ static void snd_usb_audio_disconnect(struct usb_device *dev,
 				     struct snd_usb_audio *chip)
 {
 	struct snd_card *card;
-	struct list_head *p;
+	struct list_head *p, *n;
 
 	if (chip == (void *)-1L)
 		return;
@@ -570,7 +570,7 @@ static void snd_usb_audio_disconnect(struct usb_device *dev,
 			snd_usb_stream_disconnect(p);
 		}
 		/* release the endpoint resources */
-		list_for_each(p, &chip->ep_list) {
+		list_for_each_safe(p, n, &chip->ep_list) {
 			snd_usb_endpoint_free(p);
 		}
 		/* release the midi resources */
