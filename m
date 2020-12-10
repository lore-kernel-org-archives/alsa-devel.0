Return-Path: <SRS0=UiOR=FO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43526C4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 15:41:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E87F23BAB
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 15:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E87F23BAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89CAE1666;
	Thu, 10 Dec 2020 16:40:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89CAE1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607614864;
	bh=BCbJuIaERpNSLN75QqMnkW2oyMSrF0Q+DvLQgp+TsLg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p5eXtM6w8tYosDFxQC4sLeCnmvdmAZlwQrl2HsfAJfmRkEs+PpYNb58OxC+XU3ckj
	 A+tOGu4eZwETPDlsd79ylJs0XSUhS21tkbZh/SRrrVcZUQvbDvijJmXUPmjYFVKxTe
	 du0IPJ5OCHTne6VvHvfFeLuQgeSTFnxlPhjI2XYs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E455FF800EF;
	Thu, 10 Dec 2020 16:40:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B414F8016E; Thu, 10 Dec 2020 16:40:12 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 194B5F800EF
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 16:40:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 194B5F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CQ4LlrZc"
Date: Thu, 10 Dec 2020 15:39:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607614802;
 bh=BCbJuIaERpNSLN75QqMnkW2oyMSrF0Q+DvLQgp+TsLg=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=CQ4LlrZcDX7xrivlV7oqo3VK20cLfAisMSdWwLdeZONp0YU+u/QSO4hiC/sywpSWR
 GBMuhrNUCNoMH6LVYSjr/0shVKXQHZqUyCUl/g6i+fB/O/7Jp4z1oEFbcAbgFoABBo
 kG+8qDbIq8wLXR5mKF3Q3zDaAIOaQnjrtaqzYTQL2v770dV45a1nx8F0uTHLBdqjrV
 A2fo3x7KiJ0IjCrbFUPsaYNgAjrJO9ulv5+g1YMtg7ls5r77qFacp2yuOAG9+o86n8
 2OsssYJ0GnMLZwp/4ZKJBLznzd8cjhhlubysT5bH+4NRRUnSsh27EbV4DuoEZ32/bh
 TlUKr7l+yIuOA==
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH v2 1/2] ASoC: rt1015p: move SDB control from trigger to
 DAPM
Message-ID: <20201210153955.GC4747@sirena.org.uk>
References: <20201210033617.79300-1-tzungbi@google.com>
 <20201210033617.79300-2-tzungbi@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <20201210033617.79300-2-tzungbi@google.com>
X-Cookie: Your step will soil many countries.
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


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 10, 2020 at 11:36:16AM +0800, Tzung-Bi Shih wrote:

> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		gpiod_set_value(rt1015p->sdb, 1);
> +		dev_dbg(component->dev, "set sdb to 1");

Now this is in DAPM it's not in atomic context so it'd be more friendly
to use gpiod_set_value_cansleep() so that it'll work even if the GPIO
isn't atomic safe.

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/SQUoACgkQJNaLcl1U
h9AhBQf+PYse9oE0ACQGVaVkDe+CXJp6gfCY8If0Q5+DpmlZUKSZfK6dwk/MAGkT
aVQllG3elTcObzFr2OdDl/NVZcN1TtS1pN/3Owa5XYutOE+0unP9mxWUFKpBzSFC
CUUAI1wSB4+NG6nWOdh6MN/DMBaQTf8VBCMGyA5Eg7dTe2nYU3WgOWERYNTOPbxo
8qOA9cJ2GJkRM7++ojVLH6yIbQ7Bh6uwzZG6ApTKMxIa2FDHXDw0E9XsifbY4ILH
T2KnvMRqvr4WJiTpgfjlV2GOiFj6HsegbQ0HSO+ol8LB9Fpff4JzWhnfrdy2DXEn
EKHnOC6tWJG+nI/Of1JXf/F/HZy40Q==
=jv7y
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
