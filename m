Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766A0C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 11:23:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0CE6103B
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 11:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF0CE6103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CC8C18B1;
	Thu, 16 Sep 2021 13:22:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CC8C18B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631791398;
	bh=hkZogoYNPdYEtUjvYmWScZnXUuf2kqU4pXAbkQUNBO0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TobUDwrJpA0haAPwW/UzMNgms+TR4Ju5qMaHB+OO3+KIhv9jZbWy7YaYLGv8BmoPB
	 Etrwutgrr0A4V6cuk50XPjn+v6pRpx1N3oUqRms3Okb4VbG+kpgH+j8n0cC3nJPq35
	 9N2FcZUxKg6KiR//cXa6z9SmMkaeHCxTvJfjAZZ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BBBFF8025A;
	Thu, 16 Sep 2021 13:20:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0467AF80271; Thu, 16 Sep 2021 13:20:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5375F8025A
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 13:19:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5375F8025A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XG8Tfc7o"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B8C761279;
 Thu, 16 Sep 2021 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631791197;
 bh=hkZogoYNPdYEtUjvYmWScZnXUuf2kqU4pXAbkQUNBO0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XG8Tfc7onQvd2XyZMTAZ/HhFjxz7fUBZIWzDGZeDEFEQ+JBkULgs90G2RkcqhYhdT
 FGUhY7ievLcyjv0rrS5mjFT0Fe+rSMK8Y2bJlU+j27Z8dULF0qG2ViDgYlQxdJQoPd
 ZzeVR60GzeTeRKolRbZYgifIexM4zRzGSLmhsWDuMeMRCyQ9MHw8z4po6yF+8Zn18W
 XOS/i5a/mH+pzQ2xtKFiI0zldFGcj2gN5yZJWyxR4v7VR2PjKxM3VbD2oRnZzG5E6J
 JgmBxQWmzxAdqz/ulkHXFIoMmqqqt8/yvPxvjQPDts4ZndELMsn+Eja18gJQpjeL+I
 FhfeBMTtzpohg==
Date: Thu, 16 Sep 2021 12:19:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: Re: [PATCH v1 0/1] ASoC: cs42l42: Implement Manual Type detection as
 fallback
Message-ID: <20210916111916.GA5048@sirena.org.uk>
References: <20210916102750.9212-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20210916102750.9212-1-vitalyr@opensource.cirrus.com>
X-Cookie: We've upped our standards, so up yours!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
 James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>, linux-kernel@vger.kernel.org
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


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 16, 2021 at 11:27:49AM +0100, Vitaly Rodionov wrote:
> For some headsets CS42L42 autodetect mode is not working correctly.=20
> They will be detected as unknown types or as headphones. According=20
> to the CS42L42 datasheet, if the headset autodetect failed,
> then the driver should switch to manual mode and perform a manual steps s=
equence.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFDKDMACgkQJNaLcl1U
h9Cg0wf/ZsdUfPPGnZrzV/JsuLORkQwmvOzzohe6dj+8bh0wk8j8oRhC7yzFw/mU
a9qvBLRTH1/8MFoEKfkb+kcHVYxscEyKhtNATEafbmJLznUziZmHPYTokvdhROSK
ZzGbDi+bF+NoyMTWoYwEdvze9PVBDLqb4cEZGC8EUHC9TiS/oLN1rPtPWP8lReuR
Q3E9jHfURI8F6rbIaJxRiSckYnSWR5X/0BlTeW/rckVq1kQY7Ng/ym/dbLdsr9s4
LaIQ8ibQ2kBUV5xynK2fhnvO/uLk9b2ydBniwd5jgcu/g9wtljPwAkTs/aNmOLu2
9C+YyScgVKLycZHwu1cfT+y4cfpOyA==
=IgJP
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
