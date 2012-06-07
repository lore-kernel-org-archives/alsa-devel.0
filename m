From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Q] Writing an alsa module for usb audio & video
 capture device
Date: Thu, 07 Jun 2012 21:21:34 +0200
Message-ID: <4FD0FF3E.5010607@ladisch.de>
References: <CALF0-+X3CT=XU1idrTrz-ZY+zMS907JAoXEvKsr6PT73yK01kA@mail.gmail.com>	<CALF0-+W=PVa6f4oYVutCs20d8K4Ya5Mb9USe7+zhp2H6MXSwrA@mail.gmail.com>	<4FCF92CC.2050600@ladisch.de>
	<CALF0-+Uj8Q-uqEL0ZWhXyOiWmgpdOFKKqW_O4=nFcXpMNXOdBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C57DC2436F
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 21:22:11 +0200 (CEST)
In-Reply-To: <CALF0-+Uj8Q-uqEL0ZWhXyOiWmgpdOFKKqW_O4=nFcXpMNXOdBw@mail.gmail.com>
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
> On Wed, Jun 6, 2012 at 2:26 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
>> make it USB Audio class compliant.
>
> What do you mean by that?

Implement the descriptors and class-specific requests required by one of
the Audio Class specifications:
http://www.usb.org/developers/devclass_docs#approved

> What's exactly the scope of supported devices by snd-usb-audio?

Pretty much everything in Audio Class 1.0 and 2.0 (some clock-related
parts of v2 are yet missing).


Regards,
Clemens
