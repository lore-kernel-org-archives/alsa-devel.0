Return-Path: <SRS0=ibvm=M4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA1CC4338F
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Aug 2021 12:53:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A7861131
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Aug 2021 12:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 07A7861131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC2ED167F;
	Thu,  5 Aug 2021 14:52:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC2ED167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628168015;
	bh=BotLa/qCp/WK5A6oJf7nn0iSax5CkRIrOB/F0LqkEdQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ghupU9Qt/otaMHVAuwcAe226cFBSkdZz10kFvfp3uelCVU354Of+v0bb7cnuBf+6P
	 Q1jXsGwkJKlON4ge/8sHvg5akFtMwhF7FD8feyNRuknUql1pfpT2jglip7LuPnEFNI
	 6rb2W4GG3wss2TeCTF+1EA/79HK2s7qPHSCb8syI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59226F8016D;
	Thu,  5 Aug 2021 14:52:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA596F802E8; Thu,  5 Aug 2021 14:52:38 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A5D2F8014D
 for <alsa-devel@alsa-project.org>; Thu,  5 Aug 2021 14:52:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A5D2F8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DYfjxYeV"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D42260720;
 Thu,  5 Aug 2021 12:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628167952;
 bh=BotLa/qCp/WK5A6oJf7nn0iSax5CkRIrOB/F0LqkEdQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DYfjxYeVpOP8LO8Tiic0T1htU7zl48gCCwiD71n+dvYGLUi3RWbuy1JfbdrIL7DpW
 39sv8Dl9Sc7ZobmG5OqU/YACvqmq4G0k21v73Jprkm65yDlJA5hp6Fd3hfjJ+WdnKy
 sDtvX0fF2TyExxIfbIaJ9m3kaxl6ZbS0eDQRTNUqMqFmrZuTzLoqcwLu/ImxEWQtZS
 Lvj4TOdGpjywsmnzKi4PBs8D8k+I3UhxL/us7v2wQD/GBIBWKM/JrSukLhJ0njnyz3
 snw5YFcwXEcJ6mVw6+ttuGGTW0eqM31CsGxL7NKs539Ps5SgQMI5XX1vvLwK2qwxNw
 BixSy7fr2lbfg==
Date: Thu, 5 Aug 2021 13:52:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v2 09/14] ASoC: audio-graph-card2: add Yaml Document
Message-ID: <20210805125216.GN26252@sirena.org.uk>
References: <87wnplvk2a.wl-kuninori.morimoto.gx@renesas.com>
 <CAL_JsqJKZ-sjbnihAkdXDk4tW8xVmyhwkHLHWouZg6da0cc99g@mail.gmail.com>
 <87lf60v9xk.wl-kuninori.morimoto.gx@renesas.com>
 <20210721115433.GB4259@sirena.org.uk>
 <87fsw124wn.wl-kuninori.morimoto.gx@renesas.com>
 <20210803165328.GO4668@sirena.org.uk>
 <87mtpyuj8c.wl-kuninori.morimoto.gx@renesas.com>
 <20210804171748.GC26252@sirena.org.uk>
 <875ywkvkkd.wl-kuninori.morimoto.gx@renesas.com>
 <874kc4vkdl.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WU3I8Do+sziGY3UL"
Content-Disposition: inline
In-Reply-To: <874kc4vkdl.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: MOUNT TAPE U1439 ON B3, NO RING
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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


--WU3I8Do+sziGY3UL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 05, 2021 at 08:51:50AM +0900, Kuninori Morimoto wrote:

> I will take Summer Vacation from tomorrow in 1 week.
> I'm sorry for my long term no respoce then.

No worries, thanks for all your hard work on this so far and please
enjoy your vacation!

--WU3I8Do+sziGY3UL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEL3v8ACgkQJNaLcl1U
h9Dfbwf/dB7/drOFm2OQqzSgsVPPLTvF1fGTrSoWsARl9YfSxQwxdV/lLC+hkYSI
42FAqavXEw8JoLQoj3TD8CQIy3RllPZ9i4vYsKy0dGXG01SPzAomwYeEGDsIuz4K
qmnAlW/ShD1KxPvImTldgJ38/i34xLAYFj2gJR+bPhQU3lzrhyEs2ARFaSRS4lGt
YyGRWRZVU6JBPuKfI2PYvzbLSobZO2bcWGZuBRfy6FLhmAk2FBHSnYO1v7Sla4SN
Re2Q76T8rSFRoBiiPwRx3qgXFBlJpZ/nTI8MxxKZLUKSzJuzrGQqkO5WhbP3E2oX
qRpXd8vIXueMErabfBFIMpIYyOYXaw==
=8qXE
-----END PGP SIGNATURE-----

--WU3I8Do+sziGY3UL--
