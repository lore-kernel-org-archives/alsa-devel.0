From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400, v2,
	RFC 8/8] usb-audio: FT C400 sync playback EP to capture EP
Date: Tue,  6 Nov 2012 01:30:39 +0100
Message-ID: <1352161839-1455-9-git-send-email-eldad@fogrefinery.com>
References: <1352161839-1455-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C1A126167F
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 01:33:52 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id e19so2096111bku.38
 for <alsa-devel@alsa-project.org>; Mon, 05 Nov 2012 16:33:52 -0800 (PST)
In-Reply-To: <1352161839-1455-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Chris Cavey <chris-alsa@rauros.net>, Grant Diffey <gdiffey@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Eldad Zack <eldad@fogrefinery.com>, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The playback endpoint uses implicit feedback mode, similiar
to the M-Audio FTU. Like with the FTU, we need to associate
the sync pipe ourselves.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 37428f7..f35c5a4 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -372,6 +372,19 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 			alts = &iface->altsetting[1];
 			goto add_sync_ep;
 		}
+		break;
+	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
+		if (is_playback) {
+			implicit_fb = 1;
+			ep = 0x81;
+			iface = usb_ifnum_to_if(dev, 3);
+
+			if (!iface || iface->num_altsetting == 0)
+				return -EINVAL;
+
+			alts = &iface->altsetting[1];
+			goto add_sync_ep;
+		}
 	}
 
 	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||
-- 
1.7.8.6
