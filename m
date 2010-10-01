From: Thor Kristoffersen <thorkr@gmail.com>
Subject: Re: Creative Sound Blaster X-Fi Titanium PCIe support
Date: Fri, 01 Oct 2010 19:30:18 +0200
Message-ID: <m2pqvtx1lh.fsf@getmail.no>
References: <AANLkTik5Xtk1SP72qOgVaAJfvytZE=Nz+ifo7VXcUcuJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.getmail.no (smtp.getmail.no [84.208.15.66])
	by alsa0.perex.cz (Postfix) with ESMTP id 8756D103A0E
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 19:30:23 +0200 (CEST)
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
	by get-mta-out02.get.basefarm.net
	(Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20
	2008))
	with ESMTP id <0L9M00ID2GMJSF80@get-mta-out02.get.basefarm.net> for
	alsa-devel@alsa-project.org; Fri, 01 Oct 2010 19:30:19 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
	(localhost.localdomain [127.0.0.1])	by localhost (Email Security
	Appliance)
	with SMTP id 380731EEFC25_CA61AABB	for <alsa-devel@alsa-project.org>;
	Fri, 01 Oct 2010 17:30:19 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
	with ESMTP id 21EDE1EEFC23_CA61AABF	for <alsa-devel@alsa-project.org>;
	Fri, 01 Oct 2010 17:30:19 +0000 (GMT)
Received: from localhost ([84.215.109.218]) by get-mta-in02.get.basefarm.net
	(Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20
	2008))
	with ESMTP id <0L9M00F0WGMJW120@get-mta-in02.get.basefarm.net> for
	alsa-devel@alsa-project.org; Fri, 01 Oct 2010 19:30:19 +0200 (MEST)
In-reply-to: <AANLkTik5Xtk1SP72qOgVaAJfvytZE=Nz+ifo7VXcUcuJ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: nidujay <nidujay@gmail.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

nidujay <nidujay@gmail.com> writes:
> I've got a Creative Sound Blaster X-Fi Titanium PCIe sound card which I
> purchased for the following 2 reasons:
>
> 1. It supports sound fonts
> 2. I require an SPDIF optical input
>
> My OS is UbuntuStudio 10.04 which I believe uses alsa version 1.0.22.
>
> Unfortunately, I haven't been able to get either of the above working (Ok I
> haven't investigated (2) very deeply yet).

The SPDIF input actually works.  The problem is that it isn't possible
to do capture with that mixer control muted, becuase muting the control
also turns off capture.  See my post about a month ago for more
information about this issue.  For some applications this bug may not
matter much, but it makes the X-Fi Titanium unusable for real-time audio
processing applications.

Thor
