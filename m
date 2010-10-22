From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: soc-cache: Add support for LZO
 based register caching
Date: Fri, 22 Oct 2010 09:18:51 -0700
Message-ID: <20101022161850.GF16521@opensource.wolfsonmicro.com>
References: <1287757702-9573-5-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8A0D21038A2
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 18:19:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1287757702-9573-5-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Fri, Oct 22, 2010 at 03:28:22PM +0100, Dimitris Papastamos wrote:

> This patch adds support for LZO compression when storing the register
> cache.  The initial register defaults cache is marked as __devinitconst
> and the only change required for a driver to use LZO compression is

This looks good, though the changelog could use a bit more discussion as
to the tradeoffs involved - clearly we're trading CPU consumption for
memory consumption here, but things like numbers about the sorts of
compression you can get and the amount of CPU time burned relative to
the actual I/O operations would help people understand when and how to
use this.

Actually, now that I think about it debug data either via debugfs or via
dev_dbg() showing the before and after memory sizes would be very useful
for people trying to decide if their register map compresses down well
enough to really benefit from compression.

It looks like this patch also needs to add selects for LZO_COMPRESS and
LZO_DECOMPRESS to Kconfig, otherwise we'll fail to build if nothing else
has enabled them.

> to set the compress_type member in codec->driver to
> SND_SOC_LZO_COMPRESSION.

It would be good if machine drivers were able to override this, 

> +static int snd_soc_compress_cache_block(struct snd_soc_codec *codec,
> +					struct snd_soc_lzo_ctx *lzo_ctx)
> +{

This is all rather assuming that LZO is the only compression method we
can use?  It doesn't really matter, though, as this is all internal to
the cache code so we can deal with adding new compression types as and
when we want them.
