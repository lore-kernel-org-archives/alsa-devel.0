From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/7] ASoC: Automatically calculate clock
 ratio for WM8580
Date: Mon, 16 Aug 2010 11:20:11 +0100
Message-ID: <20100816102010.GB3276@rakim.wolfsonmicro.main>
References: <20100813193305.GB3778@sirena.org.uk>
	<1281728107-25386-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTi=6Op9C3adxhN8HsZu9FewFYqeCWRoQs=P3LP18@mail.gmail.com>
	<20100815110924.GA25723@opensource.wolfsonmicro.com>
	<AANLkTi=9Y=uhX2b+Y=OMGCVA=gJNif8HwXe3Eg517nbq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D778103821
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 12:20:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=9Y=uhX2b+Y=OMGCVA=gJNif8HwXe3Eg517nbq@mail.gmail.com>
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

On Mon, Aug 16, 2010 at 01:36:50PM +0900, Jassi Brar wrote:

> For us, having CPU in slave mode is more important than clearing all the
> use cases perfectly on a _reference_ platform.
> More so when the 'problem' can be obviously attributed to the h/w design.

Hrm, OK - this is the opposite way around to what most CPU vendors would
ask for.  Is there any particular reason for this preference?

> So please modify only if you must, otherwise, as I said, we'd prefer
> CPU slave mode working
> by default in mainline.

Well, I'd like to see the driver working as well as possible, especially
since people tend to take reference code from mainline and clone it.
The way the hardware is the clock tree should definitely be rooted in
the WM8580, it's just the LRCLK and BCLK I'm thinking about here.
