Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D62C27C79
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Jun 2024 11:58:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A28AC851;
	Mon, 17 Jun 2024 13:57:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A28AC851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718625489;
	bh=zcF/2nXoBUoTs0IfILCFfijm4oSftAfNtCrvpe11/JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dEHx+odX45khOAKJN3KypVIoM8thyMmgFlmk7a/yHWl3hCiksIxalj8gC43OydcPj
	 W7h/h3Q5h//HfoDp/8jhsxDp/2J6xccpONO9WvCPMi6eR1MyU6kSfl6FwvwiIagVsX
	 HZSIZ7s3fmNKCWG0jp6OENeKs2484jvKH3rYIiC0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 065AEF805BA; Mon, 17 Jun 2024 13:57:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 85757F805B6;
	Mon, 17 Jun 2024 13:57:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AEA2DF80269; Mon, 17 Jun 2024 13:56:07 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D1D6AF800ED
	for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2024 13:56:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1D6AF800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=MNlghp6D
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EF8366125F;
	Mon, 17 Jun 2024 11:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D453FC4AF1D;
	Mon, 17 Jun 2024 11:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718625361;
	bh=zcF/2nXoBUoTs0IfILCFfijm4oSftAfNtCrvpe11/JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNlghp6DagZTuTPTqt7feyE/Pjb+tLZZgu0Kr3PsMIWSKE0VWP1UYsimkCgtLoE/C
	 wslQ3UHIOFq9Rsp8QOLEB3fGaD/EiPENVDmb4PCMG2frVOK6RHfxkXYGKig171GY57
	 jsu/Mw6n/v18YMASJ6qhRyFZNIYHqSDXHzI2zJfjESwb+4kGYW1RJUSymHK0DEZPtA
	 Q2C27waazGeMCrQy29psngYn2EKl/GCHgE/Tp8BrwNR9QRPRidZXT4ptJrCTRo3LFv
	 Puz0e6/XdVV3fQhv1ZsxgCmVrezG7nBcKVi2nI4oCZeBCzxwhef5lRUSO53mJZDvBU
	 px7qdOWQ0JHZg==
Date: Mon, 17 Jun 2024 12:55:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
	quic_pkumpatl@quicinc.com, Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v6 3/7] ASoC: codecs: wcd937x: add wcd937x codec driver
Message-ID: <f741630e-f9e8-45e1-b3e2-4866f0baeac2@sirena.org.uk>
References: <20240611074557.604250-1-quic_mohs@quicinc.com>
 <20240611074557.604250-4-quic_mohs@quicinc.com>
 <2b92c0f9-2595-4b73-8015-1abb825a61a1@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IKXHfzXLDDZvI4f7"
Content-Disposition: inline
In-Reply-To: <2b92c0f9-2595-4b73-8015-1abb825a61a1@wanadoo.fr>
X-Cookie: Life is the urge to ecstasy.
Message-ID-Hash: Q52LAEILZV63WUO2LWDBFY3YYQFZVM7X
X-Message-ID-Hash: Q52LAEILZV63WUO2LWDBFY3YYQFZVM7X
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q52LAEILZV63WUO2LWDBFY3YYQFZVM7X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--IKXHfzXLDDZvI4f7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 04:54:58PM +0200, Christophe JAILLET wrote:
> Le 11/06/2024 =E0 09:45, Mohammad Rafi Shaik a =E9crit=A0:

> > +static void wcd937x_soc_codec_remove(struct snd_soc_component *compone=
nt)
> > +{
> > +	struct wcd937x_priv *wcd937x =3D snd_soc_component_get_drvdata(compon=
ent);
> > +
> > +	wcd937x_mbhc_deinit(component);
> > +	free_irq(wcd937x->aux_pdm_wd_int, wcd937x);
> > +	free_irq(wcd937x->hphl_pdm_wd_int, wcd937x);
> > +	free_irq(wcd937x->hphr_pdm_wd_int, wcd937x);

> These irq have been requested wth devm_request_threaded_irq(), so either
> this free_irq should be removed, or devm_free_irq() should be used if the
> order is important.

Yes, this should be fixed.

--IKXHfzXLDDZvI4f7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZwJEcACgkQJNaLcl1U
h9BiSgf/a6KPiaGF02vTC6372jxwFNBIm3cNPKZNeyNpRRu/hf1ru8zAJllwGy3w
jmCbCxYcnIzP5H5Hs/F7DLxQ9zaUbTRSp1irscvX4KGvbR6Jm17p7lrLp7tWz2LF
sZT5ha4eSzyRnB/1h5a8jtq8TxhSCSfzfKxXJiZPpr8q44lEHrIjurttAJ5jurph
ucJZ9kaS3oER2djdLu2IizER1e9LW2zCB+T4TwbYkPxfVuAE9EMpxmtUEegkEP1w
F8EtFjowt9U7IL8whvvAmbUW0hzJRDnKxAyLDsC1xWE9V2fsKGpcGEKig5e0m8kB
77V/5PeoWOVfqxadcYa00d+xcoFIyQ==
=kada
-----END PGP SIGNATURE-----

--IKXHfzXLDDZvI4f7--
