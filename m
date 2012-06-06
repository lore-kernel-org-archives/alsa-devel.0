From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Q] Writing an alsa module for usb audio & video
 capture device
Date: Wed, 06 Jun 2012 19:26:36 +0200
Message-ID: <4FCF92CC.2050600@ladisch.de>
References: <CALF0-+X3CT=XU1idrTrz-ZY+zMS907JAoXEvKsr6PT73yK01kA@mail.gmail.com>
	<CALF0-+W=PVa6f4oYVutCs20d8K4Ya5Mb9USe7+zhp2H6MXSwrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 8ABF524484
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2012 19:27:07 +0200 (CEST)
In-Reply-To: <CALF0-+W=PVa6f4oYVutCs20d8K4Ya5Mb9USe7+zhp2H6MXSwrA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ezequiel Garcia <elezegarcia@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ezequiel Garcia wrote:
> 1. Why do I need to write another module for my device? Is it not
> possible to make it work
> with snd-usb-audio?

Of course it is possible; just make it USB Audio class compliant.

> 2. The device uses ac97 chip, could I use some ac97 common code
> instead of rewriting it myself?

The AC'97 code is for managing codecs on an AC'97 bus, but the bus
inside a USB device is not directly accessible to code on the host.


Regards,
Clemens
