Return-Path: <SRS0=2x8D=I4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF94C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 17:10:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34C7619CB
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 17:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34C7619CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5D471675;
	Tue, 30 Mar 2021 19:09:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5D471675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617124230;
	bh=uIEg22xT2klEz+m34gGB1p2VL2itTxZRE/biPoxhASk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=los71AuJV1BnfNzRECjWq0RMfqtjYXby9Qy7huzDS8YLCPGZBBQA5VnuFvW/ip+bN
	 N3KHrBS6RsiB9w+M+b3qEDHDRDBtouck9zWRdJo5dO9JGoTfI8YbYkHgRgmOTJQ6bL
	 YeFsI4Fs1E2Sk+/esNuXXz5LIoS/BwzG/ZD/xgiQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A974F8023E;
	Tue, 30 Mar 2021 19:09:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2317EF80240; Tue, 30 Mar 2021 19:09:38 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8BC7F800B9
 for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2021 19:09:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8BC7F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IjnYc0sd"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 368E3619AA;
 Tue, 30 Mar 2021 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617124169;
 bh=uIEg22xT2klEz+m34gGB1p2VL2itTxZRE/biPoxhASk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IjnYc0sdh0ArAatNW9i5fDsriXvLFH9V1aYiC+u2/doWA0xDk0F899sDkDOOhjsed
 nJc4n3ZlQ7Av9KDRpoS3lfZUxrsygnyoHxOVbuu5Q6r1DdV5EKNFYapI+IFfrL2D4B
 iabYvL+fls+lmtHuBstUX0sWIlxxma93FcJZHNtr0SU8T68rUr/CU9dGOW2/VDXrQ2
 MRoCN0ddE3Ur6Pv46UEUQ43l42UVrrebDFeb2/jvF3fHLjV1RFuu2Z7Xy6n43VQlYJ
 Ycc+IrwJ8n9Nen1ocz1k4VP5QhprGA/LUgScv7ddU5bCL/k7/myjYc2vu7Ykx6xbiV
 EnmYmJbtaQOqw==
Date: Tue, 30 Mar 2021 18:09:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>
Subject: Re: [PATCH v2 2/3] ASoC: rt715: remove kcontrols which no longer be
 used
Message-ID: <20210330170915.GH4976@sirena.org.uk>
References: <5c314f5512654aca9fff0195f77264de@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OgApRN/oydYDdnYz"
Content-Disposition: inline
In-Reply-To: <5c314f5512654aca9fff0195f77264de@realtek.com>
X-Cookie: Memory fault - where am I?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 "bard.liao@intel.com" <bard.liao@intel.com>,
 Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>,
 "pierre-louis.bossart@intel.com" <pierre-louis.bossart@intel.com>
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


--OgApRN/oydYDdnYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 29, 2021 at 06:54:00AM +0000, Jack Yu wrote:
> Using new kcontrols "Capture Switch" and "Capture Volume" instead,
> remove kcontrols which no longer be used.

Is this going to disrupt any UCM profiles?

--OgApRN/oydYDdnYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBjWzoACgkQJNaLcl1U
h9Cpugf/QeJnZVvHq2t17gLkZNZ3GI8IukKhWJjOES0D/RO1UCS3ZLZ9JNCIYDCU
PYE3MqNern5kNEGTtSLjPlp/RtHblLX4dUhomdbAjHAOgYF5lAiW/0R+nOde0HRv
uO+RsoBwQwQjyDz26B8uil4LP/klm0B1iFyGQO8Pw5P0+BRUdGBfpyzaj4e+HlRC
2TSxkcESodyNyHH31tG8zB3cQ0PCzO1JFc4+0zAGHU5hgN7W3bgipynxFTehJWsJ
JUZV+1pd3MW0d3bw+typ3Dsvo2IhMouhEpeUdwPtr4RkuuQ4WA3H1PNIolO9wvDJ
0ApLFl8UGv+O/JYFFcCrqmHRTayAcg==
=uFIl
-----END PGP SIGNATURE-----

--OgApRN/oydYDdnYz--
