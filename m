From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Small hdsp maintenance patch
Date: Thu, 17 Jul 2003 22:13:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1826.62.39.219.34.1058472822.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_20030717221342_91020"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_20030717221342_91020
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

The attached patch :

* fixes a typo in the number of channels for hdsp 9652 cards
* fixes problems on hdsp9652 where the driver reported the firmware had to
be loaded
* adds an explicit warning about the fact that hardware metering is not
supported yet for hdsp 9652 cards

Thomas



------=_20030717221342_91020
Content-Type: text/plain; name="hdsp_cleanup.patch"
Content-Disposition: attachment; filename="hdsp_cleanup.patch"

--- hdsp.c.old	2003-07-12 17:39:07.000000000 +0200
+++ hdsp.c	2003-07-17 21:44:38.000000000 +0200
@@ -76,8 +76,8 @@
 #define DIGIFACE_DS_CHANNELS     14
 #define MULTIFACE_SS_CHANNELS    18
 #define MULTIFACE_DS_CHANNELS    14
-#define H9652_DS_CHANNELS        26
-#define H9652_SS_CHANNELS        14
+#define H9652_SS_CHANNELS        26
+#define H9652_DS_CHANNELS        14
 
 /* Write registers. These are defined as byte-offsets from the iobase value.
  */
@@ -643,6 +643,7 @@
 
 static inline int hdsp_check_for_firmware (hdsp_t *hdsp)
 {
+	if (hdsp->io_type == H9652) return 0;
 	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
 		snd_printk("firmware not present.\n");
 		hdsp->state &= ~HDSP_FirmwareLoaded;
@@ -3798,6 +3799,10 @@
 	
 	switch (cmd) {
 	case SNDRV_HDSP_IOCTL_GET_PEAK_RMS:
+		if (hdsp->io_type == H9652) {
+		    snd_printk("hardware metering isn't supported yet for hdsp9652 cards\n");
+		    return -EINVAL;
+		}
 		if (!(hdsp->state & HDSP_FirmwareLoaded)) {
 			snd_printk("firmware needs to be uploaded to the card.\n");	
 			return -EINVAL;


------=_20030717221342_91020--



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
