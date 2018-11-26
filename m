From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 01/10] ASoC: soc-core: add
	snd_soc_of_parse_node_prefix()
Date: Mon, 26 Nov 2018 00:07:22 +0000
Message-ID: <87o9ac3e2l.wl-kuninori.morimoto.gx@renesas.com>
References: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
 <87zhu2lz26.wl-kuninori.morimoto.gx@renesas.com>
 <20181123135313.GH2089@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400110.outbound.protection.outlook.com [40.107.140.110])
 by alsa0.perex.cz (Postfix) with ESMTP id B12762679A7
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 01:07:25 +0100 (CET)
In-Reply-To: <20181123135313.GH2089@sirena.org.uk>
Content-Language: en-US
Content-ID: <61194A2C8B14ED43AD16F73CDF1D2603@jpnprd01.prod.outlook.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi Mark

> > +void snd_soc_of_parse_node_prefix(struct device_node *np,
> >  				   struct snd_soc_codec_conf *codec_conf,
> >  				   struct device_node *of_node,
> >  				   const char *propname);
> > +#define snd_soc_of_parse_audio_prefix(card, conf, node, name) \
> > +	snd_soc_of_parse_node_prefix((card)->dev->of_node,    \
> > +				     (conf), (node), (name))
> 
> This is basically fine but it'd be better to make this a static inline
> rather than a #define - it helps with error messages and type safety.
> I'll apply the series since otherwise this looks good, please send a
> followup patch fixing this.

OK, thanks.
Yes, I will post it soon


Best regards
---
Kuninori Morimoto
