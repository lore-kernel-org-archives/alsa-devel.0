From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 01/12 v2] ASoC: core: remove
 of_xlate_dai_name from snd_soc_component_driver
Date: Wed, 18 Mar 2015 10:03:12 +0100
Message-ID: <55093F50.5040706@metafoo.de>
References: <87egopk13d.wl%kuninori.morimoto.gx@renesas.com>
 <87d249k0ut.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-133.synserver.de (smtp-out-145.synserver.de
 [212.40.185.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 842FA2604DF
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 10:03:00 +0100 (CET)
In-Reply-To: <87d249k0ut.wl%kuninori.morimoto.gx@renesas.com>
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

On 03/16/2015 05:44 AM, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> No one is using .of_xlate_dai_name for DT,
> Let's remove it.

I'd prefer to keep this, there will probably be user for it eventually.
