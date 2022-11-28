Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15821C433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Nov 2022 13:05:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2AE541678;
	Mon, 28 Nov 2022 14:04:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2AE541678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669640718;
	bh=MAHEmDCiN0vbrOZKzNTziYXCfsP5QEh77/H5l6XhV4A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nVDdHRfJdP/uzioWmMIJ48lz2aBsOPqDCSsoQ39130LhkzyMRAsg2D++Nr7UyeXkY
	 okm5CMTRR8ugzlEJQQGPN6fL9Vd/yXwDU23eepIRr4l4Ie843UPo7uJ9HB03IluYWn
	 u9A3JNnp+wTOjf4tqzy982Sr+tpjPVc/rESMOo0k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C92F6F801D8;
	Mon, 28 Nov 2022 14:04:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3D81F800B6; Mon, 28 Nov 2022 14:04:25 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D01CDF800B6;
 Mon, 28 Nov 2022 14:04:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D01CDF800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ih5j5qgb"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EBE6FB80DB1;
 Mon, 28 Nov 2022 13:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF31C433C1;
 Mon, 28 Nov 2022 13:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669640651;
 bh=MAHEmDCiN0vbrOZKzNTziYXCfsP5QEh77/H5l6XhV4A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ih5j5qgbjrAldGfHjRrTtjSZU8R5xKjXKh9C8AZK4IppzHNjJu4bNSR8icuDJm7fd
 hoL3fPX9rBBe94BmqlKqO+BbEvfXeyFJccTdnTq5iu+CwXh0LuRSc0pv0L/D6ddke7
 3yNY9XGMWYXIgAKrHpQzNfVBjCSU48Eh3Nmp52m1VecxAcPzPhOtmohrCvHMVvYNnE
 nY1UrX7dvrSEtzxjCUmWTKc9pnVq64bAEDQHFOy1kU6Zqi5c1mqEUi85EIvTEX0F15
 54F1HrJHTO4PElbESfvSru0f+jl3Wd9V69/6C/OpXIJWC3nC59S753sA7f419FIMbA
 IpPoGeHopPJcw==
Date: Mon, 28 Nov 2022 13:04:04 +0000
From: Mark Brown <broonie@kernel.org>
To: V sujith kumar Reddy <vsujithkumar.reddy@amd.corp-partner.google.com>
Subject: Re: [PATCH v1 4/4] ASoC: SOF: Add DAI configuration support for AMD
 platforms.
Message-ID: <Y4SxxLVu+aSWiLHz@sirena.org.uk>
References: <20221123121911.3446224-1-vsujithkumar.reddy@amd.corp-partner.google.com>
 <20221123121911.3446224-5-vsujithkumar.reddy@amd.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jRcYyp1a21ZEBUQI"
Content-Disposition: inline
In-Reply-To: <20221123121911.3446224-5-vsujithkumar.reddy@amd.corp-partner.google.com>
X-Cookie: The meek are contesting the will.
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, venkataprasad.potturu@amd.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Basavaraj.Hiregoudar@amd.com,
 Takashi Iwai <tiwai@suse.com>, Chao Song <chao.song@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Vijendar.Mukunda@amd.com, V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
 Rander Wang <rander.wang@intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE \(SOF\) DRIVERS"
 <sound-open-firmware@alsa-project.org>
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


--jRcYyp1a21ZEBUQI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2022 at 05:49:11PM +0530, V sujith kumar Reddy wrote:
> From: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
>=20
> Add support for configuring sp and hs DAI from topology.

This doesn't apply against current code, please check and resend.

--jRcYyp1a21ZEBUQI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOEscMACgkQJNaLcl1U
h9DyDwf8CgLg3OCxJy2zctWsb8kB4EaKtieIb81yXKV04kOB7HuVezVhLNMH1DjY
g5+sF3UOX5ojq43XmLQvUHluNdjehIvK5JCPIDUCuACR0oLSO7mmcAmIQvwFqCnF
rQcAbdFOH2gk8kvyINyxv/jRTTBhsc9iSvoPfVaQOQzPeSVZ2OsSLrDvUEpxNGpl
ma0ssie7dmnZNaOFtXxbK/bXMYix28tZp7J7mFEEg4zCATR3Pzhchg4/RBGd//p5
kDcX+UsNQRz7ThSME+QU4WomoLnYx0OermyVDVbW7I1ScKTve6WrwM64LaXbS/2S
lJnJloUwUfb5BLxjSh8zgKwobKpHzQ==
=XLKQ
-----END PGP SIGNATURE-----

--jRcYyp1a21ZEBUQI--
