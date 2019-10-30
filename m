Return-Path: <SRS0=P70v=YX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DB1CA9EC5
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:08:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1325420856
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ulMBoCR/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xjr+lTJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1325420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A4AC21A1;
	Wed, 30 Oct 2019 15:07:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A4AC21A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572444501;
	bh=4dtsQ7TEnQ0yfBfkt+YUt/sZdMkh9KyRb+cyiYarJpo=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ulMBoCR/TfeE1SkQBBr6Pn1dvkOL/er6KGuhk5No8eecW83ONeIAh3VDx55ByLmBx
	 miPmfZfRYi+kzpsbgJBKBn5bQMOvs7dmHGEzjNsegqtGGKn1Y84J/aA8Kfz+fFRgp8
	 dYOZWqrL83WOK10agZHQPHa1WYIVVtjlS9RrvvIs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB735F802BD;
	Wed, 30 Oct 2019 15:07:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3ED6AF80361; Wed, 30 Oct 2019 15:07:28 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C038FF8015A
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2019 15:07:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C038FF8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="xjr+lTJd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FnH/2ydTL0qeRlhySMW3Be47z3nOnZJ8mli7o1vcrKA=; b=xjr+lTJdRlr9MPq6YQgljEPHp
 X53zJpoUWSsm9N/dFCEVg6aLgsLk8cPjvwSBGc8U+eVG0G1dzDnR2S+FrcSeTkQLKQkedxpe9pga9
 V1M6lj78dh+7zLadhoAJm6JkrfX7ivpD/xaQbbytckfuc1nGX05ciMCbW91GtcWRCrvmg=;
Received: from [195.11.164.221] (helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1iPod8-00057l-0A; Wed, 30 Oct 2019 14:07:22 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 58058D020A6; Wed, 30 Oct 2019 14:07:21 +0000 (GMT)
Date: Wed, 30 Oct 2019 14:07:21 +0000
From: Mark Brown <broonie@kernel.org>
To: shumingf@realtek.com
Message-ID: <20191030140721.GK4568@sirena.org.uk>
References: <20191030085533.14299-1-shumingf@realtek.com>
MIME-Version: 1.0
In-Reply-To: <20191030085533.14299-1-shumingf@realtek.com>
X-Cookie: Keep out of the sunlight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, lgirdwood@gmail.com, derek.fang@realtek.com,
 sathya.prakash.m.r@intel.com, flove@realtek.com
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: rt5682: improve the sensitivity
	of push button
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
Content-Type: multipart/mixed; boundary="===============9010868552617104622=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============9010868552617104622==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SBT+cnFS/G3NVgv4"
Content-Disposition: inline


--SBT+cnFS/G3NVgv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2019 at 04:55:33PM +0800, shumingf@realtek.com wrote:

> +	device_property_read_u32(dev, "realtek,btndet-delay",
> +		&rt5682->pdata.btndet_delay);

This should have a matching binding document update.

--SBT+cnFS/G3NVgv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl25mRUACgkQJNaLcl1U
h9BvAwf/SL2H8SLsFkJbQ2HeMAbNhUAZKBxAUaczndwUM+B8rU+cTWljCnv1ZQiK
pa+5Ja+JWoHUQ6MdIVMES4n4RL0vTXaJSD7pKjIQqbihs+/sEC2c1h/WE4sMxTQz
tgpYTLwfY3cWl7xcbovhRsm8ti1dzbITuGYxOKkSXWuzQDvDil7bDR7105xQ9aQ0
+ioWDppbIXmhrIBHSfFC4YdjqRmVx/c7QF7G5MKyjjErS8O1ZF7pxaqq4WdL0eMP
95SPB3uEML1iwKeOFM6EQoqjYC1/JbB+97SyS19vC7qQQH1dmYudZZ4BO81Kfuol
h0NkQuif1RxvySyfgOOygRZQ/ghBLw==
=MbVZ
-----END PGP SIGNATURE-----

--SBT+cnFS/G3NVgv4--

--===============9010868552617104622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9010868552617104622==--
