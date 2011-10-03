From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: samsung: s3c-i2s-v2.c needs module.h
Date: Mon, 3 Oct 2011 18:01:22 +0100
Message-ID: <20111003170121.GR3731@opensource.wolfsonmicro.com>
References: <1317562466.4996.2.camel@phoenix>
	<20111002182605.GC2857@opensource.wolfsonmicro.com>
	<CAF+7xWkfTJXwt1uUtXgkh5Go9yxWasdM5a3DuLnii_5LqB00UQ@mail.gmail.com>
	<20111003103026.GB23811@sirena.org.uk>
	<4E89DCC7.4010703@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A18A24516
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 19:01:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E89DCC7.4010703@windriver.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org, Axel Lin <axel.lin@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 03, 2011 at 12:03:19PM -0400, Paul Gortmaker wrote:
> On 11-10-03 06:30 AM, Mark Brown wrote:

> > That's exactly what I'm running at the minute with no problem...

> Then I'm guessing you don't have the option for it enabled (as

I'm pretty sure I'd have noticed if I wasn't building the driver, my
systems would be a lot less noisy than it currently is.

> Thanks Axel, I'll squish this into the commit that adds module.h
> to all the other sound drivers that have it missing.

Now that we've worked out what it's for I don't see any reason not to
apply Axel's patch right now so I've done that.

It would be useful if you could send your patches for module.h
upstream, there's no reason to avoid sending them now and it'd be useful
to cut down on the noise from small merge issues.
