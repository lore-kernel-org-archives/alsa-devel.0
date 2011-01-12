From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/3] ASoC: fsi/ak4642/da7210: select sound
 format from fsi-codecs
Date: Wed, 12 Jan 2011 11:12:26 +0000
Message-ID: <1294830746.3303.86.camel@odin>
References: <w3pk4iay72i.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2459A24507
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 12:12:30 +0100 (CET)
Received: by wwe15 with SMTP id 15so456682wwe.20
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 03:12:29 -0800 (PST)
In-Reply-To: <w3pk4iay72i.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-01-12 at 15:22 +0900, Kuninori Morimoto wrote:
> Dear Mark, Liam, Paul
> 
> These patches are for fsi-ak4642, fsi-da7210 to select sound format.
> 
> Kuninori Morimoto (3):
>       ASoC: ak4642: add SND_SOC_DAIFMT_FORMAT support
>       ASoC: sh: fsi: Add fsi_get_priv_frm_dai function
>       ASoC: sh: fsi: Add snd_soc_dai_set_fmt support
> 
> In current fsi-codecs, fsi format is selected from platform,
> and codecs format is selected from fsi-codecs.
> These patches modify it, and select format from fsi-codecs only.
> 
> ak4642 didn't have SND_SOC_DAIFMT_FORMAT, so 1st patch add it.
> (da7210 already have it)
> 
> These patches are tested on Ecovec, AP4EVB, Mackerel board,
> and Paul's rmobile-latest + Mark's for-2.6.38 branch.
> 
> Best regards
> --
> Kuninori Morimoto

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
