Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1465CC4363A
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:07:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38397207BB
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qdoROVRj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="akE2NGKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38397207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E06AC16DE;
	Mon, 26 Oct 2020 13:06:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E06AC16DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603714057;
	bh=k/lA6Dkda+6vd6SRahMsDzJ+uJdsADh3oKw7p28hhps=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qdoROVRjBAyyQm0rmfCDJlAxl2Gi55t4R/SAwxCSJx5HupjNFxERLE9zV/fN25lc0
	 HOW8ItPBtDYDMnTuNBqLOPYG4ypqBPAk8+xoykKTkie/JXCKccKwQubmrVmx0VQ9Gj
	 af6HQLMYS8DV2yxslaMeJl5rhrb0YDuZD0EXD4D8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DAAB4F801D8;
	Mon, 26 Oct 2020 13:06:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1DFBBF80212; Mon, 26 Oct 2020 13:06:44 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0FCF2F80086
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 13:06:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FCF2F80086
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="akE2NGKi"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6044E22281;
 Mon, 26 Oct 2020 12:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603713997;
 bh=k/lA6Dkda+6vd6SRahMsDzJ+uJdsADh3oKw7p28hhps=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=akE2NGKii2ZnovqzsJkTwwqEs2qwcaC50pS828uzpgJDyQpFoaTuGLPyhs00oV2tD
 ta59UUokKoDcKKRS040UbeWrbwuHxv7hFreIPZzg6qy6kJ1n4iFf/fkR4EWZ6w/F/g
 IJJrnZkMoK+r+LUOS1bzd6IVRE0AcFFcoJiuoN3g=
Date: Mon, 26 Oct 2020 12:06:33 +0000
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [RESEND v2] ASoC: tegra20-spdif: remove "default m"
Message-ID: <20201026120633.GA7402@sirena.org.uk>
References: <e6e89abff9004e8ed2e79a9ccf1377eeac9e4134.1603542719.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <e6e89abff9004e8ed2e79a9ccf1377eeac9e4134.1603542719.git.mirq-linux@rere.qmqm.pl>
X-Cookie: Safety Third.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Thierry Reding <thierry.reding@gmail.com>,
 linux-tegra@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org
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


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2020 at 02:34:14PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Make tegra20-spdif default to N as all other drivers do.
> Add the selection to defconfigs instead.

Please send defconfig updates as separate patches, they are merged via
arm-soc.

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+Wu8UACgkQJNaLcl1U
h9BsEQf/bJ8JpSs01wcZxMpvZJtL2CZcnbcK2LRCO/xTGEM1bQa9z/NzruQ83TDf
3Mfn8UafejS24D1FYRylHRGvxPQb4fJmkINXRT/qGar1cgDKW3V+l53/o5WMuwwR
44qb4iTj1KaN0lZKR0D9u8aviRxqN2nmVWX1bjDxoqFLSSeQMqmUio0ovqsRf9WQ
RuPKzsNoXlL9xM/kfjtRgTM1/4uyhy2pHuCnH4EFDV8QJC1CVEyhVqNnu4+z+v/X
FV/CpiBbMR64UanqL56ehez0qeS8s4uobivn/MjkeNKchQF+ZFeB7cZlJVRq16XX
OECo4aEGG/F0a3Pwa4c6L05BRLts0A==
=jdIz
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
