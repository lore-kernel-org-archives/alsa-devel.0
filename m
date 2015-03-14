From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 04/13] ASoC: dapm: add driver prefix
 matching for snd_soc_dapm_add_route()
Date: Sat, 14 Mar 2015 13:19:56 +0100
Message-ID: <5504276C.4050503@metafoo.de>
References: <874mppsngc.wl%kuninori.morimoto.gx@renesas.com>
 <87wq2lr8s8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-169.synserver.de (smtp-out-170.synserver.de
 [212.40.185.170])
 by alsa0.perex.cz (Postfix) with ESMTP id C09342605D3
 for <alsa-devel@alsa-project.org>; Sat, 14 Mar 2015 13:19:49 +0100 (CET)
In-Reply-To: <87wq2lr8s8.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, shiiba <naoya.shiiba.nx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Das Biju <biju.das@bp.renesas.com>
List-Id: alsa-devel@alsa-project.org

On 03/13/2015 02:22 AM, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current DAPM will lost correct route settings if some CPU/Codec was using
> same stream name, and it will be problem when DPCM case.
> For example, stream name of Renesas sound drver / ak4642 / dummy for DPCM
> have same name as "Playback", like below
>
> FE CPU   (rsnd):   "DAI0 Playback"
>     Codec (dummy):  "Playback"
>
> BE CPU   (dummy):  "Playback"
>     Codec (ak4642): "Playback"
>
> Then, "Playback" - "DAI0 Playback" can't match correctly. This patch adds
> "driver name" prefix for this case.
> We can use "ak4642-hifi Playback" - "DAI0 Playback" here.

Hi,

There is already a prefix mechanism to handle this. If you have widgets with 
the same name in different contexts you can use the snd_soc_codec_conf 
struct and set the name_prefix field to assign a unique prefix to each context.

- Lars
