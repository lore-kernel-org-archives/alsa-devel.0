Return-Path: <SRS0=DUcU=XG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC442C49ED6
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:27:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4530220CC7
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2019 10:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="s/AGqke4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="lKqixCK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4530220CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 664B0172E;
	Wed, 11 Sep 2019 12:26:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 664B0172E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568197666;
	bh=6E5gWPYhf2XDN+hKT9wDlF898+yjVu3lzM65Xo60iJ8=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s/AGqke4QExtBDnADsQXM548Lp6TGoxOMkk3aR1yjLRq04g0EAAK3bln9u0lzwl1K
	 +Z5aN9ZFyHal1HDRg5t2gBRTwzTj5SP8JzrwLeq4xSks9/tBmRmsg+Uy93gr8zk1gL
	 7glkz69irkH8GdgkLhkNUli3nroWtRSAxqcMSZ/Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27D61F805FF;
	Wed, 11 Sep 2019 12:25:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71532F80610; Wed, 11 Sep 2019 12:25:07 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE722F8060E
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2019 12:25:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE722F8060E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="lKqixCK9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oZFAOPo4X3BNQVGNEvYEWVxowwA0kAKGhQaDd6PyNTE=; b=lKqixCK91s1J1JK3SHw2V5czw
 XB09ulI7YQNYyM/LPqK0Kdn9wXhWahr5Dk4HHFMUEkVoU6L2jpBurkUS97X1hI6D4Tp6W6GRRO80U
 8Ki1dzLg1BP5ftkgX79qPrn2txPoYHQO2yHxFffL7cWsG9NIS1FaxrXcfLZD40HexDm0Y=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1i7zo7-0007mQ-Jw; Wed, 11 Sep 2019 10:25:03 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 11645D02EB4; Wed, 11 Sep 2019 11:25:03 +0100 (BST)
Date: Wed, 11 Sep 2019 11:25:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Curtis Malainey <cujomalainey@chromium.org>
Message-ID: <20190911102503.GV2036@sirena.org.uk>
References: <20190906194636.217881-1-cujomalainey@chromium.org>
 <20190906194636.217881-6-cujomalainey@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20190906194636.217881-6-cujomalainey@chromium.org>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Ben Zhang <benzh@chromium.org>, Bard Liao <bardliao@realtek.com>
Subject: Re: [alsa-devel] [RFC 05/15] ASoC: rt5677: Auto enable/disable DSP
	for hotwording
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
Content-Type: multipart/mixed; boundary="===============6837968802082828954=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6837968802082828954==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vBRosIkLXbYTRpGW"
Content-Disposition: inline


--vBRosIkLXbYTRpGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2019 at 12:46:27PM -0700, Curtis Malainey wrote:
> From: Ben Zhang <benzh@chromium.org>
>=20
> The kcontrol 'DSP VAD Switch' is automatically enabled/disabled
> when the hotwording PCM stream is opened/closed.

So why do we have the switch?

--vBRosIkLXbYTRpGW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl14y34ACgkQJNaLcl1U
h9Ducwf9GvpmQ2cBexf2sZ5kopxqM+aghq47gK58uex4nmib4ocMBESEtVwnXEi/
ymlCnK8VRSy0jhTqdpdyeyLYdbnYqKC7MB23MSWg8XQ0zmEcy163ypKg9rLzJCIR
gbnn5+kxXRpVAWqchYPLgAmGa/6jZaoQo68PMSLc47lErOF/XeKxSpUTw6vRQG3p
jP8TUK8CmYl27kRpPtl9vVQ1tDdw9KE4J+E6gxaXhXv0j+pDpnIufX+y59UTQSfc
cxUuqaMMw/pM0Sk5Tp7zL1t3B23072q+aReKYBPnY8lgV9cU73mehOGveMpbMsPS
eZR4MMn0+IsRUaCAMz3pbYw7TvemyQ==
=YzHU
-----END PGP SIGNATURE-----

--vBRosIkLXbYTRpGW--

--===============6837968802082828954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6837968802082828954==--
