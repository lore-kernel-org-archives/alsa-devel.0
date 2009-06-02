From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: Palm27x-asoc: fix it to work without jack gpio
	specified
Date: Tue, 2 Jun 2009 02:11:46 +0200
Message-ID: <200906020211.46536.marek.vasut@gmail.com>
References: <200906012230.58977.marek.vasut@gmail.com>
	<20090601225843.GA5807@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 68E92243F4
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 02:11:48 +0200 (CEST)
Received: by fxm18 with SMTP id 18so8347292fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 01 Jun 2009 17:11:47 -0700 (PDT)
In-Reply-To: <20090601225843.GA5807@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 02 of June 2009 00:58:44 Mark Brown wrote:
> On Mon, Jun 01, 2009 at 10:30:58PM +0200, Marek Vasut wrote:
> > -	if (!(machine_is_palmtx() || machine_is_palmt5() ||
> > -		machine_is_palmld() || machine_is_palmte2()))
> > -		return -ENODEV;
> > -
> > -	if (pdev->dev.platform_data)
>
> These machine_is_() checks don't get re-added elsehwere (and it looks
> like you generated the diff against a different verison of the file to
> the one that's in ALSA git).  It'd be better to keep them here and just
> add the { to the platform_data check.

But do we need those checks? The driver is registered only on those machines 
anyway.
>
> Otherwise this is fine.
