From: Alexander <subaparts@yandex.ru>
Subject: Re: Does anyone really have success experience with
 SPI codecs with new name-based SOC API?
Date: Thu, 02 Dec 2010 23:35:59 +0300
Message-ID: <1291322159.1469.38.camel@r60e>
References: <1290079866.1496.55.camel@r60e>
	<AANLkTimPf9MUOtcVs7Yuf6MAftj6LErGXiLCCs6Q5DAp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward9.mail.yandex.net (forward9.mail.yandex.net
	[77.88.61.48]) by alsa0.perex.cz (Postfix) with ESMTP id 4C0C8244E7
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 21:36:01 +0100 (CET)
In-Reply-To: <AANLkTimPf9MUOtcVs7Yuf6MAftj6LErGXiLCCs6Q5DAp@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Thu, 2010-12-02 at 16:12 -0200, Fabio Estevam wrote:
> On Thu, Nov 18, 2010 at 9:31 AM, Alexander <subaparts@yandex.ru> wrote:
> > Does anyone really have success experience with SPI codecs with new
> > name-based SOC API?
> > There are really few SPI codecs in ASoC subsystem, so I wonder if only I
> > cannot bind my SPI codec to machine driver.
> >
> > The codec is registered with name spi0.0 it's the behavior of SPI
> > subsystem, I suppose. So the form is %s%d.%d and not %s.%d as supposed
> > in fmt_single_name() in soc_core.c
> >
> Have you managed to bind the SPI codec? I am trying the same thing
> here. Please let me know.

I've received a reply from Dimitris Papastamos, SoC subsystem developer,
and he written, that I should use it as is, ie spi0.0
So I'm finished with names and successfully binded it as
codecname==spi0.0

But for now, I have no sound anyway, it seems that something in SPI path
is broken (but I suppose, not in my code, as it works on 2.6.36-rc6), I
cannot see any communications going to codec with oscilloscope.
So I'm trying to figure it out now...

Best regards,
	Alexander A. Sverdlin.
