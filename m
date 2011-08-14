From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: Add ADAU1373 codec support
Date: Sun, 14 Aug 2011 19:24:10 +0900
Message-ID: <20110814102407.GB18382@opensource.wolfsonmicro.com>
References: <1312948364-2587-1-git-send-email-lars@metafoo.de>
	<1312948364-2587-2-git-send-email-lars@metafoo.de>
	<20110811092702.GA18454@opensource.wolfsonmicro.com>
	<4E43AACF.5060701@metafoo.de>
	<1313068590.19990.2.camel@finisterre.wolfsonmicro.main>
	<4E4471E1.5060706@metafoo.de>
	<1313112046.19990.32.camel@finisterre.wolfsonmicro.main>
	<4E45EEB5.8080107@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6043624856
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Aug 2011 12:24:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E45EEB5.8080107@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Frysinger <vapier.adi@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 13, 2011 at 05:25:41AM +0200, Lars-Peter Clausen wrote:

> Since this driver's DAPM already doesn't distinguish between the left and the
> right channel of the input bypass signals none of the outputs or mixers are not
> powered when they should be.
> 
> So I would like to keep these as enums, as they are right now.

OK.
