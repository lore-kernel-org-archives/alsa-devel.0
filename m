From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Using the timer
Date: Thu, 22 Sep 2011 16:45:49 +0200
Message-ID: <4E7B4A1D.7010209@ladisch.de>
References: <CAPhDKbFdHV_7QXw=jZtmD3nmV8O0KoiREzDQ3gH=wtvf=C_L+A@mail.gmail.com>	<4E79ECAB.5030904@ladisch.de>	<CAPhDKbFwuX_HRYYxbUiwDi=G5BU8P9j_8YVytH1bY+x03_cBuA@mail.gmail.com>	<4E7B22C6.5030600@ladisch.de>
	<CAPhDKbHXBidShZ4WhLaQPtHwUT9Kw2cRX=JSfdYMB7MmK1a9Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id E3465244AB
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 16:45:21 +0200 (CEST)
In-Reply-To: <CAPhDKbHXBidShZ4WhLaQPtHwUT9Kw2cRX=JSfdYMB7MmK1a9Vg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ilya Dmitrichenko <errordeveloper@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ilya Dmitrichenko wrote:
> So you are saying that PCM slave timer can be used in some
> way, but it would be clocked at the sampling rate, right?

We get an interrupt at every period boundary, so the timer would
run at, e.g., one 128th of the sampling rate.

> Hm, so 'snd-seq-timer' is essentially hooked to the host cpu
> clock (be that TSC/RTC/HPET) ?

In the default setting, yes.


Regards,
Clemens
