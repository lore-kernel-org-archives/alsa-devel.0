From: Clemens Ladisch <clemens@ladisch.de>
Subject: [doc PATCH] more supported USB MIDI devices
Date: Wed, 13 Nov 2002 11:29:13 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211131125050.14532-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


Added the Edirol UA-20 and the Yamaha EOS BX.
The other Yamaha USB MIDI devices aren't green anymore.


--- alsa-doc-soundcard-matrix.html.org	Wed Nov 13 10:12:10 2002
+++ alsa-doc-soundcard-matrix.html	Wed Nov 13 10:21:21 2002
@@ -2225,7 +2225,7 @@
       	</td>
       <td>[A][B][C][D][E][F]</td>
     </tr>
- <tr><th rowspan="21">
+ <tr><th rowspan="22">
       <a href="http://www.edirol.com/">Roland/Edirol</a>
  </tr>
  <tr>
@@ -2299,6 +2299,13 @@
       <td>&nbsp;</td>
     </tr>
  <tr>
+      <td><a href="http://www.edirol.com/products/info/ua20.html">UA-20</a></td>
+      <td>&nbsp;</td>
+	<td align="center"><a href="doc-php/template.php3?company=Edirol&card=UA-20&chip=&module=usb-audio">Details</a>
+	</td>
+      <td>&nbsp;</td>
+    </tr>
+ <tr>
       <td><a href="http://www.edirol.com/products/info/archive/ua100.html">UA-100</a></td>
       <td>&nbsp;</td>
 	<td align="center"><a href="doc-php/template.php3?company=Edirol&card=UA-100&chip=&module=usb-audio">Details</a>
@@ -2873,7 +2880,7 @@
       <td>&nbsp;</td>
       <td>[D]</td>
     </tr>
- <tr><th rowspan="34">
+ <tr><th rowspan="35">
       <a href="http://www.yamaha.com">Yamaha</a>
  </tr>
  <tr bgcolor="#aaaaaa">
@@ -2908,47 +2915,54 @@
       	</td>
       <td>[A][C][D] USB!</td>
     </tr>
- <tr bgcolor="#00ff00">
+ <tr>
       <td><a href="http://www.yamaha.co.jp/product/cl/clp/clp-150.html">CLP-150</a></td>
       <td>&nbsp;</td>
 	<td align="center"><a href="doc-php/template.php3?company=Yamaha&card=CLP-150&chip=&module=usb-audio">Details</a>
 	</td>
-      <td>untested</td>
+      <td>&nbsp;</td>
     </tr>
- <tr bgcolor="#00ff00">
+ <tr>
       <td><a href="http://www.yamaha.co.jp/product/cl/clp/clp-170.html">CLP-170</a></td>
       <td>&nbsp;</td>
 	<td align="center"><a href="doc-php/template.php3?company=Yamaha&card=CLP-170&chip=&module=usb-audio">Details</a>
 	</td>
-      <td>untested</td>
+      <td>&nbsp;</td>
+    </tr>
+ <tr>
+      <td><a href="http://www.yamaha.co.jp/product/syndtm/p/synth/bx/">EOS BX</a></td>
+      <td>&nbsp;</td>
+	<td align="center"><a href="doc-php/template.php3?company=Yamaha&card=EOS%20BX&chip=&module=usb-audio">Details</a>
+	</td>
+      <td>&nbsp;</td>
     </tr>
- <tr bgcolor="#00ff00">
+ <tr>
       <td><a href="http://www.yamahasynth.com/pro/motif/index.html">MOTIF6</a></td>
       <td>&nbsp;</td>
 	<td align="center"><a href="doc-php/template.php3?company=Yamaha&card=MOTIF6&chip=&module=usb-audio">Details</a>
 	</td>
-      <td>untested</td>
+      <td>&nbsp;</td>
     </tr>
- <tr bgcolor="#00ff00">
+ <tr>
       <td><a href="http://www.yamahasynth.com/pro/motif/index.html">MOTIF7</a></td>
       <td>&nbsp;</td>
 	<td align="center"><a href="doc-php/template.php3?company=Yamaha&card=MOTIF7&chip=&module=usb-audio">Details</a>
 	</td>
