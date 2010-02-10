From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add Phytec i.MX sound support for AC97
Date: Wed, 10 Feb 2010 10:51:43 +0000
Message-ID: <20100210105142.GA9481@rakim.wolfsonmicro.main>
References: <20100209101428.GG17643@pengutronix.de>
	<20100209195322.GA13437@opensource.wolfsonmicro.com>
	<20100210102415.GO17643@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F305D24405
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 11:51:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100210102415.GO17643@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 10, 2010 at 11:24:15AM +0100, Sascha Hauer wrote:

> I added the corresponding files to my mxc-master branch and they should
> show up on -next tomorrow. I removed the BROKEN in this patch because I
> was sure that I add the files during this merge window and because it
> shouldn't cause compile breakage in the mean time since the driver is
> not selected in any config. But of course you are right, will do so
> next time.

Given the interest in i.MX audio support even stuff that's not there by
default is going to raise people's hopes needlessly.
