Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6964C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:51:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9F12465E
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QUXjpVnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9F12465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46C031615;
	Wed, 18 Dec 2019 18:50:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46C031615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576691490;
	bh=CspLSdIJTeb8zd/Q8HCvPMhC82dFXZLY2UJhb0X/fgQ=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QUXjpVnxSSQq7GOyxJU485UUe5e0cwNWBxFMicqSfbPIf8XIjYIdr4QakUD/ZmAO+
	 XprLo5yHXTZsLl1alfeVI70CSvpCReVuZEtYE+CrNLwdEtsJYZORTt4GQesrRp9ZPR
	 cKPMNXN0eV7kekOQ3mXbbItpYC1jh5siyosl4hx0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD5D2F8015A;
	Wed, 18 Dec 2019 18:50:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 716A1F8022C; Wed, 18 Dec 2019 18:50:38 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id F0320F80096
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 18:50:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0320F80096
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1309B1FB;
 Wed, 18 Dec 2019 09:50:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 856C13F67D;
 Wed, 18 Dec 2019 09:50:33 -0800 (PST)
Date: Wed, 18 Dec 2019 17:50:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Message-ID: <20191218175031.GM3219@sirena.org.uk>
References: <20191218172420.1199117-1-jbrunet@baylibre.com>
 <20191218172420.1199117-3-jbrunet@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <20191218172420.1199117-3-jbrunet@baylibre.com>
X-Cookie: Power is poison.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH 2/4] ASoC: meson: axg-fifo: add fifo depth
 to the bindings documentation
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
Content-Type: multipart/mixed; boundary="===============9147555744479039174=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============9147555744479039174==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KSyhVCl2eeZHT0Rn"
Content-Disposition: inline


--KSyhVCl2eeZHT0Rn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2019 at 06:24:18PM +0100, Jerome Brunet wrote:

> Add a new property with the depth of the fifo in bytes. This is useful
> since some instance of the fifo, even on the same SoC, may have different
> depth. The depth is useful is set some parameters of the fifo.

Can't we figure this out from the compatible strings?  They look SoC
specific (which is good).  That means we don't need to add new
properties for each quirk that separates the variants.

--KSyhVCl2eeZHT0Rn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl36ZucACgkQJNaLcl1U
h9DwRAf/XO9oHDzn1VThOJNKz5nrgTjAgtf51hmSYc2qC4bFBEPQmKXHTQJwgxhC
7Q+4EV0qC+zkHdnDBl9RM5HgwVFirK2Bq106WvVMJizoEWf0D5B2C8vp8vMhCOXA
yquL9sijTzs79Z2+/wM05/OaaQ+nrKBZpBv6IOGYYkgZ+z4x7Jp8HQ9EhPW25EsU
am8nea9rtuvWkEDskXQ541gQw38hPicim+pS37hD/BzhTstwLpU7LqnyyFq6O+OE
ZtatzXOFXvOohYrOK4yGFUnT74rg6wE6shFbq3E4NNwnRtwh9TCCpUjS43JrNOZT
DJ6vG/tnjzlofd9ok9LwVvNZ2d4xQg==
=9adF
-----END PGP SIGNATURE-----

--KSyhVCl2eeZHT0Rn--

--===============9147555744479039174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9147555744479039174==--
