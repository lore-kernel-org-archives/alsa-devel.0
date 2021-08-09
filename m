Return-Path: <SRS0=CTIr=NA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77461C4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 11:39:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D66D6054F
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Aug 2021 11:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D66D6054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B838167B;
	Mon,  9 Aug 2021 13:38:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B838167B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628509186;
	bh=S9kxTtlXTJr3NbJmG9tLK9bXNWLQ2s+Fd0kDKV43p24=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZJrxFvWC0DxDMDULG0fKIdLpmRypoJe9JKMa8W1eijBVFUF99dBuh2DZ7pztwAjO8
	 IuOHfhzOf6Q/QFBUNVrLpPrQVR3N6myEHIKjrKYL6aiR5SAgB+OrNY3ajEqQ/aobE9
	 14CyL2DRNG6ad37le4JnQTO6Cdkx5tnpCZfy3D18=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2C44F800CB;
	Mon,  9 Aug 2021 13:38:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EE9EF802D2; Mon,  9 Aug 2021 13:38:54 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B05CF800CB
 for <alsa-devel@alsa-project.org>; Mon,  9 Aug 2021 13:38:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B05CF800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TLQ9/ffa"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5270860EFF;
 Mon,  9 Aug 2021 11:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628509125;
 bh=S9kxTtlXTJr3NbJmG9tLK9bXNWLQ2s+Fd0kDKV43p24=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TLQ9/ffazQ1dgt0npsBtWTPE/yxxm2Ym25BO9Qlkt8E1NbvPnHVTi0oRyCTQCrc1J
 Yolp5DNM/cpwRN1DMnk4ThvVptEoRYUxKud7yNYXPlUltilIVx+Ken2CrCrfFVUxEv
 YKo/O3rFXIFom7tN9TdXMKukl/MlpfOdaVy+UvkQ/ma2Anf3whm2z9i1LSTHW5ok3N
 rOfPWEIi5TEEAcFGTi8xgtkvs8fK04i083EhjbTh4Q7hkhclLWCwStRhvBkeDiLcOe
 kiLXLUi1bvRAT8Bgat4udPZWExUlR18om2TKTKlTGdeg6j5Di6ab9FVAm4maXYL07V
 27NB5fNZ6TfVA==
Date: Mon, 9 Aug 2021 12:38:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt1015p: add new acpi id and comapatible id
Message-ID: <20210809113825.GB4866@sirena.org.uk>
References: <20210317062309.14051-1-jack.yu@realtek.com>
 <423b6c6b835e431da2f196036ac2ab4f@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline
In-Reply-To: <423b6c6b835e431da2f196036ac2ab4f@realtek.com>
X-Cookie: Flattery will get you everywhere.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 =?utf-8?B?a2VudF9jaGVuQHJlYWx0ZWsuY29tIFvpmbPlu7rlro9d?=
 <kent_chen@realtek.com>, =?utf-8?B?6Zmz5pi25b+X?= <kenny_chen@realtek.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "tzungbi@google.com" <tzungbi@google.com>,
 Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 09, 2021 at 08:52:49AM +0000, Jack Yu wrote:
> Hi Mark,
>=20
> Could you help to review below patch?=20
> https://patchwork.kernel.org/project/alsa-devel/patch/20210317062309.1405=
1-1-jack.yu@realtek.com/
> I'm not sure if you miss this patch or not.

Please don't send content free pings.  Sending content free pings adds
to the mail volume (if they are seen at all) which is often the problem
and since they can't be reviewed directly if something has gone wrong
you'll have to resend the patches anyway, so sending again is generally
a better approach though there are some other maintainers who like them
- if in doubt look at how patches for the subsystem are normally handled.

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmERE7AACgkQJNaLcl1U
h9BEwQf+PloEdQw7KxKYmci1nNBpHQSp9jYL7MNa/hCQFQen4o0CfH2p/NUVyZec
RSVpsOqA0+zV7UfzwfBPOkxt29gQULq9ov7Fin1wKY951GrrgFM2nvXQ368rl1EQ
h1Q24i4LxHrDb28yFDNcSPcVr4iuv0nIrFtaIfo/2SXLUhL/yVXb2kDQgttvkmTn
14NXeDnzJRaaQNu9SG3vEP8JbTfiae28lxOADgJbiAb929ZNZDMNVDmHIpXN2sO8
kw5pUGWzbil7QUBKjMDt4fekgVFqz+NAOqwf+BZrt2vSzHzuibltrqGKGWoGbFgi
RSc53O0Vng9YZkCpE663HNXBh/OzVQ==
=/kBa
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--
