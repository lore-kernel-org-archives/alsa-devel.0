From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 15/38] ASoC: cs47l24: replace platform to
 component
Date: Wed, 24 Jan 2018 14:23:59 +0000
Message-ID: <20180124142359.hcipz24l3ymli42d@localhost.localdomain>
References: <87vag7gb9o.wl%kuninori.morimoto.gx@renesas.com>
 <87a7xjgb01.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id A1878266FE0
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 15:24:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87a7xjgb01.wl%kuninori.morimoto.gx@renesas.com>
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

On Fri, Jan 12, 2018 at 12:47:14AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Now platform can be replaced to component, let's do it.
> This patch merges cs47l24_compr_platform into soc_codec_dev_cs47l24
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

These patches look good but it looks like there are some problems with the patch:

commit 9e7e3738ab0e ("ASoC: snd_soc_component_driver has snd_compr_ops")

I have sent a patch to fix that up:

ASoC: compress: Correct handling of compressed ops

Please do have a look an let me know your thoughts.


Thanks,
Charles
