From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC: soc-cache: Add support for LZO
 register caching
Date: Fri, 05 Nov 2010 10:22:31 +0000
Message-ID: <1288952551.8256.19.camel@dplaptop>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1288880564-31957-4-git-send-email-dp@opensource.wolfsonmicro.com>
	<20101104224557.GC8161@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7479E243AC
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 11:22:32 +0100 (CET)
In-Reply-To: <20101104224557.GC8161@opensource.wolfsonmicro.com>
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

On Thu, 2010-11-04 at 18:45 -0400, Mark Brown wrote:

> As we discussed previously this can be mitigated against in future by
> keeping the last accessed block of memory uncompressed so that we don't
> need to do the LZO operations so often when doing a sequence of accesses
> to the same area of the register map (this should work well during DAPM
> runs since the power bits tend to all be close together, for example).
> Timeouts or a different chunking algorithm could be used to reduce the
> memory cost of this, though we need to be careful we don't overengineer.

Yes that's the idea.  I was also thinking, that during sync() we can
have another flag like cache_bypass which would be set so when we are
writing out the cache to the hardware, we don't write back to the
cache again.

Thanks,
Dimitrios
