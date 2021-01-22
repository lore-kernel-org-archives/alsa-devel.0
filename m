Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD5DC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 14:02:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F67239D1
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 14:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F67239D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A7DB1EFE;
	Fri, 22 Jan 2021 15:01:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A7DB1EFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611324148;
	bh=AhBnsL0cjjM0WRFp3zekqRkmyonpdHuNG1ggq5WvWQU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tpB40ctW7V+52gvUzFPr1CiJ0tLY438RPTbSb4/JaJGEkRErRPTYOO6jG1kR++Crg
	 AgY+tvWaB8YwMIbeqtinUULaILl4jB7nIQNLdOxErvx12HvCBhDaOICN/KjqIAhgTC
	 cfmTNULrIy/gzwb2YoPta3ZMjNBM6H7zz3pIGwVA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B26BAF80166;
	Fri, 22 Jan 2021 15:01:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4441BF8016E; Fri, 22 Jan 2021 15:01:36 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D98A6F80129
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 15:01:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D98A6F80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="WS6Gc5JS"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3170239D1;
 Fri, 22 Jan 2021 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611324090;
 bh=AhBnsL0cjjM0WRFp3zekqRkmyonpdHuNG1ggq5WvWQU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WS6Gc5JSZ0Gs+MXhq0cPAEBnqDTbQU4c8pPyXXaeGBtToGsSoN06moSCk9PZ3vVWN
 6MHZl0ufzFQRE/ZmNmDBN8rHCNejPsCXZsSRxOpuL0YdjSc0f0ialGHJVFr62Mfvqh
 nxxggeH8YOXiCGjMYBjbnGL+QYrxg7tjcQxR3ELHooZq5weBm6me3wWUET3oDEbD1Z
 t3iCM3aSM7ZXsKxxg6WTymXTfKHq2PYMAaZ/B3kTLg2kn9S76+sp6tqBQEelRRIaC/
 +6xK7FZZwAUoCXuKP+rTgGKRxRw9x3gK1XcNaeAPv4mbuUSXD5yvrhkqhSPdA9mVH3
 NJ8bWytIHpolg==
Date: Fri, 22 Jan 2021 14:00:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH 1/4] ASoC: mediatek: mt8192-mt6359: use
 asoc_substream_to_rtd()
Message-ID: <20210122140050.GE6391@sirena.org.uk>
References: <20210122100742.3699128-1-tzungbi@google.com>
 <20210122100742.3699128-2-tzungbi@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
In-Reply-To: <20210122100742.3699128-2-tzungbi@google.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org
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


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 22, 2021 at 06:07:39PM +0800, Tzung-Bi Shih wrote:
> Uses asoc_substream_to_rtd() helper.

Any fixes in a series should go before cleanup patches like this, it
avoids any dependencies which might stop the fix being sent as a fix.

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAK2pEACgkQJNaLcl1U
h9CARgf9GxQJac90TmyGXLorPoW/P5fDRBEW998dBObRx6faUKY/zo7WCqm6Yyck
s8luh8bwP3hSlBnKOF8p/sc+f+9lzyYi7tvL4dYYYo5UgREIWqTUdO8qbrDfFXMn
4qWtEewb0LCHsPHHOe7uTWWdiqP3uWPPTvbxhA4SbsZUtI1XhfvQnqwXRbYj6rkY
styTM5ynAnWNV8o1CL0AJ+KosbdHAiSq5tbi74drrIKQ602qfNISmjZAq+8o/o3k
Q3l5H3JOMBdW0ULlehGuxtrHUKqj/4qtKk6y/XkpkIFmxjH2e8oMn7hs57bjCp1i
jylKdfRXcs6MVgmSLAjAy65XeM6LAQ==
=wCPm
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
