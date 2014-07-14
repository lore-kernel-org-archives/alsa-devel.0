From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
	registration
Date: Mon, 14 Jul 2014 20:23:55 +0200
Message-ID: <16507628.c6raaN50oI@wuerfel>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <4494372.fAWcxQ0qku@wuerfel> <53C402C4.5090908@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id C7B60261B36
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 20:24:05 +0200 (CEST)
In-Reply-To: <53C402C4.5090908@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, t.figa@samsung.com, Maurus Cuelenaere <mcuelenaere@gmail.com>, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Monday 14 July 2014 18:18:12 Lars-Peter Clausen wrote:
> On 07/14/2014 05:46 PM, Arnd Bergmann wrote:
> [...]
> >>> +static struct gpiod_lookup_table smartq_audio_gpios = {
> >>> +   .dev_id = "smartq-audio",
> >>> +   .table = {
> >>> +           GPIO_LOOKUP("GPL", 12, "headphone detect", 0),
> >>> +           GPIO_LOOKUP("GPK", 12, "amplifiers shutdown", GPIO_ACTIVE_HIGH),
> >>
> >> There is no such thing as GPIO_ACTIVE_HIGH, just 0 for flags.
> >
> > The original driver does gpio_direction_output(..., 1);
> >
> > For some reason I earlier concluded that this was what the '1' would need
> > to get converted to. Are you sure '0' is correct then?
> >
> 
> Yes. But now that you say it the gpiod_direction_output() call is missing 
> from this patch.

I'm lost now. The GPIO_ACTIVE_HIGH I added comes from Documentation/gpio/board.txt
and as Linus Walleij explained to me the other day, the lookup is supposed
to replace devm_gpio_request_one(), which in turn replaced both the
gpio_request and the gpio_direction_output(). Do I need to put the
gpiod_direction_output() back or is there another interface for that when
registering the board gpios?

	Arnd
