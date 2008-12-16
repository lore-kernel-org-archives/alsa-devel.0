From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: [PATCH] ALSA: ca0106 MSI K8N Diamond MB spi_dac 2->1
Date: Wed, 17 Dec 2008 01:26:27 +1100
Message-ID: <1229437587.13074.108.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pecan2.exetel.com.au (pecan2.exetel.com.au [220.233.0.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 930A72438A
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2008 15:26:28 +0100 (CET)
Received: from 168.78.233.220.exetel.com.au ([220.233.78.168]
	helo=[192.168.1.2]) by pecan2.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <Ben.Stanley@exemail.com.au>) id 1LCasU-0008JP-Rb
	for alsa-devel@alsa-project.org; Wed, 17 Dec 2008 01:26:27 +1100
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

>From fe2e6692ea6fcdf93d724b8aa48e7433994e011c Mon Sep 17 00:00:00 2001
From: Ben Stanley <Ben.Stanley@exemail.com.au>
Date: Mon, 15 Dec 2008 23:38:12 +1100
Subject: [PATCH] ALSA: ca0106 MSI K8N Diamond MB spi_dac 2->1

This patch removes an inconsistency that became apparent when I 
documented the fields of snd_ca0106_details. spi_dac is always 
used in a 'boolean' sense, so this cleanup should make no difference.

Signed-off-by: Ben Stanley <Ben.Stanley@exemail.com.au>
---
 pci/ca0106/ca0106_main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/pci/ca0106/ca0106_main.c b/pci/ca0106/ca0106_main.c
index 88fbf28..6ac1936 100644
--- a/pci/ca0106/ca0106_main.c
+++ b/pci/ca0106/ca0106_main.c
@@ -254,7 +254,7 @@ static struct snd_ca0106_details ca0106_chip_details[] = {
 	   .name   = "MSI K8N Diamond MB",
 	   .gpio_type = 2,
 	   .i2c_adc = 1,
-	   .spi_dac = 2 } ,
+	   .spi_dac = 1 } ,
 	 /* Shuttle XPC SD31P which has an onboard Creative Labs
 	  * Sound Blaster Live! 24-bit EAX
 	  * high-definition 7.1 audio processor".
-- 
1.5.4.3
