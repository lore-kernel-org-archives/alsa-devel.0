From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC driver parts probing order (MPC5200/MPC5121)
Date: Thu, 20 Oct 2011 13:35:13 +0100
Message-ID: <20111020123513.GA3484@opensource.wolfsonmicro.com>
References: <20111020122317.6c705289@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B5BA24774
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 14:35:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20111020122317.6c705289@archvile>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Jander <david.jander@protonic.nl>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 20, 2011 at 12:23:17PM +0200, David Jander wrote:

> of the probe function. So obviously, it is supposed that the DMA driver
> somehow gets probed before the PSC driver, but I can't see where this is
> enforced. AFAIK, the order is fairly random, so it could be the other way
> around.... and indeed, in my case it is.

The order the device model devices get probed in is entirely random and
any driver which is relying on this is buggy.

> 2.- Simply turning the dev_get/set_drvdata and chip initialization order
> around does work in my case, but doesn't seem a robust solution to me. Any
> idea how this should be handled?

I'd expect that delaying whatever relies on both devices being there
until the ASoC level probes happen is the way forward - you're
guaranteed that both deivces will be present there and the probe
ordering is guaranteed stable.
