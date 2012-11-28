From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400, PATCH RFC,
	v4 10/10] usb-audio: FT C400 sync playback EP to capture EP
Date: Wed, 28 Nov 2012 23:55:41 +0100
Message-ID: <1354143341-1623-11-git-send-email-eldad@fogrefinery.com>
References: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 03CDB264F45
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 23:56:13 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so5643893bkc.38
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 14:56:13 -0800 (PST)
In-Reply-To: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>, Felix Homann <linuxaudio@showlabor.de>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
Cc: Grant Diffey <gdiffey@gmail.com>, George Willian Condomitti <georgecondomitti@gmail.com>, Chris Cavey <chris-alsa@rauros.net>, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

The playback endpoint uses implicit feedback mode, similar
to the M-Audio FTU. Like with the FTU, we need to associate
the sync pipe ourselves.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 2158943..f30f46ca 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -359,6 +359,19 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	attr = fmt->ep_attr & USB_ENDPOINT_SYNCTYPE;
 
 	switch (subs->stream->chip->usb_id) {
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
+		break;
 	case USB_ID(0x0763, 0x2080): /* M-Audio FastTrack Ultra */
 	case USB_ID(0x0763, 0x2081):
 		if (is_playback) {
-- 
1.7.8.6
