From: Timur Tabi <timur@freescale.com>
Subject: pcm_lib.c: XRUN alsa-back-porting
Date: Thu, 31 Jul 2008 13:24:13 -0500
Message-ID: <4892034D.1060606@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 78FC52440C
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 20:24:25 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m6VIOEWD022740
	for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2008 11:24:19 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m6VIODcY012171
	for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2008 13:24:13 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

A customer is reporting that he's seeing this message every now and then, but
when I try to examine the kernel source code, I don't see the source of it.  In
fact, when I do a google search of "alsa-back-porting", I get zero hits.  So
maybe the customer is using some older kernel, but when I scan the git change
history for sound/core/pcm_lib.c, I still don't see it.

So can someone tell me what "alsa-back-porting" means, and where it comes from?

-- 
Timur Tabi
Linux kernel developer at Freescale
