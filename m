From: thomas charbonnel <thomas@undata.org>
Subject: [PATCH] hdsp ghost midi device fix
Date: Fri, 28 Jan 2005 18:17:39 +0100
Message-ID: <1106932660.10925.6.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-zpEGk1ZUbrR/b/PDCKdI"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
List-Id: alsa-devel@alsa-project.org


--=-zpEGk1ZUbrR/b/PDCKdI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

The following patch, on top of the patches I submitted yesterday,
prevents a ghost midi device to be created on cards with only one midi
I/O (Multiface and HDSP9632).
It closes the ALSA bug #0000286.

Thomas

ChangeLog:
* Prevents the creation of a second midi device for cards with only
  one midi I/O

Signed-off-by: Thomas Charbonnel <thomas@undata.org>



--=-zpEGk1ZUbrR/b/PDCKdI
Content-Disposition: attachment; filename=hdsp_midi_dev_fix.patch
Content-Type: text/x-patch; name=hdsp_midi_dev_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- hdsp.c.old	2005-01-28 17:42:27.000000000 +0100
+++ hdsp.c	2005-01-28 18:15:35.000000000 +0100
@@ -3670,7 +3670,7 @@
 			snd_hdsp_midi_input_read (&hdsp->midi[0]);
 		}
 	}
-	if (midi1 && midi1status) {
+	if (hdsp->io_type != Multiface && hdsp->io_type != H9632 && midi1 && midi1status) {
 		if (hdsp->use_midi_tasklet) {
 			/* we disable interrupts for this input until processing is done */
 			hdsp->control_register &= ~HDSP_Midi1InterruptEnable;
@@ -4827,10 +4827,11 @@
 		return err;
 	}
 
-
-	if ((err = snd_hdsp_create_midi(card, hdsp, 1)) < 0) {
-		snd_printk("Hammerfall-DSP: Error creating second midi interface\n");
-		return err;
+	if (hdsp->io_type == Digiface || hdsp->io_type == H9652) {
+		if ((err = snd_hdsp_create_midi(card, hdsp, 1)) < 0) {
+			snd_printk("Hammerfall-DSP: Error creating second midi interface\n");
+			return err;
+		}
 	}
 
 	if ((err = snd_hdsp_create_controls(card, hdsp)) < 0) {
@@ -4967,6 +4968,8 @@
 	hdsp->midi[1].input = NULL;
 	hdsp->midi[0].output = NULL;
 	hdsp->midi[1].output = NULL;
+	hdsp->midi[0].pending = 0;
+	hdsp->midi[1].pending = 0;
 	spin_lock_init(&hdsp->midi[0].lock);
 	spin_lock_init(&hdsp->midi[1].lock);
 	hdsp->iobase = NULL;

--=-zpEGk1ZUbrR/b/PDCKdI--



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
