From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: [PATCH 4/5] emu10k1 SB Live: Master volume and front channels via
 fxbus 8,9
Date: Mon, 21 Feb 2005 20:45:11 +0100
Message-ID: <421A3A47.2050102@glocalnet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060901030409000001060803"
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CF1D815A
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2005 20:45:12 +0100 (MET)
Received: from mulder.hem.za.org (unknown [84.217.26.207])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 7C4BF57F54
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2005 20:45:12 +0100 (MET)
Received: from skinner.hem.za.org ([192.168.0.2])
	by mulder.hem.za.org with esmtp (Exim 4.34)
	id 1D3JUV-0000a9-Sr
	for alsa-devel@alsa-project.org; Mon, 21 Feb 2005 20:45:11 +0100
Received: from localhost ([127.0.0.1])
	by skinner.hem.za.org with esmtp (Exim 4.34)
	id 1D3JUV-0001aW-JC
	for alsa-devel@alsa-project.org; Mon, 21 Feb 2005 20:45:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060901030409000001060803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

front_config.patch:

Routes front channels via fxbus 8 and 9 instead of fxbus 0 and 1. This 
makes the front and default outputs independent of each other.

Signed-Off-By: Mikael Magnusson <mikma@users.sourceforge.net>

--------------060901030409000001060803
Content-Type: text/x-patch;
 name="front_config.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="front_config.patch"

--- alsa-lib/src/conf/cards/EMU10K1.conf	16 Feb 2005 11:47:05 -0000	1.14
+++ alsa-lib/src/conf/cards/EMU10K1.conf	21 Feb 2005 13:34:35 -0000
@@ -9,9 +9,29 @@
 	@args.CARD {
 		type string
 	}
-	type hw
-	card $CARD
-	device 0
+	type hooks
+	slave.pcm {
+		type hw
+		card $CARD
+		device 0
+	}
+	hooks.0 {
+		type ctl_elems
+		hook_args [
+			{
+				name "EMU10K1 PCM Send Volume"
+				index { @func private_pcm_subdevice }
+				lock true
+				value [ 255 255 0 0 255 0 0 0 0 255 0 0 ]
+			}
+			{
+				name "EMU10K1 PCM Send Routing"
+				index { @func private_pcm_subdevice }
+				lock true
+				value [ 8 9 0 0 8 9 0 0 8 9 0 0 ]
+			}
+		]
+	}
 }	
 
 <confdir:pcm/rear.conf>
@@ -31,13 +51,6 @@
 		type ctl_elems
 		hook_args [
 			{
-				name "Wave Surround Playback Volume"
-				preserve true
-				# don't lock a global control
-				# lock true
-				value [ 0 0 ]
-			}
-			{
 				name "EMU10K1 PCM Send Volume"
 				index { @func private_pcm_subdevice }
 				lock true
@@ -64,18 +77,6 @@
 		type ctl_elems
 		hook_args [
 			{
-				name "Wave Center Playback Volume"
-				preserve true
- 				# lock true
-				value 0
-			}
-			{
-				name "Wave LFE Playback Volume"
-				preserve true
-				# lock true
-				value 0
-			}
-			{
 				name "Headphone Center Playback Switch"
 				index 1
 				preserve true

--------------060901030409000001060803--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
