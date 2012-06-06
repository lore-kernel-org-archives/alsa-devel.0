From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [Q] Writing an alsa module for usb audio & video
	capture device
Date: Wed, 6 Jun 2012 13:40:48 -0300
Message-ID: <CALF0-+W=PVa6f4oYVutCs20d8K4Ya5Mb9USe7+zhp2H6MXSwrA@mail.gmail.com>
References: <CALF0-+X3CT=XU1idrTrz-ZY+zMS907JAoXEvKsr6PT73yK01kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9637B2445B
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2012 18:40:49 +0200 (CEST)
Received: by obbup19 with SMTP id up19so10704595obb.38
	for <alsa-devel@alsa-project.org>; Wed, 06 Jun 2012 09:40:48 -0700 (PDT)
In-Reply-To: <CALF0-+X3CT=XU1idrTrz-ZY+zMS907JAoXEvKsr6PT73yK01kA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi again,

On Mon, Jun 4, 2012 at 6:50 PM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
> Hi everyone,
>
> I'm writing a driver for stk1160 usb bridge (audio & video capture device).
> The video part is almost done [1] and now I've started the alsa part.
>
> As the driver replaces an in-tree staging driver I could just grab the alsa part
> from the original driver (called easycap), or look into em28xx sources.
>
[snipped myself]

I also would like to know (if anyone is reading this):

1. Why do I need to write another module for my device? Is it not
possible to make it work
with snd-usb-audio?
2. The device uses ac97 chip, could I use some ac97 common code
instead of rewriting it myself?

Currently, v4l drivers that must support alsa rewrites a lot of stuff.
I'm not sure this is the *right thing*.

Thanks,
Ezequiel.
