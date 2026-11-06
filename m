Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F5606A326
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=qdRz0sbp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABnzvU9b
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F53C601DC;
	Fri,  6 Nov 2026 13:25:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F53C601DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793967929;
	bh=gcp3IhERIolgxwFIIfmfPI/w27CHLBf1HSdIWgRYFIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qdRz0sbpmJDqFugo8T+U4fu+500PVGo0SmdU9ASj5SBJW6VN9od+1q7vCPPK7EmxX
	 ArIZbZCes3Tzc0P1hSgANqNJKjnKawBKJsd7q/rJBbzi91xzUi4Th4GZQ2iWfbih5N
	 SOXcqBgjzYOyF4hs4p5WI3HcBo0JzvKizmcPkzHs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4BE73F805EE; Fri,  6 Nov 2026 13:24:54 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AFAAAF805FF;
	Fri,  6 Nov 2026 13:24:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F34F5F80510; Fri,  6 Nov 2026 13:24:46 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793967885;
	b=BqXY1e+1t0MIOZ18Y9AqigPtDuoiXAPT6P9A1QF4suDRhv026kmgBlGPCKzx75mDwMMd
	 qzRpBC18kIKv+Uv5NohmNF49CeN+QqxgnSBZLT4fqwjpyks9Tf61Xy7+xy/TgI04BLIfy
	 hvgWmn4RxVzsW/F/B81LCZT0aPjVLiX/wp3rft7ijph/TAk9mEpUSorn7iDUsvXIc9Ri1
	 M+p9sSe050jyjphaanKlLu8AS//oj5ftIcFBO5elRuD8rfqxJNfZOknESsM6X5+So25r/
	 AazcGW8XXeduIUwaOrT/4wVkJMfkgufJ/oH/NcBrMCb3n+lwM/YmzPN4GkHmPRubfPA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793967885;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=gcp3IhERIolgxwFIIfmfPI/w27CHLBf1HSdIWgRYFIU=;
	b=mfjkA73oTulSn/BmovN7rZctZmSNA/BXpNQsyNycdkTubgHTGYY9mc44sdnCfQ9AhoNo
	 cp3Y+mGZ9VQo0vSyGQnciIB71izoSYynnpn7Nos1SumeEGcuPIUIscjIJB4kw5hZ2F9u+
	 ogjIm7exfWcTI3Zgn9INBvvZKrWIjvVvWt6xbAcwGainGua++9buAgF0KLN/cEz6BsGTL
	 Qok48SQxUQfH4MgL+kQ94J4oJhQQKTICIRpk8wADO3aVZ9D23IJxXOgW6bkPZE0Z5TYFJ
	 M9P9+pU8TZXDaJDCG8D8b0nXE1Kvoe4z3PbEFfoqMS0rnmRl/P8FqhTOeIZlvUtBDLQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ABnzvU9b;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 74FF4F8024C
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 13:24:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74FF4F8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ABnzvU9b
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 188D7605F7;
	Fri,  6 Nov 2026 12:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D93A1F008A4;
	Fri,  6 Nov 2026 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793967881;
	bh=gcp3IhERIolgxwFIIfmfPI/w27CHLBf1HSdIWgRYFIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ABnzvU9baluU2lB7w7dVGXVD4uEQ9nzo7xXPN2K9Im7YvijuTTwZObNv5hOI13ktg
	 uwlwe/66CzEPC7hAsY5FIQTVM0rzrAe47iFB0Dek2BwqQoWPr+d734MeJXUsMiftzC
	 DPson5kD4vK9J1ire6r1ZkhoxXkKZj7z4wJWdYLhRoVQ70hCd+1Gi6JBL/B+JR4oNc
	 z/aYO33umAA6MELW2u6d6jHEcga94AIRnHUN4y4XOOSeDJ/Mw5mLmNOE3efqO0mKxI
	 Vx1qVQ2U8lQvuHGpsmlopA/SbOdRuYHj/5C6Y02zwPsWcbCUS7sg/tyUJwJ5ldJH3P
	 ysFvtq5Sg0Sfg==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 74A3B28067DD; Fri, 06 Nov 2026 12:24:38 +0000 (GMT)
Date: Fri, 6 Nov 2026 12:24:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: pierre-louis.bossart@linux.dev, Basavaraj.Hiregoudar@amd.com,
	Mario.Limonciello@amd.com, Richard.Gong@amd.com,
	Sunil-kumar.Dommati@amd.com, Syed.SabaKareem@amd.com,
	alsa-devel@alsa-project.org, lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	perex@perex.cz, tiwai@suse.com, venkataprasad.potturu@amd.com
Subject: Re: [PATCH 0/2] ASoC: amd: acp: supplement patches for ACP7.B/7.F
 SoundWire machine driver series
Message-ID: <1a75c8e5-975b-4225-9e25-5b6b1148fb50@sirena.org.uk>
References: <20261030094714.1123396-1-Vijendar.Mukunda@amd.com>
 <20261106114622.219126-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FH2cet+fmQufu3HQ"
Content-Disposition: inline
In-Reply-To: <20261106114622.219126-1-Vijendar.Mukunda@amd.com>
X-Cookie: Whoever dies with the most toys wins.
Message-ID-Hash: UHD3U2UE376SZFPHWNEMYVRMDINLOZAZ
X-Message-ID-Hash: UHD3U2UE376SZFPHWNEMYVRMDINLOZAZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UHD3U2UE376SZFPHWNEMYVRMDINLOZAZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>


--FH2cet+fmQufu3HQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2026 at 05:16:20PM +0530, Vijendar Mukunda wrote:
> These two patches address nit-picks raised in review of the ACP7.B/7.F
> SoundWire machine driver series posted at:

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

This has really confused my tooling :(

--FH2cet+fmQufu3HQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCau3HBgAKCRAv73Ows9A4
iXi7AQC07VcxSDE6UbX0pOoDNP8D1f1Jtizz+IeY4X3x0IECPQD/TjXFLaUY9jSB
kdnhWuXzBerTTocsHg+Nf4FELEip0QM=
=4+SU
-----END PGP SIGNATURE-----

--FH2cet+fmQufu3HQ--
