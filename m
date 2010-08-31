From: Felix Homann <fexpop@web.de>
Subject: Re: [PATCH - Fix Fast Track Ultra series: 44.1/88.1
 kHz 1/Fix playback/capture issues and related chrashes at 44100 Hz and
 88200 Hz for M-Audio Fast Track Ultra series.
Date: Tue, 31 Aug 2010 08:39:24 +0200
Message-ID: <4C7CA39C.60205@web.de>
References: <4C32E3B2.5080707@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000806000303030107040809"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 365FB103800
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 08:39:26 +0200 (CEST)
In-Reply-To: <4C32E3B2.5080707@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <fexpop@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000806000303030107040809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear Alsa developers,

almost 2 months ago I send a patch making the M-Audio Fast Track Ultra 
series audio interfaces work flawlessly in Linux except for missing 
mixer support:

Am 06.07.2010 10:05, schrieb Felix Homann:
> This fixes issues with M-Audio's Fast Track Ultra series:
>
> * devices now work at 44100 and 88200 Hz
> * apparently, fixes some crashes, too

Unfortunately, the patch didn't make it into Alsa so far. Clemens 
Ladisch seemed reluctant to apply a fixed endpoint quirk since the 
device should have worked without in his opinion. I gave him all the 
requested information to see what was happening without the fixed 
endpoint quirk. I never heard back from him again.

So, could someone in charge kindly tell me why the patch didn't make it 
into Alsa? What's missing, what's wrong?

If it's just the fact that Clemens doesn't like the fixed endpoint quirk 
please find attached a different patch yielding the same result. 
(Against Linux 2.6.35. It's again from dhubsith who posted it on the 
M-Audio forum. He would sign it off if requested - on the other hand it 
is already derived work of the Alsa sources).

And please, if it's not going anywhere, please tell us "laymen, 
volunteer Alsa helpers" about the reasons.

The current situation is most frustrating: We know how to make the 
device work (much better than in Windows, btw) but we don't know why we 
have to patch alsa again and again.

Thanks in advance,

Felix



--------------000806000303030107040809
Content-Type: text/plain;
 name="maudio.patch-2.6.35.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="maudio.patch-2.6.35.txt"

diff -rupN /sound/usb/card.c /sound/usb/card.c
--- /sound/usb/card.c
+++ /sound/usb/card.c
@@ -209,6 +209,8 @@ static int snd_usb_create_streams(struct
 						 NULL, UAC_HEADER);
 	altsd = get_iface_desc(host_iface);
 	protocol = altsd->bInterfaceProtocol;
+                if (chip->usb_id == USB_ID(0x0763, 0x2080) || chip->usb_id == USB_ID(0x0763, 0x2081))
+		protocol = UAC_VERSION_1;
 
 	if (!control_header) {
 		snd_printk(KERN_ERR "cannot find UAC_HEADER\n");
diff -rupN /sound/usb/endpoint.c /sound/usb/endpoint.c
--- /sound/usb/endpoint.c
+++ /sound/usb/endpoint.c
@@ -252,6 +252,8 @@ int snd_usb_parse_audio_endpoints(struct
 		alts = &iface->altsetting[i];
 		altsd = get_iface_desc(alts);
 		protocol = altsd->bInterfaceProtocol;
+                if (chip->usb_id == USB_ID(0x0763, 0x2080) || chip->usb_id == USB_ID(0x0763, 0x2081))
+		protocol = UAC_VERSION_1;
 		/* skip invalid one */
 		if ((altsd->bInterfaceClass != USB_CLASS_AUDIO &&
 		     altsd->bInterfaceClass != USB_CLASS_VENDOR_SPEC) ||
@@ -403,11 +405,15 @@ int snd_usb_parse_audio_endpoints(struct
 			break;
 		case USB_ID(0x041e, 0x3020): /* Creative SB Audigy 2 NX */
 		case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
-		case USB_ID(0x0763, 0x2080): /* M-Audio Fast Track Ultra 8 */
-		case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
 			/* doesn't set the sample rate attribute, but supports it */
 			fp->attributes |= UAC_EP_CS_ATTR_SAMPLE_RATE;
 			break;
+		case USB_ID(0x0763, 0x2080): /* M-Audio Fast Track Ultra   */
+		case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
+			/* force playback sync to adaptive only and turn off async*/
+			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+				fp->ep_attr = 0x09;
+			break;
 		case USB_ID(0x047f, 0x0ca1): /* plantronics headset */
 		case USB_ID(0x077d, 0x07af): /* Griffin iMic (note that there is
 						an older model 77d:223) */
diff -rupN /sound/usb/format.c /sound/usb/format.c
--- /sound/usb/format.c
+++ /sound/usb/format.c
@@ -353,6 +353,8 @@ static int parse_audio_format_i(struct s
 	struct usb_interface_descriptor *altsd = get_iface_desc(iface);
 	int protocol = altsd->bInterfaceProtocol;
 	int pcm_format, ret;
+                if (chip->usb_id == USB_ID(0x0763, 0x2080) || chip->usb_id == USB_ID(0x0763, 0x2081))
+		protocol = UAC_VERSION_1;
 
 	if (fmt->bFormatType == UAC_FORMAT_TYPE_III) {
 		/* FIXME: the format type is really IECxxx
@@ -415,6 +417,8 @@ static int parse_audio_format_ii(struct 
 	int brate, framesize, ret;
 	struct usb_interface_descriptor *altsd = get_iface_desc(iface);
 	int protocol = altsd->bInterfaceProtocol;
+                if (chip->usb_id == USB_ID(0x0763, 0x2080) || chip->usb_id == USB_ID(0x0763, 0x2081))
+		protocol = UAC_VERSION_1;
 
 	switch (format) {
 	case UAC_FORMAT_TYPE_II_AC3:

--------------000806000303030107040809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000806000303030107040809--
