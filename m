From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: soc-cache: Add support for LZO
 based register caching
Date: Sat, 23 Oct 2010 19:28:01 +0100
Message-ID: <1287858481.9010.11.camel@dplaptop>
References: <1287757702-9573-5-git-send-email-dp@opensource.wolfsonmicro.com>
	<20101022161850.GF16521@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F3CE61037FB
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Oct 2010 20:28:02 +0200 (CEST)
In-Reply-To: <20101022161850.GF16521@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam@alsa-project.org, Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-10-22 at 09:18 -0700, Mark Brown wrote:
> On Fri, Oct 22, 2010 at 03:28:22PM +0100, Dimitris Papastamos wrote:
> 
> > This patch adds support for LZO compression when storing the register
> > cache.  The initial register defaults cache is marked as __devinitconst
> > and the only change required for a driver to use LZO compression is
> 
> This looks good, though the changelog could use a bit more discussion as
> to the tradeoffs involved - clearly we're trading CPU consumption for
> memory consumption here, but things like numbers about the sorts of
> compression you can get and the amount of CPU time burned relative to
> the actual I/O operations would help people understand when and how to
> use this.

Yes, that makes sense.

> Actually, now that I think about it debug data either via debugfs or via
> dev_dbg() showing the before and after memory sizes would be very useful
> for people trying to decide if their register map compresses down well
> enough to really benefit from compression.

I'll send an incremental patch for that.

> It looks like this patch also needs to add selects for LZO_COMPRESS and
> LZO_DECOMPRESS to Kconfig, otherwise we'll fail to build if nothing else
> has enabled them.
> 
> > to set the compress_type member in codec->driver to
> > SND_SOC_LZO_COMPRESSION.
> 
> It would be good if machine drivers were able to override this, 

I'll think about this to see how it can be overriden.

> > +static int snd_soc_compress_cache_block(struct snd_soc_codec *codec,
> > +					struct snd_soc_lzo_ctx *lzo_ctx)
> > +{
> 
> This is all rather assuming that LZO is the only compression method we
> can use?  It doesn't really matter, though, as this is all internal to
> the cache code so we can deal with adding new compression types as and
> when we want them.

The function naming is wrong.  This function is a helper function for
the LZO compression type.  I've prefixed this function with LZO to avoid
misunderstanding.  Ideally this would live in a separate file.

Thanks,
Dimitrios
