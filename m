From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: conversion of opti93x driver to use cs4231-lib
Date: Mon, 7 Jan 2008 20:08:01 +0100
Message-ID: <20080107200801.008a3cc1.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.poczta.interia.pl (smtp35.poczta.interia.pl [80.48.65.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 07F31249A6
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 20:04:52 +0100 (CET)
Received: from poczta.interia.pl (mi01.poczta.interia.pl [10.217.12.1])
	by smtp4.poczta.interia.pl (INTERIA.PL) with ESMTP id 668D8298124
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 20:04:47 +0100 (CET)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id E059F769D8E
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 20:04:42 +0100 (CET)
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

Hi,

I posted some time ago two patches which converts opti93x driver to use cs4231-lib library. 

The opti93x chips are almost compatible with the cs4231 differing mostly by mixer.

This change greatly reduces the source of the opti drivers.

Here are patches:
[addition of opti93x details to the cs4231-lib]
http://mailman.alsa-project.org/pipermail/alsa-devel/2007-September/003395.html

and 
[conversion of opti93x driver to use cs4231-lib]
http://mailman.alsa-project.org/pipermail/alsa-devel/2007-September/003396.html

I will rediff the second patch as there were some changes to opti93x driver after sending the patch.

If it is not a good idea to do such conversion, please reply and drop patches.

Regards,
Krzysztof


------------------------------------------------------------
Walcz w kosmicznej wojnie w nowej grze!
Kliknij >>> http://link.interia.pl/f1cc1
