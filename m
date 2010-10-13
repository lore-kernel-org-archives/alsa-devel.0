From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] sound/soc/codecs/wm8962.c: Use
 register index, save 100kb text
Date: Wed, 13 Oct 2010 21:29:38 +0100
Message-ID: <20101013202938.GA25495@rakim.wolfsonmicro.main>
References: <20101013082414.GD6424@rakim.wolfsonmicro.main>
	<1286971846.1117.191.camel@Joe-Laptop>
	<20101013123301.GL6424@rakim.wolfsonmicro.main>
	<1286974549.1117.254.camel@Joe-Laptop>
	<20101013151117.GM6424@rakim.wolfsonmicro.main>
	<1286983667.1117.347.camel@Joe-Laptop>
	<20101013152916.GA20270@rakim.wolfsonmicro.main>
	<1286997031.1117.405.camel@Joe-Laptop>
	<20101013194017.GB17574@rakim.wolfsonmicro.main>
	<1287000382.1117.416.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C8A23103A2C
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 22:29:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1287000382.1117.416.camel@Joe-Laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Jesse Marroquin <Jesse.Marroquin@maxim-ic.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 13, 2010 at 01:06:22PM -0700, Joe Perches wrote:
> On Wed, 2010-10-13 at 20:40 +0100, Mark Brown wrote:

> > The size impact of doing something
> > simple is a bit annoying but not usually a pressing issue on devices
> > that would want a CODEC with a noticably large register map.

> I think wasting 100+ KB is excessive if I
> were designing some cheap mp3 player.

Absolutely, but if you're desigining a cheap MP3 player you're very much
more likely to be using a much simpler device which doesn't have the
very large, sparse register maps that get a substantial benefit from
compressing the data like this.  As I said, devices that would want a
CODEC with a register map that is affected usually aren't under that
much size pressure for the kernel.

> Up to you how/when it should be resolved/fixed,
> but I think it should be.

As I said in the text which you cut I agree that this should be improved
but don't want to have to go through each and every device cut'n'pasting
code since that's not going to do anything for maintainbility.

In addition to my previous comments about your subject lines for patches
please also avoid burying new patches in the middle of tangentially
related threads.
