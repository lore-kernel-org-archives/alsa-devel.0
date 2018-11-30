From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 1/4] ASoC: audio-graph-scu-card: care link
	/ dai count
Date: Fri, 30 Nov 2018 00:31:28 +0000
Message-ID: <87a7lr1kke.wl-kuninori.morimoto.gx@renesas.com>
References: <87bm6c30kz.wl-kuninori.morimoto.gx@renesas.com>
 <87a7lw30k9.wl-kuninori.morimoto.gx@renesas.com>
 <20181128104629.GH6828@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400108.outbound.protection.outlook.com [40.107.140.108])
 by alsa0.perex.cz (Postfix) with ESMTP id BBA55267B82
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2018 01:31:32 +0100 (CET)
In-Reply-To: <20181128104629.GH6828@sirena.org.uk>
Content-Language: en-US
Content-ID: <12A88F4819CFB84885A24027B900D81F@jpnprd01.prod.outlook.com>
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

> > -static int asoc_graph_get_dais_count(struct device *dev)
> > +static void asoc_graph_get_dais_count(struct device *dev,
> > +				      int *link_num,
> > +				      int *dais_num,
> > +				      int *ccnf_num)
> 
> I can't tell what a "ccnf" is reading this and there's no documentation :(

It means "snd_soc_codec_conf number" -> "codec_conf number" -> "ccnf_num".
I aligned it. I can update if it is better

Best regards
---
Kuninori Morimoto
