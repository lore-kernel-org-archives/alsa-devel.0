From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] Soundcard matrix - echoaudio
Date: Sun, 8 Jan 2006 19:14:09 +0000
Message-ID: <20060108191409.73bda174.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- vendor-Echo_Corporation__orig	2005-10-15 16:39:37.000000000 +0000
+++ vendor-Echo_Corporation	2005-10-21 21:29:38.000000000 +0000
@@ -17,7 +17,7 @@
     <has_analog_out count="8"/>
     <has_analog_in count="2"/>
     <extrainfo>Discontinued</extrainfo>
-    <extralink>http://xoomer.virgilio.it/g_pochini/ea.html</extralink>
+    <extralink>http://www.webalice.it/g_pochini/ead</extralink>
   </device>
 
   <device>
@@ -34,7 +34,7 @@
     <has_spdif_out count="1"/>
     <has_spdif_in count="1"/>
     <extrainfo>Discontinued</extrainfo>
-    <extralink>http://xoomer.virgilio.it/g_pochini/ea.html</extralink>
+    <extralink>http://www.webalice.it/g_pochini/ead</extralink>
   </device>
 
   <device>
@@ -53,7 +53,7 @@
     <has_midi_out count="1"/>
     <has_midi_in count="1"/>
     <extrainfo>Discontinued</extrainfo>
-    <extralink>http://xoomer.virgilio.it/g_pochini/ea.html</extralink>
+    <extralink>http://www.webalice.it/g_pochini/ead</extralink>
   </device>
 
   <device category="pro">
@@ -68,7 +68,7 @@
     <has_analog_out count="8"/>
     <has_analog_in count="2"/>
     <extrainfo>Discontinued</extrainfo>
-    <extralink>http://xoomer.virgilio.it/g_pochini/ea.html</extralink>
+    <extralink>http://www.webalice.it/g_pochini/ead</extralink>
   </device>
 
   <device category="pro">
@@ -90,7 +90,7 @@
     <has_adat_out count="1"/>
     <has_adat_in count="1"/>
     <extrainfo>Discontinued</extrainfo>
-    <extralink>http://xoomer.virgilio.it/g_pochini/ea.html</extralink>
+    <extralink>http://www.webalice.it/g_pochini/ead</extralink>
   </device>
 
   <device category="pro">
@@ -119,7 +119,7 @@
     <has_midi_out count="1"/>
     <has_midi_in count="1"/>
     <extrainfo>Discontinued</extrainfo>
-    <extralink>http://xoomer.virgilio.it/g_pochini/ea.html</extralink>
+    <extralink>http://www.webalice.it/g_pochini/ead</extralink>
   </device>
 
   <device category="pro">
@@ -146,7 +146,7 @@
     <has_adat_out count="1"/>
     <has_adat_in count="1"/>
     <extrainfo>Discontinued</extrainfo>
-    <extralink>http://xoomer.virgilio.it/g_pochini/ea.html</extralink>
+    <extralink>http://www.webalice.it/g_pochini/ead</extralink>
   </device>
 
   <device category="pro">
@@ -165,7 +165,7 @@
     <has_spdif_in count="1"/>
     <has_mixing/>
     <extrainfo>Discontinued</extrainfo>
-    <extralink>http://xoomer.virgilio.it/g_pochini/ea.html</extralink>
+    <extralink>http://www.webalice.it/g_pochini/ead</extralink>
   </device>
 
   <device category="pro">
@@ -185,7 +185,7 @@
     <has_midi_out count="1"/>
     <has_midi_in count="1"/>
     <has_mixing/>
-    <extralink>http://xoomer.virgilio.it/g_pochini/ea.html</extralink>
+    <extralink>http://www.webalice.it/g_pochini/ead</extralink>
   </device>
 
   <device category="pro">
@@ -201,7 +201,7 @@
     <has_analog_out count="2"/>
     <has_mixing/>
     <extrainfo>Discontinued</extrainfo>
-    <extralink>http://xoomer.virgilio.it/g_pochini/ea.html</extralink>
+    <extralink>http://www.webalice.it/g_pochini/ead</extralink>
   </device>
 
   <device category="pro">
@@ -218,7 +218,7 @@
     <has_analog_out count="2"/>
     <has_analog_in count="2"/>
     <has_mixing/>
-    <extralink>http://xoomer.virgilio.it/g_pochini/ea.html</extralink>
+    <extralink>http://www.webalice.it/g_pochini/ead</extralink>
   </device>
 
   <device category="pro">
@@ -233,7 +233,7 @@
     <pcmcia/>
     <has_analog_out count="4"/>
     <has_mixing/>
-    <extralink>http://xoomer.virgilio.it/g_pochini/ea.html</extralink>
+    <extralink>http://www.webalice.it/g_pochini/ead</extralink>
   </device>
 
   <device category="pro">
@@ -256,7 +256,7 @@
     <has_adat_in count="1"/>
     <has_midi_out count="1"/>
     <has_midi_in count="1"/>
-    <extralink>http://xoomer.virgilio.it/g_pochini/ea.html</extralink>
+    <extralink>http://www.webalice.it/g_pochini/ead</extralink>
   </device>
 
   <device category="pro">
@@ -279,7 +279,19 @@
     <has_adat_in count="1"/>
     <has_midi_out count="1"/>
     <has_midi_in count="1"/>
-    <extralink>http://xoomer.virgilio.it/g_pochini/ea.html</extralink>
+    <extralink>http://www.webalice.it/g_pochini/ead</extralink>
+  </device>
+
+  <device category="pro">
+    <product>
+      <name>Audiofire 8</name>
+      <link>http://www.echoaudio.com/Products/FireWire/AudioFire8/index.php</link>
+    </product>
+    <product>
+      <name>Audiofire 12</name>
+      <link>http://www.echoaudio.com/Products/FireWire/AudioFire12/index.php</link>
+    </product>
+    <possible/>
   </device>
 
 </alsacards>


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
