From: Raimonds Cicans <ray@vardes.lv>
Subject: Re: SB Live! 24-Bit External: remote control support
Date: Fri, 28 Apr 2006 12:52:02 +0300
Message-ID: <4451E5C2.7050104@vardes.lv>
References: <44512925.30803@vardes.lv> <20060428084200.GA26640@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040205000707030009030100"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060428084200.GA26640@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040205000707030009030100
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Clemens Ladisch wrote:
> Raimonds Cicans wrote:
>>Attached patch contains support for 'SB Live! 24-Bit External' remote
> 
> It seems the codes are not compatible with the Extigy/Audigy2NX.
Yes

> Are the lower 8 bits unique, or does the LIRC driver need to be updated
> to read 32 bit codes?
Unique.
But I plan to send patch to LIRC to support 32bit codes,
because IMHO it may be useful for other remotes.

> Please provide a Signed-off-by line.
In attached file

Raimonds Cicans

--------------040205000707030009030100
Content-Type: text/x-patch;
 name="sb_live24_usb_remote.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb_live24_usb_remote.patch"

Support for 'SB Live! 24-Bit External' remote

Signed-off-by: Raimonds Cicans <ray@vardes.lv>

--- old/alsa-driver-1.0.11/alsa-kernel/usb/usbmixer.c	2006-03-28 18:58:28.000000000 +0300
+++ alsa-driver-1.0.11/alsa-kernel/usb/usbmixer.c	2006-04-27 22:33:53.000000000 +0300
@@ -46,6 +46,28 @@
 /* ignore error from controls - for debugging */
 /* #define IGNORE_CTL_ERROR */
 
+/*
+ * Sound Blaster remote control configuration
+ *
+ * format of remote control data:
+ * Extigy:       xx 00
+ * Audigy 2 NX:  06 80 xx 00 00 00
+ * Live! 24-bit: 06 80 xx yy 22 83
+ */
+static const struct rc_config {
+	u32 usb_id;
+	u8  offset;
+	u8  len;
+	u8  pkt_min_len; /* offset + len */
+	u8  pkt_max_len;
+	u32 mute_code;
+	u8  mute_mixer_id;
+} rc_configs[] = {
+	{USB_ID(0x041e, 0x3000), 0, 1, 1, 2, 0x0013, 18}, /* Extigy       */
+	{USB_ID(0x041e, 0x3020), 2, 1, 3, 6, 0x0013, 18}, /* Audigy 2 NX  */
+	{USB_ID(0x041e, 0x3040), 2, 2, 4, 6, 0x6e91,  2}, /* Live! 24-bit */
+	{0}}; /* Terminator */
+
 struct usb_mixer_interface {
 	struct snd_usb_audio *chip;
 	unsigned int ctrlif;
@@ -55,11 +77,7 @@
 	struct usb_mixer_elem_info **id_elems; /* array[256], indexed by unit id */
 
 	/* Sound Blaster remote control stuff */
-	enum {
-		RC_NONE,
-		RC_EXTIGY,
-		RC_AUDIGY2NX,
-	} rc_type;
+	const struct rc_config *rc_cfg;
 	unsigned long rc_hwdep_open;
 	u32 rc_code;
 	wait_queue_head_t rc_waitq;
@@ -1647,7 +1665,7 @@
 static void snd_usb_mixer_memory_change(struct usb_mixer_interface *mixer,
 					int unitid)
 {
-	if (mixer->rc_type == RC_NONE)
+	if (mixer->rc_cfg == NULL)
 		return;
 	/* unit ids specific to Extigy/Audigy 2 NX: */
 	switch (unitid) {
@@ -1732,20 +1750,20 @@
 						 struct pt_regs *regs)
 {
 	struct usb_mixer_interface *mixer = urb->context;
-	/*
-	 * format of remote control data:
-	 * Extigy:	xx 00
-	 * Audigy 2 NX:	06 80 xx 00 00 00
-	 */
-	int offset = mixer->rc_type == RC_EXTIGY ? 0 : 2;
+	const struct rc_config *rc = mixer->rc_cfg;
 	u32 code;
 
-	if (urb->status < 0 || urb->actual_length <= offset)
+	if (urb->status < 0 || urb->actual_length < rc->pkt_min_len)
 		return;
-	code = mixer->rc_buffer[offset];
+
+	code = mixer->rc_buffer[rc->offset];
+
+	if (rc->len == 2)
+		code |= ((u32)(mixer->rc_buffer[rc->offset + 1]))<<8;
+
 	/* the Mute button actually changes the mixer control */
-	if (code == 13)
-		snd_usb_mixer_notify_id(mixer, 18);
+	if (code == rc->mute_code)
+		snd_usb_mixer_notify_id(mixer, rc->mute_mixer_id);
 	mixer->rc_code = code;
 	wmb();
 	wake_up(&mixer->rc_waitq);
@@ -1801,21 +1819,18 @@
 static int snd_usb_soundblaster_remote_init(struct usb_mixer_interface *mixer)
 {
 	struct snd_hwdep *hwdep;
-	int err, len;
+	int err, len, i;
 
-	switch (mixer->chip->usb_id) {
-	case USB_ID(0x041e, 0x3000):
-		mixer->rc_type = RC_EXTIGY;
-		len = 2;
-		break;
-	case USB_ID(0x041e, 0x3020):
-		mixer->rc_type = RC_AUDIGY2NX;
-		len = 6;
-		break;
-	default:
-		return 0;
-	}
+	mixer->rc_cfg = NULL;
 
+	for (i = 0; rc_configs[i].usb_id != mixer->chip->usb_id; i++)
+		if (rc_configs[i].usb_id == 0)
+			return 0;
+
+	mixer->rc_cfg = &rc_configs[i];
+
+	len = mixer->rc_cfg->pkt_max_len;
+	
 	init_waitqueue_head(&mixer->rc_waitq);
 	err = snd_hwdep_new(mixer->chip->card, "SB remote control", 0, &hwdep);
 	if (err < 0)

--------------040205000707030009030100--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
