From: Thomas Charbonnel <thomas@undata.org>
Subject: [PATCH] hdsp driver : spdifFrequency bitmasks fix
Date: 11 Mar 2003 18:33:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1047403993.1519.22.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-iqil4w3+5bcmnRKjrM6C"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-iqil4w3+5bcmnRKjrM6C
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

The attached patch fixes the spdifFrequency bitmasks in the hdsp driver.
Applies on top of Paul's version II patch. Includes my preceding
"missing break" patch.

Thomas


--=-iqil4w3+5bcmnRKjrM6C
Content-Disposition: attachment; filename=hdsp_spdif_freq_mask.patch
Content-Type: text/plain; name=hdsp_spdif_freq_mask.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- hdsp.c.orig	2003-03-05 19:23:52.000000000 +0100
+++ hdsp.c	2003-03-11 18:27:38.000000000 +0100
@@ -240,13 +240,13 @@
 
 #define HDSP_spdifFrequencyMask    (HDSP_spdifFrequency0|HDSP_spdifFrequency1|HDSP_spdifFrequency2)
 
-#define HDSP_spdifFrequency32KHz   (HDSP_spdifFrequency0|HDSP_spdifFrequency1|HDSP_spdifFrequency2)
-#define HDSP_spdifFrequency44_1KHz (HDSP_spdifFrequency2|HDSP_spdifFrequency1)
-#define HDSP_spdifFrequency48KHz   (HDSP_spdifFrequency0|HDSP_spdifFrequency2)
-
-#define HDSP_spdifFrequency64KHz    0
-#define HDSP_spdifFrequency88_2KHz (HDSP_spdifFrequency2)
-#define HDSP_spdifFrequency96KHz   (HDSP_spdifFrequency0|HDSP_spdifFrequency1)
+#define HDSP_spdifFrequency32KHz   (HDSP_spdifFrequency0)
+#define HDSP_spdifFrequency44_1KHz (HDSP_spdifFrequency1)
+#define HDSP_spdifFrequency48KHz   (HDSP_spdifFrequency0|HDSP_spdifFrequency1)
+
+#define HDSP_spdifFrequency64KHz   (HDSP_spdifFrequency2)
+#define HDSP_spdifFrequency88_2KHz (HDSP_spdifFrequency0|HDSP_spdifFrequency2)
+#define HDSP_spdifFrequency96KHz   (HDSP_spdifFrequency2|HDSP_spdifFrequency1)
 
 /* Status2 Register bits */
 
@@ -3002,9 +3002,9 @@
 			case 0xa:
 			case 0x64:
 				firmware_ptr = (u32 *) multiface_firmware;
+				break;
 			default:
 				firmware_ptr = (u32 *) multiface_firmware_rev11;
-				break;
 			}
 		}
 		

--=-iqil4w3+5bcmnRKjrM6C--



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
