Return-Path: <SRS0=rOcL=HY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D614C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 13:47:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA8A64DD0
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Feb 2021 13:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA8A64DD0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 645AA950;
	Mon, 22 Feb 2021 14:46:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 645AA950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614001669;
	bh=Jdlf1YoXgcYANn4fh5pk/iGaCdru+ISdg46QCBusPw4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vBdeK0Tj6LtXo4EcR7iHngLkgbL6olIhvLG+wY+p9JnG1tkjdXjY/r75X4ItMyci0
	 oUmwJx0XQEhAFaA+6ngp4uA89A+0B71TJhx9j0mIpn/YwndaQGZ/v6Qb+MBsMoN7vq
	 2Xmc6mLgvu4ZKDg+LmCjE7I2X/vsoInl/LOxyG1Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D38CBF80129;
	Mon, 22 Feb 2021 14:46:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 375C7F8025E; Mon, 22 Feb 2021 14:46:57 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F02FF80082
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2021 14:46:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F02FF80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZBSEk09w"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8EB464DDC;
 Mon, 22 Feb 2021 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614001612;
 bh=Jdlf1YoXgcYANn4fh5pk/iGaCdru+ISdg46QCBusPw4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZBSEk09w69TegsIGMGVzgUjM065PRkEn/W897BqZi0Zabqx2fVS47MKLHmgDEVO+f
 vkF266MgnpnVroJWzZHY+LfMUCZeWwqWTcALbVYNZDhPUxo0x+wfuNLzaBCHYnbQKP
 lgaryBvj6EJys+a0VulmXIjaJV0AxNAdrmpkHvPGqbAEIalsiF4+cxMOyhHCbuEAWB
 s7LVzAZWZvDRpaL2U6DESVVhAN+9AOn3PJixHf4AtCigPV2MrkAjzpa2IU4PGgLfUG
 KkST/qJyS3BRVMQFGuGF9qUCM58/6iNmZdry3g/S9d8saU/C3ZjNORkBKjs6TQ9r3S
 P1Oc5JZcLExfg==
Date: Mon, 22 Feb 2021 13:45:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Curtis Malainey <cujomalainey@google.com>
Subject: Re: [PATCH] ASoC: rt5682: remove jack detect delay
Message-ID: <20210222134551.GC6127@sirena.org.uk>
References: <20210217214914.700751-1-cujomalainey@chromium.org>
 <5b90530b77744937b87bbbd35901e320@realtek.com>
 <s5hr1ld22a9.wl-tiwai@suse.de>
 <CAOReqxibmAQNQe8PuHkUSW5Kb2L986X9DDqia-aN=ZrS8VJysA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <CAOReqxibmAQNQe8PuHkUSW5Kb2L986X9DDqia-aN=ZrS8VJysA@mail.gmail.com>
X-Cookie: A motion to adjourn is always in order.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
 Curtis Malainey <cujomalainey@chromium.org>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 18, 2021 at 01:06:27PM -0800, Curtis Malainey wrote:

> I am trying to understand the purpose of this delay currently, won't
> the press already be registered since we have an interrupt? Or does it need
> to stabilize? The reason is 250ms is well within human perception or even
> double tap time, which results in users possibly double tapping buttons but
> only seeing one press come through.

It's quite common to have lots of issues with debounce on jacks,
especially around insert/removal - it looks like this delay covers both
insert/removal and button presses so it may well be needed for robust
handling of the actual jack insert.

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAztY4ACgkQJNaLcl1U
h9BiEAf+Jmc6uf5Ei6jJAyhW8W62ILUic+up3txE5MWU+rGub4EiJzL7JvZ79kPp
py1+yfT/B6TLUMHb3MPphJyCqITB2pf549rV3YKK+GTeoBuNSbOMvng0Ff/a2D1F
nWmVXV1ysgfpzXcvvIVzaN/jgnhcV+ip2SDj1e+/CIZI3/QcBfy10AAW9wHsdCnl
4MMXE5NHbIwkKhzvDQL3yonHuxd4KP8g6/UZ2r6QFNZYQRot9DEbZd2D019mml8L
P5gbT3xc/Enn+jsq85wd1G4NNaC2VyG15MMbz6k7dJdQ/VdVh2GaAqkK3q88KLgh
QJ263ohaXGAisodyA0bGoP+LUEyCkA==
=kAXw
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
