From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: soc-cache: Add support for
 rbtree based register caching
Date: Thu, 4 Nov 2010 14:49:48 -0400
Message-ID: <20101104184948.GE6088@opensource.wolfsonmicro.com>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1288880564-31957-5-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BE67124413
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 19:49:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288880564-31957-5-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Thu, Nov 04, 2010 at 02:22:44PM +0000, Dimitris Papastamos wrote:

> This patch adds support for rbtree compression when storing the
> register cache.  It does this by not adding any uninitialized registers
> (those whose value is 0).  If any of those registers is written
> with a nonzero value they get added into the rbtree.

> +	rbtree_ctx = codec->reg_cache;
> +	for (node = rb_first(&rbtree_ctx->root); node; node = rb_next(node)) {
> +		rbnode = rb_entry(node, struct snd_soc_rbtree_node, node);
> +		if (!rbnode->dirty)
> +			continue;
> +		snd_soc_cache_read(codec, rbnode->reg, &val);
> +		snd_soc_write(codec, rbnode->reg, val);
> +		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
> +			rbnode->reg, val);

Hrm, dirty handling is kind of interesting.  It is unconditionally set
in the write function and never cleared so we'll always rewrite a
register if it's ever been touched.  Is it worth remembering the default
values and just comparing with them, the memory overhead will probably
be low since we only have one bitfield value here...  (and remember that
we'll be unlikely to allocate memory in 21 byte packed hunks with no
overhead...).
