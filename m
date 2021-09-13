Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC88C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 14:24:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B8860F9B
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 14:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14B8860F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 018E6828;
	Mon, 13 Sep 2021 16:23:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 018E6828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631543087;
	bh=Z6j0LTCb/0Fx5pxLfWQP2iaIBaU+rx32o1y6TgwxBf8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jQ5oQytFFO0+R8k8cjGyXc2yDqftrJhqeC/rWHHvcHPSc2jajlWKoCyUxms52Hs5H
	 VwBvi6tcuhVLFHfTaSycC0oft3VS1iL2lU3yZXMlz1V3VPNts+93ffLrmcbKo0IJGk
	 J3COlkAIvRC4KZM7oIrjDmvpxeauvWEqEaX+CEkw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B5EFF80227;
	Mon, 13 Sep 2021 16:23:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7BCD4F8027C; Mon, 13 Sep 2021 16:23:55 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0ACD9F80132
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 16:23:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0ACD9F80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MU3y9lQu"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BF8960C51;
 Mon, 13 Sep 2021 14:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631543026;
 bh=Z6j0LTCb/0Fx5pxLfWQP2iaIBaU+rx32o1y6TgwxBf8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MU3y9lQuvncRuxjepqLqkpJUzPPrYF1sGflnKzj/heuTwTgCN2oNNAs23fggxVkTI
 SAJJTyaiBjgQRaDV37IIVo3TBX6/pRgLJBSRVK+p6AZE8/p0AZ0ClN/l2wERwsr08e
 ZK+t0tQObmMvi3NvViHiwLgD/7Hn6EBQdRpGn+P+w2fQyfNrVuAsSDhjSpJhHlKvEh
 VRnEwO+o3S7UB09yT9HlUXq94DNsRj+WtZyJ6fdb9gHLV2FBqziv4gzSvKSwLGoGed
 XR4Lx9PEzHDqaq7/WoM+A7Oqtzy39yurrcScsemlk7ouYCJQqPgTcuvTy2Agqiu4eG
 IIVYWobHBYlIA==
Date: Mon, 13 Sep 2021 15:23:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH 06/13] ASoC: tegra: Add Tegra210 based MVC driver
Message-ID: <20210913142307.GF4283@sirena.org.uk>
References: <1630056839-6562-1-git-send-email-spujar@nvidia.com>
 <1630056839-6562-7-git-send-email-spujar@nvidia.com>
 <20210903181326.GP4932@sirena.org.uk>
 <29c785d0-cc70-7cce-c205-77059c11e0e1@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline
In-Reply-To: <29c785d0-cc70-7cce-c205-77059c11e0e1@nvidia.com>
X-Cookie: Above all else -- sky.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, catalin.marinas@arm.com, tiwai@suse.com,
 lgirdwood@gmail.com, jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
 robh+dt@kernel.org, thierry.reding@gmail.com,
 linux-arm-kernel@lists.infradead.org, sharadg@nvidia.com, will@kernel.org,
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


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 13, 2021 at 10:32:32AM +0530, Sameer Pujar wrote:
> On 9/3/2021 11:43 PM, Mark Brown wrote:

> > > +	err |= regmap_update_bits(mvc->regmap, TEGRA210_MVC_SWITCH,
> > > +			TEGRA210_MVC_VOLUME_SWITCH_MASK,
> > > +			TEGRA210_MVC_VOLUME_SWITCH_TRIGGER);
> > > +
> > > +end:
> > > +	pm_runtime_put(cmpnt->dev);
> > > +	return err;
> > > +}

> > _put() should return 0 if there's no change or 1 for a change.

> So this means, no need to return any error value and just return 0 in such
> cases?

If there's an error you should return that instead.

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE/XsoACgkQJNaLcl1U
h9Aeywf+L19DUp0pquR8XpAdjcB8vCJFQ8bpY19O2MoHi1ytdVvLaesU9Hd+lPBc
hvbcsNlfBqDuH2EGjUqPFkRKDevu6YiF+UsAYldN6011XNMjbyo5GtPnLSQbtFY0
55lL43iJ4KqIZDIYwgdoz5f/kEDfuhAFP1GUvo31JnSRRqcsooD/0YWnKx3rOmvF
EA3QmaFxjp46zpSp+U92iKEMDi3rkJNpqgBiL/vpQRgLQ4xov5nBxzMHx+AmH/hl
89lvssVBxEV6+waoi1STpaAdHR5ynuhBctdoBh0UgEGg1T+l477TFZ/dCHFQd5OF
zHcyS9EQ2akuFsPlpZA9FqtaxNTN+w==
=rm21
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--
