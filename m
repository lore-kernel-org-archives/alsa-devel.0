Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90B4C4708F
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 12:37:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26A9613B1
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 12:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26A9613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FEF116D0;
	Tue,  1 Jun 2021 14:36:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FEF116D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622551058;
	bh=2+ivin/diukkvPRUMoKU7rL59DqrYfnBewenIeEPcR4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FkOaNbUGWjQ6fh8kYODH74UiMN3qW6Wl5f9CcsEzO7QYsw+RatF8zGmZhhi/vjz/I
	 S2XhBMjyfLeaqYPI66yw06A+OP+D0aZVLTpDvxcxDVYY1bBYFToZW0jH4WI57CvNxt
	 2FY+UBwRKuzl/luK3iO6LwMk1IfRAShfa8V/mY2w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5117F800B2;
	Tue,  1 Jun 2021 14:36:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 903DCF80254; Tue,  1 Jun 2021 14:36:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5619F800B2
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 14:36:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5619F800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VShp+p8W"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EAF960FE5;
 Tue,  1 Jun 2021 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622550994;
 bh=2+ivin/diukkvPRUMoKU7rL59DqrYfnBewenIeEPcR4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VShp+p8WU+C5SXju/x1RnursJXYFwXVm7kesfGEsdonSYFoSZH9jyRF7NbXcLShI3
 JM41GwjxJ0leXNp6dr43QUoXpTwvsbUyZU/0gLMBIyiUDy1dwQjeMcdkJdY/wcEMZ1
 VjMzvekTSawV8DgJ/wfyLitvuN8mFMwYoNTQIxuw79ewrg4CLv3V+0UbcW+Ci5gOFf
 Kf2HGNtM6nkTg719e4HTUrDNsJyothhZnet7rxLLIsfWYqmondn5rGL+jiWRrf7Ef6
 HT1J3pwFZhAvUEPl63R8VNfe9DIGjsquK+MiuHamS3YmRviqEgldIi8QVPwsLh9v/m
 5kSQ7uJyIK49w==
Date: Tue, 1 Jun 2021 13:36:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v2 05/12] ASoC: hdmi-codec: Add a prepare hook
Message-ID: <20210601123600.GA4089@sirena.org.uk>
References: <20210525132354.297468-1-maxime@cerno.tech>
 <20210525132354.297468-6-maxime@cerno.tech>
 <YK4lWaB6Lx+SPjpF@sirena.org.uk>
 <20210531094213.kuuunk7ytu3q6sq6@gilmour>
 <s5hzgwb17ji.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <s5hzgwb17ji.wl-tiwai@suse.de>
X-Cookie: Sic Transit Gloria Thursdi.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Tim Gover <tim.gover@raspberrypi.com>,
 linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Liam Girdwood <lgirdwood@gmail.com>,
 Eric Anholt <eric@anholt.net>, Daniel Vetter <daniel.vetter@intel.com>,
 Phil Elwell <phil@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>,
 linux-arm-kernel@lists.infradead.org, Dom Cobley <dom@raspberrypi.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-rpi-kernel@lists.infradead.org
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


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 31, 2021 at 01:12:17PM +0200, Takashi Iwai wrote:
> Maxime Ripard wrote:

> > There's a build dependency between the DRM bits and the new hook
> > introduced in hdmi-codec, would you be ok with merging it through the
> > drm tree?

> Speaking of ALSA core changes, I'm fine with that.

Yeah, a pull request for the shared bits would be handy in case there's
some collision with other work.

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC2KccACgkQJNaLcl1U
h9BKcAf+O81ROM96RMUTZYJIimTQF0+J/oQkn+ESJXI+SHZBaclCwMSDyDON/sKl
JWt3ZmmxhZcLbu0e+i0IKllvpqlENXAAn3WxWdlC7/uFvY0fe1YLRTLVPUneRD0G
PY6UdYKkSfSbfQj/9CJR2svgHPHwrjtb2zrrFK+SnD57cAbuOsrKJPVNGQNl7YKl
p0KBajw4X98C2vToZhWraDaKNlq0PJ0IiPCqo17/UHi8M0dhr1VQ6lTcBGa3Wn6y
JkS69Xdqm+M7Nwz2LNekJ8yRBbjnpSA8d/ENLPUWiuRifvMYQlNCbJ0evCFQYhmn
szkAj4KiQQhziNgUPgsCjN+8N/HlLQ==
=/Jte
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
