Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5E9C79F99
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:32:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0761E601E5;
	Tue,  8 Sep 2026 15:32:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0761E601E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788874372;
	bh=cyG+sSh237EOVnuMFkTK1wpwDyjge8f0jycj9+sSLWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pq/MmuYnbNv6UWXrHDSJeyZL9JXrUsqgjiAr5lS6z+fjKmK7bQiPSmjDWTjm01v2I
	 BtwnkNqva0PlkRgtj59fcSFzUgaYm2aTeFVL/BxYqBdP2aXJ642sn6AdF0C3v+G7bp
	 ILtspFcprJ9rgH36R1FZY7K+hfpdRT3KaJDY6qLk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88B04F80557; Tue,  8 Sep 2026 15:32:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C767F805F2;
	Tue,  8 Sep 2026 15:32:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3573F80518; Tue,  8 Sep 2026 15:32:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788874328;
	b=oQvn2+VsS647k/58fy27+8FktPlAMHc2MAq+SfTjGwPcvhjq709+XLNKi1YJsaSv02Zb
	 ebGQTY+1//DiDIMVfx6+DJMElBLghuyMgmkWLiUEcGb43SU6cCBZ/reDGu0FOFE0Usc4o
	 31fx0xu7ySHdLJDeQfH/IporneJj4G/yk0yg2cn61xi7xudliNHiZPY4MkeAJ6HF//B/X
	 qYtyc7mu4FgdjTjdwqmSVbQO0t0AE7aIuXY4ZGO1ikRiZLQWlQJe/OK1GAUoFC5xbSWdF
	 124Te8QFWlxJp55mgT4UXj586rS8JK70W6o5X6MllCwCV0ZDZMidW+rOWSsQtBRFx4w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788874328;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=cyG+sSh237EOVnuMFkTK1wpwDyjge8f0jycj9+sSLWI=;
	b=rBntdevPLzjaw366wABcwj68ZOlEW6JeH8qxLjAYoiz9Ch19IpFkFxsTzC2lyRLlA59H
	 tOSwU0B0EoCT9UpAfx/woMRfTXCq/njKgGWlsn++8Y1cDSiHBaXmJdgpKKbLc+AgIwiIm
	 jd731UNDTwvSGOgK0IhjCHX60Xe/duvG0ScSOawgw/v1FsOiNy76v0An2sqyp414EnndD
	 4McUwlyCZQ+BL6Z59y4XgvUeGGQ1vB+gXLJHOSzGWx43lFkGuYDTUMrXVX+HoqsxT8Mfc
	 S66qfNLM/7tA3ZSApllgd6lCbTKvNxD/h0LMKs4BSFFIG28U6mLpU4Ih65qIC3zzGtg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dNWapE1f;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B4D3DF8011B
	for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2026 15:31:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4D3DF8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dNWapE1f
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4B10E40223;
	Tue,  8 Sep 2026 13:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDDD1F00A3E;
	Tue,  8 Sep 2026 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788874288;
	bh=MJB6EV6B8H1QkWSKyg6bAxo/dFbrWzrSiPC8c5mTVQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dNWapE1fIJQeVp0KKq5Ybi4QjYRKAreXIP/TfSlvMMabSgKtyXMBU2jj924WySLpH
	 P6GvTI/55RckumCUCJTyvFIe9+MOfxNwq2wH5oEAtcjQtnMVj8EPpj2ZE+2Z/soRlH
	 S9AT2sGejp2ChMJSTGVXjtUpDfEA1Ej0XbLqutajl7qcYwwqacaIowrLQ162ro7Xqr
	 BynkAyC6vFNzzhO3OGLKnzPl8FRPEthx85fs6qGvqixknvffMjGt3VX1ADoJt7UCYF
	 LrIV7xB4FkrDQzj2jAiUd9nvcZSj8PLoVbBFZyzGHDJz2AHNz/HkIl/T/5qA7Lt4Yw
	 MP8jT6KjNFYgA==
Date: Tue, 8 Sep 2026 14:31:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
	krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	neo.chang70@gmail.com, kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v3] ASoC: codecs: nau8360: Block DSP path selection when
 firmware load fails
Message-ID: <c068db2b-e21c-4891-847d-01a6a201e33e@sirena.org.uk>
References: <20260908030342.222655-1-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PzAFdN8Mc7izNR9I"
Content-Disposition: inline
In-Reply-To: <20260908030342.222655-1-YLCHANG2@nuvoton.com>
X-Cookie: The world is not octal despite DEC.
Message-ID-Hash: 2Q6LP7YGDPZ76AZFPV2EH6LIVOHBAW7T
X-Message-ID-Hash: 2Q6LP7YGDPZ76AZFPV2EH6LIVOHBAW7T
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2Q6LP7YGDPZ76AZFPV2EH6LIVOHBAW7T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--PzAFdN8Mc7izNR9I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 11:03:42AM +0800, Neo Chang wrote:
> Block the DSP path selection if the firmware fails to load to prevent
> invalid routing states.

> +++ b/sound/soc/codecs/nau8360.c
> @@ -719,6 +719,11 @@ static int nau8360_dac_mux_put_enum(struct snd_kcont=
rol *kcontrol,
>  		return ret;
>  	}
> =20
> +	if (item[0] =3D=3D NAU8360_DAC_SRC_DSP && !nau8360->load_fw_done) {
> +		dev_warn(nau8360->dev, "Cannot enable DSP: Firmware not ready or disab=
led\n");
> +		return ret;

ret is 0 at this point so this will look like success, you need to
return an error code (-EBUSY might be good).  I'd also use a _ratelimit
print here to avoid spamming the logs.

--PzAFdN8Mc7izNR9I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqgDiMACgkQJNaLcl1U
h9CkJwf/el48DUA/0/pug6z/kykTBH6+ujIZlS2GWiEt64HCfjfu8RsIqRbILDpp
Kcac061HmF8BE77McbqVO0RdR3ce2RMEmpxlarJKAyKqt25EIEITsBffEPasAPCc
HXZ/CRGEtsEf38ged0aTU4rJm0Hhk1s64S20MzuNWkhzeDv4VAbxRVxJQJCEUTOz
2ehKtTyJoeYJVWiqnnc6vVqhcEQ48qBKGuVuHoLc8NpPqbdEs4z20tGWWhj9m8ug
Xik9ujRG7tMPY/oLQML8LjObe9gxP2CNnMZjYpHrkGES9XTcXDFhCmHB6k4PD9C1
6/vAgi8dZAgzmTpqglUJem2B8+p4Dw==
=JCPF
-----END PGP SIGNATURE-----

--PzAFdN8Mc7izNR9I--
