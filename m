Return-Path: <SRS0=Aiaa=GV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD12EC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 12:05:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A2A223DB
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 12:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A2A223DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A329D17E3;
	Mon, 18 Jan 2021 13:04:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A329D17E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610971500;
	bh=5JIZNpOAuXjudU6ZQ7N4iBY+T/rnQaQAjKMQnYWoePw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IvOv//+sG1aj965DFk8GnmEr6pPAol4FTZRPOrmTNC3lKQRp7lvPPjs0Bhi2hartR
	 Q/vBufk6P0QkejtM853pf8BwwajRSMZ9r8nofYDTmcco49sjQBmYU6J5FRSoG5TqwW
	 rryeGBvbPanBS/5hrviccqPy4fQBEWBddihLx/SI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A512F80166;
	Mon, 18 Jan 2021 13:04:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFB35F8016E; Mon, 18 Jan 2021 13:04:09 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E252F800E7
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 13:04:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E252F800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="U/y1YPLs"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E4AD224B8;
 Mon, 18 Jan 2021 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610971442;
 bh=5JIZNpOAuXjudU6ZQ7N4iBY+T/rnQaQAjKMQnYWoePw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U/y1YPLsE9UFBFBA7q92Oa50xV98nkfD56zidQK28kcnH9LdVVPmjGH7MOCWLCa5W
 GbNRs7ZtZO4+y+IXTF4AfX5eJxBUBu0ZjvQwHNCnXEQYsR6LmI8IVpx/NHMOuQxk9f
 yGlJy7Hy7utlv5oVu61EKnEyr1Jb7RMYIyEHZ3BMfH0WZqVH8CoKXnskpetpWyV6XM
 +Vk8g3/n0HlMRhpmb0Rmz+KxRkLZ7wtdq9aEh/GMBMyls78bpL8Cy08jLabipCsO5o
 HauiH6xMzlPMYMtlXYsvj48WrZ8n5c/Lr9k9Zu1imT3jFjOn8EXjpLtHGJdq3CvSay
 sUWaLp7icxyCQ==
Date: Mon, 18 Jan 2021 12:03:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Perry Yuan <perry979106@gmail.com>
Subject: Re: [PATCH v3 3/3] ASoC: rt715:add micmute led state control supports
Message-ID: <20210118120325.GB4455@sirena.org.uk>
References: <20210112171814.5404-1-Perry_Yuan@Dell.com>
 <20210112175406.GF4646@sirena.org.uk>
 <bd2aea87-2f91-2748-424b-50b3b6feb22b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <bd2aea87-2f91-2748-424b-50b3b6feb22b@gmail.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, mgross@linux.intel.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 Perry Yuan <Perry.Yuan@dell.com>, Mario.Limonciello@dell.com, tiwai@suse.com,
 hdegoede@redhat.com, platform-driver-x86@vger.kernel.org
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


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 16, 2021 at 11:50:31PM +0800, Perry Yuan wrote:
> On 2021/1/13 1:54, Mark Brown wrote:

> > > +	bool micmute_led;

> > What is this for, it never seems to be read except for in the function
> > where it's set?

> Do you mean i can use a local micmute_led var in the function?

Yes.

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAFeQwACgkQJNaLcl1U
h9Bi/gf/a1axKJapuFhHFDtl+4V48j7+sPO2o2ca2rzuf5frVz4W4s27sxUvhgr2
t0CPGS0wrR3P15AlEGaMhlBvZbv8KZUA8FAGI3F98fgcxzwWOaWZmDUb/tLrnr3X
QQVcX8sCWqz64o/WyBIEqSvKwxkDIgK19RjCHC64Q+JQz5hpPLkdO7uTAbqslLqD
AMHP9m5rXkt4p395mENABsxV/fN0i3NESe4sbBR3J4iblIMQ1OTC8Q4/0gmG/mYz
5wy5KjCfT8v4QPMcbp8LjDsg4M0hs2+LdxA2DijSlQyIGgOuhzjB92WcA9Yprfog
loUeGuAuZ+Yx88zu3XVDEUmVfcqjxA==
=0TFr
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
