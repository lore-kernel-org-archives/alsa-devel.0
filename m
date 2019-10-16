Return-Path: <SRS0=FfYG=YJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CCAFA372A
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 14:52:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BBC2168B
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 14:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cjCAoFQR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMkLi5d6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BBC2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1469D844;
	Wed, 16 Oct 2019 16:51:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1469D844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571237524;
	bh=dveIp+eBELQazgKmcPOzxj4g2N2s/Uthb3zdLyVaX/w=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cjCAoFQR/BDIKpB8HF+PjdPxB9xAuvzle5ESyk1o4afqiPJ1PQKgYz8gCXPQ5M9DW
	 loc1Gb88zRCDVyPgVw8+9pNxqQ0HwjtxQXWdce967wX02qZ6HXWwaJYTYh2leX++6h
	 cGp1cw9IAEUCSjPnmz2hNzVsrTz3bnoUYT6GE9JM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8447FF8011F;
	Wed, 16 Oct 2019 16:51:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28B97F80362; Wed, 16 Oct 2019 16:51:11 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9BF2BF8011F
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2019 16:51:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BF2BF8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bMkLi5d6"
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 331AE2168B;
 Wed, 16 Oct 2019 14:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571237465;
 bh=Xh/9gWmwBKdF+8neE3kItdxVMfpHXwc3n8w1uZywGNQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bMkLi5d63UN14+72d9h18uH19CkeKG76vGq+CqQ+wIG2Cyem630Ojwrt9CEOdzh1f
 nfcG0oLaZc2le2vb93goK32+ObpHGn+url2irqclWJw+pWdZempUJgMh0VLuA1KDwD
 FgYwaZLYrXiSq3mJDbHG9vjPT2zA1qR1eMkuVBy4=
Date: Wed, 16 Oct 2019 16:51:03 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Code Kipper <codekipper@gmail.com>
Message-ID: <20191016145103.im4h75qi2fcdcmar@gilmour>
References: <20191016070740.121435-1-codekipper@gmail.com>
 <20191016070740.121435-2-codekipper@gmail.com>
 <20191016080420.4cbxn2hdt3wwtrhl@gilmour>
 <CAEKpxBmNCA4U8-X8iSwOxBZ7T3dp6352S2Kfxc6f5E4N671zvg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEKpxBmNCA4U8-X8iSwOxBZ7T3dp6352S2Kfxc6f5E4N671zvg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "Andrea Venturi \(pers\)" <be17068@iperbole.bo.it>,
 Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH v6 1/7] ASoC: sun4i-i2s: Move channel
	select offset
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
Content-Type: multipart/mixed; boundary="===============2673402443098103098=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2673402443098103098==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fi6amry3fbotqfax"
Content-Disposition: inline


--fi6amry3fbotqfax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2019 at 10:41:31AM +0200, Code Kipper wrote:
> On Wed, 16 Oct 2019 at 10:04, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Wed, Oct 16, 2019 at 09:07:34AM +0200, codekipper@gmail.com wrote:
> > > From: Marcus Cooper <codekipper@gmail.com>
> > >
> > > On the newer SoCs the offset is used to set the mode of the
> > > connection. As it is to be used elsewhere then it makes sense
> > > to move it to the main structure.
> >
> > Elsewhere where, and to do what?
> Thanks...How does this sound?
>
> As it is to be used to set the same offset for each TX data channel in use
> during multi-channel audio then let's move it to the main structure.

That still doesn't explain why you want to move it to the main
structure. It's there, it's calculated already, and can be used during
multi-channel audio if you set it up in the same function. What you
need to explain is why you can't do it in the same function.

Maxime

--fi6amry3fbotqfax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXacuVwAKCRDj7w1vZxhR
xTaQAP0X2iGfJ5IY9S8B+s9Zh5MP11erZjYLItvMfIJTyW5EAgD/QxPJRbfuSz03
Mqd/XK6k/sf6xBYpSzArepQAruvCDQs=
=rCXO
-----END PGP SIGNATURE-----

--fi6amry3fbotqfax--

--===============2673402443098103098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2673402443098103098==--
