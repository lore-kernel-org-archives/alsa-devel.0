From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [PATCH] Fix AC3 output on alsa-lib ca0106.conf
Date: Sat, 19 Mar 2005 17:45:59 +0000
Message-ID: <423C6557.50005@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010307040200040506030806"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010307040200040506030806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This fixes AC3 SPDIF output. It now correctly turns SPDIF OUT on when 
using the iec958 device.

Sign off: James Courtier-Dutton

--------------010307040200040506030806
Content-Type: text/plain;
 name="alsa-lib-ca0106-spdif-fix.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib-ca0106-spdif-fix.diff.txt"

Index: alsa-lib/src/conf/cards/CA0106.conf
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/conf/cards/CA0106.conf,v
retrieving revision 1.1
diff -u -r1.1 CA0106.conf
--- alsa-lib/src/conf/cards/CA0106.conf	6 Dec 2004 15:28:06 -0000	1.1
+++ alsa-lib/src/conf/cards/CA0106.conf	19 Mar 2005 17:43:42 -0000
@@ -162,7 +162,7 @@
 				name "SPDIF Out"
 				lock true
 				preserve true
-				value 0
+				value 1
 			}
 			{
 				name "IEC958 Playback Default"

--------------010307040200040506030806--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
