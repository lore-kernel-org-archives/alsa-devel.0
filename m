From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Palm27x-asoc: fix it to work without jack gpio
	specified
Date: Mon, 1 Jun 2009 23:58:44 +0100
Message-ID: <20090601225843.GA5807@sirena.org.uk>
References: <200906012230.58977.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A63232436B
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 00:58:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200906012230.58977.marek.vasut@gmail.com>
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

On Mon, Jun 01, 2009 at 10:30:58PM +0200, Marek Vasut wrote:

> -	if (!(machine_is_palmtx() || machine_is_palmt5() ||
> -		machine_is_palmld() || machine_is_palmte2()))
> -		return -ENODEV;
> -
> -	if (pdev->dev.platform_data)

These machine_is_() checks don't get re-added elsehwere (and it looks
like you generated the diff against a different verison of the file to
the one that's in ALSA git).  It'd be better to keep them here and just
add the { to the platform_data check.

Otherwise this is fine.
