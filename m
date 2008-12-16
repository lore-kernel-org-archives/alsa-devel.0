From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: [PATCH] ALSA: ca0106 Add comments to
	snd_ca0106_details struct
Date: Wed, 17 Dec 2008 01:22:32 +1100
Message-ID: <1229437353.13074.106.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pecan2.exetel.com.au (pecan2.exetel.com.au [220.233.0.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 201F72438A
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2008 15:22:36 +0100 (CET)
Received: from 168.78.233.220.exetel.com.au ([220.233.78.168]
	helo=[192.168.1.2]) by pecan2.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <Ben.Stanley@exemail.com.au>) id 1LCaoi-0008G4-6E
	for alsa-devel@alsa-project.org; Wed, 17 Dec 2008 01:22:32 +1100
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

>From dada1c7fe866b860f96d56315648cd5704675aa1 Mon Sep 17 00:00:00 2001
From: Ben Stanley <Ben.Stanley@exemail.com.au>
Date: Fri, 12 Dec 2008 09:47:13 +1100
Subject: [PATCH] ALSA: ca0106 Add comments to snd_ca0106_details struct

Takashi wrote an email [1] explaining the fields of snd_ca0106_details,
so I captured the information into the ca0106.h header file.

[1] http://article.gmane.org/gmane.linux.alsa.devel/56783/match=takashi+gpio_type

Signed-off-by: Ben Stanley <Ben.Stanley@exemail.com.au>
---
 pci/ca0106/ca0106.h |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/pci/ca0106/ca0106.h b/pci/ca0106/ca0106.h
index 74175fc..3faccb6 100644
--- a/pci/ca0106/ca0106.h
+++ b/pci/ca0106/ca0106.h
@@ -664,10 +664,14 @@ struct snd_ca0106_pcm {
 struct snd_ca0106_details {
         u32 serial;
         char * name;
-        int ac97;
-	int gpio_type;
-	int i2c_adc;
-	int spi_dac;
+	int ac97;	/* ac97 = 0 -> Select MIC, Line in, TAD in, AUX in.
+			   ac97 = 1 -> Default to AC97 in. */
+	int gpio_type;	/* gpio_type = 1 -> shared mic-in/line-in
+			   gpio_type = 2 -> shared side-out/line-in. */
+	int i2c_adc;	/* with i2c_adc=1, the driver adds some capture volume
+			   controls, phone, mic, line-in and aux. */
+	int spi_dac;	/* spi_dac=1 adds the mute switch for each analog
+			   output, front, rear, etc. */
 };
 
 // definition of the chip-specific record
-- 
1.5.4.3
