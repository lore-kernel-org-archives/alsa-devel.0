From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: Hold runtime PM references to
 components of active DAIs
Date: Mon, 5 Dec 2011 11:39:41 +0000
Message-ID: <20111205113939.GF11150@opensource.wolfsonmicro.com>
References: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4EDC7A43.5040409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E2946103902
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 12:39:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EDC7A43.5040409@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 05, 2011 at 10:01:07AM +0200, Peter Ujfalusi wrote:
> On 12/05/2011 02:01 AM, Mark Brown wrote:

> > +	pm_runtime_get_sync(cpu_dai->dev);
> > +	pm_runtime_get_sync(codec_dai->dev);
> > +	pm_runtime_get_sync(platform->dev);
> > +
> >  	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);

> I think it is better to move the pm_runtime_get_sync calls after the
> mutex_lock_nested() to be really safe (and to not change the way DAI
> drivers were handling the pm_runtime).

This increases the amount of time we are sitting with the pcm_mutex held
and I can't see a reason why we should need to do that.  If there is a
problem here I'd rather improve the drivers so that they can cope with
having the power management happening after the lock, the main reason
the drivers were doing this previously is that the lock happened to be
held by the caller.
