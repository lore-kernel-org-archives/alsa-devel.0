Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8531C49EAB
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:49:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DEC8214B2
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QS5yGqni";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="CoarkaAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEC8214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 403671660;
	Tue, 22 Oct 2019 18:39:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 403671660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571762447;
	bh=ULDJDKyKog/i/urJ9JZfTgDrSn0QihqnrasDjU/bi5Q=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QS5yGqniFWdriBkAxlrPFX5k1Cy/RAyEIdqbxgfL43IcKDyy9vb4xQOXYIR14CNwH
	 IUMnblc6YhMzdOJ0Q4jOzZzHm7EUC12ccfx4qy7EI/yzwb7TkDv+lpw4rkFbD318qP
	 U+7UCx/yt8X8LXG03wUl0McE7EqqRKkkgulmjhyo=
Received: from vmi242170.contaboserver.net (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 552FBF802FB;
	Tue, 22 Oct 2019 18:38:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1F40F80539; Tue, 22 Oct 2019 18:38:05 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8E28F802FB
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 18:38:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8E28F802FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="CoarkaAR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9/fvYnIL7LfXM+M3n0vReAsqZf3TBvnkJHO/5fj3JO0=; b=CoarkaARHMkWh9bAgIzemxZsR
 ZvzmzF5YtXG46kMDc4mq8Elq4v2Ls1Ksi/5d0fJ6wJKXvnPpN8U2VLyNJkUidbNWi4BxmYBYFdmOF
 n65S189GFbYRke3uf//1BK3EiXaZQdS65jWEunJuTsODPGypUvSDx8gwF1rjAgkf9WshY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iMxAY-00073e-Kl; Tue, 22 Oct 2019 16:38:02 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 20D842743259; Tue, 22 Oct 2019 17:38:02 +0100 (BST)
Date: Tue, 22 Oct 2019 17:38:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191022163802.GR5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-21-arnd@arndb.de>
MIME-Version: 1.0
In-Reply-To: <20191018154201.1276638-21-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH 21/46] ARM: pxa: spitz: use gpio
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
Content-Type: multipart/mixed; boundary="===============2484943554496479563=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2484943554496479563==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jTlsQtO0VwrbBARu"
Content-Disposition: inline


--jTlsQtO0VwrbBARu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:36PM +0200, Arnd Bergmann wrote:
> The audio driver should not use a hardwired gpio number
> from the header. Change it to use a lookup table.

Acked-by: Mark Brown <broonie@kernel.org>

--jTlsQtO0VwrbBARu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vMGkACgkQJNaLcl1U
h9BZoAf/byNOVvP8AyVc+q40jXPdmEx1BeW+W+mdkphAUOlrJ8L7ofKVxME7W4jz
lCcZv3svPKXE4Tuv1b8Ua+cFGKl37CIRLQJnpXajrmm5699mqaovyUu6BZXJS9mn
jZvyjEMHS3N2WrMeIZ79cdLjPYLX4ruUhzC0F/gsKPIgHVl9Rt1eJYBGzkTuImWm
yG4Uda6MUVs46UNkpIcT2WWBf72YHWoo2uzy81R+2NX+Hsc4vx1ocJS2VJoDJWPe
yLvJBZlDtnrq1S2F1HMJaK8H86GAT1vNK6FjyrOtDQfpvdqNFCm0oTcyqpn7DvLV
CuSqfIOGxomBEe6WRIVMGaPQ9mKR+w==
=QbX5
-----END PGP SIGNATURE-----

--jTlsQtO0VwrbBARu--

--===============2484943554496479563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2484943554496479563==--
