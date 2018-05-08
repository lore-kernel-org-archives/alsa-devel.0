From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 02/10] ASoC: remove codec reg_cache
Date: Tue, 8 May 2018 12:51:45 +0100
Message-ID: <20180508115145.GO20410@imbe.wolfsonmicro.main>
References: <87lgcurg9f.wl%kuninori.morimoto.gx@renesas.com>
 <87in7yrg7c.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 40775266F69
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 13:51:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87in7yrg7c.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 08, 2018 at 03:18:38AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Codec reg_cache is legacy feature, almost all driver are now using
> common regmap, and very few driver had been used this legacy feature.
> Because of this background, it is now implemented on each
> driver internally now.
> So now, no one is using codec reg_cache. Let's remove it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
