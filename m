Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E8AC021A9
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:09:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C9E5602CC;
	Mon, 17 Feb 2025 13:09:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C9E5602CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1739794179;
	bh=ad38LmBqRTzZlEH/YO9pRaaUwndt5TUoj5spK6oLskY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uwZ/ixMxKB+RSMCTRybpt8j/45C621Cg2WS0rtWRUaXn0HpLHx54+leLAmcsKHtUz
	 MNmu3QcAJb6XJOMo+Z96ZkGSgjFgWYdOa3bcLHqWntFZ5zPCqcIyBK40KXUMptkRXp
	 6Th4wzfoeOt+thordqr9zaGwJCMLp/X42wE0o6IM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 48DA4F805C1; Mon, 17 Feb 2025 13:09:04 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C3295F805C2;
	Mon, 17 Feb 2025 13:09:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30F19F80246; Mon, 17 Feb 2025 13:08:58 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 71A17F80095
	for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2025 13:08:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71A17F80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DRGYK53+
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DBFB3A411C9;
	Mon, 17 Feb 2025 12:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1299FC4CED1;
	Mon, 17 Feb 2025 12:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739794131;
	bh=ad38LmBqRTzZlEH/YO9pRaaUwndt5TUoj5spK6oLskY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRGYK53+g2Z5fuLN9abzwz0IGEJ4Oj+8rtOy7qozqfphEY5osnDg80w1KNY/3Vls/
	 w7yj7HAdYLb7I0ghiobqwLPTgWnmJjx+XNoERfOtr+JuTKby0P2w1qFlgw0YwD+3xl
	 qa0wp3eGfg7J+3+aeZSTcglrk0Mb6+QSXouPJpAf6JcEJ+xCQqPHthb9eAPXBpcz7P
	 q6Df5gX/gBOwlQ9yUh86uw7VbayAt6dWa7RCSHWFo7WJ7HDDy4FiidQnhQkPdpX9GP
	 k0x6IQFaB1sx2jbSyx4q+2hHC2KPJt6J0yANFVEWjgHRaVqRBa/kjKpEV3oryuRzzI
	 xrahpCy+Eteug==
Date: Mon, 17 Feb 2025 12:08:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, 13916275206@139.com,
	13564923607@139.com, alsa-devel@alsa-project.org, tiwai@suse.de,
	baojun.xu@ti.com
Subject: Re: [PATCH v1 1/3] ASoC: tas2781: Support dsp firmware Alpha and
 Beta seaies
Message-ID: <e693c3df-1dbf-43a2-bcad-58ea4d895af2@sirena.org.uk>
References: <20250212145601.1279-1-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dc+yeonfnGvOTTRp"
Content-Disposition: inline
In-Reply-To: <20250212145601.1279-1-shenghao-ding@ti.com>
X-Cookie: 1 bulls, 3 cows.
Message-ID-Hash: 5X4NIJAJHNDS3PX2VRCHFCRDQFZIWJML
X-Message-ID-Hash: 5X4NIJAJHNDS3PX2VRCHFCRDQFZIWJML
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5X4NIJAJHNDS3PX2VRCHFCRDQFZIWJML/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--dc+yeonfnGvOTTRp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 10:55:58PM +0800, Shenghao Ding wrote:
> For calibration, basic version does not contain any calibration addresses,
> it depends on calibration tool to convery the addresses to the driver.
> Since Alpha and Beta firmware, all the calibration addresses are saved
> into the firmware.

This breaks an x86 allmodconfig build:

/build/stage/linux/sound/pci/hda/tas2781_spi_fwlib.c:373:37: error: =E2=80=
=98PPC3_VERSIO
N_TAS2781=E2=80=99 undeclared (first use in this function); did you mean =
=E2=80=98PPC3_VERSION_B
ASE=E2=80=99?
  373 |         if (fw_fixed_hdr->ppcver >=3D PPC3_VERSION_TAS2781) {
      |                                     ^~~~~~~~~~~~~~~~~~~~
      |                                     PPC3_VERSION_BASE
/build/stage/linux/sound/pci/hda/tas2781_spi_fwlib.c:373:37: note: each und=
eclar
ed identifier is reported only once for each function it appears in
/build/stage/linux/sound/pci/hda/tas2781_spi_fwlib.c:376:44: error: =E2=80=
=98PPC3_VERSIO
N=E2=80=99 undeclared (first use in this function); did you mean =E2=80=98G=
CC_VERSION=E2=80=99?
  376 |         } else if (fw_fixed_hdr->ppcver >=3D PPC3_VERSION) {
      |                                            ^~~~~~~~~~~~
      |                                            GCC_VERSION
/build/stage/linux/sound/pci/hda/tas2781_spi_fwlib.c: In function =E2=80=98=
dspfw_default_callback=E2=80=99:
/build/stage/linux/sound/pci/hda/tas2781_spi_fwlib.c:1608:31: error: =E2=80=
=98PPC3_VERSION=E2=80=99 undeclared (first use in this function); did you m=
ean =E2=80=98GCC_VERSION=E2=80=99?
 1608 |                 if (ppcver >=3D PPC3_VERSION) {
      |                               ^~~~~~~~~~~~
      |                               GCC_VERSION


--dc+yeonfnGvOTTRp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmezJs4ACgkQJNaLcl1U
h9C8QAf/SW7Mmf50xkpbLBNcuyrRs8xBCSN3Csgicg48Lago15sxlbW14ffe6rXT
XUZ0Thd/YzkVwsCp66v5jlA4xJEvY7JoZBIISCaq+z5WwdQZW89f4c2VtkkqF418
YB1CTJlaL/XkZRV9xROv6UM7FY7m7dtzDt7z7Q1K8Jpz4u7k8MrwTTWj1qsd64a7
VvVC2Pal+ahmTjsgb85ms7SabR9GrQ6i7Usbx66Zz0lM0waLQJG+q4Xn2vy06hU9
e+s/pjyf4R7V3URGqhLc2TZC6TjsnRgROSJdm5mUJrCu0/b6WcIjou8cIqdzWU3/
0vyR3TaDWAVYj10S7sWE7Hi7RjQ4Hg==
=bKPe
-----END PGP SIGNATURE-----

--dc+yeonfnGvOTTRp--
