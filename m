From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: No shutdown code in soc-core.c
Date: Tue, 20 Apr 2010 01:59:57 +0900
Message-ID: <20100419165956.GA29819@opensource.wolfsonmicro.com>
References: <11864963.186471271683156859.JavaMail.weblogic@epml11>
	<1271686255.3208.309.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D4702247DF
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 18:59:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1271686255.3208.309.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "liam.girdwood@wolfsonmicro.com" <liam.girdwood@wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, anish.singh@samsung.com
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 19, 2010 at 03:10:55PM +0100, Liam Girdwood wrote:

> Ah, your kernel is very old. I would just do what you are currently
> doing with shutdown and use the dev_pm_ops when you upgrade your kernel.

Actually, IME it's probably as easy to just backport current ASoC to
2.6.29 if you're doing anything non-trivial - the backport is very
straightforward for most platforms and the benefits of the enhancements
in ASoC are well worth the effort.
