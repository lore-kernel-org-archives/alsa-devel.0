From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC: soc-cache: Add support for LZO
 register caching
Date: Fri, 5 Nov 2010 09:33:50 -0400
Message-ID: <20101105133349.GI13709@opensource.wolfsonmicro.com>
References: <1288880564-31957-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1288880564-31957-4-git-send-email-dp@opensource.wolfsonmicro.com>
	<20101104224557.GC8161@opensource.wolfsonmicro.com>
	<1288952551.8256.19.camel@dplaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D1483103960
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 14:33:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288952551.8256.19.camel@dplaptop>
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

On Fri, Nov 05, 2010 at 10:22:31AM +0000, Dimitris Papastamos wrote:

> Yes that's the idea.  I was also thinking, that during sync() we can
> have another flag like cache_bypass which would be set so when we are
> writing out the cache to the hardware, we don't write back to the
> cache again.

Yeah, though if we do the thing with keeping the last page uncompressed
that'd get the overwhelming bulk of that anyway.
