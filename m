Return-Path: <SRS0=qvmA=JD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E27C433ED
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 14:45:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AAC613C4
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 14:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AAC613C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD22484C;
	Tue,  6 Apr 2021 16:44:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD22484C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617720340;
	bh=i71hhYw3F74gnofXNvpnYOIGFdLIheWYnd7NNTeKahQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NxQJ6BfdQpMEWb85svJR9sjZmkhmhNFotBSV510OLYy9PG3RDPuoAOwJoqd9OR3Y+
	 djovYwQPi53015lbYzTy0AW5ClVgTppKWcq68WpnV1Xj/5mGKpGtMVgIEkV+W3TZsu
	 RbNIdz9LVV7C6M83uSh0Arkl9j6s4/BH9NkabYBY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3989EF80169;
	Tue,  6 Apr 2021 16:44:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2598DF8020B; Tue,  6 Apr 2021 16:44:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78688F800E1
 for <alsa-devel@alsa-project.org>; Tue,  6 Apr 2021 16:44:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78688F800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qhi6RZIp"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 591A961262;
 Tue,  6 Apr 2021 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617720280;
 bh=i71hhYw3F74gnofXNvpnYOIGFdLIheWYnd7NNTeKahQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qhi6RZIpRu437fNY1V89wm49ZAPtfkZQS9GpDbBUcNVSn8qbUAZda4YjESeWNvDq3
 UB8GQc+FZRxQlkF0zg6MynNfUfCLbPV0pG7/jVSiuRjSbzf0SBwKpcupMD72Yd/66I
 vbGJ1LX+yAa6HQdWx0RrOa+vZtYV927jx8G9L6uw2bNk4PAnFMzA+LHyHlWl298OKY
 rMFp0d3ypXu0C5sICPGiAN6oXrojUnDUuctfyLFXNjkG32Ht7IPMF05JxiPxi7mPDQ
 iJTp2xO0Ze8zUYnG/fYMFU/XllqwRZelUMETPaziKcPkhqJbjGDwnpfDjwzYTwHt2T
 /YXDV9TXr0OtQ==
Date: Tue, 6 Apr 2021 15:44:23 +0100
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?SmnFmcOt?= Prchal <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH 3/5] SOC Codecs: TLV320AIC3X add SPI: I2C code
Message-ID: <20210406144423.GK6443@sirena.org.uk>
References: <20210406105018.59463-1-jiri.prchal@aksignal.cz>
 <20210406105018.59463-4-jiri.prchal@aksignal.cz>
 <20210406121326.GG6443@sirena.org.uk>
 <888ec87b-d79c-163b-ffa2-899362dec9e3@aksignal.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d6d1KVhp94hk3Jrm"
Content-Disposition: inline
In-Reply-To: <888ec87b-d79c-163b-ffa2-899362dec9e3@aksignal.cz>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>
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


--d6d1KVhp94hk3Jrm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 04:05:21PM +0200, Ji=C5=99=C3=AD Prchal wrote:
> On 06. 04. 21 14:13, Mark Brown wrote:
> > On Tue, Apr 06, 2021 at 12:50:16PM +0200, Jiri Prchal wrote:

> > > +++ b/sound/soc/codecs/tlv320aic3x-i2c.c
> > > @@ -0,0 +1,72 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * ALSA SoC TLV320AIC3x codec driver I2C interface

> > Please make the entire comment a C++ one so things look more
> > intentional.

> OK,
> but coding style checker complains:
> WARNING: Improper SPDX comment style for
> 'sound/soc/codecs/tlv320aic3x-i2c.c', please use '//' instead
> #64: FILE: sound/soc/codecs/tlv320aic3x-i2c.c:1:
> +/* SPDX-License-Identifier: GPL-2.0-only

That's a C style comment not a C++ one.

--d6d1KVhp94hk3Jrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBsc8cACgkQJNaLcl1U
h9BFzgf8CZ4Y6v17Mwd6/Fg+syQA9DTpHepM/rGytLPnA14bbj6PbDRmbmHs/U3D
5R+184xEB+8ISUBCixqXtEyqgyC84OJEups/jRn7WQn14k+2TzWKSI1TDGpFfrfx
l0y16rOYE6Le21fYzHLuNQ6mYDGPMln0NtKGDcepS1U5rjN2HLiu4YB8vxl4kJ0U
PwbtrGhrZqp5HMvOq9CmUUYubKPth6OjwnyWBx7o8guve3Y1FtJ0j/Rv9JB++H6X
EiPgU/3lO04efyiRAILpFCSwQk790j+p5KEuJRMPR0yYFDkE54gyS4cB3/bnoJbW
2Que0l0ppPJ3KWUit0uZd377lj2EPw==
=Q6cA
-----END PGP SIGNATURE-----

--d6d1KVhp94hk3Jrm--
