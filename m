From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [RFC][PATCH] ASoC: cs42l73: Fix Output
 [X|A|V]SP_SCLK Sourcing Mode setting for master mode
Date: Tue, 31 Jan 2012 09:53:34 -0600
Message-ID: <alpine.DEB.2.02.1201310947070.32715@heelrod.ad.cirrus.com>
References: <1327974544.4566.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 970FF103ACB
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 16:54:41 +0100 (CET)
In-Reply-To: <1327974544.4566.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


> For master mode, set Output [X|A|V]SP_SCLK Sourcing Mode to MCLK Mode.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> Hi Brian,
> I think current code of setting priv->config[id].spc for master mode is wrong:
> priv->config[id].spc &= MCK_SCLK_64FS; will set priv->config[id].spc to be 0.
>
> I don't have this hardware, I'd appreciate you can review and test this patch.

Hey Axel,

Thanks for the catch.  Yes, for most normal slave operations where sclk = 
mclk you would set it the way you have it.

There is however another case where the SCLK = PREMCLK that puts 
constraints on the supported rates for the MCLK.  Your fix catches the 
majority of uses for Codec slave mode though.

Acked-by:Brian Austin <brian.austin@cirrus.com>
