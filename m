From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: soc-cache: Add support for flat
 register caching
Date: Fri, 05 Nov 2010 13:59:51 +0000
Message-ID: <1288965591.8256.40.camel@dplaptop>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1288880564-31957-3-git-send-email-dp@opensource.wolfsonmicro.com>
	<20101104183140.GD6088@opensource.wolfsonmicro.com>
	<1288949677.8256.14.camel@dplaptop>
	<20101105133143.GH13709@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 250AF103969
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 14:59:53 +0100 (CET)
In-Reply-To: <20101105133143.GH13709@opensource.wolfsonmicro.com>
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

On Fri, 2010-11-05 at 09:31 -0400, Mark Brown wrote:

> On Fri, Nov 05, 2010 at 09:34:37AM +0000, Dimitris Papastamos wrote:
> > On Thu, 2010-11-04 at 14:31 -0400, Mark Brown wrote:
> 
> > > > +	mutex_init(&cache_rw_mutex);
> > > > +
> 
> > > I'd kind of expect this to be with the other cache setup?
> 
> > Do you mean that the mutex should also be used with the other caching
> > techniques?  That is not needed because we currently lock at a higher
> > level, in the function that delegates the calls to the implementation
> > functions.
> 
> I'd expect this to be with the rest of the initialisation for the
> structure that it's embedded in - having this be initialised in this
> place separately to anything else feels wrong.  Of course at the minute
> it's not in a structure (which I raised as an issue as well IIRC) which
> means that we'll have an issue with multiple initialisation if two
> devices are registered.

Aw yes, I've made the mutex to be per codec, so its initialized in
snd_soc_cache_init() for each codec that's registered.

> 
> > Any CODEC driver that calls snd_soc_register_codec() and has provided
> > reg_cache_size and reg_word_size will have soc-core setting up its cache
> > accordingly.  By default the provided snd_soc_codec_driver is zero-ed
> > out, so its compress_type will default to the flat compression type.
> 
> Are you absolutely positive that every user of the code is using a
> register cache initialised using that method?

If people don't want to use our caching API, then if they need so they
will have to manage that locally somewhere in the driver code.  In that
scenario, they will not call snd_soc_codec_set_cache_io() and they will
have to set the codec->read() and codec->write() to point to their own
implementation.  They should also not set reg_cache_size and
reg_word_size.

The previous caching code had the same issue.  If someone called
snd_soc_codec_set_cache_io() and they had not provided a valid
reg_cache_size and reg_word_size (both of them were zero), the
underlying codec->reg_cache would have been NULL and therefore any
read()/write() operations going through soc-cache.c would result
in an invalid access.

Thanks,
Dimitrios
