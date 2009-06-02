From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Palm27x-asoc: fix it to work without jack gpio
	specified
Date: Tue, 2 Jun 2009 10:48:56 +0100
Message-ID: <20090602094856.GD19390@rakim.wolfsonmicro.main>
References: <200906012230.58977.marek.vasut@gmail.com>
	<20090601225843.GA5807@sirena.org.uk>
	<200906020211.46536.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E87EF244FE
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 11:48:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200906020211.46536.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 02, 2009 at 02:11:46AM +0200, Marek Vasut wrote:
> On Tuesday 02 of June 2009 00:58:44 Mark Brown wrote:

> > These machine_is_() checks don't get re-added elsehwere (and it looks
> > like you generated the diff against a different verison of the file to
> > the one that's in ALSA git).  It'd be better to keep them here and just
> > add the { to the platform_data check.

> But do we need those checks? The driver is registered only on those machines 
> anyway.

Yes, they're not needed since it's a platform driver - that's not
obvious when looking at the context diffs (this is one of those cases
where explaining what you're doing in the changelog helps!).
