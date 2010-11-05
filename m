From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: soc-cache: Add support for flat
 register caching
Date: Fri, 5 Nov 2010 09:31:44 -0400
Message-ID: <20101105133143.GH13709@opensource.wolfsonmicro.com>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1288880564-31957-3-git-send-email-dp@opensource.wolfsonmicro.com>
	<20101104183140.GD6088@opensource.wolfsonmicro.com>
	<1288949677.8256.14.camel@dplaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 396BD103943
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 14:31:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288949677.8256.14.camel@dplaptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 05, 2010 at 09:34:37AM +0000, Dimitris Papastamos wrote:
> On Thu, 2010-11-04 at 14:31 -0400, Mark Brown wrote:

> > > +	mutex_init(&cache_rw_mutex);
> > > +

> > I'd kind of expect this to be with the other cache setup?

> Do you mean that the mutex should also be used with the other caching
> techniques?  That is not needed because we currently lock at a higher
> level, in the function that delegates the calls to the implementation
> functions.

I'd expect this to be with the rest of the initialisation for the
structure that it's embedded in - having this be initialised in this
place separately to anything else feels wrong.  Of course at the minute
it's not in a structure (which I raised as an issue as well IIRC) which
means that we'll have an issue with multiple initialisation if two
devices are registered.

> > Are you sure that all the CODECs that rely on the existing shared
> > register cache are going to call this?

> What do you mean by 'shared register cache'?  Each codec gets its own
> copy of their register cache.

The shared register cache support code.

> Any CODEC driver that calls snd_soc_register_codec() and has provided
> reg_cache_size and reg_word_size will have soc-core setting up its cache
> accordingly.  By default the provided snd_soc_codec_driver is zero-ed
> out, so its compress_type will default to the flat compression type.

Are you absolutely positive that every user of the code is using a
register cache initialised using that method?
