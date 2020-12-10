Return-Path: <SRS0=UiOR=FO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4720FC4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 18:21:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BFC23358
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 18:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BFC23358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D07E1671;
	Thu, 10 Dec 2020 19:20:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D07E1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607624500;
	bh=9uZM6ZYwHA7EBtGq5T5DZmNA2TjCU1rt8UULQuYgvHI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vX8HT8krYP//N5dZaQC7OicDF67K11ag756XHT2tSV11bM/Zxhfo9Grs3OnBtwwPw
	 NPgRPzQXCPVnLRLwk18enRgiCLKbXBoZ77p6yJ1quTuuhCVR2YLCdyxbbicvTZYb02
	 pUIEvhHSbml40XrtX8B+zwdxUgFLSaNYaMeJEVYM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C442CF800EF;
	Thu, 10 Dec 2020 19:20:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67670F80218; Thu, 10 Dec 2020 19:20:48 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33D6CF800EF
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 19:20:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33D6CF800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CmM8g3W/"
Date: Thu, 10 Dec 2020 18:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607624444;
 bh=9uZM6ZYwHA7EBtGq5T5DZmNA2TjCU1rt8UULQuYgvHI=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=CmM8g3W/3IDj4dLmhrlG7/LK4wKFZkMtI8+vjLv7n0rOGIqA5cuLmiaC0TVRhG6ay
 Hz3Cqz2lQX9vd0aZRFpV3k4tKo2HFQGzaNNSRlhas9klK8i8rEOV/vcDYOWIxxwj42
 XCCcoofEHDYwqWndlW55g/UQmvq9p/dF+WFy2iJBXflH+LcVoV2I/s3U/1LvDmdSnF
 vL7KHzYedfdCRZRMTSqpwMvtCcQyburWSLaApHes5OEy+TFm5iHIQrdjP3Ih2KIaec
 PDu5PdDLAJOWF00G1r/swo/8Nz3wAAUAdNKKt58madTGa8i0xdYYdMzWer60mXY6RH
 a/6IrRbANVVjA==
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH v2 2/2] ASoC: rt1015p: delay 300ms after SDB pulling high
 for calibration
Message-ID: <20201210182036.GG4747@sirena.org.uk>
References: <20201210033617.79300-1-tzungbi@google.com>
 <20201210033617.79300-3-tzungbi@google.com>
 <20201210154200.GD4747@sirena.org.uk>
 <CA+Px+wXQp9mdvsjz7A1vmaipdnZkav7Mm4oDfH9LviFLC8eDKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Content-Disposition: inline
In-Reply-To: <CA+Px+wXQp9mdvsjz7A1vmaipdnZkav7Mm4oDfH9LviFLC8eDKg@mail.gmail.com>
X-Cookie: Your step will soil many countries.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ALSA development <alsa-devel@alsa-project.org>
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


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 11, 2020 at 12:47:47AM +0800, Tzung-Bi Shih wrote:
> On Thu, Dec 10, 2020 at 11:42 PM Mark Brown <broonie@kernel.org> wrote:

> > Might we need to reset calib_done over suspend?  If the device looses
> > power I guess it forgets the calibration.

> In our environment, the power VBAT and AVDD are still on even if the
> system suspends.  In more low power mode, AVDD could probably lose.

> But agree with you, in general, suppose the device needs to calibrate
> again after suspend/resume is better.

Yeah, even on that system there might be a problem if the system goes
into hibernate instead of suspend (especially if it hibernates due to
running out of battery!).

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/SZvQACgkQJNaLcl1U
h9BUEwf+L6JrrlZySFsIw8GW0+5tdA48ryUOw9wR7c+rgT7vR3er/kDVhmIZhl7k
Y4q5dGOMpE/A/XmSPmruWtnrURaNcW3YGtO/VprJljbn4+CYa3jEVQYNumsFWZpb
nLNxdk5saboVnzoWHOW7/tFZMRleE8pFJ44noM5g28b8v4zFq13h/QtQujd4W9zs
Ck8mBL+syRhsbJRNAWaK2TrtxLaRsVDOhND7VoqCHvFyGmNsMNBZ4AaxmsQTzRF4
jdWsf6E14xkulfgu6Nwp5tx5iDWq9H4peC3R7TggiDfwj7o0TpQMpTXUHrXRN+aO
H8xAbldKXqSEA4vGy1CDqNqU51Myvw==
=0+xs
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--
