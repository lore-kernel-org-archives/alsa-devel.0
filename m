Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E5EC43458
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:10:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3483F601EE;
	Fri,  3 Jul 2026 19:10:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3483F601EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783098630;
	bh=g4Z9AW55xBLuMsEyuGV+NPzY+gyjS9YnsvIV1ygMJzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BGyBh4Omqz2Xp1f2cARuJc5HXtuQOReKFHZ60kxTF5rVlgvNJCNO9jSFcw3sYESfv
	 iInb7OXHjzRRsqndhkmdiJ4lYEHlZ47if/Vmvfm9K+awmvyiK+swyMb/sdLZa5S4Tj
	 Y0THjp721bTEgePZ6XUnhGADxY7KtYEQaMM3FwSI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60741F805F1; Fri,  3 Jul 2026 19:09:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1100BF805FB;
	Fri,  3 Jul 2026 19:09:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08F16F80579; Fri,  3 Jul 2026 19:09:50 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783098589;
	b=Goc2A44DzhoWjj1OLO/TXX30900rjY7EhG5jKxNas0S+75NLzXVvhJJAAWrZCc/dwjVV
	 3YRK82z+1cV2BbORu+QdC/RlLY9SVQrPZzIzrLGHELoUWW8AViVWHzL74YPkANB5eHUgL
	 ou48x0cLtCYZfSZrmBvMo3nElc+wYMiip36/mC+L9zgtYqoSYRfLtkXxfNYT+NA0jd7d0
	 VqiMPqUCyZKOIcCd14oUBH3B/Ft+rCFSp13inbu2A52SXrAe5PNWoGVCOzGDD3QHpR2iq
	 DzwQL1y6nhrLWEp76Oh1mw6ZYP31Dl372WXSnDINUnkqwWAHjX8i7eD4TXkwy/TECGQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783098589;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=g4Z9AW55xBLuMsEyuGV+NPzY+gyjS9YnsvIV1ygMJzY=;
	b=VInLm5wwe370WGbYIiNeRMk2cYOI6BqouquspWMI3ue0zvoUaMeMgCSqk+F8xaTZS4Qc
	 OkHGipm/VzhN25W5FA4eJ0hve1Dwx6huNI1SQ2zene7GwZQSYvbLnCNIZUTmI+n5c/xKw
	 xUC5QiGTCTwz9A/t9ULQNu4UO0Y7+SmT2vUaxJqeErVtQAf6Ifszrumb9k/pt7RwD02wJ
	 4nsePvnU/SClICKDN6t9gb5iZZ3fgevHxMM48Xdd7jrePH9vpBwRvaxCEaMu+hdiyuovn
	 QqAL03+ct3GA4JH+z9Zw9Z/I9Dzd9gsst2wi5wo7pOVxeFawzXTnk60PI27PCL/lxRA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UIQnp8GU;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5B06BF8011B;
	Fri,  3 Jul 2026 19:09:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B06BF8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UIQnp8GU
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0B4F160051;
	Fri,  3 Jul 2026 17:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0624A1F000E9;
	Fri,  3 Jul 2026 17:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783098584;
	bh=DBWihNUWgBjLa2D1ABgjObGnnXBcwoJR2Z7C+FfpPkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UIQnp8GUpIiYzbi7J219Gdr7+5yLHtjEjhRA9fJnSYdGkSs52FKWh2lvQRn7wqXP1
	 6HkykOtaGBBW675NugNHY5LI1jILRM8r/kGlQrN9641TKuyuliw0+4MvzKvQdjuzH4
	 Qf798J55OOHyERK1GeC3/zKWnE1hxo0+zhVq03PS8jXQCatp3CKM4Hqr67oP3iMQnn
	 iNrVwf0JFrvyP467YWE7Ri9GrgbLngXf+r38BhauAVKgJZ76vRXo78Q96dQ2X5WvsM
	 mq41dS5B08iUMd1DUsOqdBbY1EMoFmnRohiaRmVp2lkOgEWRZCX2D8OxGj8lOb85ws
	 yVccAJkSM2opQ==
Date: Fri, 3 Jul 2026 18:09:39 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	perex@perex.cz, tiwai@suse.com, Basavaraj.Hiregoudar@amd.com,
	Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
	mario.limonciello@amd.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
Subject: Re: [PATCH 16/16] ASoC: SOF: amd: add system and runtime PM ops for
 ACP7x
Message-ID: <632c9729-3f64-41fd-b85d-18f4437a68df@sirena.org.uk>
References: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
 <20260701095759.1012929-17-Vijendar.Mukunda@amd.com>
 <58e4579d-f87c-48db-9682-fec99c4706af@sirena.org.uk>
 <68d6745f-8bfd-4b1e-b4f1-33190038566d@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B9Lvx88CybaklRd/"
Content-Disposition: inline
In-Reply-To: <68d6745f-8bfd-4b1e-b4f1-33190038566d@amd.com>
X-Cookie: Another megabytes the dust.
Message-ID-Hash: 5OL7U4TLAPCSCX5VNUW7YSSK7BYN7J5S
X-Message-ID-Hash: 5OL7U4TLAPCSCX5VNUW7YSSK7BYN7J5S
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5OL7U4TLAPCSCX5VNUW7YSSK7BYN7J5S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--B9Lvx88CybaklRd/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2026 at 10:21:25PM +0530, Mukunda,Vijendar wrote:
> On 7/3/26 21:58, Mark Brown wrote:
> > On Wed, Jul 01, 2026 at 03:25:17PM +0530, Vijendar Mukunda wrote:

> > The interrupt is requested with IRQF_SHARED so probably worth double
> > checking if the interrupt handler is safe to run while the suspend and
> > resume callbacks are running, I see we reset the device during suspend
> > so there might be some risk of corrupted register reads?

> There won't be any corrupted register reads when acp reset sequence
> is executed,=A0 all the acp registers are set to default values. i.e Inte=
rrupt
> control registers are disabled. This sequence ensures that till interrupt

Including whatever the threaded handler is doing?  I didn't actually
check properly, just saw the indirection through the SOF I/O functions
and the threaded handler.

> masks are enabled during resume sequence, no interrupt will be asserted
> for ACP IP.

Right, but IRQF_SHARED means it might be an interrupt for something
else.

--B9Lvx88CybaklRd/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpH7NIACgkQJNaLcl1U
h9DpJAf+PRQxFBpzYYnL5SWVj8/kH3j6IPakFuC4uf9GK9QxFvIGxdF80Np5xhve
fyV8KbFiYy3QRlF8ajBJGaZDvZmP0rOSHY5WRTmEK8epIEUcfJqFhuK3w7sonJXe
GzzbFU+Mokq9LsOFgtFZjuheuMOSRJLUtPlRzv+m7tD0HpdBJTuzQGfyV8gy8/oW
hk6mJk/ky4NGLvUPqxiyzt1KUE/yHmaDYcv8TCI49zJXYmgv08p4LEQGQkRpgGf/
tbIr/QLeZ0uKXyuLiJbOnwYwpipKiyjggqcx8gsNcvEeL4vWwti4MeYVeazLdwil
PBUvOeZagcXwcDGZ4YvRf9DivTZmew==
=rtYV
-----END PGP SIGNATURE-----

--B9Lvx88CybaklRd/--
