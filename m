Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C23C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:27:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 841FD227BF
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hGiKI5Up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841FD227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74D0885D;
	Wed, 18 Dec 2019 14:26:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74D0885D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576675640;
	bh=mmzozQXuWUwsqbfmpyanxiBb9OJ+7LxAwHK6JzuwGiI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hGiKI5UpEFb4iD5FyzFTxTcU2PGyxVwjkqIWzhkZgaMzEL1uKZjo47HkpizDZC9VM
	 Yip3yuLIwHWTEqkdzCNqv8aAtp9IiP9f/oiP9OUCdjus3+ESOtyXpTO0DkwGRH9Za2
	 2j2rBzPgPppI2VL+ne57Wg9gK0Bi7EHruSvYI6a4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0858AF80088;
	Wed, 18 Dec 2019 14:26:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2DE40F8022C; Wed, 18 Dec 2019 14:26:27 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id C25DEF80088
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 14:26:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C25DEF80088
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA4BF30E;
 Wed, 18 Dec 2019 05:26:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 686583F718;
 Wed, 18 Dec 2019 05:26:22 -0800 (PST)
Date: Wed, 18 Dec 2019 13:26:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Message-ID: <20191218132620.GE3219@sirena.org.uk>
References: <CGME20191128152110epcas3p2b205b4b55f6d8bfac42fcb8faaade93c@epcas3p2.samsung.com>
 <20191128151908.180871-1-tzungbi@google.com>
 <8aceb9ec-aa6e-1fa4-cee9-e22084c141e8@samsung.com>
 <CA+Px+wXPa_cwdZUQfCx4jAhhj4Q9b7bNABUGazLKOJ7U5ae-mA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+Px+wXPa_cwdZUQfCx4jAhhj4Q9b7bNABUGazLKOJ7U5ae-mA@mail.gmail.com>
X-Cookie: Power is poison.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>, Takashi Iwai <tiwai@suse.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Dylan Reid <dgreid@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: max98090: save and restore SHDN
 when changing sensitive registers
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
Content-Type: multipart/mixed; boundary="===============7451656707754255207=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============7451656707754255207==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Content-Disposition: inline


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2019 at 02:05:32AM +0800, Tzung-Bi Shih wrote:

> I have no enough resources to test and trace the code temporarily.
> But is it possible:
> - snd_card_new( ) succeed in snd_soc_bind_card( ), so that userspace
> can see the control

This feels like snd_card_new() is being overly enthusiastic here, I'd
expect that we might have other problems elsewhere with that.  I'd not
expect userspace to see things until snd_card_register() since between
_new() and that we're in the process of building the card up.  Given
this we *will* need to handle partially constructed cards after all,
unless we change the ALSA core.  Takashi?

> - code in later snd_soc_bind_card( ) decided to defer the probe
> - soc_cleanup_card_resources( ) may forget to clean the control?  (not
> sure about this)

There's going to be a race condition where userspace can see the control
on the partially built card regardless of if it gets cleaned up or not.

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl36KPwACgkQJNaLcl1U
h9B1FAf/cs3ZrczpxiE1GFa6hVrnrhHMslFp8vgCJtcL9LHgABdrhfm04brDk4PJ
dx9OKHFPDmverQZCGNx6jGoeWcCwoUukplE3VO+EJG6yVIzwEhhZMPjdHhbnn3aI
rcZP/MDL70bOuxcLCxSzUtZE/0c0da09vqZblmyPKKRMYfIz3LsIDdkNFsIOnmhk
99U0K0WSEOCdZ9A/bcqPR2qm02Yf3Ng+v6KMMOAuIeGrnIugbLJY+yPuKPqCPykl
3XzWVWaJGchqzwpMT33HK146N1lJpdddY2BztM56J1+isrYkZ0qcY8b24HlGKFiB
0gK4QJHf6RYxKdMfiq0ofn6ARX3Cyw==
=pw2R
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--

--===============7451656707754255207==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7451656707754255207==--
