From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: DaVinci: i2s,
	reduce underruns	by combining into 1 element
Date: Tue, 1 Sep 2009 22:22:24 +0100
Message-ID: <20090901212224.GA27078@opensource.wolfsonmicro.com>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
	<20090901105302.GD18651@sirena.org.uk>
	<4A9D669F.6090906@boundarydevices.com>
	<20090901190327.GA25706@opensource.wolfsonmicro.com>
	<4A9D73BE.8000901@boundarydevices.com>
	<20090901202855.GA26626@opensource.wolfsonmicro.com>
	<4A9D871A.0@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CBAD82414B
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 23:22:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A9D871A.0@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: avm@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 01, 2009 at 01:42:02PM -0700, Troy Kisky wrote:
> Mark Brown wrote:

> >> is using the same TC. But sram isn't on by default either. And probably shouldn't
> >> be since the newer chips don't have an underrun problem.

> > Hrm, that suggests that if it's enabled at all the default should depend
> > on the chip in use?

> That seems unnecessarily complex to me. As long as platform data can
> specify what you need, you'll eventually get it right. If tracking of
> an object is always wrong because of a channel swap, that is easier
> to notice, and debug, and fix, then if the tracking is only occasionally
> wrong. I'd much rather have a repeatable bug. And most codecs do allow
> you to swap the left and right channels. So, for most people, the fix
> will not be to disable channel combining.

My thinking was that if the newer chips don't have the underrun issue at
all then it seems like a bad move to enable the workaround for them
since they're currently fine.  There should be no intermittent problems
if the underrun issue isn't present.
