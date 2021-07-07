Return-Path: <SRS0=Jhnj=L7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238B3C07E95
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 17:34:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6CEE61CC8
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 17:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CEE61CC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64B6782A;
	Wed,  7 Jul 2021 19:33:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64B6782A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625679255;
	bh=6x2K/8dtQPD7TfuQmLGsF4RjEQpumNrlnKWiFjh0lZg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GowbgQd6PsHikmNVKMpfsOgFZ6LDAX7VRjG+iHRzrqYHVaWL+E5kmVospSZJUayrb
	 3OE9fVtGTaPCXvMQBBBbvrmSQeJvFFYIfFjNSXq6mq0RKkX2nNgV8svjIcS98h2AfL
	 iq9ktcwGvHLNL0SgMmlfzhHOK6yXWam3vTmbchl4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA1FAF8016C;
	Wed,  7 Jul 2021 19:33:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03F4EF80224; Wed,  7 Jul 2021 19:33:24 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8AF82F8012A
 for <alsa-devel@alsa-project.org>; Wed,  7 Jul 2021 19:33:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8AF82F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kfz05N/p"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34AD161CC8;
 Wed,  7 Jul 2021 17:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625679197;
 bh=6x2K/8dtQPD7TfuQmLGsF4RjEQpumNrlnKWiFjh0lZg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kfz05N/piVj8WvcFIarSCF5Mj7hfDttircIx7N7RVv0NJkUc5F8LKR4r9XFBoraFu
 ihZnG/Ec142GAnEVZ2vsheAUs33i1AWkv8y9a7fgGqdcnA9IKDQ9EAYaX8gIzECfjF
 nZ0at52LqNeL9KY+kWZl39BnIHG///0KvEU8H2E8oy5VGegYCFtfhLgZkw9MQ9gS8c
 3Atzyp1CPWzAXHNxS8KOKEalI7xbbJk4znDK84HhMmlp6kJoQgPUDprnENtZ6X7UIO
 rCNFDfX/p4ahRdBTf62J8UPHXhUkO2G87Q4ejNL0e8+bcKVhwRGGvv5a+FAQs2m4gH
 u4UGQLMnF9qHA==
Date: Wed, 7 Jul 2021 18:32:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH v2 0/5] ASoC: ti: davinci-mcasp: Fix the DIT mode and
 OMAP4 support
Message-ID: <20210707173245.GK4394@sirena.org.uk>
References: <20210705194249.2385-1-peter.ujfalusi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UUBKWyapWpFAak7q"
Content-Disposition: inline
In-Reply-To: <20210705194249.2385-1-peter.ujfalusi@gmail.com>
X-Cookie: I will never lie to you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tony@atomide.com, hns@goldelico.com, alsa-devel@alsa-project.org,
 linux-omap@vger.kernel.org, lgirdwood@gmail.com
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


--UUBKWyapWpFAak7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 05, 2021 at 10:42:44PM +0300, Peter Ujfalusi wrote:

> Mark, Tony:
> The ASoC and dts patches can go via separate tree I felt that it is better if
> they are together, at least initially.

I'm happy to take both through ASoC?  The patches look fine to me.

--UUBKWyapWpFAak7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDl5T0ACgkQJNaLcl1U
h9AbPQf9G9VBpfX/XZMST84thd5Q01UVglI7YPXJPFBONmTR4yiIMZdU/FYDutSd
tkyL1QA6VVLZ5zN33dDuPBX2o0qSFqEqWimOqakg0y771o+I5gQ20qiivP4pH1Kg
8VR9w5POi86u+NoiTq6YSWngf96j1LBzMwikwgkW3ouK/nb3nwd5tsIB4wDtFaJu
2/szMqtzxLvuI21UBFY6WI3tI5aX8vfjfnU6Hb6X7Ci1/XRzl8us4u/lLZgbOpvQ
veag2SanI0nh7aDWoQZgspq2Ljfh7KAoeqKkSFdHkpCfAfgbUJtVul7Ij6nMZK4w
Az+dg2VbFyGLs4J+ZQMyieJJFdNwsQ==
=pR27
-----END PGP SIGNATURE-----

--UUBKWyapWpFAak7q--
