Return-Path: <SRS0=TlZm=FT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC309C4361B
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 13:01:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02BC2246B
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 13:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02BC2246B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2CA2C172D;
	Tue, 15 Dec 2020 14:00:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2CA2C172D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608037291;
	bh=fDiP7ilApLHaKkbPhxkJs3BwaJy+ICOzNNwrseuWDDQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bMPXo0Xfh0+NA0oh7tQWZGMmXZ6eu5r0NXvZcaVgAsbXVT98LhDlxo9KXCXW0+7Nn
	 piwl0CoIAS4QqNUwtDWvLmzNEqUyCNrhE+bLRZx+mU8d2pIsJ6WciYC7qcOHduH9BT
	 27gW/JKkQfyPEvnHDFvTr4lJFu2PnXzuikM8MfKo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B35FFF80259;
	Tue, 15 Dec 2020 14:00:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35ABFF80278; Tue, 15 Dec 2020 14:00:39 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE17DF8014B
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2020 14:00:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE17DF8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="igylZFgu"
Date: Tue, 15 Dec 2020 13:00:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608037233;
 bh=fDiP7ilApLHaKkbPhxkJs3BwaJy+ICOzNNwrseuWDDQ=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=igylZFgutp+6ZB0uy7rkm5KPCGAKGCZ3mZ7wmryn8yElieFXFV6sfnel/Cz2/SXqb
 wVQLyLa5IxVG5Y1PuFhaH9N543ogMHakK69qg9PQ+PeykMYouz5iCpi+gD/w/Fk1Po
 IKjH40Ne5hYN0an/elbKmglXRdAddDvi4CYsJM8cLnOoZg56Ap0HTe0oHa55pGFYvu
 sKwEMVM52gRNnoc8m85BwOiTpJnxYjPrc8Fd0LBqAq0k609+tCZSJsVb44grJZeO4u
 gjiE2QIjDnaU2K2pjlAfuu1w3/3WeA5tp665NLBMS8DDdrypBh3+CLDLCjTSUpA8xh
 niVQhMC+fXB/g==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH][RFC] ASoC: rsnd: don't call clk_disable_unprepare() if
 can't use
Message-ID: <20201215130021.GC4738@sirena.org.uk>
References: <CAMuHMdWvB+p=2JqTsO7bR8uJqKqO5A2XgXFXsVAjHk3hcxgcTw@mail.gmail.com>
 <87v9d4gcqt.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <87v9d4gcqt.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: In specially marked packages only.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
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


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 15, 2020 at 09:06:05AM +0900, Kuninori Morimoto wrote:

> -			adg->clk_rate[i] = clk_get_rate(adg->clk[i]);
> +			if (ret < 0)
> +				dev_warn(dev, "can't use clk %d\n", i);
> +			else
> +				adg->clk_rate[i] = clk_get_rate(adg->clk[i]);

We never reset adg->clk_rate[i] so if we use the clock once then get an
error attempting to use it again...

>  		} else {
> -			clk_disable_unprepare(clk);
> +			if (adg->clk_rate[i])
> +				clk_disable_unprepare(clk);

...we'll try to disable twice.  This was already an issue of course, not
something introduced in this patch.

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/Ys2QACgkQJNaLcl1U
h9DL3gf+LbNAoq+ie6MXE724oAYdw14gdhZfxkEnqHxElgGxZvKK4DzEZl6tGfvw
pfaEOw057v0Jd+6M7/EgbVW+FEMMHkyrb9HJrsAaQJyBnKE8KreAqVCcsHuCIqGA
z5qEphd6k9vzNByer4Rs+Lo8AAnNSLvEgKDfPjAVyJNOTJjR+C6JbCf/LrXU5u+s
tuar+WbDmCTjX5mRPOqE2jyWt85IL5TFNnEegN80uYwXgpdBoIq25oFOgbzqP9Pg
rW/6/xhRsUQ+WeyBfZrNCxpg0kgQt69OmqfG8uVniwUF0W2BAiYlG8jq46n6CAIB
bzkkTuu/1Sh9yjRVkt9OIcQCjYvt6w==
=B+vF
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
