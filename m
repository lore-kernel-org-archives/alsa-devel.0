From: Thomas Charbonnel <thomas@undata.org>
Subject: HDSP + multiface "freezing" patch
Date: 06 Mar 2003 17:53:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046969583.1338.3.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ZC/F1yCWe8stbSJzYbGw"
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


--=-ZC/F1yCWe8stbSJzYbGw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

We were searching a vicious bug, but it was a trivial one...
Applies on top of Paul's patch version II.

Thomas



--=-ZC/F1yCWe8stbSJzYbGw
Content-Disposition: attachment; filename=hdsp_missing_break.patch
Content-Type: text/plain; name=hdsp_missing_break.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- hdsp.c.orig	2003-03-05 19:23:52.000000000 +0100
+++ hdsp.c	2003-03-06 17:47:44.000000000 +0100
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
 		

--=-ZC/F1yCWe8stbSJzYbGw--



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
