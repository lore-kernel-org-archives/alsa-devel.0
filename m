Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEDEE71D53
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Sep 2023 15:27:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC2A4DF0;
	Fri, 29 Sep 2023 17:26:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC2A4DF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696001256;
	bh=a6761QvQRE1xtpY5lhrhWHOaasJib8GidjbbwOgM82M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GqzV1yKS43NgeHeqhZnqm7MeimtLr+HrL5guJLlpv4oaofJQR4D/o5LkUXh9dxvlk
	 W8qeFgANGZbMOOH8E4AR5Yz/G7QKGd3OCjBl0FP/1SSi5Y5J40PZacdloU/KhvlkDd
	 uXOqoUFybntLLiYiLf56gUPE03w/h3yMQH+fPnxY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 100F2F8057A; Fri, 29 Sep 2023 17:26:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D3EA8F8057A;
	Fri, 29 Sep 2023 17:26:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7052F80571; Fri, 29 Sep 2023 17:26:21 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 609A4F80552;
	Fri, 29 Sep 2023 17:26:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 609A4F80552
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Tzi+o/tB
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7F9BB61F69;
	Fri, 29 Sep 2023 15:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C236C433C7;
	Fri, 29 Sep 2023 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696001175;
	bh=a6761QvQRE1xtpY5lhrhWHOaasJib8GidjbbwOgM82M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tzi+o/tBEBP4461DI/dGBBkIzRBjoNMab6UDQNhWdyUrn37T0w6SZiYuKK5QRK4Sc
	 lTlOI26Po8hWGPPQxw18QHTQswbCk7kXddrF94EfNLD1NNylksLo/bLoj10wC33cMf
	 kk6QQlNv6NLXKslFIGujVWA4/fJQzZyQ5tYMse5TS+j3DNqmYZpnCd0nH+KjUyBV+b
	 aAty6N5WvlaT0PGEaJnvbytVWy+kLFLkQdevtVcklzdlLEWeM4DRrhKmUoVU4JI+Fc
	 9ud2oOFaDyDSqM3PeZuXZlaMOHGSMhJnC7PMuYYWGmuA9Xz4KjvgBW0L1NSPBoq33P
	 hOyX6wNMhIowA==
Date: Fri, 29 Sep 2023 17:26:13 +0200
From: Mark Brown <broonie@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>, linux-kernel@vger.kernel.org,
	sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v5 02/12] ASoC: SOF: core: Add probe_early and
 remove_late callbacks
Message-ID: <ZRbslaHeR+5JgdD+@finisterre.sirena.org.uk>
References: <20230929145123.233838-1-maarten.lankhorst@linux.intel.com>
 <20230929145123.233838-3-maarten.lankhorst@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/njO6HX7W3+mjKuA"
Content-Disposition: inline
In-Reply-To: <20230929145123.233838-3-maarten.lankhorst@linux.intel.com>
X-Cookie: Save energy:  Drive a smaller shell.
Message-ID-Hash: HI6VMFLAP3AY4IYEEXFMVPCWTWVGADL7
X-Message-ID-Hash: HI6VMFLAP3AY4IYEEXFMVPCWTWVGADL7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HI6VMFLAP3AY4IYEEXFMVPCWTWVGADL7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--/njO6HX7W3+mjKuA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 04:51:16PM +0200, Maarten Lankhorst wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> The existing DSP probe may be handled in a workqueue to allow for
> extra time, typically for the i915 request_module and HDAudio codec
> handling.

Acked-by: Mark Brown <broonie@kernel.org>

--/njO6HX7W3+mjKuA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUW7JQACgkQJNaLcl1U
h9AUtgf/YApaEB7FmIa5/bkJ+zW+uYABrL/XbKWdtakaKUYLoWxSsNfcfSOd1QoA
/eSO8Y4jTFYpbOpjex7SJ1l58gqPa7cqQNXZYxQq9d5wOCGn46s9X9CYSiuf0Bau
ke6hkU2LqvyRlGjX1E4Pf7GJdzxwndy7CsasIHjTcVtb6vaIETrANWwgojWJwVnO
v492ROgGIoDJdZA1Oj7m3nyy3/LLNJL1skj6wzbyt8IqTlq5npB1koIp7FI+Nllo
fvLkUsr7+Cp65etyvjIu23WN2dK9/W3yYqwyQVHwGxaV9mrGzG0blT5izuawATji
qLfg1rIdlZ5p99hZwNgpG/j7+/MOVA==
=3vPj
-----END PGP SIGNATURE-----

--/njO6HX7W3+mjKuA--
