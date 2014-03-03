From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8753: Remove superfluous
	'codec->cache_sync =	1'
Date: Mon, 3 Mar 2014 09:09:17 +0000
Message-ID: <20140303090917.GG8570@opensource.wolfsonmicro.com>
References: <1393678004-17427-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E557265602
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 10:09:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1393678004-17427-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 01, 2014 at 01:46:44PM +0100, Lars-Peter Clausen wrote:
> The wm8763 driver uses regmap for IO which means that codec->cache_sync is not
> used. The line was added in commit d3398ff ('ASoC: Convert WM8753 to direct
> regmap API usage'). Presumably this was meant to be regcache_mark_dirty(), but
> since we already call regcache_mark_dirty() in the core when suspending the
> CODEC it is safe to just remove the line.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
