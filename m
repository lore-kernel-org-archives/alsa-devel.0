From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Custom IOCTL call
Date: Mon, 13 Dec 2010 10:00:43 +0100
Message-ID: <4D05E0BB.6040402@ladisch.de>
References: <AANLkTinRmEkLL8Lhp9uZVCWjn2Z3Qh0cgwKZGqJG8o0p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 753371037E3
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 09:57:56 +0100 (CET)
In-Reply-To: <AANLkTinRmEkLL8Lhp9uZVCWjn2Z3Qh0cgwKZGqJG8o0p@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Radivoje Jovanovic wrote:
> I am writing custom IOCTL calls for my card. I have made hwdep interface and
> set ioctl ops call for it. But, now the question is which device I need to
> open in my user space app to talk to correct ioctl?

You should use snd_hwdep_open(... "hw:0" ) and snd_hwdep_ioctl().


Regards,
Clemens
