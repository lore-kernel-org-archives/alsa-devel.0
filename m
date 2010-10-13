From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] sound/soc/codecs/wm8962.c: Use
 register index, save 100kb text
Date: Wed, 13 Oct 2010 20:40:17 +0100
Message-ID: <20101013194017.GB17574@rakim.wolfsonmicro.main>
References: <B2150E1E4418E1438554A300EA5040E40D469C124F@ITSVLEX06.it.maxim-ic.internal>
	<1286934472.1117.129.camel@Joe-Laptop>
	<20101013082414.GD6424@rakim.wolfsonmicro.main>
	<1286971846.1117.191.camel@Joe-Laptop>
	<20101013123301.GL6424@rakim.wolfsonmicro.main>
	<1286974549.1117.254.camel@Joe-Laptop>
	<20101013151117.GM6424@rakim.wolfsonmicro.main>
	<1286983667.1117.347.camel@Joe-Laptop>
	<20101013152916.GA20270@rakim.wolfsonmicro.main>
	<1286997031.1117.405.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CB4B7103A1C
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 21:40:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1286997031.1117.405.camel@Joe-Laptop>
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

On Wed, Oct 13, 2010 at 12:10:31PM -0700, Joe Perches wrote:

> I don't know if the binary chop is too cpu
> intensive or if too much data access would be
> a problem.

It's on my list to do something about this but if we're going to do
anything it should be in generic code - this is an issue which affects
a growing number of devices and there's enough code to mean that it
should be librified.  This should ideally also involve compressing the
cache itself since that has a similar effect again.

I'm not a fan of doing device specific stuff here since it will make it
harder to transition those devices to use generic code, causing hassle
trying to maintain the subsystem.  The size impact of doing something
simple is a bit annoying but not usually a pressing issue on devices
that would want a CODEC with a noticably large register map.

By the way, please try to provide prefixes for your patches which are
consistent with those normally used for the code you are modifying
rather than making up your own.
