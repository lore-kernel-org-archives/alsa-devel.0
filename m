Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25659C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jun 2022 20:28:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DFA91708;
	Tue,  7 Jun 2022 22:27:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DFA91708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654633692;
	bh=ZvOKkoNIqMpj8L6SNvIrmHvsiWA+GYoGbrPhoi+E1n8=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aqN8sgRDjehkO9Lpyycrw4uIJSKxkTHw1k5J5+SXecXsjPCw+o3skwdS29syVD0BW
	 LS5aRjLgaCncfqzkgehJ3TEzoPz0tKxmLW7Tc7uJiXXRTAbf8ViqU6nvQtfHorTMz7
	 4KrCbCCixuzT4sSV8k4rCKrvr9Hg+f1dH5ZEwSuo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0056FF800ED;
	Tue,  7 Jun 2022 22:27:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 552AFF80159; Tue,  7 Jun 2022 22:27:20 +0200 (CEST)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 619C6F800ED
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2022 22:27:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 619C6F800ED
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:243a:e14b:d107:1f56])
 by baptiste.telenet-ops.be with bizsmtp
 id gLTC2700V1qF9lr01LTCXg; Tue, 07 Jun 2022 22:27:13 +0200
Received: from geert (helo=localhost)
 by ramsan.of.borg with local-esmtp (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1nyfnE-0038Bk-D0; Tue, 07 Jun 2022 22:27:12 +0200
Date: Tue, 7 Jun 2022 22:27:12 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 6/6] ASoC: ak4613: add TDM256 support
In-Reply-To: <878rskp9l0.wl-kuninori.morimoto.gx@renesas.com>
Message-ID: <alpine.DEB.2.22.394.2206072222390.746371@ramsan.of.borg>
References: <87h778p9mx.wl-kuninori.morimoto.gx@renesas.com>
 <878rskp9l0.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

 	Hi Morimoto-san,

On Tue, 5 Apr 2022, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> AK4613 has STEREO/TDM512/TDM256/TDM128 mode.
> Renesas is the only user of ak4613 on upstream for now,
> and is using it as STEREO mode, because of board connection.
> Thus, current driver is supporting STEREO mode only, and other
> modes are not supported.
>
> But I noticed that I can try first 2ch out of TDM256 mode 8ch
> Playback even in such a situation.
>
> But because of board connection, I can't test full TDM256 mode,
> and/or other TDM mode. Thus I don't want to add new DT propaty for now.
> This patch enables TDM256 mode test by "ifdef style",
> but it has no effect to current supported STEREO mode.
> You can define AK4613_ENABLE_TDM_TEST to try TDM256 mode.
>
> Please don't hesitate to break current code if you can add full TDM256
> and/or other TDM mode. You don't need to care compatibility with Renesas.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch, which is now commit f28dbaa958fbd8fb ("ASoC:
ak4613: add TDM256 support") in v5.19-rc1.

> --- a/sound/soc/codecs/ak4613.c
> +++ b/sound/soc/codecs/ak4613.c
> @@ -645,6 +851,29 @@ static void ak4613_parse_of(struct ak4613_priv *priv,
> 		if (!of_get_property(np, prop, NULL))
> 			priv->oc |= 1 << i;
> 	}
> +
> +	/*
> +	 * enable TDM256 test
> +	 *
> +	 * !!! FIXME !!!
> +	 *
> +	 * It should be configured by DT or other way
> +	 * if it was full supported.
> +	 * But it is using ifdef style for now for test
> +	 * purpose.
> +	 */
> +#if defined(AK4613_ENABLE_TDM_TEST)
> +	AK4613_CONFIG_SET(priv, MODE_TDM256);
> +#endif
> +
> +	/*
> +	 * connected STDI
> +	 */
> +	sdti_num = of_graph_get_endpoint_count(np);
> +	if (WARN_ON((sdti_num > 3) || (sdti_num < 1)))

This WARN_ON() is triggered on Ebisu-4D, as sdti_num = 0.
It can be reproduced by booting renesas-devel-2022-06-07-v5.19-rc1
using renesas_defconfig.

Sorry for not noticing before.

> +		return;
> +
> +	AK4613_CONFIG_SDTI_set(priv, sdti_num);
> }
>
> static int ak4613_i2c_probe(struct i2c_client *i2c,

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
