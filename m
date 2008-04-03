From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: ASoC for TI OMAP - alsa-devel submission?
Date: Thu, 3 Apr 2008 08:56:10 +0300
Message-ID: <20080403085610.c0141864.jarkko.nikula@nokia.com>
References: <20080402134530.3460b0bf.jarkko.nikula@nokia.com>
	<20080402110054.GA7977@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id CC9A3103806
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Apr 2008 07:55:58 +0200 (CEST)
In-Reply-To: <20080402110054.GA7977@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2 Apr 2008 12:00:54 +0100
"ext Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, Apr 02, 2008 at 01:45:30PM +0300, Jarkko Nikula wrote:
> 
> > So what I mean that should I post the patch like as it now, rebased
> > to dev branch of linux-2.6-asoc tree and with some minor changes,
> > or wait a bit when all linux-omap and ASoC v2 evolve? What you
> > think?
> 
> Whatever is most convenient for you.  From the point of view of
> getting stuff in immediately it's best to base things on ASoC v1
> though from an ongoing development point of view ASoC v2 is a better
> target if you can cope with any churn and hopefully we should be
> starting to push it into the kernel within the next couple of release
> cycles so if it's going to take a while to get the required BSP
> changes in...
>
I'll think I have to go for both :-)

The first ASoC v1 based version I would mostly like to see as an
enabler for getting n different ALSA implementation we have in
linux-omap tree to be ported for ASoC. Especially codec drivers. Or to
have an another DAI link driver for EAC (Enhanced Audio Controller)
found in OMAP2420.

The v2 I see also as mandatory path. We already do have boards with
multiple DAI links and codecs: e.g. audio codec + audio link to
bluetooth chip.

I'll simplify a bit my patch, base it to alsa-dev and post it here soon.

-- 
Jarkko
