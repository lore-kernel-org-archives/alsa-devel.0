Return-Path: <SRS0=8QnY=FM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8975EC4361B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 17:41:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A30EE23B23
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 17:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30EE23B23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43F31843;
	Tue,  8 Dec 2020 18:40:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43F31843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607449278;
	bh=yOyC4qHKemto1j72GzyjD19aXtaWVjGOr3sC0BhP930=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kDBce+1jCoGBiwJmxXl4J+Bh7xRHr8K2B1MQhyuWyD9wpLNlNYxaH4d6G8LK1M6AK
	 Z9CEnJIwfugirFojwyz4ogb+snvnoMjRuIfmt3F7RNmLxAK2/JJz0nCLEuAmXQy0GO
	 blvJxUQS1BgqdfwzPboexOp3LPXqw4bWK6MDQk3Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD809F80164;
	Tue,  8 Dec 2020 18:40:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54724F8019D; Tue,  8 Dec 2020 18:40:15 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA62EF800E1
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 18:40:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA62EF800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bnatAupE"
Date: Tue, 8 Dec 2020 17:40:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607449209;
 bh=yOyC4qHKemto1j72GzyjD19aXtaWVjGOr3sC0BhP930=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=bnatAupEo9hjxtvW77bK9zTRwDyFZD2KxX9isVsBQ5nhpXWUwEfGn+iIV5ceMUMM0
 uSdhk+YiF0LtexT5Uq2nuKZxKVScen1EXKXRBGe3iqA1uMhsvu0b6GBHnWfEPsr1VS
 8fuAD09yv4njGrqDFOr8b8lCpXEebehM3jEyxcn6f3HAlWUltdTQjdfTIkxMtRCL/R
 EPJGu4X+m6ZVUBTnU4bWfp81wm1cZ9+yCHwkkFl/oLA5srkzkhGtzCPl/F88xDUGw0
 F4g+SHp+ZXnEDlATE8Gegxl2+ulXzsy4NKq3cELAH/m5HOWNs+dBvhPy3xUj74Kv7j
 JQJw1FOTir7nA==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ASoC: AMD Renoir - add DMI table to avoid the ACP mic
 probe (broken BIOS)
Message-ID: <20201208174002.GH6686@sirena.org.uk>
References: <20201208153654.2733354-1-perex@perex.cz>
 <s5h4kkww9j3.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nOM8ykUjac0mNN89"
Content-Disposition: inline
In-Reply-To: <s5h4kkww9j3.wl-tiwai@suse.de>
X-Cookie: Do not dry clean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, stable@kernel.org
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


--nOM8ykUjac0mNN89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 08, 2020 at 05:24:32PM +0100, Takashi Iwai wrote:

> BTW, both Raven and Reonir drivers point to the very same PCI ID,
> and both drivers will be probed for this machine (and both to be
> skipped).

Ugh, that's not good.  It's not even super obvious from the code that
this is happening.  Seems like it should be one core driver which
instantiates the components for Raven and Reonir as appropriate, the PCI
driver is pretty thin at present anyway.

--nOM8ykUjac0mNN89
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/PunEACgkQJNaLcl1U
h9C1DQf+OHdY/C+svGqUFYKBxhn9Yj9BXS1k3Idh1csgs7klXpUSdAEml/eMfcnn
RZ6dK7Qg5GI3KBZtOASwdGg8E9UpKUwFlzgodK0Px497xpCaaEEsJj4CCNKoYAEN
YYw6J8qqpv27UlaMIkzxxatQreQM0GITWXWCkeQvfuI3sCFcxjQ5SGTt2ax7bjYx
XMPziPeNnb/FTnOpCPJkJctnJYND31Pd0M25LdOGqnbTrjMqSTZ641C1AKDjd/1D
90enl5f2s1eVNvG/r7X3gXKKGIlKH1dLbfO/9LFY5JyJsQv3Ocle4vwduP7HxhL8
7ezX6E9Pzd+XhOFQRkKzShBwenmk0A==
=h5Xu
-----END PGP SIGNATURE-----

--nOM8ykUjac0mNN89--
