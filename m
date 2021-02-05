Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DA8C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 19:26:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 672D364E3F
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 19:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672D364E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42AED15F9;
	Fri,  5 Feb 2021 20:25:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42AED15F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612553172;
	bh=slBMzILp9QgXeNYRnY8ojvq0IafhxVVhPZ1aE5vU+Kc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VhtbOCmvuKL4hpt3AtbMRQv58LK77hKqR8OSFhGjJMXqhIWUEu4DJ739flTy4+MyL
	 Fm13rYFzwiOE4dMojv+S6A5GZgDHg0cAHBWWVDS481L2tRi5Djy9OO2cBPoh/3Jwts
	 +R4bTY/y3vczryG1uQs62ZJX6atVkT96bhjypBqY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A360EF80139;
	Fri,  5 Feb 2021 20:25:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37771F8015A; Fri,  5 Feb 2021 20:25:20 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C8BFF80139
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 20:25:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C8BFF80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="OxHxDOIg"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B46764E2E;
 Fri,  5 Feb 2021 19:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612553113;
 bh=slBMzILp9QgXeNYRnY8ojvq0IafhxVVhPZ1aE5vU+Kc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OxHxDOIgvp3x8FVmE9kU1x7oe2zAFmrx8UskZnRa7Sz+btX8Qjxvug4SpUWoXH4rW
 rkRb8c3XNTvSfb+xXyPW3LgdPzda7JAVTqxepJ2ohReRhIqML8R0711TioSOXpHxH2
 9A+i5cx6jSysjyLvACKhZThkDYxzM6VpXd868q25/XiqVgZNM6Ilf+AJgpe+dZQFhI
 yaya6ALMw22278pArjmoCLRwUSBcAguAyhzuOMnpD9THg3s49Xr+OpgBcTx7HNFqCJ
 ptlAwQtkOHabiS58p88EBnUlOuRwlEgPaKFLWkKK0qlknRpTFtoTh8kZ/APHLdQnt2
 KoOsyeLgKNaLQ==
Date: Fri, 5 Feb 2021 19:24:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v2 0/3] Rename audio graph export functions
Message-ID: <20210205192424.GK4720@sirena.org.uk>
References: <1612446612-32613-1-git-send-email-spujar@nvidia.com>
 <875z37scr8.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NqNl6FRZtoRUn5bW"
Content-Disposition: inline
In-Reply-To: <875z37scr8.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Sameer Pujar <spujar@nvidia.com>,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, sharadg@nvidia.com,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org
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


--NqNl6FRZtoRUn5bW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 05, 2021 at 07:20:42AM +0900, Kuninori Morimoto wrote:

> > This series renames exported functions from audio graph for a better
> > global visibility. In doing so update the references in audio graph
> > and Tegra audio graph card drivers.

> I guess [1/3] and [2/3] should be merged/squashed ?
> Otherwise, there is git-bisect error.

Yes, and I'll complain because I have automation to test every patch
individually!  Otherwise this does look fine to me too.

--NqNl6FRZtoRUn5bW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAdm2cACgkQJNaLcl1U
h9Cjjgf/YHn+MjPCdow32NDrJsA500L+9pHXNUNT68r7wTkbBQbkR5vVW2x+xnCW
IpI5PWFNS1ziAIAuxc6hWVK4VDVA5PVQkoEw/RQXoC7JbproJ6+6QHuFi1ZpZ2Hq
Q1UoSu82H0g4gx86WqsyqN0sJHIMptniLFQvk830RnDA28iX+N/IXsIh1QBArkZm
0A1lu77XKKGNFLcOt8xSyXA94aEvAzZYltWROVgdSAOK8e1eAX75ocgeI/uj+eiY
/yoD6PECteaO6iJLirDAEy5DS/vIW6HBHcIqutdNYc6Z8qrIHWGXqKOJgDQtmvvl
Rdqyg7VPac3KKd/kcCRjNq/Hi3dbZQ==
=y6/g
-----END PGP SIGNATURE-----

--NqNl6FRZtoRUn5bW--
