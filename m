From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/3] ALSA: snd-usb: add delay quirk for
	"Playback Design" products
Date: Sun, 17 Mar 2013 20:07:26 +0800
Message-ID: <1363522047-7515-4-git-send-email-zonque@gmail.com>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 8117826517C
 for <alsa-devel@alsa-project.org>; Sun, 17 Mar 2013 13:07:44 +0100 (CET)
In-Reply-To: <1363522047-7515-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

"Playback Design" products need a 50ms delay after setting the USB
interface.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Andreas Koch <andreas@akdesigninc.com>
---
 sound/usb/pcm.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index f94397b..c263991 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -350,6 +350,13 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 				fmt->iface, fmt->altsetting);
 		subs->interface = fmt->iface;
 		subs->altset_idx = fmt->altset_idx;
+
+		/*
+		 * "Playback Design" products need a 50ms delay after setting the
+		 * USB interface.
+		 */
+		if (le16_to_cpu(dev->descriptor.idVendor) == 0x23ba)
+			mdelay(50);
 	}
 
 	subs->data_endpoint = snd_usb_add_endpoint(subs->stream->chip,
-- 
1.7.10.4
