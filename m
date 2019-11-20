Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B75DC432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:17:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5EE208C3
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RFHOX828"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5EE208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFC9716FF;
	Wed, 20 Nov 2019 18:16:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFC9716FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574270229;
	bh=ijrQPcbzlT5NF/eDcqxiKvSbRYD5HgnpvT0Gs3xf5vg=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RFHOX828yMT5+oAmzkc2a9W9qP+TKG6kr11rNTOVVFxB9r/Vb2Emwp744E4xRqgIf
	 67HADola4Djfzx/bm2uBGj8ZiH1jvIG/y8h7QxU0OX3eRDcQrVTFtA+zVgtWuiJ9GI
	 cJicechLguU9MjVO9lcrMQu6r9eSLTx1dpDhuhdU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 223ECF8013C;
	Wed, 20 Nov 2019 18:16:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A68CF8013D; Wed, 20 Nov 2019 18:16:17 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 651DFF800FF
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 18:16:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 651DFF800FF
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 116AE1FB;
 Wed, 20 Nov 2019 09:16:12 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82B343F703;
 Wed, 20 Nov 2019 09:16:11 -0800 (PST)
Date: Wed, 20 Nov 2019 17:16:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Message-ID: <20191120171609.GB5705@sirena.org.uk>
References: <20191120060844.224607-1-tzungbi@google.com>
 <20191120060844.224607-3-tzungbi@google.com>
MIME-Version: 1.0
In-Reply-To: <20191120060844.224607-3-tzungbi@google.com>
X-Cookie: Best if used before date on carton.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, dgreid@google.com, cychiang@google.com
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: max98090: save and restore SHDN
 when changing sensitive registers
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
Content-Type: multipart/mixed; boundary="===============1426483883964284124=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============1426483883964284124==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 20, 2019 at 02:08:44PM +0800, Tzung-Bi Shih wrote:
> According to the datasheet, there are some registers can only be changed
> when SHDN is 0.  Chaning these settings during SHDN = 1 can compromise
> device stability and performance specifications.

This doesn't apply against current code, please check and resend.

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3VdNkACgkQJNaLcl1U
h9AB1gf6A8Kv/6joSm8eQOdj0uGXJfFgEGVLx3agP1UAMIaJ4dJ4Ss/F9wyLylOT
RpA/Wudc6usgxo+7Nd+KlGkuXgFkRai8uqNoKIfisrBaw5W9jbiyslOg5l/gCWS7
N4tCzY+qZqdA6hFzXR1pXPgfPjgY9Lk+aNpErtl0KBx5dEGUUcrCPOeIl/gHQKiM
oNG6oDsa62ImFxJyf1N+Laj+x0OHHVzFdW+qymzbXGgOk5pjcb4yBfB0VdtgLZ6L
tIW+3rMZRmURRe3ecGnxFgkawmETpeOPt81sWdrFXXfE56A1EmuarJgBF7rwLQ0X
zCWu9qgXz2wG+0IKT15PfpbNSIfFfw==
=Dvgx
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--

--===============1426483883964284124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1426483883964284124==--
