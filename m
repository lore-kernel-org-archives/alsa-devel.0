Return-Path: <SRS0=v73L=ZE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F11C17441
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 19:25:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DFA21925
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 19:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BTGewmYs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="MU9UB8ho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DFA21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0E7A1614;
	Tue, 12 Nov 2019 20:16:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0E7A1614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573586226;
	bh=9A3HI4oAY7AzS4OgW/6sHL78T91Mpsw4g10cqTZBFo0=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BTGewmYsM5hxCGxfFb1P0RgDGXfEUh2JjFI5TMIZVtpR/QCkMbBCLcl5YjHqb813+
	 zEGWnLBtKZtwdY7bMYyY6OHW3zI4z5n9jIbZJSjFICUlWXgd5NWVFDVIPbsz8D2hJ9
	 l0YGtfksJbZ7qGh0TXJntvyqO+fzt+eJTFQNwzYM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 264BDF80483;
	Tue, 12 Nov 2019 20:16:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB2D7F8048F; Tue, 12 Nov 2019 20:16:14 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 463D5F8044C
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2019 20:16:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 463D5F8044C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="MU9UB8ho"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q4hg0aeHUc/0HiChQjA/soQcPBC23fuMapDnEBYN4vI=; b=MU9UB8ho0AZy5V0fVGYID74Rp
 mt/dF7+kV4HTIZEX9MU68YQcePXE+9Zh1PEuof3W0eYT6/8A3svQSN+Q+ujICa/Hd50U+209rScmT
 9n395Qjzc0DSQxilKTLTB7eeoreUzq+ZFQsgoWcU3ULjPbc6E7y2rbpw0z5qEgJmq9e4I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iUbe7-0000Bm-8y; Tue, 12 Nov 2019 19:16:11 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id C5BDD274299F; Tue, 12 Nov 2019 19:16:10 +0000 (GMT)
Date: Tue, 12 Nov 2019 19:16:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Message-ID: <20191112191610.GL5195@sirena.co.uk>
References: <20191108153538.11970-1-robh@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191108153538.11970-1-robh@kernel.org>
X-Cookie: As famous as the unknown soldier.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [alsa-devel] [PATCH] dt-bindings: vendor-prefixes: Add
 'fsi[ab]' to the list of non-vendor prefixes
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
Content-Type: multipart/mixed; boundary="===============2505166148923009121=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2505166148923009121==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aYrjF+tKt+ApYAdb"
Content-Disposition: inline


--aYrjF+tKt+ApYAdb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2019 at 09:35:38AM -0600, Rob Herring wrote:
> 'fsia' and 'fsib' property prefixes were added as schema in commit
> 2f52475bac7e ("ASoC: fsi: switch to yaml base Documentation").
> Unfortunately to do checks on actual vendor prefixes, we have to track
> the handful of prefixes which are not vendors like 'fsia' and 'fsib'.

Nobody's complained so I'll go ahead with this.

--aYrjF+tKt+ApYAdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3LBPkACgkQJNaLcl1U
h9BBCQf5AZbQ47BYpfn5IuGPdkZUTcnZn0uF1mMVQognzK3a+pVbGhSpYUtn5/Ag
KGfJZSjwfYQWUDS123xHNtjk7bY9g5FLJV4oZOJ/Fi1nKtzXabeLxRDOB/+xIV85
DMquZvoXuEFgm2PsYLjgW8/iYf/2G3GaXey7RKzU6dXTtKIKW8yy06RYReVYQntY
iMuj0VqMyU1lpwLzBJhtM2YkL2TPbiZmbHmMPrHFmIuWMdP8o732SQflkCpkmQl6
oC7Pou4LGWtQtqIjCb8xi/k853FHJUDvZEVDqoVsqBHiS+JFRWvcuTTd0KY+E+ME
I0qR8vDbsxZgrA8R59M4GfuSglZZ4A==
=WTXi
-----END PGP SIGNATURE-----

--aYrjF+tKt+ApYAdb--

--===============2505166148923009121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2505166148923009121==--
