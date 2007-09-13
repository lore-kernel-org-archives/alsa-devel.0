From: "Krzysztof Helt" <krzysztof.h1@gmail.com>
Subject: [PATCH] sc6000: 2 minor fixes
Date: Thu, 13 Sep 2007 23:15:07 +0200
Message-ID: <8c74410a0709131415q130603eao784247da2329b474@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189])
	by alsa0.perex.cz (Postfix) with ESMTP id E62B4243BB
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Sep 2007 23:15:11 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so438722rvb
	for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2007 14:15:09 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch zeroes buffer for the card name and
fixes incorrect jump in the probe function.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff -urp alsa-driver-1.0.15rc2/sound/isa/sc6000.c
alsa-driver-new/sound/isa/sc6000.c
--- alsa-driver-1.0.15rc2/sound/isa/sc6000.c	2007-09-12 13:33:51.000000000 +0200
+++ alsa-driver-new/sound/isa/sc6000.c	2007-09-13 23:14:43.288766750 +0200
@@ -351,6 +351,7 @@ static int __devinit sc6000_init_board(c
 		return err;
 	}

+	memset(answer, 0, sizeof(answer));
 	err = sc6000_dsp_get_answer(vport, GET_DSP_COPYRIGHT, answer, 15);
 	if (err <= 0) {
 		snd_printk(KERN_ERR "sc6000_dsp_copyright: failed!\n");
@@ -529,7 +530,7 @@ static int __devinit snd_sc6000_probe(st
 		snd_printk(KERN_ERR PFX
 			   "SC-6000 port I/O port region is already in use.\n");
 		err = -EBUSY;
-		goto err_unmap2;
+		goto err_unmap1;
 	}
 	vmss_port = devm_ioport_map(devptr, mss_port[dev], 4);
 	if (!vport) {
