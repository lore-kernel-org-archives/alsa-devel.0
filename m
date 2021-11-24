Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7D0C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Nov 2021 12:58:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D146178F;
	Wed, 24 Nov 2021 13:57:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D146178F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637758726;
	bh=vsVsagoiY0F4/uydLZDgana7weWtcVQC3gXtJPCx/ig=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hirkYYsvFzfphEVLDmw41U1voyUvnmi3Z3Bv6/O1TbZwgsbNOKMICID1HRZyTr+Ax
	 V/jRScPHVVjArFmpeMdhLU5O4iC+3WK+2PEH3YO10MoxzU/LuMKyAtdmm/C8eNJHNT
	 VAQTJYZJvxsJKW7EXUgZSpvswKc7JhmIWYWB+IQo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02AF7F8014D;
	Wed, 24 Nov 2021 13:57:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE6A7F8011F; Wed, 24 Nov 2021 13:57:54 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A0F8F8011F
 for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2021 13:57:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A0F8F8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AneXnjUS"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B2CA63258;
 Wed, 24 Nov 2021 12:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637758668;
 bh=vsVsagoiY0F4/uydLZDgana7weWtcVQC3gXtJPCx/ig=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AneXnjUSbgfyG9nxkume3qkF/+uJjxM/A62J6fu76kGooRO90z7P0/Bed1LcxYUEN
 XjIOmd2706PlSCC+F1gGtabuuy+HhVw75fmLvrtNRbrl3ceFvKMHL02oQr93tOZfOb
 3odDd5mTwLgqF1tb/yrqvfMQYuT6byZw5h7yPW/DJ0sJcp5QZ0zBNua1mW3CSexKxg
 3uPwi4M86ORZtJj9bag1204nlYansShR1DMI+u9+XJxDE65wTyeZL1Q9zJd40GXFB6
 +LsbRvgP9vT3FuJ1Ak+7Wq4uH7GUTFILPn8Ears7Rl1aWgbNi2FTeDVga/IBESgUNm
 UsIVa7uC9u/Mw==
Date: Wed, 24 Nov 2021 12:57:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH v2 1/3] ASoC: SOF: sof-audio: setup sched widgets during
 pipeline complete step
Message-ID: <YZ42x4GkTEboP1bi@sirena.org.uk>
References: <20211123171606.129350-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ubdSIvIoQZalMlu7"
Content-Disposition: inline
In-Reply-To: <20211123171606.129350-1-kai.vehmanen@linux.intel.com>
X-Cookie: (null cookie
Cc: alsa-devel@alsa-project.org, yung-chuan.liao@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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


--ubdSIvIoQZalMlu7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 23, 2021 at 07:16:04PM +0200, Kai Vehmanen wrote:

> Fixes: 5fcdbb2d45df ("ASoC: SOF: Add support for dynamic pipelines")
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This doesn't actually apply as a fix FWIW, I've queued it for -next.

--ubdSIvIoQZalMlu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGeNscACgkQJNaLcl1U
h9Dnywf+LnO1gCmaSzt7vGSniDo3SGgTRNB78Uy0uw3ubtx9EXFjYTrVQ+XfCD+2
o9bP6f0XGa9r5xqkJEu9s7zHSsfe+QdHt1PLSAbZKkGZAB+3Aa0yhsT0mnKHLFSe
Qhhigl/nKiuMbUGQx6Jg4LTWzfuNP8cQ2o0ptN3bw/3LnoBh/homX5/PjVGq1lYf
6EFdF7QHiKErBaFAcZDQD7QIl/VdE5yB0KdQrVFIhJM4jZrzTb2bykhuamQ0r4kS
/FSVGW0/+8G6vCRjhkX3amcHEHtoTVOgzdE4vQDYjNek5+U0Ywd7+b+M4gjPnhw6
P+pmZUzywjFXbZO4JXiQDm3TJaUQog==
=RB+r
-----END PGP SIGNATURE-----

--ubdSIvIoQZalMlu7--
