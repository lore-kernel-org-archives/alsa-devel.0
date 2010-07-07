From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problems running "amixer"
Date: Wed, 07 Jul 2010 15:20:13 +0200
Message-ID: <4C347F0D.1050305@ladisch.de>
References: <AANLkTinSa0nOGY0OQDdjRaPZFES9QM-5zr_F3ZwIxCEw@mail.gmail.com>	<4C347742.3050404@ladisch.de>	<AANLkTikQfdPuAGwPyq4j1Syi9iiBgj-MzLmPEiAy2lYc@mail.gmail.com>
	<AANLkTikvbxebpDbMl_3ui9TOmF4glhhJRT31-fQhXHCW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C2D50244D1
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 15:20:13 +0200 (CEST)
In-Reply-To: <AANLkTikvbxebpDbMl_3ui9TOmF4glhhJRT31-fQhXHCW@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adish Kuvelker <adkuvi@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

Adish Kuvelker wrote:
> I don't have this file ".asoundrc" in my ramdisk. Do I need this?

No.

>>>> ALSA lib control.c:910:(snd_ctl_open_noupdate) Invalid CTL default

I just tried without alsa.conf, and alsa-lib then outputs an additional
error message in this case; so this is not your problem.

Can you try "strace amixer"?


Regards,
Clemens
