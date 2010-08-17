From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/7] ASoC: Automatically calculate clock
 ratio for WM8580
Date: Tue, 17 Aug 2010 10:46:05 +0100
Message-ID: <20100817094605.GC18622@rakim.wolfsonmicro.main>
References: <20100813193305.GB3778@sirena.org.uk>
	<1281728107-25386-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTi=6Op9C3adxhN8HsZu9FewFYqeCWRoQs=P3LP18@mail.gmail.com>
	<20100815110924.GA25723@opensource.wolfsonmicro.com>
	<AANLkTi=9Y=uhX2b+Y=OMGCVA=gJNif8HwXe3Eg517nbq@mail.gmail.com>
	<20100816102010.GB3276@rakim.wolfsonmicro.main>
	<AANLkTinTYo6_BBSkhTt8Km-MR4wwexDS3orFJdNSiufT@mail.gmail.com>
	<20100816151958.GE3276@rakim.wolfsonmicro.main>
	<AANLkTindYfm3vh_OgF-0tt_MS+Uxii2s7Dw=Kk487RTd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 86C522440E
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Aug 2010 11:46:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTindYfm3vh_OgF-0tt_MS+Uxii2s7Dw=Kk487RTd@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Seungwhan Youn <sw.youn@samsung.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Seungwhan Youn <claude.youn@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 17, 2010 at 08:14:43AM +0900, Jassi Brar wrote:

> I guess most quality conscious products can afford to attach a dedicated
> OSC to a good CODEC. A CODEC already specifies the clocks it support
> and usually comes with 'preferred' input clocks. So, just having a specified
> rating accurate enough OSC can take care of quality. On the other hand
> the clock sources on CPU side are not particularly accurate for audio-clock
> generation. Or so have I seen so far.

Right, this shouldn't be an issue with the change I proposed - the
clocks are still rooted from the CODEC and its clock generation
facilities would still be used, it's just that they get routed
differently.

The issue with using most CPU clocks isn't really the dedicated
oscillator so much as the ability to generate non-integer divisions of
whatever input clock is available.  If this can't be done then it can be
hard to generate the full range of common audio frequencies.
