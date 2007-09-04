From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] sun-cs4231: memory management fix
Date: Tue, 4 Sep 2007 21:15:25 +0200
Message-ID: <20070904211525.fe39f58e.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 26765103966
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Sep 2007 21:09:19 +0200 (CEST)
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <alsa-devel@alsa-project.org>; 4 Sep 2007 21:09:04 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The chip structure is now allocated by snd_card_new()
and it must not be released by separate kfree().

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This bug was introduced by the previous patch.

--- linux-2.6.23.ref/sound/sparc/cs4231.c	2007-09-03 16:03:46.000000000 +0200
+++ linux-2.6.23/sound/sparc/cs4231.c	2007-09-04 18:02:34.000000000 +0200
@@ -1865,8 +1865,6 @@ static int snd_cs4231_sbus_free(struct s
 	if (chip->port)
 		sbus_iounmap(chip->port, chip->regs_size);
 
-	kfree(chip);
-
 	return 0;
 }
 
@@ -2037,8 +2035,6 @@ static int snd_cs4231_ebus_free(struct s
 	if (chip->port)
 		iounmap(chip->port);
 
-	kfree(chip);
-
 	return 0;
 }
