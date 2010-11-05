From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: soc-cache: Add support for flat
 register caching
Date: Fri, 05 Nov 2010 14:12:00 +0000
Message-ID: <1288966320.8256.42.camel@dplaptop>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1288880564-31957-3-git-send-email-dp@opensource.wolfsonmicro.com>
	<20101104183140.GD6088@opensource.wolfsonmicro.com>
	<1288949677.8256.14.camel@dplaptop>
	<20101105133143.GH13709@opensource.wolfsonmicro.com>
	<1288965591.8256.40.camel@dplaptop>
	<20101105140757.GC15977@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E9CC8103965
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 15:12:01 +0100 (CET)
In-Reply-To: <20101105140757.GC15977@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-11-05 at 10:07 -0400, Mark Brown wrote:
> On Fri, Nov 05, 2010 at 01:59:51PM +0000, Dimitris Papastamos wrote:
> > On Fri, 2010-11-05 at 09:31 -0400, Mark Brown wrote:
> 
> > > Are you absolutely positive that every user of the code is using a
> > > register cache initialised using that method?
> 
> > If people don't want to use our caching API, then if they need so they
> > will have to manage that locally somewhere in the driver code.  In that
> > scenario, they will not call snd_soc_codec_set_cache_io() and they will
> > have to set the codec->read() and codec->write() to point to their own
> > implementation.  They should also not set reg_cache_size and
> > reg_word_size.
> 
> My concern is that since nothing stops people mix'n'matching currently
> someone may be using one bit and not the other - we need to audit all
> the current drivers to make sure that nothing is going to explode.
> > 
> > The previous caching code had the same issue.  If someone called
> > snd_soc_codec_set_cache_io() and they had not provided a valid
> > reg_cache_size and reg_word_size (both of them were zero), the
> > underlying codec->reg_cache would have been NULL and therefore any
> > read()/write() operations going through soc-cache.c would result
> > in an invalid access.
> 
> They could be setting these up later, or otherwise initialising.  It's
> likely that nobody is but it's ringing an alarm bell that we need to
> audit in case there's something that's going to bite us later on.

Yup sure, it'd be wise to audit the codecs for any invalid use of the
caching API.

Thanks,
Dimitrios
