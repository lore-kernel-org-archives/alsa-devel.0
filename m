From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [PATCH] ALSA: ens1370: SRC stands for Sample Rate
	Converter
Date: Thu, 17 Jul 2008 09:35:16 +0200
Message-ID: <487EF634.9060205@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080607050808050505040903"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id CA40F243D5
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 09:33:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080607050808050505040903
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Trivial...

--------------080607050808050505040903
Content-Type: text/plain;
 name="0001-ALSA-ens1370-SRC-stands-for-Sample-Rate-Converter.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-ALSA-ens1370-SRC-stands-for-Sample-Rate-Converter.patch"

>From 7f839eda81a36fb4291941423ac7f9b61e72fee1 Mon Sep 17 00:00:00 2001
From: Rene Herman <rene.herman@gmail.com>
Date: Thu, 17 Jul 2008 09:22:29 +0200
Subject: [PATCH] ALSA: ens1370: SRC stands for Sample Rate Converter

Signed-off-by: Rene Herman <rene.herman@gmail.com>
---
 sound/pci/ens1370.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 72d85a5..38808fb 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -522,7 +522,7 @@ static unsigned int snd_es1371_wait_src_ready(struct ensoniq * ensoniq)
 			return r;
 		cond_resched();
 	}
-	snd_printk(KERN_ERR "wait source ready timeout 0x%lx [0x%x]\n",
+	snd_printk(KERN_ERR "wait src ready timeout 0x%lx [0x%x]\n",
 		   ES_REG(ensoniq, 1371_SMPRATE), r);
 	return 0;
 }
-- 
1.5.5


--------------080607050808050505040903
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080607050808050505040903--
