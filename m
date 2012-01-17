From: Dave Lentz <dtl131@gmail.com>
Subject: Suggestion for change in HD-Audio-Models.txt
	documentation
Date: Mon, 16 Jan 2012 19:53:59 -0500
Message-ID: <4F14C6A7.50209@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040201010606040407080508"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9631D24399
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 01:54:02 +0100 (CET)
Received: by qcsd16 with SMTP id d16so835554qcs.38
	for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2012 16:54:01 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040201010606040407080508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

See attachment. Conexant model names have been updated.

--------------040201010606040407080508
Content-Type: text/plain;
 name="patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch.txt"

--- HD-Audio-Models.txt.orig	2012-01-16 19:45:01.149076888 -0500
+++ HD-Audio-Models.txt	2012-01-16 19:46:57.887075223 -0500
@@ -53,7 +53,7 @@
   laptop-amic	Laptops with analog-mic input
   laptop-dmic	Laptops with digital-mic input
 
-ALC662/663/272
+ALC662/663/665/272
 ==============
   asus-mode1	ASUS
   asus-mode2	ASUS
@@ -192,8 +192,8 @@
   laptop-dig	ditto with SPDIF
   auto		auto-config reading BIOS (default)
 
-Conexant 5045
-=============
+Conexant 5045/Venice/CX20549
+============================
   laptop-hpsense    Laptop with HP sense (old model laptop)
   laptop-micsense   Laptop with Mic sense (old model fujitsu)
   laptop-hpmicsense Laptop with HP and Mic senses
@@ -203,8 +203,8 @@
 		can be adjusted.  Appearing only when compiled with
 		$CONFIG_SND_DEBUG=y
 
-Conexant 5047
-=============
+Conexant 5047/Waikiki/CX20551
+=============================
   laptop	Basic Laptop config 
   laptop-hp	Laptop config for some HP models (subdevice 30A5)
   laptop-eapd	Laptop config with EAPD support
@@ -212,17 +212,18 @@
 		can be adjusted.  Appearing only when compiled with
 		$CONFIG_SND_DEBUG=y
 
-Conexant 5051
-=============
+Conexant 5051/Hermosa/CX20561
+==============================
   laptop	Basic Laptop config (default)
   hp		HP Spartan laptop
   hp-dv6736	HP dv6736
   hp-f700	HP Compaq Presario F700
   ideapad	Lenovo IdeaPad laptop
+  lenovo-x200	Lenovo X200 laptop
   toshiba	Toshiba Satellite M300
 
-Conexant 5066
-=============
+Conexant 5066/Pebble/CX20582 
+=============================
   laptop	Basic Laptop config (default)
   hp-laptop	HP laptops, e g G60
   asus		Asus K52JU, Lenovo G560
@@ -355,3 +356,4 @@
 VIA VT17xx/VT18xx/VT20xx
 ========================
   auto		BIOS setup (default)
+

--------------040201010606040407080508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040201010606040407080508--
