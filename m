From: Adish Kuvelker <adkuvi@gmail.com>
Subject: Re: Problems running "amixer"
Date: Thu, 8 Jul 2010 23:44:25 +0530
Message-ID: <AANLkTilhHbA3EExy3ubSUmvSn0n7185GQeMFwcE8okEz@mail.gmail.com>
References: <AANLkTinSa0nOGY0OQDdjRaPZFES9QM-5zr_F3ZwIxCEw@mail.gmail.com>
	<4C347742.3050404@ladisch.de>
	<AANLkTikQfdPuAGwPyq4j1Syi9iiBgj-MzLmPEiAy2lYc@mail.gmail.com>
	<AANLkTikvbxebpDbMl_3ui9TOmF4glhhJRT31-fQhXHCW@mail.gmail.com>
	<4C347F0D.1050305@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 12175103897
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jul 2010 20:14:27 +0200 (CEST)
Received: by vws9 with SMTP id 9so1367128vws.38
	for <alsa-devel@alsa-project.org>; Thu, 08 Jul 2010 11:14:26 -0700 (PDT)
In-Reply-To: <4C347F0D.1050305@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>>>>> A: Because it messes up the order in which people normally read text.
>>>>> Q: Why is top-posting such a bad thing?
>>>>> A: Top-posting.
>>>>> Q: What is the most annoying thing in e-mail?

I'm sorry for messing it up....


>>>>> I just tried without alsa.conf, and alsa-lib then outputs an additional
>>>>> error message in this case; so this is not your problem.
>
>>>>> Can you try "strace amixer"?

I tried with the strace and got the bug. Now it's working fine. Just
that alsa.cong and related files weren't at right location in ramdisk
file system.
Thanks a lot Clemens.

Regards;
Aadish
