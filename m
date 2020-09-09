Return-Path: <SRS0=lIjM=CS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B82C433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:37:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38754218AC
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="N0k/jLTk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wLzlH809"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38754218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39FCC1718;
	Wed,  9 Sep 2020 17:36:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39FCC1718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599665835;
	bh=3HW7/YZpNR5PKfJypmmXKtFx2FgzoWRoaPzw05ImMYU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N0k/jLTkYottY7fUUmXnz/I8Iy+sfK1jYZjz16DzlgnSgGVvuWaccisLQZ3q4bhft
	 74XnPfEI1i14Hui8pNwmdxC1MtSJuLg8abMSuUNDaPGdj87NIjzA9HEWyuAkhcM2le
	 S2UbJYlVRiOxAoWWiYKRtaOh4ihKfc7ND7rIHsFU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD40FF8021C;
	Wed,  9 Sep 2020 17:36:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96A34F80227; Wed,  9 Sep 2020 17:36:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B2A6F8015F
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2020 17:36:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B2A6F8015F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="wLzlH809"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 00C142078E;
 Wed,  9 Sep 2020 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599665771;
 bh=3HW7/YZpNR5PKfJypmmXKtFx2FgzoWRoaPzw05ImMYU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wLzlH809IZZ8Q09B/sG7jf9PBljl6iCXX/4tdxMzMRKUtkG2wiGZR4Cc90e61dTy5
 1dUPctUxZ8MElnHsnXk2AIxOxLjiSoNmcaIMcOMyywsWtCaAc//woQfJxCoEJg7YY+
 UF4UtexqtQji6PJ8oc/lVuKjdWwKoCies9lvjLG8=
Date: Wed, 9 Sep 2020 16:35:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC] Device addition to the tlv320adcx140 and tas2562
Message-ID: <20200909153525.GF4926@sirena.org.uk>
References: <8c47c81f-5f83-2cf4-7bf1-62201b35bed3@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Content-Disposition: inline
In-Reply-To: <8c47c81f-5f83-2cf4-7bf1-62201b35bed3@ti.com>
X-Cookie: MIT:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: LKML <linux-kernel@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>
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


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2020 at 10:01:51AM -0500, Dan Murphy wrote:

> For the TLV320adcx140 driver I have another device which is register and
> bitmap compatible but it does not support Analog microphones or Line In l=
ike
> the x140.

> Should I add a new driver specifically for this part or should I add the =
new
> audio maps, widgets and controls to the existing driver?=A0 This would ma=
ke
> this existing driver really big in terms of LoC and object size.

Are they sharing anything (eg, the code is the same but the data tables
vary) or is it just two unrelated devices?

> Similar question for the TAS2562.=A0 I have a new device that is register=
 and
> bitmap compatible but removes the I/V sense. Adding this new device to the
> existing driver wouldn't be as intrusive as the x140 as the audio map and
> controls are much simpler

That definitely sounds like sharing the driver makes sense.

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Y9jwACgkQJNaLcl1U
h9BRGgf/a6zuU0wHCq5OOO1RymVVtslMfSmac1WHzxfuSkO69/NsPCzFN75Hf+aU
41aKjkomQcSwL+xAhIG5dvAKqtgxWUpJ/SmMtFT3EVIv3vwerr2aMlK25j1Im444
IJzswJ5J7U+FbLc7Ie8bs18+QX3Vnq/iRyt3tgT6sqEvlpPOQuWeS9a0WSVyYpKc
Ay6Rju4a2WzTYF5+B3XUsNZwpmlBG2UgG+thli0zqg8z/4brKGBSiethg40D6XcV
NeqLIj0x5pe2H/5T61++/KSibVi0HQZoKeUYnLwHM9am0fqxJtk4I2hFCC0d4wHS
kMEY/ad8Gny5AGUphwwmp9WxtI3XdQ==
=kQP4
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--
