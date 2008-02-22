From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-audio syncronisation problem
Date: Fri, 22 Feb 2008 17:31:58 +0100
Message-ID: <47BEF8FE.4030408@ladisch.de>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>	<47BEC97A.3030507@ladisch.de>	<43e8c7320802220545m6ccf8c7fr13a9390563d7df7@mail.gmail.com>	<47BED4C2.4020501@ladisch.de>	<43e8c7320802220619x4dfc049cv1f38a6fb8b1cb7a8@mail.gmail.com>	<47BEDF9E.3000907@ladisch.de>	<43e8c7320802220651r25ac78d7pecca63f3e1d48249@mail.gmail.com>	<47BEEF4D.4050507@ladisch.de>
	<43e8c7320802220815y332a82f4kac19999cc15fd276@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id B85E0243DB
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 17:30:17 +0100 (CET)
In-Reply-To: <43e8c7320802220815y332a82f4kac19999cc15fd276@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Stancu <adrian.stancu.82@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian Stancu wrote:
> According to dmesg, the device is running at high speed:
> usb 1-6: new high speed USB device using ehci_hcd and address 20
>
> So, if I convert the freq using the high speed formula, I get a value
> within the acceptable range,

No; the device is high speed, but it sends a full speed feedback value.

Please try "subs->freqm = f / 8;"


The value quoted in your previous message was exactly 48000 Hz; please
check if it ever changes.


Regards,
Clemens
