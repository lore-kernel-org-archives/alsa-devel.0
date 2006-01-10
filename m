From: Brent Cook <busterbcook@yahoo.com>
Subject: Re: Support for EDIROL UM-3ex
Date: Tue, 10 Jan 2006 07:34:32 -0600
Message-ID: <200601100734.33174.busterbcook@yahoo.com>
References: <200512312154.35173.busterbcook@yahoo.com> <s5hmzi5h2s4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pf7wD89RJfwYDqw"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzi5h2s4.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_pf7wD89RJfwYDqw
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 09 January 2006 08:52, Takashi Iwai wrote:
> At Sat, 31 Dec 2005 21:54:35 -0600,
>
> Brent Cook wrote:
> > Dear all,
> >
> > This is my naive attempt at adding ALSA device support. The attached
> > patch provides support for the EDIROL UM-3ex. This is a 3-port USB midi
> > interface with a built-in USB hub and the ability to chain 2 other
> > UM-3x's in a master-slave configuration. I only have one, so I do not
> > know how this works in practice.
>
> The patch looks OK to me, but it cannot be applied because we removed
> xxx_t typedefs in the latest ALSA code.  Could you regenerate a patch
> for Linus' latest git tree (also together with Signed-off-by line) ?
>
> Thanks.
>
> Takashi

Here you go. By the way. what was the rationale behind removing the typedefs? 
I always agonize over when to choose a typedef over a struct.

 - Brent

--Boundary-00=_pf7wD89RJfwYDqw
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="um-3ex.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="um-3ex.patch"

diff --git a/sound/usb/usbmidi.c b/sound/usb/usbmidi.c
index f15b021..905e33e 100644
--- a/sound/usb/usbmidi.c
+++ b/sound/usb/usbmidi.c
@@ -1092,6 +1092,8 @@ static struct {
 	{ USB_ID(0x086a, 0x0001), 8, "%s Broadcast" },
 	{ USB_ID(0x086a, 0x0002), 8, "%s Broadcast" },
 	{ USB_ID(0x086a, 0x0003), 4, "%s Broadcast" },
+	/* Edirol UM-3ex */
+	{ USB_ID(0x0582, 0x009a), 3, "%s Control" },
 };
 
 static void snd_usbmidi_init_substream(struct snd_usb_midi* umidi,
diff --git a/sound/usb/usbquirks.h b/sound/usb/usbquirks.h
index 6190ada..8f34861 100644
--- a/sound/usb/usbquirks.h
+++ b/sound/usb/usbquirks.h
@@ -204,6 +204,28 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
+	USB_DEVICE(0x0582, 0x009a),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.vendor_name = "EDIROL",
+		.product_name = "UM-3ex",
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_COMPOSITE,
+		.data = (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum = 0,
+				.type = QUIRK_MIDI_FIXED_ENDPOINT,
+				.data = & (const struct snd_usb_midi_endpoint_info) {
+					.out_cables = 0x000f,
+					.in_cables  = 0x000f
+				}
+			},
+			{
+				.ifnum = -1
+			}
+		}
+	}
+},
+{
 	USB_DEVICE(0x0582, 0x0002),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
 		.vendor_name = "EDIROL",

--Boundary-00=_pf7wD89RJfwYDqw--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
