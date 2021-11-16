Return-Path: <SRS0=I3pN=QD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBB9C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 15:00:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9EF61C4F
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 15:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF9EF61C4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E086168C;
	Tue, 16 Nov 2021 15:59:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E086168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637074840;
	bh=kLgNCOXcOMdbR7IPP44gOExLnRjFLRrAYmTTznSGFas=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ewfEtXXB24y1lqGoBGDHDkntHF2yPXg0kc0xxjR9NJq5SP2LDvGk7+Q4c0Er/cDcw
	 8BA0wtsyMVvHTpTpSDU8AlxSwGv5wqOtfPB5XYLJX1BDMSCOMVHzHwNU9uUe/35Xkz
	 8qVDax7pssTIdzdcmUKQnxNUe9jom7yIl1+dFQzI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 12A5CF80089;
	Tue, 16 Nov 2021 15:59:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A069F80272; Tue, 16 Nov 2021 15:59:47 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CD0AF80089
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 15:59:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CD0AF80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PEt18bk5"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A60AA61C4F;
 Tue, 16 Nov 2021 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637074776;
 bh=kLgNCOXcOMdbR7IPP44gOExLnRjFLRrAYmTTznSGFas=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PEt18bk582cM292euP4s0OwFA1lx3lzTTclKy3RNrQ4QN2xysp9MJJSw7MGDMM9bH
 RNX30oV5vCIzcGXZ3oIULBZkWjAC5b0BJPnXeTziRvUR0cL8PUJvgF0msn25RAylB9
 hg7oPwHtqPsEYP5GG9CzRatQF6/l0DWdeT0Z8iruXDO72CV1FcF9jHuK8zB7nI32Rm
 0u3tSnLIV6IQ0D2rKkx3Bo8j6mqp7HQxvqzTPG03hT83tt0r9pv5Zk1/ofT6/1hQLi
 eNXBow7yOCqovGhoca+j4usdpXbcdyElvdv6wvrx74u4+i2pixjcOD3GvttY5KKGkU
 6EzdhT/s4h7Yw==
Date: Tue, 16 Nov 2021 14:59:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Trevor Wu <trevor.wu@mediatek.com>
Subject: Re: [PATCH 3/4] ASoC: mediatek: mt8195: separate the common code
 from machine driver
Message-ID: <YZPHUmDdGF/59XqA@sirena.org.uk>
References: <20211103100040.11933-1-trevor.wu@mediatek.com>
 <20211103100040.11933-4-trevor.wu@mediatek.com>
 <YYP+l7tMofYoB+aC@sirena.org.uk>
 <b4360ea17c3045759e85ee13fa9c001afe73c93c.camel@mediatek.com>
 <YYVQC7KLZx8oxdXT@sirena.org.uk>
 <e404d241-0685-643b-4b9d-d85bb8783385@linux.intel.com>
 <YYVez/V9ocCXhYmg@sirena.org.uk>
 <4e876c89ee58cd1408511a34573005e3df359cd0.camel@mediatek.com>
 <f915d1090abf2b6d188ce27068919a181828e463.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YuLN/D4BxE4Sko6x"
Content-Disposition: inline
In-Reply-To: <f915d1090abf2b6d188ce27068919a181828e463.camel@mediatek.com>
X-Cookie: UNIX enhancements aren't.
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, tiwai@suse.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 YC Hung <yc.hung@mediatek.com>, matthias.bgg@gmail.com, daniel.baluta@nxp.com,
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


--YuLN/D4BxE4Sko6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 16, 2021 at 05:33:48PM +0800, Trevor Wu wrote:

> Is the reply from YC clear? Any suggestion would be appreciated. If you
> need more information, please let us know.=20

Not really.  It's super high level and only at the driver level, not
talking about the hardware much.  As far as I can see it's showing a
single physical system and even seems to have what looks like it's
supposed to be two cards connected together which really seems like
it's a single device.

> Additionally, it was my understanding you suggested that DSP routes
> should be configurable in some ways, and we should not just add a new
> driver for SOF in case we need to support some other interface
> combinations in the future. If I'm wrong, please kindly correct me.

Yes, I'd not expect a separate driver depending on system configuration.

--YuLN/D4BxE4Sko6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGTx1EACgkQJNaLcl1U
h9DQcQf/UeSfcn6HVEpGYxZ8QFiUTj+pbv+kGdokbgKrS0ecwwnxMi4Py7KS5Z+G
t3FU9D3QiuU1BnHL92LIKT0wdYM7r7yededEPF0t8bnU4+CiO6nJbCRNp9E3jfPA
wlXwe7J+sTEWqmJ+HUNIX/MVHTBdAPwSIyYHWQmB3CgC2WDX8oLsLwobCOCZyh9n
7hdw4rjGE5m4P95j+SHERYBB1osAixaTLMrQ4aa59f5epfn0M5iQ0ABQltYIR48u
DOyGK2ZiJUs524JKVVbHtjz/JY3/SJqlY2DQKIt3vePa/fNNowo5Fjv4oReFJoQS
uek9HwybelDl1KbN9VhWNQDm2SyfsQ==
=42uA
-----END PGP SIGNATURE-----

--YuLN/D4BxE4Sko6x--
