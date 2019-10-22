Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5929C47E49
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:49:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD432184C
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="p36YliBW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="eujbdbr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD432184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DD931697;
	Tue, 22 Oct 2019 18:39:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DD931697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571762404;
	bh=yu/OOBwyuLefVTHmd6WmFh9vcjZ/yzKHTbwdahPNrmM=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p36YliBW7TZStjyGQbYT+oiFDOnwaYOJpv7K43rGTJ6SyL8XG7/EpJgWnyz20wzXL
	 apohXf85n7Eby2d1Nh9v/qUMZEkAYkenBKpwFWs0KnAf4DaiuGVs6BNuXMKtKtEN5e
	 7HCQ5jQKI/444xqitPiGtXUO5aW0N6XhcIuJqB3A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1DBAF80634;
	Tue, 22 Oct 2019 18:37:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56F9CF80635; Tue, 22 Oct 2019 18:37:51 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3A71F80612
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 18:37:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3A71F80612
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="eujbdbr8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yEWjUh9HRZLx9XZTRlNwU0IyHfWYaOjUVBl6LKXoSGg=; b=eujbdbr8i14aLx7d16qzSg84a
 Fy/kXsYQnk8/XUTrW2u/qw/hMLvFjm4w0Q7lg5KpxbaI0CCxIsw/f0PdaQNCOdA7TGUyxoYsIrW1R
 JoNZO8dYJgUf5Adtu5cTcRIOQ7VA6XlRBx1INaHuA17pBD98PhJGENc8UqV4BbNuFsTDo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iMxAK-00073S-Fl; Tue, 22 Oct 2019 16:37:48 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id ED5112743259; Tue, 22 Oct 2019 17:37:47 +0100 (BST)
Date: Tue, 22 Oct 2019 17:37:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191022163747.GQ5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-19-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20191018154201.1276638-19-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Daniel Mack <daniel@zonque.org>, Philipp Zabel <philipp.zabel@gmail.com>,
 Paul Parsons <lost.distance@yahoo.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH 19/46] ARM: pxa: hx4700: use gpio
	descriptors for audio
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
Content-Type: multipart/mixed; boundary="===============8183527616425858271=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============8183527616425858271==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lG9v85r552aFjg4G"
Content-Disposition: inline


--lG9v85r552aFjg4G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:34PM +0200, Arnd Bergmann wrote:
> The audio driver should not use a hardwired gpio number
> from the header. Change it to use a lookup table.

Acked-by: Mark Brown <broonie@kernel.org>

--lG9v85r552aFjg4G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vMFsACgkQJNaLcl1U
h9AyrAf+PEou8xICUpA4tJXD4/V65hYlHwHijqpdDNIb8z17mM77HkKGZt59II8h
yPCGMI+KNeqAj3bhR7kC6pGAdJ0O2EPBV27wvfg7qdsZ4tTLkKDKRpU+Ub3BawaV
Y+hcM8ovqmbJV9E/1jiwUl29KVvbCbMSjupVbL8YpxA5uK4hLUfPi2W0fuC92wxB
riKv3rnc0+qfsjc2nZBAQ+A16BA6pQZYOi62Nk8aTosPva2zP6kIPXjwnRmKahZw
gfsjwsHCKgOA4qu1FQSNkw/p/D1SFXSl5Y9CVT4SZoJhJSBQ7sE7UsxiV/+2cd8g
dq6oYdPGaAueZLaZTJz0Xru8jPwafQ==
=hKIE
-----END PGP SIGNATURE-----

--lG9v85r552aFjg4G--

--===============8183527616425858271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8183527616425858271==--
