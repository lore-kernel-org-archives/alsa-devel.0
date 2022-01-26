Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEB8C28CF5
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Jan 2022 16:51:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C8E11EFD;
	Wed, 26 Jan 2022 17:51:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C8E11EFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643215913;
	bh=1cgmbcZ0e/AT2PqQvRKm/v2aOJwVfwwesAq0tfOOHcQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t+QU4ndk7tY8ZmI9j33mfpKwoTnnVRqSHFK83C8OGa81bOmigxV/Xy+bJs6qeR6d+
	 zfyPbh6gjNR/q/O70WnOfDamd9hc46vdD5F84nFob9PaQXeY/eVHLwhMRH7zrUBPyS
	 47qfzoK74CxOJeOlhHbl3Q2NL67yx1NZxnHFZjk0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A3AA6F8047D;
	Wed, 26 Jan 2022 17:51:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBE39F8049C; Wed, 26 Jan 2022 17:50:59 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF49FF80118
 for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2022 17:50:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF49FF80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HDzMRyNr"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6DA8161A90;
 Wed, 26 Jan 2022 16:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC97C340E3;
 Wed, 26 Jan 2022 16:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643215849;
 bh=1cgmbcZ0e/AT2PqQvRKm/v2aOJwVfwwesAq0tfOOHcQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HDzMRyNrEJENcowk1xqt+k2IrEi6qh5BxqxnclOJKO2dqh3/A0N5SiuPxnIirhf7I
 SIATo2hAoQQu19QHkddDteWUjlIncQe+vLBQYY6f+J8UW/2r2ZGmJVXSgMRbpljhW9
 cIxAxfkI/rQr8zo393UmHUnX9+C2zNqys3E3xcjkjOwsaLyuL/k5xQ9Ol3OOeB9Dh3
 Gzad1+9sXSD2LqH3KQkRYFTX8UbWE5bG/Y0uBj1GoFibNiP5YWTL/9enFLh9tH2F0y
 z9J7UtmtUs2mp8CdBJpzJZZexZkk1qW5rEWfCeuWbIuJKiAEae/HFElejXVln+OxKG
 /v0regaxaCcsg==
Date: Wed, 26 Jan 2022 16:50:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH 1/5] ASoC: tegra: Update AHUB driver for Tegra234
Message-ID: <YfF75N97CzLNDRMs@sirena.org.uk>
References: <1643100491-5398-1-git-send-email-spujar@nvidia.com>
 <1643100491-5398-2-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7G6rfQCsm0QlA7PU"
Content-Disposition: inline
In-Reply-To: <1643100491-5398-2-git-send-email-spujar@nvidia.com>
X-Cookie: Falling rock.
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
 robh+dt@kernel.org, jonathanh@nvidia.com, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, mkumard@nvidia.com
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


--7G6rfQCsm0QlA7PU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 25, 2022 at 02:18:07PM +0530, Sameer Pujar wrote:
> From: Mohan Kumar <mkumard@nvidia.com>
>=20
> The register offsets of switches connecting various AHUB internal
> modules have changed from previous chip. Address this variation by
> making use of Tegra234 based compatible.

This doesn't apply against current code, please check and resend.

--7G6rfQCsm0QlA7PU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHxe+MACgkQJNaLcl1U
h9C39gf7Bgac0Z427RTs2ThXzH7ngg9dB03iZ+TD9vFLhe4Prs/g68DP3xec+gCI
yG2D688DuGSW6QSIcGggWJHgrTYqzD0+IC1bE1JmamwUB4ulq2ftBIqk4ot0l9t4
UQu4CYuL52Tohok1/1RKQYRVKAD+Evw5fFrygVCRPXqU4bhTOiEA+z+6MxL1zfcO
YZEAvcm3WYjzqK5+so6kcCJL2aVIc7u2TNekGm343hvnwDthhZPjENNrlM1xwlYG
XpsHUKxvWEBXRn2wE+eB5mY81VvmhVd4W1/002WeVICx1w34pxFQVtvTk4DZFsB2
bPMLsH0d6SXkpRPOXSVXi5fvC1WwRQ==
=udiP
-----END PGP SIGNATURE-----

--7G6rfQCsm0QlA7PU--
