From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] pxa2xx-ac97-lib: support building for
	several CPUs
Date: Thu, 11 Sep 2008 16:04:13 +0100
Message-ID: <20080911150413.GC12311@sirena.org.uk>
References: <1221008480-13377-1-git-send-email-dbaryshkov@gmail.com>
	<1221008480-13377-2-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AB98224335
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Sep 2008 17:04:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1221008480-13377-2-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 10, 2008 at 05:01:18AM +0400, Dmitry Baryshkov wrote:

> +#endif
> +#ifdef CONFIG_PXA3XX
> +	if (cpu_is_pxa3xx())
> +		pxa_ac97_warm_pxa3xx();
> +	else
> +#endif

Typo, should be CONFIG_PXA3xx (and also in cold reset).  Again, I've
fixed that up locally.  However, PXA3xx support seems broken in some
other way, it fails during init - I'll debug this and post updated
patches.
