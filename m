Return-Path: <SRS0=ac5z=QE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B140C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Nov 2021 17:30:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611C861B9F
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Nov 2021 17:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 611C861B9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC88A1843;
	Wed, 17 Nov 2021 18:29:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC88A1843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637170248;
	bh=/OY3TTIbV3uqWHM/tEbq0g7zfM/Ce2n1Er3jv+U3qDM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AEu1wYON52ZnhDADu+C9xjp7+dcFjQDQ7Bdh5p3h80V0GhZCcqyF0hvGYtAjq26YK
	 3crJ7ygYhspb2thRmrvYo+KlcWmA0WA7ETNh7bMLKdTaNVY266AQnUwQUe4MlSJSnU
	 Zcil7Pjm2sZxtRI/y4I/wrLhJi5AyRHyJnBsIhb4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ABE99F80134;
	Wed, 17 Nov 2021 18:29:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30A86F8027D; Wed, 17 Nov 2021 18:29:36 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84D0DF80134
 for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2021 18:29:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84D0DF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="riEW7iAQ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE6BF6138B;
 Wed, 17 Nov 2021 17:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637170155;
 bh=/OY3TTIbV3uqWHM/tEbq0g7zfM/Ce2n1Er3jv+U3qDM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=riEW7iAQGlfz/01XujlKXW58hpsfRK2MX8Vib0ljC9yKWVFlvlq3qyx/nf0HCUc+a
 5AbHTlE66rT1wD34hxtikfQRt4ud9m637U1/octfKduJNIjD2CMbbP43LKiMgFNRWW
 i5WFd1cMfci2wDKywf7cx4CbFcxLeQYBDmkqL7E2udw7WZZb/FvZItvt022qlnMONZ
 dk3PVaz22gcjJ+nNDFPc49SJdWvJvRenasLC512ZHRbgXFCcvqD2ffPq4RL+EwtvNA
 bZeOnOyhCY/qd+Bs5WILvGYDCD8vA9TMYu9rQ3CneU1PUCvZXLeby4QfKAakiGtoeh
 FKWxlDvSP10AQ==
Date: Wed, 17 Nov 2021 17:29:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 16/21] ASoC: SOF: topology: Add support for Mediatek AFE
 DAI
Message-ID: <YZU75B2JHbYHy40l@sirena.org.uk>
References: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
 <20211117093734.17407-17-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y1aGE2SznRaFViUz"
Content-Disposition: inline
In-Reply-To: <20211117093734.17407-17-daniel.baluta@oss.nxp.com>
X-Cookie: Leave no stone unturned.
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 daniel.baluta@gmail.com, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 AjitKumar.Pandey@amd.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
 alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 Julian.Schroeder@amd.com, linux-mediatek@lists.infradead.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Balakishore.pati@amd.com, yc.hung@mediatek.com,
 vishnuvardhanrao.ravulapati@amd.com, vsreddy@amd.com, daniel.baluta@nxp.com
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


--y1aGE2SznRaFViUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 17, 2021 at 11:37:29AM +0200, Daniel Baluta wrote:
> From: YC Hung <yc.hung@mediatek.com>
>=20
> Add new sof dai and config to pass topology file configuration
> to SOF firmware running on Mediatek platform DSP core.
> Add mediatek audio front end(AFE) to the list of supported sof_dais

This breaks an x86 allmodconfig build:

/mnt/kernel/sound/soc/sof/mediatek/mt8195/mt8195.c: In function 'mt8195_run=
':
/mnt/kernel/sound/soc/sof/mediatek/mt8195/mt8195.c:207:2: error: implicit d=
eclaration of function 'sof_hifixdsp_boot_sequence' [-Werror=3Dimplicit-fun=
ction-declaration]
  207 |  sof_hifixdsp_boot_sequence(sdev, adsp_bootup_addr);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
At top level:
/mnt/kernel/sound/soc/sof/mediatek/mt8195/mt8195.c:201:12: error: 'mt8195_r=
un' defined but not used [-Werror=3Dunused-function]
  201 | static int mt8195_run(struct snd_sof_dev *sdev)
      |            ^~~~~~~~~~
cc1: all warnings being treated as errors

_boot_sequence is added in "ASoC: SOF: mediatek: Add fw loader and
mt8195 dsp ops to load firmware" which is later in the series.

mt8195_run should be either global, a static inline or not declared in
the header at all.

--y1aGE2SznRaFViUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGVO+MACgkQJNaLcl1U
h9BHUAf/WPdQ1sU34pc7wXKT7HjpQzqXz6Y92JQZagFk6v6n4c5zaV8lGeMp4RJe
b7qYWE1l7b+95S89NCV2cZOTqRX/e0aikOjZp4COv6NUSx9wwq6niGVbf7Vp7514
eRbtxcUNrzrjW6ccMgjuV9J5X+QMXY6+hShIqxVFFDWuzQl0TzXFpXaZ1mb7C1gC
KQIkWxluoO20C4TSQi/TvoxSGnxIfq4dvrb6i1oVMFnMOBvbQrqPRkVs1+r+cv8K
s43s9ZjcIQkDOzVX76tMmLSb64yEP+7FJzlwIhaIaPOoMmebYpzzf8JNHE4rjti1
necJgXEnDl0sH2hhC7ZS5gv1m6qkGQ==
=WcZw
-----END PGP SIGNATURE-----

--y1aGE2SznRaFViUz--
