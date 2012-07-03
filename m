From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: A problem with USB audio devices and the UHCI
	scheduler
Date: Tue, 03 Jul 2012 19:47:04 +0200
Message-ID: <4FF33018.2050701@ladisch.de>
References: <CACrD=+8BOOb=17Qs5k_2jZeEf_+N3U1dq2sm0PtwrWxkrouRLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 7730E103F3B
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2012 19:47:45 +0200 (CEST)
In-Reply-To: <CACrD=+8BOOb=17Qs5k_2jZeEf_+N3U1dq2sm0PtwrWxkrouRLw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Monty Montgomery <xiphmont@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Monty Montgomery wrote:
> UHCI (and EHCI) use the endpoint's wMaxPacketSize for all bandwidth
> allocation.  My device supports all of its sample rates on the same
> altset, with a wMaxPacketSize matching the highest (96kHz) rate.  So,
> the HCD is reserving most of the USB bus's bandwidth regardless of the
> actual requirements.
>
> How should I approach fixing this in the driver?

You cannot fix it in the audio driver; bandwidth allocation is done in
the controller driver, and that one doesn't know that your device lies
about its bandwidth requirements.

> There's currently no means to communicate a desired bandwidth
> reservation to the HCD from USB audio, so I'd have to extend even the
> quirks.

The device is supposed to use alternate settings for this.

Can't you change its firmware?


Regards,
Clemens
