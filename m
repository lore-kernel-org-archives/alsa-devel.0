From: Martin Langer <martin-langer@gmx.de>
Subject: soundcard matrix
Date: Wed, 26 Nov 2003 22:42:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031126214244.GA14389@tuba.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Patrick,

here is a soundcardmatrix patch which creates new Tascam USx2y entries.


bye,
martin

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="matrix.diff"

--- matrix.html.ORIGINAL	Wed Nov 26 21:57:55 2003
+++ matrix.html	Wed Nov 26 22:24:54 2003
@@ -2790,6 +2790,32 @@
     </tr>
 
 
+<tr><th rowspan="4">
+      <a href="http://www.tascam.com/">Tascam</a>
+ </th></tr>
+ <tr>
+      <td><a href="http://www.tascam.com/product_info.php?pid=253">US-122</a></td>
+      <td>EZUSB, FPGA</td>
+     	<td align="center"><a href="http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=Tascam&amp;card=US-122&amp;chip=EZUSB,+FPGA&amp;module=usb-usx2y">Details</a>
+      	</td>		
+      <td>&nbsp;</td>
+    </tr>
+ <tr bgcolor="#aaaaaa">
+      <td><a href="http://www.tascam.com/product_info.php?pid=268">US-224</a></td>
+      <td>EZUSB, FPGA</td>
+     	<td align="center">&nbsp;
+      	</td>		
+      <td>&nbsp;</td>
+    </tr>
+ <tr>
+      <td><a href="http://www.tascam.com/product_info.php?pid=270">US-428</a></td>
+      <td>EZUSB, FPGA</td>
+     	<td align="center"><a href="http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=Tascam&amp;card=US-428&amp;chip=EZUSB,+FPGA&amp;module=usb-usx2y">Details</a>
+      	</td>		
+      <td>&nbsp;</td>
+    </tr>
+
+
 <tr><th rowspan="13">
       <a href="http://www.terratec.net/ttus/default.htm">Terratec</a>
  </th></tr>

--VbJkn9YxBvnuCH5J--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
