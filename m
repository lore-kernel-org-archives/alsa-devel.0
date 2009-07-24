From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Jack handling enhancements as
 suggested by subsystem maintainer
Date: Fri, 24 Jul 2009 11:27:17 +0100
Message-ID: <20090724102717.GA28228@rakim.wolfsonmicro.main>
References: <200907240248.58433.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 052CF24581
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 12:27:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907240248.58433.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 24, 2009 at 02:48:57AM +0200, Janusz Krzysztofik wrote:
> The patch adds a few small enhancements to the ASoC jack handling, as 
> suggested by Mark in his comments to my Amstrad Delta driver, and a few fixes 
> for related bugs found while learning Mark's code and testing results.

Applied, thanks.  It would have been nice to split this down into
smaller patches - at least making the GPIO export addition a separate
one.
