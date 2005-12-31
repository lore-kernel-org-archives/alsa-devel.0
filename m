From: =?ISO-8859-2?Q?Piotr_Tajdu=B6?= <aegis@op.pl>
Subject: ld10k1 equalizer patch
Date: Sat, 31 Dec 2005 18:23:29 +0100
Message-ID: <43B6BE91.80705@op.pl>
References: <43909E54.20503@op.pl>	<s5h3bl7mkj3.wl%tiwai@suse.de>	<43974589.1070502@op.pl> <s5hirtzft0h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080807020504000508040001"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp8.poczta.onet.pl (smtp8.poczta.onet.pl [213.180.130.48])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 457C212C
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 18:22:31 +0100 (MET)
In-Reply-To: <s5hirtzft0h.wl%tiwai@suse.de>
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
--------------080807020504000508040001
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable

There were problems with EQ10 on Sound Blaster (caused by ACCUM or macmv=20
instruction, i am not sure), so i made some changes. Now equalizer=20
should work also with SB Live.

Piotr Tajdu=B6



--------------080807020504000508040001
Content-Type: text/x-patch;
 name="eq10.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="eq10.patch"

diff -N -u -r ld10k1.orig/setup/effects/eq10.asm ld10k1/setup/effects/eq10.asm
--- ld10k1.orig/setup/effects/eq10.asm	2005-12-31 18:00:13.000000000 +0100
+++ ld10k1/setup/effects/eq10.asm	2005-12-31 18:16:24.000000000 +0100
@@ -42,7 +42,7 @@
 inlfe	io
 toutlfe	equ inlfe
 
-Equalizer control 0,0,#1
+Equalizer control #0,0,#1
 F0_31Hz control #0.5,0,#1
 F1_62Hz control #0.5,0,#1	
 F2_125Hz control #0.5,0,#1	
@@ -75,12 +75,12 @@
 
 ;;; Band Pass Filter Macro:
 BPF	macro   OUT , IN , DELAY , DLXCB , COEF , GAIN
-		macs1	ACCUM,C_0,COEF+1,DLXCB+1
-    		macs	ACCUM,ACCUM,COEF+1,IN
-		macs	ACCUM,ACCUM,COEF+2,DELAY
-		macs1	ACCUM,ACCUM,COEF,DELAY+1
-		macmv	DELAY+1,DELAY,C_0,C_0
-		macints	DELAY,C_0,ACCUM,sco
+		macs1	tmp2,C_0,COEF+1,DLXCB+1
+    		macs	tmp2,tmp2,COEF+1,IN
+		macs	tmp2,tmp2,COEF+2,DELAY
+		macs1	tmp2,tmp2,COEF,DELAY+1
+		macs	DELAY+1,DELAY,C_0,C_0
+		macints	DELAY,C_0,tmp2,sco
 		macs	OUT,OUT,DELAY,GAIN
 	endm
 
@@ -109,8 +109,5 @@
 	IIR	toutrr,inrr,dlx3,dly3
 	IIR	toutc,inc,dlx4,dly4
 	IIR	toutlfe,inlfe,dlx5,dly5
-;	macmv	toutlfe,inlfe,C_0,C_0
 
 	end
-
-

--------------080807020504000508040001--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
