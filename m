From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: Re: [PATCH v2 1/5] ASoC: add mt6351 codec driver
Date: Fri, 20 Apr 2018 14:54:02 +0800
Message-ID: <1524207242.3290.19.camel@mtksdaap41>
References: <20180416003252.4177-1-kaichieh.chuang@mediatek.com>
 <20180416003252.4177-2-kaichieh.chuang@mediatek.com>
 <20180418164040.GG10061@sirena.org.uk>
 <1524103097.3290.14.camel@mtksdaap41>
 <20180419144139.GG27188@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id E7E39266CA1
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 08:54:09 +0200 (CEST)
In-Reply-To: <20180419144139.GG27188@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, chipeng.chang@mediatek.com, wsd_upstream@mediatek.com
List-Id: alsa-devel@alsa-project.org

> > the regmap is obtain from parent dev, i assume i can use
> > snd_soc_component_init_regmap() as alternative for
> > get_regmap().callback?
> 
> Yes, though you shouldn't even need to do that - the core should just
> try using the parent regmap if none is provided.

>From my experiment, the register cannot be controlled without calling
snd_soc_component_init_regmap(). ASoC didn't seems to get the parent's
regmap directly, also from code tracing.
