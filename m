Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F19AC4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 16:13:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66B2610E5
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 16:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C66B2610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6E3B1694;
	Wed, 18 Aug 2021 18:12:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6E3B1694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629303222;
	bh=JWW5Yxq0yaTQMvkOTdyI+JSYXK2HUBiyO98PmK+0Aes=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fCRIZ4Z1vHh1shsEQ/pumCFSW/gGYGyHks7iWjq5MQOIX6xCkCI8cEcARGGkuuHi0
	 82+Th30Qdcnz6pH1C5DDJ61avUigTBmNCntlo+C4CjIYo3kmCjVAUKWKoA+0Pvrqr5
	 xMm24DsmXkaW4Bl3EUvyC0HLhDtDfsj7ARcM3qSg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60C9DF80246;
	Wed, 18 Aug 2021 18:12:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 211B6F80249; Wed, 18 Aug 2021 18:12:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9A25F80169
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 18:12:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9A25F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nYfjX7SN"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C32B3610A6;
 Wed, 18 Aug 2021 16:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629303161;
 bh=JWW5Yxq0yaTQMvkOTdyI+JSYXK2HUBiyO98PmK+0Aes=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nYfjX7SNalRDHX6xdWVXgsESrBY/6uUKKC2n+TnLjETAbhePrwqKmjfO8hM0QO687
 p9soaYhjNRGG2/cEbt0KjAYkUYf0pWMruVpnxa+APeF3wBK2+MZX8cltWbkP4USd9o
 GK8V84c3AGk1fCTE84d1tV7qj/1hLzhbGLRX4iKtke+sGHB+pTvm5DZv9WkbIWVNpD
 oLECaSVfpLYQOBpCITUdItFBnZNZ9Od2VV2L0eMR//dttojW7aYVjjltrozmtTs8hB
 /j3X1ozIr/966HLiWRi8yLdxDdN1RUzmmOOCi26kKaKlTvJgSG9vfrIdoDvcQx24K0
 Da2GafP9T2ZQw==
Date: Wed, 18 Aug 2021 17:12:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/5] ASoC: rt5640: Move rt5640_disable_jack_detect() up
 in the rt5640.c file
Message-ID: <20210818161217.GG4177@sirena.org.uk>
References: <20210815154935.101178-1-hdegoede@redhat.com>
 <20210815154935.101178-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
In-Reply-To: <20210815154935.101178-2-hdegoede@redhat.com>
X-Cookie: She sells cshs by the cshore.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 15, 2021 at 05:49:31PM +0200, Hans de Goede wrote:
> Move rt5640_disable_jack_detect() to above rt5640_enable_jack_detect().
> This is a preparation patch for reworking how the IRQ gets requested.

This doesn't apply against current code, please check and resend.

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEdMWAACgkQJNaLcl1U
h9AcmAf/Qo/LMw6LQABck3jNO4onCcfDZZzQNajTz1PQwCZP7teKt+MJcan56xD+
wnXvODCYwGV52K3zmyYJQP1+yh1wmNQVF0HwUtm4YBQbBmYqfjImBgFNluKjQtGo
yBuW94kD5pipYW7UpVzbphmWnf7lyCaVIjyk7/DICzqElYGMLqqGzSOdvvQOInZV
eajSf3JurA2yILbwjCgHKxyk46QDD6Iqytp5+oEZL7roZznFgDUnlOYDoVGVIg+Z
R3PFPfNInSYiLBS0Y2fSPYjMTG+WLl9nYYj7quGVnGG2vbH07W3HPqm+uA7HAjNj
mIWGPPwuMl73rdYDPTtA744y0c1GsA==
=UTm2
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
