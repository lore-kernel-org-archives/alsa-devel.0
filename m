Return-Path: <SRS0=3oXn=IW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1806C433C1
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 19:40:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58BC8619FB
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 19:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58BC8619FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2350165D;
	Wed, 24 Mar 2021 20:39:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2350165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616614845;
	bh=K7lclq9Ur7+JomjNBUZNWpB07jY6eFWk04UbS/jYjTE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GGYaqFl/dMvzY5oX7Q1d2ODZJVnvWLEXth601GakhrqjAjZfp2Xlg/scNQZd5cXc9
	 Curh5Bm/1U7gsWe1srWHLIOmZxlGkuTs5fXxDw3AGanvw5JV3k7BUlaL9yURXPXoJc
	 YQI3X+Z6hiM8Psl45cdeiCdKVDrzt8AIJjA/rG74=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EB81F80156;
	Wed, 24 Mar 2021 20:39:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 649D7F8016B; Wed, 24 Mar 2021 20:39:52 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86348F8012B
 for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2021 20:39:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86348F8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YUxbHooD"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18C04619FB;
 Wed, 24 Mar 2021 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616614782;
 bh=K7lclq9Ur7+JomjNBUZNWpB07jY6eFWk04UbS/jYjTE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YUxbHooDCY67q0rkp6fGz+LrhytyIdt//e6NHU+2+G+DMio70/OeHqbo/lgpBBx+n
 sNRtkYrpfHSvr6tq7bdbJJT3q0w+ZPt9SJpLk8SHW9/eeyqDu2JmPKfRig+ptckvZW
 /O1xF7BYrRmO9dk7V8mOtlXRTEMS4Up8GqpT3nO4Ec8tqTaYVgA5qR5ylq6RqfuOy7
 CxWnqlroAGSC4CSSH6Oxw20ExOs6vMKjEzyaBD5PGUJ6vjco0i+cKkVG6P7jpxl6oo
 lZ6pLv9yjvs7RX2v17/u1ne9ecGOxNRn1rsQNHFHJxUaKtm06xOz49vOaujmNUrvNI
 AFZLydSQOkN8w==
Date: Wed, 24 Mar 2021 19:39:34 +0000
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH v1 2/2] ASoC: amd: update spdx license for acp machine
 driver
Message-ID: <20210324193934.GA4596@sirena.org.uk>
References: <1616118056-5506-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1616118056-5506-2-git-send-email-Vijendar.Mukunda@amd.com>
 <1038aeb4-d9da-6b45-2b09-b0bd399d752f@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <1038aeb4-d9da-6b45-2b09-b0bd399d752f@amd.com>
X-Cookie: The eyes of taxes are upon you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, Basavaraj.Hiregoudar@amd.com,
 Takashi Iwai <tiwai@suse.com>, Chuhong Yuan <hslester96@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com,
 derek.fang@realtek.com, shumingf@realtek.com, flove@realtek.com
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


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 24, 2021 at 09:49:02PM +0530, Mukunda,Vijendar wrote:

> I see in the same patch series patch 1 got merged and this patch hasn't been
> reviewed.
> Should I resend the patch again?

Yes.

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBblXUACgkQJNaLcl1U
h9ATAAf+OJ95Ec2wUekesYTW7ReP0rxlq8HFnqHbAvVdwaxxNVfOpR9NI45bZ81F
Kr+5Fz3hkCdaT23h6B5Nz0eyjG7bEScPSFnqBoFt2V1JM8oDm+Evt3UA7ZsvZGs/
kAKXTZEXIBBrelPUHLOK3T837O+ES7527HVUqyNyiCfg/ogKX7IRj0WNxiQLeJVO
97IDHzXR70yHeccV84ztVRlTSnN3KmJzXQ7zavNnpEAqDOoDXLercY/V8qnFWJ+7
5VvdkI0YQ3fNYuvLZlAHrehmJw6d7h2MvLMsJetYdKOTtD5jiziItlYzzhAGBdwI
dL5xAS4LdtybjQ/zIvz1NZ1W8PHEnQ==
=368L
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
