Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF54BC43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:21:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 728D76025C;
	Wed,  1 Jul 2026 20:21:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 728D76025C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782930113;
	bh=SPJjNBOdLnus/niDqbSYCMhD49X0R1V2BT2ev1PNCQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MrcV6Sly7GapxoIAtfGhBdIrvOm/Nby8fY5BNwYiSzHHMa33L7f9R+ZqmDLlpD3Vy
	 iSG1m0gxZf+rjHddRxU3SjdmWX5UBhzeH/M/55o7qz9UPTrMqK2Py7tFl4jetcXW5T
	 SZyXJYOXCMF5GMTUhfSO8CMFV3C+2hNtsdRzSap0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 271CAF805FE; Wed,  1 Jul 2026 20:21:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CC70FF805F0;
	Wed,  1 Jul 2026 20:21:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1294DF804D6; Wed,  1 Jul 2026 20:21:14 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782930073;
	b=EJQ2mkh3rDj+B2nQJLWn7aS4Yy1Jk3rNvvd8O0aaaMRMXEFAZ60t27m5cFzfH4sN8oAm
	 7LWGsHeVSDCWARemrW7ih3OhGplAJFqVkESQa0Jei4JI7a5wtyXxoAZdcXEMrTBQBv83h
	 To5p9mdAKN6z8UgEMJMEK8w7pVUMEcLJJBjR3YBkwfFVpr7X2tSC5X9veggnAvt7DfMrD
	 rlNeNATsuu9lzHdOolcoHMhPRoxBdkRu3pmgt5LQ0hvU1oMa6DZaGhQW5ULS+IKKqEg/k
	 zfFV+TqtbjjXFEcl4b/cvMmnLxVrQfZnlhnBnuZK3yyeeKYcKwxoqL59s7/Gd6eeT2Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782930073;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=SPJjNBOdLnus/niDqbSYCMhD49X0R1V2BT2ev1PNCQM=;
	b=qwzHTuoc54GhB0i2/eM6maIM6/MrbOE8MTbf4QnerFhjRVpL3lVCrogGE2j2wmJJvRg6
	 Cq5PgzbbEMkskdbgpAzWM3jRp3qeJuRn5jALzym2uJUtFleeh+B3399WXHdISUqvIau8E
	 n+pTCsyToucrmUfkHOIm3lUUwjtveRM+fHgsOj8fkf7Sx0PMAaz4Emo4mkv6J4gy8b8ao
	 ZdMtNt4+o7+GMNn3hBwpuf8RKmnTTaRl+42Ey7Q9hwne2YoC6WFf8e2bpjgszU2d01IQV
	 esUgcLicFdU/WbUxMGDq1SSJVq52oEbxELBlZUspg3eIw2OFsl0YzR20dKcFELtVqBw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=I2Y6UDHB;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 29344F8016D
	for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2026 20:21:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29344F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=I2Y6UDHB
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CCB7541A2E;
	Wed,  1 Jul 2026 18:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799901F000E9;
	Wed,  1 Jul 2026 18:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782930068;
	bh=dWESgHXPzQP1SIE7M5Gl/JtaO4ZOYr1I0S/sGw6JZds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I2Y6UDHBBPAWJzdFSiHKVo42ZtGN7Dj6eTqY6yd41MJaorf0eleDYx9qh7wSPN54P
	 jPUbV6mktiDEoLlUSfP2DjDziBK/30/kJ+mKpLp/rCNB25vm3QwY3uaMNHJjDJvZdM
	 iglv6F9fs9h4MmTv7/4FdG5+arO/RMRtjQLgMNsVk6hGG2EHYHfPrw76lIp+SBoGb8
	 yiacv8vr1ENWJguzXcf2rmeJ7UR/vcqkxjEY0IIKsIga0cqcmFOhY+Zrlq5umsSc3a
	 xjXznETunk8Lo9Eb/AGzhh59uE8CEO4NSu6MWy8nAAs/7RqPYRHH9m2iJQ4yBWarNn
	 VQEbxfBPlstNw==
Date: Wed, 1 Jul 2026 19:21:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, shenghao-ding@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	k-yi@ti.com, henry.lo@ti.com, robinchen@ti.com, niranjan.hy@ti.com
Subject: Re: [PATCH v2] ASoC: amd: acp: amd-acp70-acpi-match: Add tas2783
 support
Message-ID: <d0f4beec-1092-482f-b214-2749c87d7be4@sirena.org.uk>
References: <20260630144904.865-1-baojun.xu@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v74EOz3zzM3IS2EN"
Content-Disposition: inline
In-Reply-To: <20260630144904.865-1-baojun.xu@ti.com>
X-Cookie: Do unto others before they undo you.
Message-ID-Hash: TOPNQ5VAJN4O7C3JMQN5JXSGSVASKGJ6
X-Message-ID-Hash: TOPNQ5VAJN4O7C3JMQN5JXSGSVASKGJ6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TOPNQ5VAJN4O7C3JMQN5JXSGSVASKGJ6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--v74EOz3zzM3IS2EN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2026 at 10:49:04PM +0800, Baojun Xu wrote:
> Add driver data and ACPI match table entries for the TAS2783 on ACP7.0 and
> ACP7.1 platforms using SoundWire link 0.

> +static const struct snd_soc_acpi_link_adr tas2783_l0[] = {
> +	{
> +		.mask = BIT(0),
> +		.num_adr = ARRAY_SIZE(tas2783_0_adr),
> +		.adr_d = tas2783_0_adr,
> +	},
> +	{}
> +};

This doesn't seem to be referenced anywhere?

--v74EOz3zzM3IS2EN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpFWo4ACgkQJNaLcl1U
h9AflQf+L1NQ2Nzaa3JVlIDDZYpbVQfz9ZfIWOfjbJARTKWQJoJYFdWFWDPsk7Qt
w4x7My0W5aov1hd92ggE/RUbRam1k0qOg5yth8JZxqS8kjObtE99h3EjglWtoqf2
oPNjmL+sZHbG8VelAjIhGGFTQtQ058rlO9K525XD090xlW01RXIBMne6KnakpbBB
LemQYNu5xZ95kOuQHesTmPiaGGVIOHGAoVrd4F+17isYJV8/cNCvcztMFOHKFrCy
YyiTtCoVtIgT8Q5W0OCRKHZtWbGrcjVhn+YafP9BiKBSgdWdyNxKPs/a9T2KK8CY
rGEgZ8x5UEFR4k5C2ADrwSMDIzVTDQ==
=cI/m
-----END PGP SIGNATURE-----

--v74EOz3zzM3IS2EN--
