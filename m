Return-Path: <SRS0=q21C=4W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278C7C3F2D1
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:46:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A862620848
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UHmUArh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A862620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F77215F8;
	Thu,  5 Mar 2020 13:45:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F77215F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583412392;
	bh=g4JCmVHP4j7gCTOUlCmkCKlN7Uxq7J/6ss24t7VXsCM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UHmUArh+LJEQoNgKrOu1zFUukggA400aUvB97bLMPNxW1qYrqRoyeIIsE0hh3vd0N
	 lmP9Rr2FEVFfOiaDIcdX9o3uZWb13LGRFVVj5ZPzMVrniQ96osoqcM5k/JVDvL6OW7
	 e4Imy6XXPcW7Of4qtTm9hhHS5xv2hSv+l+1fnVVo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2BE41F80245;
	Thu,  5 Mar 2020 13:45:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C9F1CF8025F; Thu,  5 Mar 2020 13:45:31 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 1B65AF800D8
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2020 13:45:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B65AF800D8
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAC6B31B;
 Thu,  5 Mar 2020 04:45:25 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C90B3F6C4;
 Thu,  5 Mar 2020 04:45:25 -0800 (PST)
Date: Thu, 5 Mar 2020 12:45:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v2 3/8] ASoC: soc-pcm: move dpcm_fe_dai_close()
Message-ID: <20200305124523.GA5035@sirena.org.uk>
References: <87o8tk7q34.wl-kuninori.morimoto.gx@renesas.com>
 <87k1487q1e.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <87k1487q1e.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Are you still an ALCOHOLIC?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2020 at 10:54:53AM +0900, Kuninori Morimoto wrote:
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> move dpcm_fe_dai_close() next to dpcm_fe_dai_open().
> This is prepare for dpcm_fe_dai_open() cleanup

This doesn't apply against current code, please check and resend.

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5g9GMACgkQJNaLcl1U
h9BETQf/TmcZ1kFBBuPSmBXa12bVgeJGuyjyoo3ndtSMXKlR/tSzq6pkI3J82ltj
J67zmT8oYm0F15KArCTZNCwObraJ5UlY0Ya436GkJEoYF7CETRarc3wqCfO89mpK
nThxnNX3pmnSfwwRlXU82B3GPYNPK18/ZtSmukoe475DdIObN3i5VpR06J1Xl1oJ
mfvcfMg+Z6V8d5rj9tMyEfjHKFUMK53C40hWZAOGr7UaQglnVk6ikJ8v3KjaSXkM
s/M4/G7eoMp7+bM5Xyo15PemjzdZdTr/xAbWWeIQkKZR9AyCuLDxWEVZFOPxS/CP
JdBF9yuUTUgIKYo1CA3a8TUCXO4ogA==
=xquc
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
