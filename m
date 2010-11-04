From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC: soc-cache: Add support for LZO
 register caching
Date: Thu, 4 Nov 2010 18:45:58 -0400
Message-ID: <20101104224557.GC8161@opensource.wolfsonmicro.com>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1288880564-31957-4-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5CF2410388B
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 23:45:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288880564-31957-4-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Thu, Nov 04, 2010 at 02:22:43PM +0000, Dimitris Papastamos wrote:

This looks really good except for the handling of unsupported register
sizes I mentioend for another patch and the fact that the LZO additions
to Kconfig probably ought to go in here.

> by using the LZO compression technique, one can get down to ~3-5kB.  There
> might be a performance penalty associated with each individual read/write
> due to decompressing/compressing the underlying cache, however that should not

I strongly suspect that there will actually be a performance penalty
associated with the (de-)compress :)  

As we discussed previously this can be mitigated against in future by
keeping the last accessed block of memory uncompressed so that we don't
need to do the LZO operations so often when doing a sequence of accesses
to the same area of the register map (this should work well during DAPM
runs since the power bits tend to all be close together, for example).
Timeouts or a different chunking algorithm could be used to reduce the
memory cost of this, though we need to be careful we don't overengineer.

> be noticeable.  The memory benefits depend on whether the target architecture
> can get rid of the memory occupied by the original register defaults cache
> which is marked as __devinitconst.

Even if it doesn't manage to get rid of the original copy there will of
course still be some memory gain as the runtime allocated register cache
will be compressed - only the size of the win will be affected, there's
no question that there will be some benefit unless the register map is
pathologic and doesn't compress.
