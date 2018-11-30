From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 1/4] ASoC: audio-graph-scu-card: care
 link	/ dai count
Date: Fri, 30 Nov 2018 00:52:08 +0000
Message-ID: <875zwf1jlt.wl-kuninori.morimoto.gx@renesas.com>
References: <87bm6c30kz.wl-kuninori.morimoto.gx@renesas.com>
 <87a7lw30k9.wl-kuninori.morimoto.gx@renesas.com>
 <20181128104629.GH6828@sirena.org.uk>
 <87a7lr1kke.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400124.outbound.protection.outlook.com [40.107.140.124])
 by alsa0.perex.cz (Postfix) with ESMTP id 12E9E267B82
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2018 01:52:11 +0100 (CET)
In-Reply-To: <87a7lr1kke.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <24397C6E302F81428146029E63FEE835@jpnprd01.prod.outlook.com>
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


Hi Mark, again

> > > -static int asoc_graph_get_dais_count(struct device *dev)
> > > +static void asoc_graph_get_dais_count(struct device *dev,
> > > +				      int *link_num,
> > > +				      int *dais_num,
> > > +				      int *ccnf_num)
> > 
> > I can't tell what a "ccnf" is reading this and there's no documentation :(
> 
> It means "snd_soc_codec_conf number" -> "codec_conf number" -> "ccnf_num".
> I aligned it. I can update if it is better

I will post v2 patch which has documentation

Best regards
---
Kuninori Morimoto
