Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51242C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:53:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE6D2078D
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LHtSMmr/";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgRyH360"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE6D2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D606176F;
	Wed, 26 Aug 2020 18:53:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D606176F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598460837;
	bh=nIHYX9Td8cBYdEW1nG0b5L2bDJPZo3p69HNnAGnAShI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LHtSMmr/uu/zyaZcrzKYkYMa5bouCNehkqqmBcBsVjdTJznHUE4CKG3QAbYml3GiD
	 /BrMksUzUxdRJU+6MiMDu143GPOZdy/PKlVVUKEjFmmXnM7S0I3Ay3gkXtfo/ZHcso
	 flfu2Bh7RDUcFDG7oUZvp34j526rAs2KWa5sDjDk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F3C1AF8016F;
	Wed, 26 Aug 2020 18:53:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C9ACF801D9; Wed, 26 Aug 2020 18:53:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB4C3F800EB
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 18:52:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB4C3F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="BgRyH360"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E79D02078B;
 Wed, 26 Aug 2020 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598460771;
 bh=nIHYX9Td8cBYdEW1nG0b5L2bDJPZo3p69HNnAGnAShI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BgRyH3607f+U2it23ApTLNMAVUFYWM729RB3nXLUqBYp5A4jKUZ5jdAeu11Q7+AMC
 g+xVI4fJ/4UaYFjyjlFvLCGWGDsKX9WYill3jS2pHk7kMIL/DJR++7xMDM7NZrOMqA
 iAb4YtDoL+QFpn7G9LVHwLqEcoe8HV5tvn9q3qBI=
Date: Wed, 26 Aug 2020 17:52:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Pavel Dobias <dobias@2n.cz>
Subject: Re: [PATCH v2] ASoC: max9867: shutdown codec when changing filter type
Message-ID: <20200826165214.GI4965@sirena.org.uk>
References: <20200826150724.15687-1-dobias@2n.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="boAH8PqvUi1v1f55"
Content-Disposition: inline
In-Reply-To: <20200826150724.15687-1-dobias@2n.cz>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, ladis@linux-mips.org
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


--boAH8PqvUi1v1f55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 05:07:24PM +0200, Pavel Dobias wrote:

> +	/* don't allow change if component active */
> +	if (snd_soc_component_active(component)) {
> +		return -EBUSY;
> +	}

AFAICT the filter only applies to the DAC/ADC but this is checking if
the component is in use at all and there's bypass paths - we should only
restrict this when the DAC and ADC are in use.

> +
> +	if (mode > 1)
> +		return -EINVAL;
> +	mode = mode ? MAX9867_CODECFLTR_MODE : 0;

Please write normal conditional statements to improve readability.

--boAH8PqvUi1v1f55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Gkz4ACgkQJNaLcl1U
h9DtNQf/X5z3npYtdILoGT5KqYx4RU3HxVWJxV+AaU9QOZglB1AIGEkHZoJiVkRw
3NgTtRY+/i8fdAxCNrLPhL5OoAcBJYpBmmNR0rcV3sC+yGS8P6Ogwvmoj2lm0vRK
knpOhX6t/CP4OW20n/cifMKGKakIB2T07RyghePAv2MxdZbY5wAyB/WkYWbNxsBw
y4O1Cs398nb3mPCW8jWOkRk3hxI+/p/AizsaHqrsr/plFoO5QzEp1BJ9XQ3j1Mwk
oHg1+pjZWlbxP461GsgcU4dmfzoAvCE0YCpET+s5oDKO+6kY9dIxoXTRzxOm/HrG
VdNsWarlzA0t0N+GPCBzYGHYWJQ3PA==
=4wwq
-----END PGP SIGNATURE-----

--boAH8PqvUi1v1f55--
