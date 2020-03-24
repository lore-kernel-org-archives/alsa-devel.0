Return-Path: <SRS0=1tVn=5J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D093BC43331
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:45:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607D220753
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H0OOHCfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607D220753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B24DD1607;
	Tue, 24 Mar 2020 14:44:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B24DD1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585057538;
	bh=eS0o/kRjog1FzGHzsXv70k3r6k3VzZc77nna9n1P+I4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H0OOHCfEGllSm07ISCowDKyxqKQLi/6Fxw+1kF88cth56ruIRVwXAW7daqBwOJd+R
	 YreAq/fqdCm81jsVxTjWlmwtg282gbtwaSdGrnnIfnlZvzg9Z1O77eGV0BomhyxkzS
	 Ci9335fwY+eT45Go5r6h8ceCFCXZceJ4KPuVFwGM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F2F1F80095;
	Tue, 24 Mar 2020 14:44:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E2C5F801F9; Tue, 24 Mar 2020 14:44:46 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id D8639F80095
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 14:44:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8639F80095
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 547291FB;
 Tue, 24 Mar 2020 06:44:42 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD68E3F52E;
 Tue, 24 Mar 2020 06:44:41 -0700 (PDT)
Date: Tue, 24 Mar 2020 13:44:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2 1/3] dt-bindings: sound: convert rockchip spdif
 bindings to yaml
Message-ID: <20200324134440.GD7039@sirena.org.uk>
References: <20200324123155.11858-1-jbx6244@gmail.com>
 <20200324133506.GC7039@sirena.org.uk> <2135168.SEOWuCda4h@diego>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <2135168.SEOWuCda4h@diego>
X-Cookie: I feel ... JUGULAR ...
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 Johan Jonker <jbx6244@gmail.com>, linux-arm-kernel@lists.infradead.org
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


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2020 at 02:39:56PM +0100, Heiko St=FCbner wrote:
> Am Dienstag, 24. M=E4rz 2020, 14:35:06 CET schrieb Mark Brown:

> > This is the second v2 you've sent of this today

> hmm at least when looking at my inbox ... I got one series for
> spdif in v2 (this one) and one for i2s in v2. And yes they do look
> somewhat identical in what they do but of course handle binding
> changes for different controllers.

Ah, this is one reason why I complain about subject lines - the
extra dt-bindings at the front hides the difference in subject lines for
me.

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl56DscACgkQJNaLcl1U
h9AX1gf/aMYAaXz2aq59CMWwQKWFUEAhfQ7OLuhs5LSFsPlUBZXUMot13HRqsiKz
uwZgsBhO7MErfMs6l85z52J7uQ56RYXkIdfdm0m0PUVVyZsUxDHMKmV6xnS3NpHm
f1COnrZDwRLRrP4qWCipkWJFRTF/9PynetTfYX456+g6aeBI7mNlO+OdY+EWis3v
lMI5+/zO0RCkIgKb3qYp4gknlqYz+1HtIgu8RBy3JaDQk1BGNP85KFxRmGPyOe2U
8H+Tu1uO9iIGgP7XAMJFsusQTC2QmPfhGH2GG9S/R2k+gZEjELOhcGtlfOl9+S+E
gpQaRpbPjoAKtCy9IPoiy6watAt2ZA==
=WwdV
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
