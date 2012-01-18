From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: tlv320aic32x4: always enable
	dividers
Date: Wed, 18 Jan 2012 11:24:50 +0000
Message-ID: <20120118112449.GH8732@opensource.wolfsonmicro.com>
References: <1326883739-8148-1-git-send-email-w.sang@pengutronix.de>
	<20120118105054.GE8732@opensource.wolfsonmicro.com>
	<20120118111424.GD2559@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 407CF103AF9
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 12:24:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120118111424.GD2559@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Javier Martin <javier.martin@vista-silicon.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 18, 2012 at 12:14:24PM +0100, Wolfram Sang wrote:

> expert and I won't have endless time for this task, but at least there
> is another driver [1] as a working reference. I'll see what I can come
> up with in that time, probably reg-caching is next.

If you're going to do that a conversion to regmap would probably be in
order, I'd rather like to remove the ASoC cache code as there doesn't
seem to be a good reason to have two implementations and it's unlikely
that there's anything ASoC specific about register access.
