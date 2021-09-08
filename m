Return-Path: <SRS0=cWdV=N6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D2EC433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Sep 2021 10:24:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5C6061178
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Sep 2021 10:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D5C6061178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D22B816E9;
	Wed,  8 Sep 2021 12:23:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D22B816E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631096680;
	bh=65QMXzF5Bvk24nU6duUdL3mKrm5mXPSa7dnF186YHww=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MlLdbdiYMPi79GkXtArDd/h5BFKOR7uW9IAbbVZiK623yhJ/PxXwrwKCII/hFv9BL
	 kdHn3CJh9cK26nG55WWjlTDGhZp4g4TrUUW3gLMsokPyy5qMimr8MQ5f+AzJgF809L
	 BMkfZ/hMRRILBV2ksmGyUsiUYgGOfJ4I7BGaDMw0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69D08F8026C;
	Wed,  8 Sep 2021 12:23:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C25EF802E7; Wed,  8 Sep 2021 12:23:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0C0BF800C7
 for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2021 12:23:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0C0BF800C7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="c9zDqRwY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 725CB6113A;
 Wed,  8 Sep 2021 10:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631096617;
 bh=65QMXzF5Bvk24nU6duUdL3mKrm5mXPSa7dnF186YHww=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c9zDqRwY+O9KjVcmp2SLPbQ5o5FikTMALXWNjOOVrbEzZk7VGnTW0bmDb7KyZDzjb
 gYuD0RQrXuTF2GR/Mzhf5DHFocLhU0X60+FBPShm2MEDcTdw+a7Vjfe4riFpKajZqg
 9bW1E+IFEtTwUSpxC0acEPXuFpwyGQn9nZjc2MLtL1EPwds1/VpaXmTrovR4ICv6D5
 VqEgqfibEWt/M+h/Pb/IUg1w26VswhxIrYUvwWN92Bbtkd6xB5qdEajoToJTk74ZvT
 Gcd3iKAjyHfY8rKTi8KtHbl19Ho+eOHm/ntQ5W7NT3tNlexafp53qFtDLnl9OrcYTN
 pije68ZtmChXQ==
Date: Wed, 8 Sep 2021 11:23:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: Re: [PATCH] ASoC: dt-bindings: lpass: add binding headers for
 digital codecs
Message-ID: <20210908102300.GA4112@sirena.org.uk>
References: <1630934854-14086-1-git-send-email-srivasam@codeaurora.org>
 <CAE-0n53Zj3pp4EJ_f_kXhRm3EW=od83UO44qt91P37waEq-z4Q@mail.gmail.com>
 <755e99d3-4d72-3292-a5da-ad3d6045038e@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <755e99d3-4d72-3292-a5da-ad3d6045038e@codeaurora.org>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, plai@codeaurora.org,
 tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 bjorn.andersson@linaro.org, agross@kernel.org, rohitkr@codeaurora.org,
 Stephen Boyd <swboyd@chromium.org>, judyhsiao@chromium.org,
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


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 08, 2021 at 10:08:33AM +0530, Srinivasa Rao Mandadapu wrote:
> On 9/8/2021 1:54 AM, Stephen Boyd wrote:
> > Quoting Srinivasa Rao Mandadapu (2021-09-06 06:27:34)

> > > +#define LPASS_CDC_DMA_VA0 8
> > > +#define LPASS_MAX_PORTS 9

> > Do we need LPASS_MAX_PORTS in the binding?

> Yes.=A0 based on this creating array of streams in machine driver. So to =
make
> upper limit introduced this macro.

That's saying it's useful to have it in the code, do we need it in the
binding itself though?

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE4jwMACgkQJNaLcl1U
h9Bjmwf/YaSV9rxdXPdpDXlgsyTS/gQcTJBtNOBq5BxQcVcRXcq4GmFnz8V4vcQ4
cTp1TOa0f/j3XMd0xQrmzpwJPjxNJSZ0bT2kNH0totGI/AQje1F/ecFw313x6yLO
bzjAhAw3JyEK268J+QK4hzYS26+mP2t/a9itRGdKqG+zDkBCERK8Ydf14CH0i1pp
x1s5hSyad+KTsBRj3shF1TyP0V+JouH9MycZ2dJKRsL8TswhtT1jBYFQ4/4wamZx
7YLNbhh6tuvk2oWmZuSr84N30/3BAXS4ISZMl1hw8qTLe4AIJu16DPXuMlmkAFz8
SRQMBAXIWvXWzzDhJlEGvMRXPjeEXQ==
=cvim
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
