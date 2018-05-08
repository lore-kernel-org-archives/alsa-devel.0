From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 10/10] ASoC: soc-core: remove
 legacy_dai_naming from snd_soc_register_dais()
Date: Tue, 8 May 2018 13:38:54 +0100
Message-ID: <20180508123854.GW20410@imbe.wolfsonmicro.main>
References: <87lgcurg9f.wl%kuninori.morimoto.gx@renesas.com>
 <877eoerg01.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id ADE3F2676CE
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 14:38:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <877eoerg01.wl%kuninori.morimoto.gx@renesas.com>
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

On Tue, May 08, 2018 at 03:23:01AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> We can get legacy dai name flag from component driver.
> Thus, there is no need to have its parameter on snd_soc_register_dais().
> Let's remove unneeded parameter
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
