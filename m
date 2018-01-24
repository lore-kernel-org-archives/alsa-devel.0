From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 003/187] ASoC: wm0010: replace codec to
 component
Date: Wed, 24 Jan 2018 15:18:23 +0000
Message-ID: <20180124151823.vs6b6lpvohybhkfw@localhost.localdomain>
References: <87bmhzevk9.wl%kuninori.morimoto.gx@renesas.com>
 <877esnevgg.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id CA783266C0E
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 16:18:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <877esnevgg.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 12, 2018 at 01:08:19AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Now we can replace Codec to Component. Let's do it.
> 
> Note:
> 	xxx_codec_xxx()		->	xxx_component_xxx()
> 	.idle_bias_off = 1	->	.idle_bias_on = 0
> 	.ignore_pmdown_time = 0	->	.pmdown_time = 1
> 	-			->	.endianness = 1
> 	-			->	.non_legacy_dai_naming = 1
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
