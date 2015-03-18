From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 03/12 v2] ASoC: rsnd-dpcm-card: add Renesas
 sound card support for DPCM
Date: Wed, 18 Mar 2015 10:05:57 +0100
Message-ID: <55093FF5.5040201@metafoo.de>
References: <87egopk13d.wl%kuninori.morimoto.gx@renesas.com>
 <87a8zdk0tx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-133.synserver.de (smtp-out-145.synserver.de
 [212.40.185.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 17702260496
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 10:05:49 +0100 (CET)
In-Reply-To: <87a8zdk0tx.wl%kuninori.morimoto.gx@renesas.com>
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

On 03/16/2015 05:45 AM, Kuninori Morimoto wrote:
> +sound {
> +	compatible = "renesas-dpcm-audio-card";

dpcm is a software component, the devicetree should describe the hardware.

> +
> +	card-name = "rsnd-ak4643";
> +	format = "left_j";
> +	bitclock-master = <&sndcodec>;
> +	frame-master = <&sndcodec>;
> +
> +	routing = "ak4642-hifi Playback", "DAI0 Playback",
> +		  "DAI0 Capture", "ak4642-hifi Capture";

This does not belong into the devicetree. These strings are all Linux driver 
specific.
[...]
