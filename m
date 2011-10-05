From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ak4535: Set codec->hw_write to
	i2c_master_send
Date: Wed, 5 Oct 2011 17:16:21 +0100
Message-ID: <20111005161620.GB11528@opensource.wolfsonmicro.com>
References: <1317799677.21481.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7D1E24451
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 18:16:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317799677.21481.6.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Richard Purdie <rpurdie@rpsys.net>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 05, 2011 at 03:27:56PM +0800, Axel Lin wrote:
> It was removed in commit f0fba2ad
> "ASoC: multi-component - ASoC Multi-Component Support".
> 
> Add it back, otherwise codec->hw_write points to NULL.

It's better to fix the driver not to use hw_write any more, it's broken
without anyway.
