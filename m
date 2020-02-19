Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4FEC34050
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:21:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C001324673
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DZ2vymv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C001324673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24B2416B3;
	Wed, 19 Feb 2020 17:20:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24B2416B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582129260;
	bh=qa0SngggUG9j6SbMXWmBqvIR3ZgD2NVPzIFlBs3AIjs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DZ2vymv0UB7rSgRg4RLVmDrC78t8hdXxvTY7uXsurCkvUdDHiooF00XWIkoVb1N5d
	 JocpwJsTDUpQ9/msqQWisjv6Nu5FOn7ZQeW07GX4oAS9CF0vIix7MTBmp92jPf2xOS
	 FD8Wg0SAVUNYg3ViG8KXRGw6JOJ+1803Qvrm9kH4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A5C8F8025F;
	Wed, 19 Feb 2020 17:20:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92404F80273; Wed, 19 Feb 2020 17:20:07 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 25654F8025F
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 17:20:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25654F8025F
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 732EB1FB;
 Wed, 19 Feb 2020 08:20:02 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB43A3F703;
 Wed, 19 Feb 2020 08:20:01 -0800 (PST)
Date: Wed, 19 Feb 2020 16:20:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 2/2] ASoC: meson: add t9015 internal DAC driver
Message-ID: <20200219162000.GF4488@sirena.org.uk>
References: <20200219161625.1078051-1-jbrunet@baylibre.com>
 <20200219161625.1078051-3-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8TaQrIeukR7mmbKf"
Content-Disposition: inline
In-Reply-To: <20200219161625.1078051-3-jbrunet@baylibre.com>
X-Cookie: FORTH IF HONK THEN
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
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


--8TaQrIeukR7mmbKf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2020 at 05:16:25PM +0100, Jerome Brunet wrote:

> +	SOC_SINGLE("Playback Mute Switch", VOL_CTRL1, DAC_SOFT_MUTE, 1, 0),
> +	SOC_DOUBLE_TLV("Playback Volume", VOL_CTRL1, DACL_VC, DACR_VC,
> +		       0xff, 0, dac_vol_tlv),

Sorry, that should just be plain "Playback Switch" - this can be used by
applications to present a combined mute/volume control together with the
Volume control (though as in this case there's no per-channel control it
is possible some applications will struggle with that).

--8TaQrIeukR7mmbKf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5NYC8ACgkQJNaLcl1U
h9CDuQf/fGT0VVRm9yQYse0qUFwaPpa/Nb3byf+rdC0Bisg4EtnyYM2uHFn0C1Mg
PEDPJX9wIjjelZpQn6pNnQjo5jcZvbnoUK4ok+t+L2+wn0qS1u9sdZHqDO0/85tB
vLFJutTkhsVu/0Ky+ejH12I+uJqIcSrWHxLdWfhOpXYoqFe+C3Jzr8WlhijxnlaR
GW5b0bdf3lS4LDOYTDCHKnPXX6PiTf80RHHqoF5ZS/JyH5E1zob3FGPSzoo/8RIN
PG/sz5w9+YJvlPHomclX1ZyMG+pnw3AdOrvtlvfkjiui7OPe8u/Z7BEoSVbKSxEF
T2IfZRw1euojF6XagOVhMMpiBoShKg==
=DBLh
-----END PGP SIGNATURE-----

--8TaQrIeukR7mmbKf--
