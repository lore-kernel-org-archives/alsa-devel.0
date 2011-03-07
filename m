From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: Re: [PATCH] ASoC: Improve EP93xx I2S clocks management.
Date: Mon, 07 Mar 2011 08:39:06 +0300
Message-ID: <1299476346.27359.120.camel@r60e>
References: <1299286635.27359.106.camel@r60e>
	<4D740490.8060200@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward3.mail.yandex.net (forward3.mail.yandex.net [77.88.46.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 237CA2445C
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 06:39:11 +0100 (CET)
In-Reply-To: <4D740490.8060200@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Ryan,

On Mon, 2011-03-07 at 11:02 +1300, Ryan Mallon wrote:
> > +	sdiv = 4;
> > +	if (div > (256 + 512) / 2) {
> > +		lrdiv = 128;
> > +	} else {
> > +		lrdiv = 64;
> > +		if (div < (128 + 256) / 2)
> > +			sdiv = 2;
> > +	}
> 
> I don't understand where the magic numbers above come from? Does it work
> correctly for all rates? I think a comment is needed to explain how this
> works.

The Magic is simply centers between divisors. The loop produced only 3
variants of divisors. So do this code. But it's simpler and it prefers
LRDIV = 64. I do not know what do you mean by all rates, with fixed MCLK
there is no way to produce all the rates. With variable MCLK I'm having
full 8000-192000 range now.

> 
> An alternative would be to keep the existing loop form, but try and find
> the closest match rather than an exact match. Something like this
> (untested):

This is huge comparing to 2 ifs... But the main task of keeping LRCLK=64
where possible still can be achieved if we swap to lines:


> 	for (sdiv = 2; sdiv <= 4; sdiv += 2) {
> 		for (lrdiv = 64; lrdiv <= 128; lrdiv <<= 1) {

But I'm sure code proposed by me should work just like previous variant
for you. Could you try it with your configuration please?
