From: Clemens Ladisch <clemens@ladisch.de>
Subject: How to use implicit feedback with full duplex?
Date: Tue, 05 Feb 2013 21:44:38 +0100
Message-ID: <51116F36.9040106@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 63940261645
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2013 21:45:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I thought I'd try to use implicit feedback with my simple audio device:

    Interface Descriptor:
      bInterfaceNumber        1
      bAlternateSetting       0
    Interface Descriptor:
      bInterfaceNumber        1
      bAlternateSetting       1
      AudioStreaming Interface Descriptor:
        ...
      Endpoint Descriptor:
        bEndpointAddress     0x01  EP 1 OUT
    Interface Descriptor:
      bInterfaceNumber        2
      bAlternateSetting       0
    Interface Descriptor:
      bInterfaceNumber        2
      bAlternateSetting       1
      AudioStreaming Interface Descriptor:
        ...
      Endpoint Descriptor:
        bEndpointAddress     0x82  EP 2 IN

So I wrote a patch to configure it like those M-Audio devices:

--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -391,6 +391,17 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	attr = fmt->ep_attr & USB_ENDPOINT_SYNCTYPE;

 	switch (subs->stream->chip->usb_id) {
+	case USB_ID(0x0582, 0x0018):
+		if (is_playback) {
+			implicit_fb = 1;
+			ep = 0x82;
+			iface = usb_ifnum_to_if(dev, 2);
+			if (!iface || iface->num_altsetting < 2)
+				return -EINVAL;
+			alts = &iface->altsetting[1];
+			goto add_sync_ep;
+		}
+		break;
 	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
 		if (is_playback) {
 			implicit_fb = 1;

This works fine when playing something:

  kernel: setting usb interface 1:1
  kernel: Creating new playback data endpoint #1
  kernel: Creating new capture data endpoint #82
  kernel: Setting params for ep #1 (type 0, 8 urbs), ret=0
  kernel: match_endpoint_audioformats: (fmt @ffff8801fefa8900) score 2
  kernel: Setting params for ep #82 (type 0, 8 urbs), ret=0
  kernel: Starting data EP @ffff8801fd4e8000
  kernel: Starting sync EP @ffff8801fd2ac000

But when I then try to record at the same time, the driver refuses to
configure the input endpoint (to the only format, which is already set):

  kernel: setting usb interface 2:1
  kernel: Re-using EP 82 in iface 2,1 @ffff8801fd2ac000
  kernel: Unable to change format on ep #82: already in use

And despite that "alreay in use" check, the input endpoint is affected
so much that playback breaks.

Is full duplex supposed to work?  Does it work with other devices?


Regards,
Clemens
