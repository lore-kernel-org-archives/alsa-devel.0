From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/4] ASoC: Add TI tlv320aic32x4 codec
	support.
Date: Tue, 1 Mar 2011 14:43:31 +0000
Message-ID: <20110301144331.GI9662@opensource.wolfsonmicro.com>
References: <1298988128-11520-1-git-send-email-javier.martin@vista-silicon.com>
	<1298988128-11520-2-git-send-email-javier.martin@vista-silicon.com>
	<20110301142231.GH9662@opensource.wolfsonmicro.com>
	<AANLkTinSqVuuiif33yd1zZBTzeb4mvvLpDd4+=RPiHHM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 59BCC103923
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 15:43:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTinSqVuuiif33yd1zZBTzeb4mvvLpDd4+=RPiHHM@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, b32542@freescale.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 01, 2011 at 03:36:13PM +0100, javier Martin wrote:

> Ok, let me organize all this stuff for better understanding. By the
> way, when you said it should be configured by platform are you
> referring to machine driver or to board specific code? Can you please

Either the machine driver or board specific code depending on what's
idiomatic for the thing you're configuring (they're both machine
specific anyway).  

> point me to a codec driver which uses a similar approach?

Quite a lot of CODEC drivers have platform data of various kinds, pretty
much all of them have an include file in include/sound - look there for
a list.
