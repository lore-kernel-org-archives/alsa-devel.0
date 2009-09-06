From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Minor WM8580 enhancements.
Date: Sun, 6 Sep 2009 02:22:33 +0100
Message-ID: <20090906012232.GA4239@sirena.org.uk>
References: <1b68c6790909051709k600c8ecdv5bc457ae8e1242c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 16D68103802
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Sep 2009 03:22:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1b68c6790909051709k600c8ecdv5bc457ae8e1242c1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 06, 2009 at 09:09:41AM +0900, jassi brar wrote:

> +	case WM8580_MCLKRATIO:
> +	case WM8580_BCLKRATIO:

There should be no need for machine drivers to configure any of this,
there's already enough information in the CODEC driver to figure out
this configuration without their help.  Having the machine drivers do it
manually simply forces each machine driver using the chip to repeat the
same logic which is at best redundant and at worst makes machine drivers
harder to write.

As mentioned previously this driver could use a bit of modernisation in
general, including with regard to clocking, which I had already been
planning to do as part of working on the SMDK boards.  As a result of
some work on another chip with a very similar clocking structure I have
a rough draft of what needs doing for the clocks already.  This is part
of why in my earlier mail I had recommended focusing on the CPU DAI
drivers for now - the lack of them is the biggest obstacle to getting
that work cleaned up and tested.
