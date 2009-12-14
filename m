From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question about snd_soc_8_8_write
Date: Mon, 14 Dec 2009 11:36:24 +0000
Message-ID: <20091214113624.GC21066@rakim.wolfsonmicro.main>
References: <upr6ich4h.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B3DF62435D
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 12:36:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <upr6ich4h.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 14, 2009 at 01:30:06PM +0900, Kuninori Morimoto wrote:

> I wounder this behavior.

> if reg >= codec->reg_cache_size,
> this functions will call hw_write
> though cache[xx] ignore it.

That's there because there were a few devices which chose to cache only
a subset of their registers.  Usually this is because there are some
extra partially documented registers at the end of the map and a lack of
documented default values makes using the cache tricky.

> even though if reg < codec->reg_cache_size,
> if hw_write return error, cache[xx] value was still changed.

> This is correct behavior ?
> Or are there any reason ?

The error handling for failed writes isn't massively good.  It's not
always entirely clear if the best thing to do is to cache the result and
hope that things work next time; for the most part if I/O starts failing
the problem is usually
