Return-Path: <SRS0=gvoF=NC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A92C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Aug 2021 11:59:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D5D60FDA
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Aug 2021 11:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7D5D60FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2C33174C;
	Wed, 11 Aug 2021 13:58:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2C33174C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628683146;
	bh=0W1oz8lScdiIK+06zsWCrOVPU0oQhVo9FL7Ek66DVtM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vS19G5+TyYFqcEU+B/renOzTzqnRadANDp7qtrnQOBmk6TFmJK5FxBjePvYU2+HOu
	 7QgBXpYoMhwZwA1hJG/AFWA6Mdvroqx+xnlcLvBgxnCVoF/df724UzgL5llbt10JXT
	 UOfWUUHh3gLvp0VwS+JV6Fk81etdfAu2rTPA8SYs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 47AFEF8020D;
	Wed, 11 Aug 2021 13:58:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53B80F804B0; Wed, 11 Aug 2021 13:58:14 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B028AF80148
 for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2021 13:58:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B028AF80148
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kioHtZVt"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 875D960E52;
 Wed, 11 Aug 2021 11:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628683084;
 bh=0W1oz8lScdiIK+06zsWCrOVPU0oQhVo9FL7Ek66DVtM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kioHtZVtmlCsxxmL16BUvs2uDbIDLH78hFbzU1A7weExd3DtJcNXUzW22OK5m4G+Q
 Zn3nxqgv/nxKde42SfEYIClEm3fbpuAv7PxHon6r8OhXzFg9GHD0LV0QR3MdC5pQEG
 Hh9W9/dHAKvCZ9zwluYMQext8gwl7GQTicaPLeesT5hMyftwRT2AErOKNI2d7HvvIY
 47Kkol+xAQoi4hrTn8/RLtVyoYYzjgiHVQtqoEGNnmHQbsmVPJmNOH2r+5/KkdlGPz
 ZFw6JCTxMuAbJCtLCaq+1/AAN0ahpJR81eVGp9tFHoPkAjHL//faF9XLvZNpSuUJ2D
 /JMYFOsGT6T6Q==
Date: Wed, 11 Aug 2021 12:57:45 +0100
From: Mark Brown <broonie@kernel.org>
To: derek.fang@realtek.com
Subject: Re: [PATCH 1/2] Revert "ASoC: rt5682: Adjust headset volume button
 threshold"
Message-ID: <20210811115745.GB4167@sirena.org.uk>
References: <20210811083750.26680-1-derek.fang@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <20210811083750.26680-1-derek.fang@realtek.com>
X-Cookie: To stay youthful, stay useful.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, lgirdwood@gmail.com, albertchen@realtek.com,
 shumingf@realtek.com, flove@realtek.com
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


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 11, 2021 at 04:37:49PM +0800, derek.fang@realtek.com wrote:
> From: Derek Fang <derek.fang@realtek.com>
>=20
> This reverts commit 6d20bf7c020f417fdef1810a22da17c126603472.
> Since it may risk affecting other headset Vol- button.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmETuzgACgkQJNaLcl1U
h9AZHQf/RuGaSks2e2jFeb1J4L/5RWhyPmbYFmUIhYZYVfy7+DawsK/8kutE8W7K
KrGM1RbDNYzgFzBRGFm2a39UqQJLaWTVmCsrztBCqHmTJlkdOtIoMuYM/VD+BHm8
IIzlFWUR3TIX9bJFeSK+LRude6NExGAxdfmLO8T8c3G7zMcb3gATeOKkA3wT70o1
GCPsJJlXgSRSH/Xx1uXGpt1Op0fLMiHxxG66HsHx/ngoXbpobK2wKWe14k7gPC4d
wQUAbwgo7Fgd8odxT/DXGXrIDsiYGkOgbayxqp01yI/2Y/XN3EMmmlYb1NwXbii9
csmcw31jDCo6B3HB1O+pEd9WbMzxsw==
=RjAn
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
