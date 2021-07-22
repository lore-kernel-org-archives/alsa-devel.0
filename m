Return-Path: <SRS0=+9Uh=MO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051B6C6377D
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 11:56:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184696128A
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 11:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184696128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 892EA16D3;
	Thu, 22 Jul 2021 13:55:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 892EA16D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626954962;
	bh=RPZVwNiL1LbskPWPDNeRTevYMqkLaT9s20LL5W9zubc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WhRoC4lGXRVq3OaT5r6+ZU3jc7gfGucIZsQOU1k+seFTf3k/Bw5gnwAcq90zcWVT7
	 pKQgxJZfjxAibQa2egxCSEZ/JWAbM7BQpsWhlgn+wX7iwjkxkAhQtsUMhrnYNHPQKK
	 n4/uKt3Ob8BK9m6suTvunF+t+oHtQ9JyyDXxzG3M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 202ABF80114;
	Thu, 22 Jul 2021 13:55:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B585F80227; Thu, 22 Jul 2021 13:55:09 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8F5BF80114
 for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2021 13:55:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8F5BF80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="P4h8DPv0"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79C9460FF4;
 Thu, 22 Jul 2021 11:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626954900;
 bh=RPZVwNiL1LbskPWPDNeRTevYMqkLaT9s20LL5W9zubc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P4h8DPv0wG+/e6Xljh6Tj+SjMCDix7iCtqIA1n8H63QeS5149I81MhgoiWdNJ4YIX
 ua8kdrsgCttyLLXsr20mfxHNjpZYyEsRlflimlypknJOw0UVprfPXVRQ86/XCvtjLH
 eUXv/J68kHYjbQ7ZV4NKfmDuVzU5hYUsD5x+KQCL+UltEVx0tao8SVdlLAUjyQD0vj
 TnJsNmd33X6aitkeouwwIov/fle4sOrrrs+hSr2mq+oe2QqekNvb0YP+5QtdrAwuoc
 T19LoXlihIfgLiulsU81OLFAAlCA0DrREf8MD6veekMwq9sBgPM3T9hE1TYlABhTtr
 NFMGTm/KL9WEg==
Date: Thu, 22 Jul 2021 12:54:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/2] cx20442: tty_ldisc_ops::write_wakeup is optional
Message-ID: <20210722115453.GC5258@sirena.org.uk>
References: <20210722115141.516-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <20210722115141.516-1-jslaby@suse.cz>
X-Cookie: Who's scruffy-looking?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 gregkh@linuxfoundation.org, Takashi Iwai <tiwai@suse.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
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


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 22, 2021 at 01:51:40PM +0200, Jiri Slaby wrote:
> TTY layer does nothing if tty_ldisc_ops::write_wakeup is NULL, so there
> is no need to implement an empty one in cx20442. Drop it.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD5XIwACgkQJNaLcl1U
h9B/iQf+MwQzsWT0jCi6a5UsrvNAyp0wA49hul7QMIqXD7tzpzsyETEG55NiqESV
1Wl5utvCxoMtIhu3ys7sQT5WCSyYYstoq4OnDrvMgTHUTZjAzZSgdlM6ycHMsx9H
EMrs4DczuoA3iZSbOXWBrSNdVfOJK//iDilqWNRlqHQ6vvIeXwrJQ8sa37kyBZpe
nyUkJg6ZGly1h8Okqqwg3EgxV4PozyfEkJfAC5lRTipb/KhZtH6UZ+SP2sm/Zd7X
gfxyyQMY04vnxI6QWafMA4S9dPIvqdXDtTfXG12Z6cMCqR0EfSgF1+bBdqPgb/mO
9zzZVg5qVrlAaAxtxUTAxb89SVuoxg==
=mL+P
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
