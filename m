From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [Q] Writing an alsa module for usb audio & video
 capture device
Date: Thu, 7 Jun 2012 15:29:38 -0300
Message-ID: <CALF0-+Uj8Q-uqEL0ZWhXyOiWmgpdOFKKqW_O4=nFcXpMNXOdBw@mail.gmail.com>
References: <CALF0-+X3CT=XU1idrTrz-ZY+zMS907JAoXEvKsr6PT73yK01kA@mail.gmail.com>
	<CALF0-+W=PVa6f4oYVutCs20d8K4Ya5Mb9USe7+zhp2H6MXSwrA@mail.gmail.com>
	<4FCF92CC.2050600@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 43D0B24497
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 20:29:39 +0200 (CEST)
Received: by lagw12 with SMTP id w12so624272lag.38
	for <alsa-devel@alsa-project.org>; Thu, 07 Jun 2012 11:29:38 -0700 (PDT)
In-Reply-To: <4FCF92CC.2050600@ladisch.de>
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

Hi Clemens,

On Wed, Jun 6, 2012 at 2:26 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Ezequiel Garcia wrote:
>> 1. Why do I need to write another module for my device? Is it not
>> possible to make it work
>> with snd-usb-audio?
>
> Of course it is possible; just make it USB Audio class compliant.

What do you mean by that? What's exactly the scope of supported
devices by snd-usb-audio?

>
>> 2. The device uses ac97 chip, could I use some ac97 common code
>> instead of rewriting it myself?
>
> The AC'97 code is for managing codecs on an AC'97 bus, but the bus
> inside a USB device is not directly accessible to code on the host.
>
Understood.

Thank you very much!
Ezequiel.
