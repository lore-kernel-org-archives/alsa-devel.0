From: Travis Place <wishie@wishie.net>
Subject: [PATCH] CA0106 on MSI K8N Diamond PLUS Motherboard
Date: Mon, 25 Aug 2008 05:35:05 +1000
Message-ID: <200808250535.05985.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pfbsIOH85CrPwma"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-224.dial.usertools.net
	[202.137.100.224])
	by alsa0.perex.cz (Postfix) with ESMTP id AB25F24133
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Aug 2008 21:35:11 +0200 (CEST)
Received: from laptop.local (unknown [192.168.0.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.wishie.net (Postfix) with ESMTP id 45FDA5080
	for <alsa-devel@alsa-project.org>; Sun, 24 Aug 2008 19:59:35 +1000 (EST)
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

--Boundary-00=_pfbsIOH85CrPwma
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Previously i posted a patch for a new ssid for the onboard ca0106 on the K8N 
Diamond motherboard. Now, it is apparently really called a 'K8N Diamond 
PLUS', and also requires the gpio_type to be changed too.

Attached is a patch for this.

Changelog: Correct a previous patch for the ca0106 onboard the MSI K8N Diamond 
PLUS motherboard. Confirmed to have Line/Mic/Aux working for input, and sound 
output working as expected.

Signed-off-by: Travis Place <wishie@wishie.net>


--Boundary-00=_pfbsIOH85CrPwma
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ca0106_main.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ca0106_main.c.patch"

--- ca0106_main.c	2008-08-25 05:31:47.000000000 +1000
+++ ca0106_main.c.fixed	2008-08-25 05:33:34.000000000 +1000
@@ -249,11 +249,12 @@
 	   .name   = "MSI K8N Diamond MB [SB0438]",
 	   .gpio_type = 2,
 	   .i2c_adc = 1 } ,
-	 /* Another MSI K8N Diamond MB, which has apprently a different SSID */
+	 /* MSI K8N Diamond PLUS MB */
 	 { .serial = 0x10091102,
 	   .name   = "MSI K8N Diamond MB",
 	   .gpio_type = 2,
-	   .i2c_adc = 1 } ,
+	   .i2c_adc = 1,
+	   .spi_dac = 2 }
 	 /* Shuttle XPC SD31P which has an onboard Creative Labs
 	  * Sound Blaster Live! 24-bit EAX
 	  * high-definition 7.1 audio processor".

--Boundary-00=_pfbsIOH85CrPwma
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_pfbsIOH85CrPwma--
