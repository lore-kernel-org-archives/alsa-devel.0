Return-Path: <SRS0=lC1U=7X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15760C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 17:38:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98161204EC
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 17:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kXCI6wj5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhlvajO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98161204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2FB54822;
	Wed, 10 Jun 2020 19:37:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2FB54822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591810691;
	bh=utG4SogSUZldhtrkFrDEcO0SomUMTV8zNf9Bc9crx+Y=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kXCI6wj58kEL8LnnzjSsqCviA48jdvuMqNwShIrazUkTqDvVfzZV5V3NO7P7W4ecO
	 AfAQhiSz3DTNg00TPLvHQ0zXo5oZrxEu8HVZsraGy2QoYlSFrnmr/ksa1ppkdpvcnX
	 WMeqfNWDjNeapNKZ6HOA5L5bBUCGcwbyUJijgJRY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A929F80088;
	Wed, 10 Jun 2020 19:37:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08DDEF8021C; Wed, 10 Jun 2020 19:37:19 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 450FDF800E0
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2020 19:37:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 450FDF800E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="EhlvajO+"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 35D01204EC;
 Wed, 10 Jun 2020 17:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591810633;
 bh=utG4SogSUZldhtrkFrDEcO0SomUMTV8zNf9Bc9crx+Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EhlvajO+Sj3UaawAk83wrJJ3AnCgi4UDhNSl2AqvNYAnOPDjnxEaCjzA7uHkP/TKX
 FYThE/vd7Gm9pv/M49vtKTTD8Ug+p2Qxu/v4Tf/kJtZNPlBxhPhZCFCAPsYc4hzIMY
 oXTO1oIkY7YTpPnN9Iagl7dcMSq4UelELdwXaFgs=
Date: Wed, 10 Jun 2020 18:37:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Vaibhav Agarwal <vaibhav.sr@gmail.com>
Subject: Re: [PATCH v2 0/6] Enable Greybus Audio codec driver
Message-ID: <20200610173711.GK5005@sirena.org.uk>
References: <cover.1591802243.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Content-Disposition: inline
In-Reply-To: <cover.1591802243.git.vaibhav.sr@gmail.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 Alex Elder <elder@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Greer <mgreer@animalcreek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 greybus-dev@lists.linaro.org, Johan Hovold <johan@kernel.org>,
 linux-kernel@vger.kernel.org
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


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2020 at 10:58:24PM +0530, Vaibhav Agarwal wrote:
> The existing GB Audio codec driver is dependent on MSM8994 Audio driver.
> During the development stage, this dependency was configured due to
> various changes involved in MSM Audio driver to enable addtional codec
> card and some of the changes proposed in mainline ASoC framework.

I'm not sure why you're copying me on a staging driver?  I don't recall
the base driver having been submitted properly yet.

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7hGkYACgkQJNaLcl1U
h9CrqAf+PTr4Z6aVY9XOlKtwcNflVCkOCX3qxnt1cwrgLmhUdXwDJ7MRRcKyzi2i
vCqjsn1rj9GAkhIwt0CC9FRnC+jq7pGLNucnbEugF6VuEr4GWTxKkS2P+yldMV2x
pdq12Re+x3tXN6oqziMyMcVWnqXXWdcxVaacEx2jqeXADr9pYkiQtN9ScJaERvPy
ComnaHl20yeooKklC7JdWutUyFCxijoMdkqhTPtO8lu5MoSk7DxuRlFgWD6EhyoP
Xx+2OdPgBaQMaIMk4GBm5Arornj2W80mLsVorGWV0SdWQ6gYuvoCn3U3h/IW6YS5
0/RCEd2Bon5c7Hd0v5eAUxPVChr5+A==
=yTza
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--
