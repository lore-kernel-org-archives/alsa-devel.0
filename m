From: Travis Place <wishie@wishie.net>
Subject: [PATCH] Support for MSI K8N v1.0 onboard CA0106 based
	soundcard
Date: Wed, 18 Jun 2008 04:44:35 +1000
Message-ID: <1213728275.13759.3.camel@temp-fallen>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-089.dial.usertools.net
	[202.137.100.89])
	by alsa0.perex.cz (Postfix) with ESMTP id A87D224663
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jun 2008 20:43:07 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

NOTE: The Exact model number of the card onboard is unknown to me
(SB0438). Not sure how I am to find this information either. For the
time being, i have just used the same model as seems to be on the other
(updated?) version of the motherboard.


Changelog: Add support for the MSI K8N Diamond Motherboard (version 1.0)
onboard CA0106 soundcard.


--- ca0106_main.c       2008-06-18 04:24:05.000000000 +1000
+++ ca0106_main.c.wishie        2008-06-18 04:39:26.000000000 +1000
@@ -249,6 +249,10 @@
           .name   = "MSI K8N Diamond MB [SB0438]",
           .gpio_type = 2,
           .i2c_adc = 1 } ,
+         { .serial = 0x10091102,
+           .name   = "MSI K8N Diamond MB version 1.0 [SB0438]",
+           .gpio_type = 2,
+           .i2c_adc = 1 } ,
         /* Shuttle XPC SD31P which has an onboard Creative Labs
          * Sound Blaster Live! 24-bit EAX
          * high-definition 7.1 audio processor".

Signed-off-by: Travis Place <wishie@wishie.net>
