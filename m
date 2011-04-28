From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/7] ASoC: DAPM: Pass snd_dapm_soc_update
	as parameter
Date: Thu, 28 Apr 2011 23:59:33 +0100
Message-ID: <20110428225933.GB11103@opensource.wolfsonmicro.com>
References: <4DB9D06C.5090006@metafoo.de>
	<20110428205827.GA18350@opensource.wolfsonmicro.com>
	<4DB9DB16.1060507@metafoo.de>
	<20110428214817.GA19535@opensource.wolfsonmicro.com>
	<4DB9E454.3060903@metafoo.de>
	<20110428221800.GC19535@opensource.wolfsonmicro.com>
	<20110428222315.GA19741@opensource.wolfsonmicro.com>
	<4DB9EB63.5020007@metafoo.de>
	<20110428224817.GA11103@opensource.wolfsonmicro.com>
	<4DB9F116.9040305@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9B5AD1039CA
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 00:59:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DB9F116.9040305@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 29, 2011 at 12:58:30AM +0200, Lars-Peter Clausen wrote:

> Yes, but the widget has a pointer to the dapm context as well. So we can get
> the context from the widget and don't have to pass it separately. Or will there
> be non-widget related updates, which ought to be done in the middle of the
> powering sequence, in the foreseeable future?

No.
