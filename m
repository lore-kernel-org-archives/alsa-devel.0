From: Garnet MacPhee <dhubsith@comcast.net>
Subject: [RESENT] [PATCH - Fix Fast Track Ultra series:
 44.1/88.1 kHz 1/Fix playback/capture issues and related chrashes at 44100
 Hz and 88200 Hz for M-Audio Fast Track Ultra series.
Date: Thu, 2 Sep 2010 12:05:31 -0600
Message-ID: <20100902120531.2e99a5e8.dhubsith@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qmta08.emeryville.ca.mail.comcast.net
	(qmta08.emeryville.ca.mail.comcast.net [76.96.30.80])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D1E4103843
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 20:05:35 +0200 (CEST)
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

Clemens Ladisch wrote:

> I've got several reports that devices no longer work since UAC2 support got
> added.  But I've just noticed this is not related to the interface class
> but to the interface protocol: the new code added checks for UAC_VERSION_1
> or _2, but real devices apparently write just random junk into this field.
> (For vendor-specific interfaces, they are actually justified to do so.)

> We need something like the following (untested), unless you have a better
> idea:

I retro-fitted Clemens' patch to kernel 2.6.35 and tested it. There is a problem in card.c and endpoint.c in that KERN_WARN needs to be KERN_WARNING, but otherwise the patch works. I get this in dmesg:

ALSA sound/usb/endpoint.c:279: 2:1:1: unknown interface protocol 0xff, assuming v1
ALSA sound/usb/endpoint.c:439: 2:1:1: add audio endpoint 0x1
ALSA sound/usb/endpoint.c:279: 2:2:1: unknown interface protocol 0xff, assuming v1
ALSA sound/usb/endpoint.c:439: 2:2:1: add audio endpoint 0x81
ALSA sound/usb/endpoint.c:279: 2:2:2: unknown interface protocol 0xff, assuming v1
ALSA sound/usb/endpoint.c:439: 2:2:2: add audio endpoint 0x81
ALSA sound/usb/clock.c:243: current rate 48000 is different from the runtime rate 96000

It is still necessary to have the following bit of code in endpoint.c, otherwise sample rates of 44100 or 88200 do not work (the original problem). I think there should be a standard name instead of using 0x09, something like UAC_EP_CS_ATTR_ADAPTIVE, this would have to be defined somewhere.

diff -rupN /sound/usb/endpoint.c /sound/usb/endpoint.c
--- /sound/usb/endpoint.c
+++ /sound/usb/endpoint.c
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
