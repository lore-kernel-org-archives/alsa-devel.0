Return-Path: <SRS0=Dyxj=JK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194E4C43460
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 12:44:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01F6613AE
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 12:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01F6613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6E2C1616;
	Tue, 13 Apr 2021 14:44:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6E2C1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618317892;
	bh=qiBtcnTxT4Pf7P7KT8Oez6AX4LDmqJOiJjbynCK5Sj0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kc66c06rkDNWMZ0RZq0XfA1zj2DgLVaY/ZXwxt2k+hL3UJNGCa4RHpsCm/Xws4TW1
	 WIvMKcP6L2UpAIkh7qhanQTXALvAeBgiGnBeIn5vv89ho67yecQs+ZfCGwgIpWoxtV
	 UPYS8I8UXf4rKH4GIZ/6PgIciKZgvXqyeMLiBb0o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C8E0F80161;
	Tue, 13 Apr 2021 14:44:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 469C1F8022B; Tue, 13 Apr 2021 14:44:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94C23F800EB
 for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2021 14:43:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94C23F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FcVngKpk"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CE1D613B2;
 Tue, 13 Apr 2021 12:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618317825;
 bh=qiBtcnTxT4Pf7P7KT8Oez6AX4LDmqJOiJjbynCK5Sj0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FcVngKpkYCCvBk30DH3rjZnD81URSc77GI/TivDJuZF+4tHYUzBHbiGRZFQKzU/hN
 ZZd7LleKkJSJSMxCNDZ81vuOBQu1iKygcACi8Kapx63xuyjRTIz3r7apROxSrIBrt9
 SW7CwCdUyk8qDCob+4+R0pnqn6t95Iz0DX7WNb1tAxwsdPSSbYhFJWfbSifPFhEVp8
 TcRw+cUQ8AgMyh8bX+XW/uCj/OnbZd8D2TWWZzotYppfUI1ta2IuFwRzffbsoyuVY6
 MSJx0kpElpiiM+/qwbeDgRIpK/aNd3L8E5zrkIN+8Z0KIgScp8hKbzPoLlglOUvUc2
 Oupbo+qQ98xAg==
Date: Tue, 13 Apr 2021 13:43:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: cs35l35: Fix an error handling path in
 'cs35l35_i2c_probe()'
Message-ID: <20210413124323.GD5586@sirena.org.uk>
References: <15720439769ba94ffb65c90217392b0758b08f61.1618145369.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Content-Disposition: inline
In-Reply-To: <15720439769ba94ffb65c90217392b0758b08f61.1618145369.git.christophe.jaillet@wanadoo.fr>
X-Cookie: Shake well before using.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 patches@opensource.cirrus.com, kernel-janitors@vger.kernel.org, tiwai@suse.com,
 james.schulman@cirrus.com, david.rhodes@cirrus.com,
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


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 11, 2021 at 02:51:06PM +0200, Christophe JAILLET wrote:
> If 'devm_regmap_init_i2c()' fails, there is no need to goto err. We should
> return directly as already done by the surrounding error handling paths.

These are stylistic improvements rather than bug fixes so it's probably
better not to call them fixes.

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmB1keoACgkQJNaLcl1U
h9Cv3wf+NEs2AimelvFepIXotWXQORggDNT0w9PYpIVhx8qJDau2m0VQTgfzprrE
SBxqb8RaJnOrzew3fZmzDit+EpfjT7D+X1tWwUvGY8HI/bjc0clVVzlpW81+s/FT
F1mepwHK26ct0/VZxKqiibsNoFCsf81VUDPy26KiScG7BAdrF8us25gVSepKAyIF
kh4fqhgcU8GPtUHz23pSgn0vzgA5qdWPJVVQ44tBoJRAtkJ0zBCf9pnvE5ZNZQt0
bwHL/EwG84ufa0Y4x+wzx+O3VeDaT1fv9K9Se/hIylrCRYg+o/agbgnZcCUDD2RI
v8uynYS9hbv6gYfp3hqFkqKWRH1suA==
=q+7O
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