-      <td>untested</td>
+      <td>&nbsp;</td>
     </tr>
- <tr bgcolor="#00ff00">
+ <tr>
       <td><a href="http://www.yamahasynth.com/pro/motif/index.html">MOTIF8</a></td>
       <td>&nbsp;</td>
 	<td align="center"><a href="doc-php/template.php3?company=Yamaha&card=MOTIF8&chip=&module=usb-audio">Details</a>
 	</td>
-      <td>untested</td>
+      <td>&nbsp;</td>
     </tr>
- <tr bgcolor="#00ff00">
+ <tr>
       <td><a href="http://www.yamaha.co.jp/product/syndtm/p/dtm/mu500/">MU500</a></td>
       <td>&nbsp;</td>
 	<td align="center"><a href="doc-php/template.php3?company=Yamaha&card=MU500&chip=&module=usb-audio">Details</a>
 	</td>
-      <td>untested</td>
+      <td>&nbsp;</td>
     </tr>
  <tr>
       <td><a href="http://www.yamaha.co.jp/product/syndtm/p/dtm/mu20mu10/index.html">MU1000</a></td>
@@ -2957,40 +2971,40 @@
 	</td>
       <td>&nbsp;</td>
     </tr>
- <tr bgcolor="#00ff00">
+ <tr>
       <td><a href="http://www.yamaha.co.jp/product/syndtm/p/dtm/mu20mu10/index.html">MU2000</a></td>
       <td>&nbsp;</td>
 	<td align="center"><a href="doc-php/template.php3?company=Yamaha&card=MU2000&chip=&module=usb-audio">Details</a>
 	</td>
-      <td>untested</td>
+      <td>&nbsp;</td>
     </tr>
- <tr bgcolor="#00ff00">
+ <tr>
       <td><a href="http://www.yamahasynth.com/pro/s08/index.html">S08</a></td>
       <td>&nbsp;</td>
 	<td align="center"><a href="doc-php/template.php3?company=Yamaha&card=S08&chip=&module=usb-audio">Details</a>
 	</td>
-      <td>untested</td>
+      <td>&nbsp;</td>
     </tr>
- <tr bgcolor="#00ff00">
+ <tr>
       <td><a href="http://www.yamahasynth.com/pro/uw500/index.html">UW500</a></td>
       <td>&nbsp;</td>
 	<td align="center"><a href="doc-php/template.php3?company=Yamaha&card=UW500&chip=&module=usb-audio">Details</a>
 	</td>
-      <td>untested</td>
+      <td>&nbsp;</td>
     </tr>
- <tr bgcolor="#00ff00">
+ <tr>
       <td><a href="http://www.yamaha.com/cgi-win/webcgi.exe/DsplyModel/?gEKS00001UX16">UX16</a></td>
       <td>&nbsp;</td>
 	<td align="center"><a href="doc-php/template.php3?company=Yamaha&card=UX16&chip=&module=usb-audio">Details</a>
 	</td>
-      <td>untested</td>
+      <td>&nbsp;</td>
     </tr>
- <tr bgcolor="#00ff00">
+ <tr>
       <td><a href="http://www.yamaha.com/cgi-win/webcgi.exe/DsplyModel/?gEKS00001UX96">UX96</a></td>
       <td>&nbsp;</td>
 	<td align="center"><a href="doc-php/template.php3?company=Yamaha&card=UX96&chip=&module=usb-audio">Details</a>
 	</td>
-      <td>untested</td>
+      <td>&nbsp;</td>
     </tr>
  <tr>
       <td><a href="http://www.yamahasynth.com/pro/ux256/index.html">UX256</a></td>



-------------------------------------------------------
This sf.net email is sponsored by: Are you worried about 
your web server security? Click here for a FREE Thawte 
Apache SSL Guide and answer your Apache SSL security 
needs: http://www.gothawte.com/rd523.html
