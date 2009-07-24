From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Help with multichannel High Speed USB audio device
Date: Fri, 24 Jul 2009 11:12:48 +0200
Message-ID: <4A697B10.1020601@ladisch.de>
References: <SNT121-W363BA2CA76A9BB36ABA8A6B2190@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 28758103A7B
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 11:12:34 +0200 (CEST)
In-Reply-To: <SNT121-W363BA2CA76A9BB36ABA8A6B2190@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Laurent ." <sid6582@msn.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Laurent . wrote:
> I made an embedded device that has a CODEC with 6 inputs connected to an ARM9
> micro-controller that has an integrated high-speed USB controller.
> Now, I need to write the USB code on that micro-controller so that i can capture those
> channels in real-time at 24bits / 48 KHz with low latency (ie. sub 10ms), on a computer.
> 
> I only need my device to work with Linux, and if possible, I would like to avoid writing a device
> driver on the Linux-side.
> 
> Is there already such a USB audio driver available that I could nearly use "as is" and to which
> i would conform ?

Yes, snd-usb-audio.

> Would you have some general guideline on how to write the high-speed USB device code ?

Just conform to the USB (2.0) and USB Audio (1.0) specifications.

> For simplicity, my device is going to be the "clock master" of the system since it is already has
> the exact clock that drives the CODEC.

So you'd use an asynchronous endpoint.


Best regards,
Clemens
