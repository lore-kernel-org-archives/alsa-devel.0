From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: USB hardware that supports implicit feedback?
Date: Fri, 16 Nov 2012 03:10:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211160159040.1157@xoschi>
References: <p06240805cccafc72f23b@[192.168.1.36]>
 <alpine.LNX.2.00.1211152158440.2632@xoschi>
 <p06240809cccb09820207@[192.168.1.8]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 62B4C265D1F
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2012 03:10:44 +0100 (CET)
Received: by mail-we0-f179.google.com with SMTP id z49so819428wey.38
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 18:10:44 -0800 (PST)
In-Reply-To: <p06240809cccb09820207@[192.168.1.8]>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Griscom <griscom@suitable.com>
Cc: Alsa Developer <alsa-devel@alsa-project.org>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


Hi Daniel,

On Thu, 15 Nov 2012, Daniel Griscom wrote:
> The audio output stream (from the computer to my device) runs at a few frames
> per second higher or lower rate than that of the input stream (from my device
> to the computer). The actual difference seems to be stable on a specific
> machine, but varies greatly between machines (I've seen differences from +7fps
> to -2fps; I presume this is due to differences in CPU clock frequencies).

Looking at the lsusb output, I assume that the sink/source coupling 
doesn't work, because it's not in an interface group.

> >I'm not an ALSA dev, but I recently posted a series of patches for the
> >M-Audio Fast Track C400, which uses the implicit feedback code that was
> >already in the tree for other devices.
> So, this device uses implicit feedback to tell ALSA to send output data at the
> same rate as its input data? Very cool; I've ordered one to test.

Yes, and it seems to work very good with my hardware. But I'm not actually sure
I want to recommend a device with broken descriptors...

Try this, it *MIGHT* work (applies against mainline 3.7-rc5) - 
completely untested, btw.

Cheers,
Eldad

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 5c12a3f..fd766a3 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -372,6 +372,19 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 			alts = &iface->altsetting[1];
 			goto add_sync_ep;
 		}
+		break;
+	case USB_ID(0x03eb, 0x2311): /* AMTEL === UNTESTED === */
+		if (is_playback) {
+			implicit_fb = 1;
+			ep = 0x82;
+			iface = usb_ifnum_to_if(dev, 2);
+
+			if (!iface || iface->num_altsetting == 0)
+				return -EINVAL;
+
+			alts = &iface->altsetting[1];
+			goto add_sync_ep;
+		}
 	}
 
 	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||
