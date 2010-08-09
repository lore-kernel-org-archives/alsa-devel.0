From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: i.MX SDMA support
Date: Mon, 9 Aug 2010 15:09:44 +0100
Message-ID: <64008892-3D75-4309-A623-CCE9B335F77F@opensource.wolfsonmicro.com>
References: <20100809091157.GC20065@pengutronix.de>
	<1281350823.3035.54.camel@odin>
	<20100809121956.GA27749@pengutronix.de>
	(sfid-20100809_132005_107048_4FC8992A)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1B47103817
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Aug 2010 16:09:22 +0200 (CEST)
In-Reply-To: <20100809121956.GA27749@pengutronix.de>
	(sfid-20100809_132005_107048_4FC8992A)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 9 Aug 2010, at 13:19, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> On Mon, Aug 09, 2010 at 11:47:03AM +0100, Liam Girdwood wrote:
>> 
>> Yeah, that should be OK. However, we do have a ASoC core multi-component
>> update merging later this week. This may conflict with some of your SDMA
>> updates, although the multi-component support only really affects ASoC
>> component probe() and remove() as every component is a regular Linux
>> device now (with platform data, etc) and private data access.
> 
> That won't be a problem. The SDMA code will wait until the next merge
> window anyway, I will rebase it after the multi-compoment merge if
> necessary.

This is precisely the issue - multi component will go in 2.6.37 too, meaning conflicts in -next unless one tree is pulled into the other during the release cycle.
>> 
