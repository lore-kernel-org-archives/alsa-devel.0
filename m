From: Thomas Charbonnel <thomas@undata.org>
Subject: HDSP9652 fix
Date: 09 Apr 2003 09:43:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049874193.1378.9.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-CwVCL/WJWjrm2rnrsmD9"
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


--=-CwVCL/WJWjrm2rnrsmD9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

This patch fixes a problem with HDSP9652 cards. Thanks to Joshua N
Pritikin for pointing to bug to me and helping in tracking it down.

Thomas



--=-CwVCL/WJWjrm2rnrsmD9
Content-Disposition: attachment; filename=hdsp9652.patch
Content-Type: text/plain; name=hdsp9652.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- hdsp.c.old	2003-04-08 18:19:00.000000000 +0200
+++ hdsp.c	2003-04-08 20:16:08.000000000 +0200
@@ -3025,7 +3025,7 @@
 		hdsp->mixer_matrix[i] = MINUS_INFINITY_GAIN;
 	}
 
-	for (i = 0; i < 2048; i++) {
+	for (i = 0; i < (hdsp_is_9652(hdsp) ? 1352 : HDSP_MATRIX_MIXER_SIZE); i++) {
 		if (hdsp_write_gain (hdsp, i, MINUS_INFINITY_GAIN)) {
 			return -EIO;
 		}

--=-CwVCL/WJWjrm2rnrsmD9--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
