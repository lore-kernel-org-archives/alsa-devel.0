From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fix build with PM_SLEEP unset
Date: Thu, 3 Feb 2011 09:27:38 +0000
Message-ID: <20110203092737.GA21591@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.1102030928150.21719@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5520A103A3B
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 10:27:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1102030928150.21719@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 03, 2011 at 09:32:29AM +0100, Guennadi Liakhovetski wrote:

> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  	/* deferred resume work */
>  	INIT_WORK(&card->deferred_resume_work, soc_resume_deferred);
>  #endif

This change is already present in current code.
