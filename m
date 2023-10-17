Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A34CDB482
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Oct 2023 16:31:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C8FD1F2;
	Tue, 17 Oct 2023 18:30:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C8FD1F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697560308;
	bh=sU2EMCsv3DyJAITFKB0Lfb/v6BJGj0xKNJXbC1q0U2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UigEDXso5WOuQC0mXY1H4mV+fXG6K7tyVuv+DCbZ8X70ZoK9rYMvwptXU6vJirWP7
	 jkSJrE43gZW92rtza37QD00pxLgBJm3GtoNCNDdxF/m9BzN+bkFEzx5EMmnJGvZ65k
	 aUcSw1ojcSSqku5a2UDqAgP/k8q3qZ4oFSrf9iiY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1B4EDF80558; Tue, 17 Oct 2023 18:30:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B4CAF8024E;
	Tue, 17 Oct 2023 18:30:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80659F8024E; Tue, 17 Oct 2023 18:30:22 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E831EF8019B
	for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2023 18:30:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E831EF8019B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ipwinJZR
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 05F88CE1FEB;
	Tue, 17 Oct 2023 16:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1FCC433C7;
	Tue, 17 Oct 2023 16:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697560207;
	bh=sU2EMCsv3DyJAITFKB0Lfb/v6BJGj0xKNJXbC1q0U2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipwinJZRe1Qem4MsMt0wxqnSCi+eYwNMvo4Xvdd1c35q/sgyWNNn8lV7carjVR0u2
	 h+lLFLw7ECnIavEltzuXMWVVfdSkrMARGbTqB2M6DOnfVy4RcFjW9i4YB4/yfE/aEy
	 zf4gjfKHJNXvwccxehbfVlQeqr1FrNR0uVfcT/syoY2XYUlBS3/5nuu6OHXmuOr3KX
	 s9hNUqk+I5qoL6pRWYWyZqmxnsztNOD0SH8YpEAyz61t/8FGhfEORB4ttTF9sMQ84+
	 0SD4UExWqSJuehVvOYXCHFn0SuqeBvz5clnkuVFId05q+R71wbjtk8Tz4Dc1IISlvx
	 /qZcdfRu9vp9A==
Date: Tue, 17 Oct 2023 17:29:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org,
	tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org,
	Bard liao <yung-chuan.liao@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: Re: [RFC PATCH 2/2] soundwire: fix initializing sysfs for same
 devices on different buses
Message-ID: <4815c8d6-635d-415c-9e02-4e39e92a3d6d@sirena.org.uk>
References: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
 <20231017160933.12624-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pDDQ5Cun2wSytVh2"
Content-Disposition: inline
In-Reply-To: <20231017160933.12624-3-pierre-louis.bossart@linux.intel.com>
X-Cookie: Santa Claus is watching!
Message-ID-Hash: UFGXOAWS6AJC6WBY2ICQVYFJDVVFRFIC
X-Message-ID-Hash: UFGXOAWS6AJC6WBY2ICQVYFJDVVFRFIC
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UFGXOAWS6AJC6WBY2ICQVYFJDVVFRFIC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--pDDQ5Cun2wSytVh2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2023 at 11:09:33AM -0500, Pierre-Louis Bossart wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> If same devices with same device IDs are present on different soundwire
> buses, the probe fails due to conflicting device names and sysfs
> entries:

Acked-by: Mark Brown <broonie@kernel.org>

--pDDQ5Cun2wSytVh2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUutoYACgkQJNaLcl1U
h9CIxwf/UPXnwjJuk+a9OL59oPDEk05nXN4hCn4ZyLLqYCrhVb0c7xe+WRXVPB2i
MVb/MYBXnGT89Fq1jAkrEG0RDke6vNmP8IzsBm7gykoHTT27eIjhbLbmcGb5FMtg
Z18c3YHTa2BYt4f/xyFRLYG5vEFlh9r/6PECuGrScXita3Xrz67vggnN0R+u+uQP
7kMq3ii5ULx7oDsRoQuERV9+WurLIAkZVGkfMVqFUmu1e7NiAXc5phj3YVcSnaFj
9+DW12wntF2N+NyYs6/+tCZjosxxRayygvt2UL8j8SyM/WT1HCx2k+H6Gq8QvM4e
oZFmY80WCCUUyBO0ZRmip+Nmzby6Hw==
=2Yub
-----END PGP SIGNATURE-----

--pDDQ5Cun2wSytVh2--
