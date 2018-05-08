From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 04/10] ASoC: remove unneeded .pcm_new/free
Date: Tue, 8 May 2018 12:54:09 +0100
Message-ID: <20180508115409.GQ20410@imbe.wolfsonmicro.main>
References: <87lgcurg9f.wl%kuninori.morimoto.gx@renesas.com>
 <87fu32rg5c.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 3712A266F69
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 13:54:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87fu32rg5c.wl%kuninori.morimoto.gx@renesas.com>
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

On Tue, May 08, 2018 at 03:19:49AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> commit ef050bece1b55 ("ASoC: Remove platform code now everything is
> componentised") removed platform code, but it didn't remove
> .pcm_new/free which existed only for platform.
> This patch remove these
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
