Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51855C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 15:45:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4FA207DA
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 15:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aRc2u5es";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKnA/zVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4FA207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 415FE1616;
	Thu, 13 Aug 2020 17:45:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 415FE1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597333554;
	bh=n+lRf4d5ROJJHRRF+9tZK3toZHtlbpLJVRPOxkuH/z8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aRc2u5esATgoI4ZSdaZgWf+s7uV9mLFwXErJYpCkBhTlmAYFpoMb+jEOYp5kQsJaa
	 9LtGzF+XSqoNR+0PW5jyK0G0i91Hy6Vmf4N1n+H4MBQHxkI/o8WeY0Qr80KAq+tA5K
	 eFlKM+4CkA+VRkVxIUnUzZ2gKxpN2064ZMStlJ8A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B84FAF8014C;
	Thu, 13 Aug 2020 17:45:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E91C5F8015B; Thu, 13 Aug 2020 17:45:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02640F800F4
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 17:44:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02640F800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lKnA/zVL"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DC5DD20829;
 Thu, 13 Aug 2020 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597333491;
 bh=n+lRf4d5ROJJHRRF+9tZK3toZHtlbpLJVRPOxkuH/z8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lKnA/zVLUdkO1TJD7+L5mhYBc70cMDkgdLPUn9ffKVSLOfUZv2cftQsPNjMY7sFcR
 hTn976Kp6Chv4Md7iyAUoFoeZpIcMbrSK6O5sPcuRizWoFrDOnHXjf8xu01CRhysoo
 VsKea1izNepj0If4Xr3fFcYV0g+ELVPGho25swa0=
Date: Thu, 13 Aug 2020 16:44:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v2 1/2] ASoC: mediatek: mt6359: add codec driver
Message-ID: <20200813154423.GC5541@sirena.org.uk>
References: <1597028754-7732-1-git-send-email-jiaxin.yu@mediatek.com>
 <1597028754-7732-2-git-send-email-jiaxin.yu@mediatek.com>
 <20200810185933.GI6438@sirena.org.uk>
 <1597217353.23246.45.camel@mhfsdcap03>
 <20200812120537.GA5545@sirena.org.uk>
 <1597333200.23246.68.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <1597333200.23246.68.camel@mhfsdcap03>
X-Cookie: Your mileage may vary.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, shane.chien@mediatek.com,
 howie.huang@mediatek.com, tiwai@suse.com, linux-kernel@vger.kernel.org,
 tzungbi@google.com, robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 eason.yen@mediatek.com, matthias.bgg@gmail.com,
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


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 13, 2020 at 11:40:00PM +0800, Jiaxin Yu wrote:
> On Wed, 2020-08-12 at 13:05 +0100, Mark Brown wrote:

> > These functions are exported for other drivers to use rather than
> > something done internally by the driver - if this were internal to the
> > driver it'd not be a big deal but when it's for use by another driver
> > it'd be better to go through standard interfaces.

> Can we move this part of the operation to the codec dai driver ops, such
> as .startup and .shutdown? Because originally these functions are
> exported to machine driver's dai_link .startup and .shutdown ops.

If it's internal to the driver sure.

> > So this needs the SoC to do something as part of callibration?

> Yes, the side of MTKAIF in SoC part named adda, we need config it before
> calibration. We will also upstream machine/platform driver that use this
> codec driver later.

It would probably be better to just leave this out for now then add the
required bits to the CODEC driver as part of a patch series that also
adds the machine driver that uses it so it's clear how it all fits
together.  It sounds like it should be fine but this'd be easier to
review.

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl81X9cACgkQJNaLcl1U
h9AgEgf8CMREa84vouym5KtpM1No5HSGwGI5+EJTOUWF8vPkS1W3IuMv5ZoWeuvF
kOFsj5OQHliWGiQbI+HI5X6H7cruLsvVPBoxUg7hHx9n7zfz25IbaTiuk5/QpTJ2
id7eshXQ5TSPfRJ4WQrcePCn07HCnvI5HkBxw3L18IBjw/z34TCPoA8cVh0SqLnS
ecTT2uq7Yjd+1OxvjHVlMsw4GE/b+JXk/IOScAFNiVe/ofYzzNP04VgJNA7f20wA
+UAs84bO5bfuqtrzbtDTRxu6P3p5Gw4d3zJuVLiqD+W481IeUVo/I5LcGFkDG+5e
20ANMcyLw+bJyzovtx+vqIMLy6AM9w==
=v+hX
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
