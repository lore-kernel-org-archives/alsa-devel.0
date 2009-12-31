From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: How to compile 1.0.22 drivers with 2.6.33-rc?
Date: Thu, 31 Dec 2009 15:41:55 +0100
Message-ID: <20091231144155.GA3318@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout0.hostsharing.net (smtpout0.hostsharing.net
	[83.223.95.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 0747410380C
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 15:42:05 +0100 (CET)
Received: from h01.hostsharing.net (h01.hostsharing.net [83.223.95.29])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtpout0.hostsharing.net (Postfix) with ESMTPS id 5C04533323
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 15:42:04 +0100 (CET)
Received: from mail.home.lxtec.de (p5B145BF3.dip.t-dialin.net [91.20.91.243])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h01.hostsharing.net (Postfix) with ESMTP id 2F38511711590
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 15:42:04 +0100 (CET)
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.71 1 (LXTEC))
	id 1NQMDy-0003y5-S9
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 15:42:02 +0100
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (baumbart.home.lxtec.de [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id I+wQr1o5Jk8N for <alsa-devel@alsa-project.org>;
	Thu, 31 Dec 2009 15:41:56 +0100 (CET)
Received: from aragorn.home.lxtec.de ([192.168.200.203] ident=Debian-exim)
	by mail.home.lxtec.de with esmtps (Exim 4.71 1 (LXTEC))
	id 1NQMDs-0003xt-7Y
	for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2009 15:41:56 +0100
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

to built alsa-driver 1.0.22.1 against 2.6.33-rc2 I had to copy files
of kernels's include/generated to include/linux. Is there a more
elegant way to improve that? I want to prepare a Debian upload. So
users which are running 2.6.33 can't compile the 1.0.22 drivers
without manipulating the kernel built dir.

Any hints?

Thanks
Elimar

-- 
  On the keyboard of life you have always
  to keep a finger at the escape key;-)
