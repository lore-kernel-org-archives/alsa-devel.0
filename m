Return-Path: <SRS0=y4EY=CX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32E0C433E2
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:58:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A0620829
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oEZ4k/rc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMgC1upo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A0620829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7225C1690;
	Mon, 14 Sep 2020 16:57:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7225C1690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600095507;
	bh=KWJqdkCZgyPNohCJGNbpJs+BDsJjwqiEDY4HQiidrKA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oEZ4k/rc5TfhKbF70z213PGVYeUPXqfg14mSudnIKskdoTh7wH6y4YyHEYrjOUqzt
	 vTH1jKREyykxjrEsNzy2stzI2iHKq22s18d2AXSbNwVVKsWKYHQ7pJYpVcRPri38xI
	 fR2bC36upL9rDi41bKzCo5V9wjaeoRtipok2Po1A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6EB09F8015D;
	Mon, 14 Sep 2020 16:56:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 874CAF801F7; Mon, 14 Sep 2020 16:56:02 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AAF1CF80150
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2020 16:55:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AAF1CF80150
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nMgC1upo"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A4152206BE;
 Mon, 14 Sep 2020 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600095355;
 bh=KWJqdkCZgyPNohCJGNbpJs+BDsJjwqiEDY4HQiidrKA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nMgC1upoTFCiy5eHK/tlQaqhKy3LYIebNGb4AsZoIG0TZg+BAQvAmGQSGZG+lYuJj
 R1W9ZAwpOQPRg47m0w8k0XP4gtIL96YXA57/PFPOVgY9yPKoaZryyww5EY6CqzBE6a
 nWbqPjP5tT8Lapr348vslBaMpk9/fJh09rj592pg=
Date: Mon, 14 Sep 2020 15:55:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Chanho Park <parkch98@gmail.com>
Subject: Re: [PATCH] ASoC: tas6424: disable regulators when probe error
Message-ID: <20200914145506.GF4821@sirena.org.uk>
References: <20200912023151.213930-1-chanho61.park@samsung.com>
 <20200914112709.GA4821@sirena.org.uk>
 <CAPTzV144n2z--Us6OpK-FKb64Bsz+x+CQu1HiBDr2XHETQmTvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline
In-Reply-To: <CAPTzV144n2z--Us6OpK-FKb64Bsz+x+CQu1HiBDr2XHETQmTvw@mail.gmail.com>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, Chanho Park <chanho61.park@samsung.com>,
 dannenberg@ti.com
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


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 14, 2020 at 11:52:15PM +0900, Chanho Park wrote:
> On Mon, Sep 14, 2020 at 8:27 PM Mark Brown <broonie@kernel.org> wrote:

> > Please think hard before including complete backtraces in upstream
> > reports, they are very large and contain almost no useful information
> > relative to their size so often obscure the relevant content in your
> > message. If part of the backtrace is usefully illustrative (it often is
> > for search engines if nothing else) then it's usually better to pull out
> > the relevant sections.

> Thanks for your suggestion.
> I'll respin this patch without the call stack messages.

It's fine, I've already applied it - just please bear this in mind for
future things.

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9fhEkACgkQJNaLcl1U
h9AtNQf9HgxmzZxTVQlfjBNeFM5yBqURDHqgtUJbisZOOpjn+VX48uJl8byD0z4I
6IEUlXwCEAg4WXDF7PgnKXmG3hkmLCDfYkJtkcU2qjgNgDxDsa59javXplzGs+oV
a8chwo357spK9SogK4HAHe2nizTi3w5g9S29X70i4bIStGAbZOAcAlAT1JgCA09W
Mv7H2gmhxr8cffv+OQ31/Jy/PbeIc0zEgXDEZsrGi/zE5mcKdVelPUf7PnO20zra
zJU0mDXZogBMQCrTXPSr+qCjhUGPVAHsk/Pxa9PoymvJ/6e2EYUehu/VcHXdD6UR
R6HSvX6mo5dJtvQptcF2oqjNnaKXJg==
=s88B
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--
