Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA3AC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 17:22:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8546164F34
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 17:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8546164F34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A078518C9;
	Tue,  2 Mar 2021 18:22:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A078518C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614705770;
	bh=s5SF+Wj96fPpy4phjHO8+7ewmYpQWLI+RzEeNDqAZhg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LfYyJ4J++W+7Msce5x15fruTm862KQCdwk8d0f4pQhf+11MQAL9br66ZCqpiUyP7T
	 jezvfSS1f/5fsqTTecBrnr0B4T6/pk0k7b25h8PhvIvLPMUQwMNBIfHvErwjrZjzkC
	 66TbqmxpfgHZRlPJT3FndA//J1eScL5URqmC6x6U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D3ADF8025B;
	Tue,  2 Mar 2021 18:22:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9EFFCF80269; Tue,  2 Mar 2021 18:21:59 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46939F80088
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 18:21:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46939F80088
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XNi3Xxua"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12EE864F2E;
 Tue,  2 Mar 2021 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614705714;
 bh=s5SF+Wj96fPpy4phjHO8+7ewmYpQWLI+RzEeNDqAZhg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XNi3Xxua4yUalefJTSZJWlmcrPr32axcZE/36Zn+IxAaiFak/0Ykp6NtSF4YRqB6J
 KqFCwK4DItx0g5k7SbF0rE9z0IoBHv2Ixmq1yVoJU6dCx9xePNhH+r/iWwiqWKeXav
 PK2Ggp/7gI1P3xqGnnNZ9yAfr8sjBraq7nhJfrX9F29+0AwT0b99CkTxOkF3e5uGYQ
 zKfbXkEKU0z4hiwmxSq6hbC4jc5DVHAf2zmum8hFf6cH0QdEbiIBYqdtB83bV7F1Jk
 KyGJo4Kcm8v7uwhaJhMsTaoLapeP1zOs3As3ZJFlaThCWU5JEVbRjJYR6DfUzl83u1
 tRUcCrLsIH+dQ==
Date: Tue, 2 Mar 2021 17:20:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH 08/15] ASoC: cs42l42: Fix channel width support
Message-ID: <20210302172047.GQ4522@sirena.org.uk>
References: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
 <20210302170454.39679-9-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qgof7w7UksPF5inF"
Content-Disposition: inline
In-Reply-To: <20210302170454.39679-9-tanureal@opensource.cirrus.com>
X-Cookie: Friction is a drag.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 Liam Girdwood <lgirdwood@gmail.com>, David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 James Schulman <james.schulman@cirrus.com>, linux-kernel@vger.kernel.org
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


--Qgof7w7UksPF5inF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 02, 2021 at 05:04:47PM +0000, Lucas Tanure wrote:
> Remove the hard coded 32 bits width and replace with the correct width
> calculated by params_width.

Again, fixes should go at the start of the series before any cleanups or
anything so they can be merged independently.

--Qgof7w7UksPF5inF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA+c+8ACgkQJNaLcl1U
h9C7Wwf+LEu+tkUUbnjzd6cLW7YcPusn3vpfd2rNRuXKUf4I70MypIONcc1TDxzJ
dL3hZr7w959SdTc31ghiy/on4MXjh0H3dIlGpkZ0XMhygCIvc4vy9OCPXTODw3Zz
/upnnTX/Mi7c0pwv+NiRjqIc1f0lZLv2+M02xMbvqNBhmG4QYTqdh2aHeSpb5Kvj
1Y9/eR9XrK2Phlk4r7iRAt3URNdqyh3GIag0434taYRClds4L5Ck2jphWATT0STc
QfoSJjUnmIZtw3ZpArjKAVKnUEJpdA44Jl5HU2nXpg1CRC7qvAhllNlpCz8jSU/n
4EyYd1TyzGh36d/GH7r8NYo9HSrPMA==
=Vz/P
-----END PGP SIGNATURE-----

--Qgof7w7UksPF5inF--
