From: Thomas Charbonnel <thomas@undata.org>
Subject: [PATCH] possible fix for misbehaving hdsp
Date: Mon, 26 Jan 2004 14:54:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40151C22.6020005@undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000101000808030206020107"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, Paul Davis <paul@linuxaudiosystems.com>, Tim Blechmann <TimBlechmann@gmx.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000101000808030206020107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Could people experiencing problems with their hdsp (namely Tim and Paul) 
try the attached patch ?

Thanks,
Thomas

--------------000101000808030206020107
Content-Type: text/plain;
 name="pci_latency_timer.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="pci_latency_timer.patch"

--- hdsp.c.old	2004-01-26 14:34:48.000000000 +0100
+++ hdsp.c	2004-01-26 14:51:18.000000000 +0100
@@ -4982,6 +4982,16 @@
 	tasklet_init(&hdsp->midi_tasklet, hdsp_midi_tasklet, (unsigned long)hdsp);
 	
 	pci_read_config_word(hdsp->pci, PCI_CLASS_REVISION, &hdsp->firmware_rev);
+	
+	/* From Martin Björnsen :
+	    "It is important that the card's latency timer register in
+	    the PCI configuration space is set to a value much larger
+	    than 0 by the computer's BIOS or the driver.
+	    The windows driver always sets this 8 bit register [...]
+	    to its maximum 255 to avoid problems with some computers."
+	*/
+	pci_write_config_byte(hdsp->pci, PCI_LATENCY_TIMER, 0xFF);
+	
 	strcpy(card->driver, "H-DSP");
 	strcpy(card->mixername, "Xilinx FPGA");
 

--------------000101000808030206020107--




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
