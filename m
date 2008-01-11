From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cs4231: remove one busy wait
Date: Fri, 11 Jan 2008 22:53:03 +0100
Message-ID: <20080111225303.636da61f.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.poczta.interia.pl (smtp35.poczta.interia.pl [80.48.65.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DCF024648
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 22:49:28 +0100 (CET)
Received: from poczta.interia.pl (mi01.poczta.interia.pl [10.217.12.1])
	by smtp4.poczta.interia.pl (INTERIA.PL) with ESMTP id 86449299583
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 22:49:25 +0100 (CET)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 58127769DC7
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 22:49:25 +0100 (CET)
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

This busy_wait is not needed after latest changes
to the cs4231-lib

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
Just after this busy wait is 1ms sleep then waiting loop.

--- linux-2.6.22/sound/isa/cs423x/cs4231_lib.c	2007-09-11 00:02:15.000000000 +0200
+++ linux-2.6.23/sound/isa/cs423x/cs4231_lib.c	2007-09-11 00:03:36.619095346 +0200
@@ -332,7 +332,6 @@ void snd_cs4231_mce_down(struct snd_cs42
 	    !(chip->hardware & (CS4231_HW_CS4231_MASK | CS4231_HW_CS4232_MASK))) {
 		return;
 	}
-	snd_cs4231_busy_wait(chip);
 
 	/*
 	 * Wait for (possible -- during init auto-calibration may not be set)


----------------------------------------------------------------------
Chcesz kupic aparat? Sprawdz, ktory jest najlepszy!
Kliknij >>> http://link.interia.pl/f1cd3
