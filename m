Return-Path: <SRS0=P7Dr=G7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D61C43331
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 20:24:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72ACA64DFD
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jan 2021 20:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72ACA64DFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9ED691695;
	Thu, 28 Jan 2021 21:23:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9ED691695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611865482;
	bh=lbM6GwZMYRImaPta0V1n79EGw3P6kP+wV2qFO0XXCEY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bYUOP3G3BSpsUgR6K7woDqyuw+V51RxOhNmSPiOEP7PtSuTk8MeFQL/vVzDecuPNm
	 m1DsuCFAatMwziC+UTgI8D//gmWGhhMk3Qscw10C1pY1tXv74N2IpouI4oatoPNSiH
	 xrKfGCmCD64iq9ADqmuvvUoLVQID5udPqqvUkZkg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32E07F80158;
	Thu, 28 Jan 2021 21:23:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3EABDF801D8; Thu, 28 Jan 2021 21:23:50 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E450EF800BE
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2021 21:23:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E450EF800BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="L5sfIFYC"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9197E64DA1;
 Thu, 28 Jan 2021 20:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611865423;
 bh=lbM6GwZMYRImaPta0V1n79EGw3P6kP+wV2qFO0XXCEY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L5sfIFYCx19rJd1BV9wJ6fpsdueLYb5eolWLbvn9hH6LMBIDu7KHFjJlbU5SxG7Eg
 XDquLwgE5EGm5DFryKIEhaQpk2uKId4zhyQzEmGel8QtgJCMWypSGp3cvEONb57Cfn
 0OYGJ9YO7rHtHd8pSeobJOfLsYLCwtdQ11sXKno41UZa6QmypJ/NAlJ6xgEx9WpCcX
 kfGLYsMmDBZA5eZaePIxwXtSrwemRYsFEltlOX9/8n6uKy46trS2Lj5H7H7KjqSfO7
 DsqGQ5/qs+Ly/Ih+Z+49Y5LPb46GN28UmRpCKlVFrxua2xD2IbvCe859NTAmcihXrT
 Sv/6bOU6R7nbA==
Date: Thu, 28 Jan 2021 20:22:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Cleanup standard unit properties
Message-ID: <20210128202257.GG4537@sirena.org.uk>
References: <20210128194515.743252-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline
In-Reply-To: <20210128194515.743252-1-robh@kernel.org>
X-Cookie: Do not pick the flowers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-iio@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Sebastian Reichel <sre@kernel.org>, linux-i2c@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, linux-serial@vger.kernel.org,
 linux-input@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Alexandre Torgue <alexandre.torgue@st.com>,
 alsa-devel@alsa-project.org, linux-pm@vger.kernel.org,
 Wolfram Sang <wolfram@the-dreams.de>, linux-arm-kernel@lists.infradead.org,
 linux-hwmon@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jonathan Cameron <jic23@kernel.org>
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


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 28, 2021 at 01:45:15PM -0600, Rob Herring wrote:
> Properties with standard unit suffixes already have a type and don't need
> type definitions. They also default to a single entry, so 'maxItems: 1'
> can be dropped.

Acked-by: Mark Brown <broonie@kernel.org>

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmATHSAACgkQJNaLcl1U
h9AFOQf7Bk9kfd72eswvzk03qYrNzRUn/oYHBukYGABZxeJRqRFJl5+jb4FOglXo
ocmDsdb34YsgINlYHWXljMcykPaAMfuY73a3ak/VfZR83lQ985rj2tyC0DRUTBnX
spUxl6EQIUaFRmlSARZRK0iGC2QknTRzafuaIDv91uXpokCIEFw/KXY+1075TAS3
2NeAWqaaV6NGsWHAhjs3HGarXyGgMzjEPBJLWnDg996A5/3nOaUm2qNeBauScB7C
ywiZRUH9e+WMcDRKMBbOMl+au1Gx1wRzTiVtCViTII7mvweTZxqybXa6ztmKKZMS
xQFRKT7ZM6c6Jsj6z1eM+bLGwj41bA==
=Q38P
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
