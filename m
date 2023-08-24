Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB4EC88CB2
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Aug 2023 22:33:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00A9F84B;
	Fri, 25 Aug 2023 00:32:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00A9F84B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692916413;
	bh=xaqiySOcBWpetlhFmgslRRyaio2RwxEIasy4gC/DPq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YimHqK0SgSqLHgW1NtjAVo9eYgwGE+N5uX7p2gN9ddwVR+TtOgQTFNw804RjT+kKI
	 CBPZcSZ55s7JwJe2BZW46G4ooAiQ4ovROZkbi/rX/ErQXJSlR4m8Fw3+g9s6mfz+sS
	 ap3F5p0f8zr6S+3wxAsuvzL+/Gv3Z8qn+0TO9uMk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE75AF800D1; Fri, 25 Aug 2023 00:32:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 44060F80537;
	Fri, 25 Aug 2023 00:32:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2D71F80549; Fri, 25 Aug 2023 00:32:09 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CF23AF8023B
	for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2023 00:32:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF23AF8023B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=s4Oz1GwI
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 08BDB62B85;
	Thu, 24 Aug 2023 22:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4421C433C8;
	Thu, 24 Aug 2023 22:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692916321;
	bh=xaqiySOcBWpetlhFmgslRRyaio2RwxEIasy4gC/DPq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4Oz1GwIJPhmMzQePW/+Mkuk/ft7qwrfUd+89aCmf8uPxeBfhvTMx8Hye3SAqoHb7
	 1Ou0EMpw4pYwk8qRCBzqgAC74vYlVI6sHavres8LeBVk9NOk61FXdKp8AAbtxMMLTg
	 5NM/xEV0s4k1OD9hzKYFYaL2s+VwqdBhZHiyhIXMRTFKqDUGBTZZ2Sj1A1YUNi7JXO
	 GMramPJFQcQufAW0FOplPB3Plxg7ioGfP6nXt7YL3ZYLo4Z0GDdMph/9Zto8hfmpeJ
	 4nSUCa3iKrYH5ab1wvBD4VD/lf0I7vxj4elyDHQ0KbT0MyWMIaJqf6w/TWicfal0lO
	 69hfYpWh+l5rA==
Date: Thu, 24 Aug 2023 23:31:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com
Subject: Re: [PATCH 13/17] ASoC: SOF: Intel: Switch to new stream-format
 interface
Message-ID: <ZOfaWN0XjBTYCKHI@finisterre.sirena.org.uk>
References: <20230823080546.2224713-1-cezary.rojewski@intel.com>
 <20230823080546.2224713-14-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BjdWjFUUwtyqw9WK"
Content-Disposition: inline
In-Reply-To: <20230823080546.2224713-14-cezary.rojewski@intel.com>
X-Cookie: Give him an evasive answer.
Message-ID-Hash: 4SFEKSQRVPZZ4UZMUEVICX3T52EAKRDA
X-Message-ID-Hash: 4SFEKSQRVPZZ4UZMUEVICX3T52EAKRDA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4SFEKSQRVPZZ4UZMUEVICX3T52EAKRDA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--BjdWjFUUwtyqw9WK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 10:05:42AM +0200, Cezary Rojewski wrote:
> To provide option for selecting different bit-per-sample than just the
> maximum one, use the new format calculation mechanism.

Acked-by: Mark Brown <broonie@kernel.org>

--BjdWjFUUwtyqw9WK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTn2lcACgkQJNaLcl1U
h9BBfQf9ET7bZ064zWIAH6JsleWCBI9a5vq/Hosm+gcGwvUu9kZi3ndfcRkaffrh
7Qx+ACcPKyGcjeI6r444G1QY5M/uMBOwvxLVY0Sr+g9+AFTjKYdwZGHEgjFd/sM7
2TUMEcBGe27SpvSZ4fKWve0HGQFElgCeRSAuYJ91Omo0XBAZJ3OiLZ2QAYywuqTY
04tci23O+2t41UQvtIKwKEld8FPKSojXNK1d0HW6FcDYrzsj5gDfTC5NKM2wakCM
a1YREztxY0ssta6Wgy6zIR+KKLweSNRiBuGbQdiPjdt2ESVkG60hCVzmfYGwmuCP
djSDq9K8rnAlCQ1tSSBFomB7+XeavA==
=iJo+
-----END PGP SIGNATURE-----

--BjdWjFUUwtyqw9WK--
