Return-Path: <SRS0=vuHx=ZK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C10C432C0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:56:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C684219F6
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="p6mrelZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C684219F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA6461684;
	Mon, 18 Nov 2019 16:55:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA6461684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574092563;
	bh=PnS+i4YVlkNRIKBMc6VP9P8Vt3t8KSZEbr0ELOoHD70=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p6mrelZz7kR+XyysOpSGuRG7tbdglAS9Sc27sGvJoV6xb5Y4DJZpu5OVWPnYW0Q6e
	 V8/QJWa7qoaw7J3B/eWbZ1lKmiuXq3h0dtdrVzL7iAywhgG02W5NOVsVeBOjpJ1avv
	 zo2k7yFWKIzB4P465k1cO6ZGCZfM5XURhqBcg+vc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D742F80100;
	Mon, 18 Nov 2019 16:55:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43425F8013B; Mon, 18 Nov 2019 16:55:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id CB888F800F1
 for <alsa-devel@alsa-project.org>; Mon, 18 Nov 2019 16:55:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB888F800F1
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E961BDA7;
 Mon, 18 Nov 2019 07:55:06 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58A333F703;
 Mon, 18 Nov 2019 07:55:06 -0800 (PST)
Date: Mon, 18 Nov 2019 15:55:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20191118155504.GF9761@sirena.org.uk>
References: <201911171006.F2M4BSQx%lkp@intel.com>
 <0d89e1df-81e7-ce5f-0709-add84ecf6295@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <0d89e1df-81e7-ce5f-0709-add84ecf6295@linux.intel.com>
X-Cookie: no maintenance:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 alsa-devel@alsa-project.org, kbuild-all@lists.01.org,
 kbuild test robot <lkp@intel.com>
Subject: Re: [alsa-devel] [asoc:for-5.4 438/441]
 sound/soc/sof/sof-pci-dev.c:136:15: error:
 'snd_soc_acpi_intel_cml_machines' undeclared here (not in a function);
 did you mean 'snd_soc_acpi_intel_cnl_machines'?
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
Content-Type: multipart/mixed; boundary="===============4534988279661256382=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============4534988279661256382==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1Y7d0dPL928TPQbc"
Content-Disposition: inline


--1Y7d0dPL928TPQbc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 09:31:12AM -0600, Pierre-Louis Bossart wrote:

> Looks like the for-5.4 branch did not pick up all the patches from the
> series [PATCH 0/3] ASoC: Intel/SOF: split CFL, CNL, CML firmware names=E2=
=80=8B
>=20
> it's missing:
> [PATCH 1/3] ASoC: Intel: acpi-match: split CNL tables in three
> [PATCH 3/3] ASoC: SOF: Intel: hda: use fallback for firmware name

Only one of those looks like a fix...  I've reverted the commit from
5.4.  Stephen reported this last week...

--1Y7d0dPL928TPQbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3SvtcACgkQJNaLcl1U
h9AUYwf/YxWACE+VvwqVNGLhGQeyil+2Ghe3oggy5nE64+4HcUifmwciv9fGlFoS
JRP2tUWwMdaKba2p79bvxU+SbanLQgpXImcyqnPy32ivqd/qGqkS1oAXsT9fH8o0
9nyfV1Ozcos0NEnRcLh6gdwHMVaCB5TVlHGphi2fbCHjiaBiUTABnhVbt4E2+S0O
+GhPcRib/0695Ud5kKB6ur8VN7Bbn+Wdos6H7V1K9MA0TC845HBxa/0mGCnuOat5
BwG0flmhnqv/LQ5wRqtaxy5jm6mMmlpEuPwwZ8T1PV3OOYuIliy/CICcZ4AxjmeI
j1Gw2ZTiiH2c7twmCJqtXAw/Zhmgvw==
=xQXt
-----END PGP SIGNATURE-----

--1Y7d0dPL928TPQbc--

--===============4534988279661256382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4534988279661256382==--
