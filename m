From: Eric Sesterhenn <snakebyte@gmx.de>
Subject: [Patch] Memory leak in sound/pcmcia/pdaudiocf/pdaudiocf.c
Date: Wed, 12 Apr 2006 11:58:05 +0200
Message-ID: <1144835885.9011.4.camel@alice>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 5CBE715E
	for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2006 11:58:08 +0200 (MEST)
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
Cc: perex@suse.cz
List-Id: alsa-devel@alsa-project.org

hi,

if one of the first three CS_CHECKS fails, we goto cs_failed:
In this case parse we donr kfree() parse. Since the the last three
CS_CHECKS might also fail, i moved the kfree() below all the CS_CHECKs
and added one in the error path. This fixes coverity bug id #1099

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc1-git5/sound/pcmcia/pdaudiocf/pdaudiocf.c.orig	2006-04-12 11:55:39.000000000 +0200
+++ linux-2.6.17-rc1-git5/sound/pcmcia/pdaudiocf/pdaudiocf.c	2006-04-12 11:56:10.000000000 +0200
@@ -241,12 +241,13 @@ static int pdacf_config(struct pcmcia_de
 	CS_CHECK(ParseTuple, pcmcia_parse_tuple(link, &tuple, parse));
 	link->conf.ConfigBase = parse->config.base;
 	link->conf.ConfigIndex = 0x5;
-	kfree(parse);
 
 	CS_CHECK(RequestIO, pcmcia_request_io(link, &link->io));
 	CS_CHECK(RequestIRQ, pcmcia_request_irq(link, &link->irq));
 	CS_CHECK(RequestConfiguration, pcmcia_request_configuration(link, &link->conf));
 
+	kfree(parse);
+
 	if (snd_pdacf_assign_resources(pdacf, link->io.BasePort1, link->irq.AssignedIRQ) < 0)
 		goto failed;
 
@@ -254,6 +255,7 @@ static int pdacf_config(struct pcmcia_de
 	return 0;
 
 cs_failed:
+	kfree(parse);
 	cs_error(link, last_fn, last_ret);
 failed:
 	pcmcia_disable_device(link);




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
