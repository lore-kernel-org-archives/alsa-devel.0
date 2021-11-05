Return-Path: <SRS0=XtK2=PY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA5BC433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Nov 2021 16:43:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52746108F
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Nov 2021 16:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D52746108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65F3B82C;
	Fri,  5 Nov 2021 17:42:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65F3B82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636130577;
	bh=ocA+aw4pirZGTHGgqV169WIEms5jSzs7du1qenb+eZ4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mIVnkvTvI9RPkRBvs41ZEmwDAIK+KJYnHENraIIhVsmXnZXDwTzN985l1OhfM5DwI
	 7C9P/8p5bfqIJeDwcC5uo7oFlvQC+w/WIw5jhmZqo3jugKOX/3Oa/jb56uegIxbbCc
	 Igq1SMK4/gxgj2lG26TSWgdMgkzIpRJPtCEQ8rmU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5541F80269;
	Fri,  5 Nov 2021 17:42:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7387EF8026A; Fri,  5 Nov 2021 17:42:05 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7187F8012A
 for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2021 17:42:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7187F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="X0CrHeWX"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E46006125F;
 Fri,  5 Nov 2021 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636130517;
 bh=ocA+aw4pirZGTHGgqV169WIEms5jSzs7du1qenb+eZ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X0CrHeWXPSgOGxW1ABfOZe5F7iB9LiCCXc1YpXOPxUUw6gyKyCvDhXkyyWXCsSaz/
 Nc22Q44HTYx2dW5mblxoy0pSUOf3OexNeLYU7GnugM5i6eXQG+7mJZ4hP41FkdnDrl
 TsPFi3OY02thxiKa4A5MWAIcUwM/PsakN08TPiLuRddw6NmojaF8HzOnQrlun07jZR
 s2FXx4uO1+suYZlEYeC1T1a1BvfjNK1CHdLodhUruXzUXElsDVo9ntdWcw3RbPRxTp
 7CIcxE6ghriTf1J3ZpSnt3E0Z40dgJbskVanPYkGje0Nk9UGVl9SjxPUFZLt59PElG
 ncqqOIWv351HA==
Date: Fri, 5 Nov 2021 16:41:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/4] ASoC: mediatek: mt8195: separate the common code
 from machine driver
Message-ID: <YYVez/V9ocCXhYmg@sirena.org.uk>
References: <20211103100040.11933-1-trevor.wu@mediatek.com>
 <20211103100040.11933-4-trevor.wu@mediatek.com>
 <YYP+l7tMofYoB+aC@sirena.org.uk>
 <b4360ea17c3045759e85ee13fa9c001afe73c93c.camel@mediatek.com>
 <YYVQC7KLZx8oxdXT@sirena.org.uk>
 <e404d241-0685-643b-4b9d-d85bb8783385@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xu7RSJUInac+5dPD"
Content-Disposition: inline
In-Reply-To: <e404d241-0685-643b-4b9d-d85bb8783385@linux.intel.com>
X-Cookie: For recreational use only.
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, Trevor Wu <trevor.wu@mediatek.com>,
 yc.hung@mediatek.com, matthias.bgg@gmail.com, daniel.baluta@nxp.com,
 linux-arm-kernel@lists.infradead.org
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


--xu7RSJUInac+5dPD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 05, 2021 at 11:16:05AM -0500, Pierre-Louis Bossart wrote:
> On 11/5/21 10:38 AM, Mark Brown wrote:

> > We shouldn't be requiring people to load completely different drivers
> > based on software configuration, what if a system wants to bypass the
> > DSP in some but not all configurations?  Can we not just have controls
> > allowing users to route round the DSP where appropriate?

> It was my understanding the card relies on separate components

> - a SOF-based component to provide support for DSP-managed interfaces
> - a 'non-SOF' component for 'regular' interfaces not handled by the DSP.

> this was the basis for the changes discussed in
> https://github.com/thesofproject/linux/pull/3217 and
> https://github.com/thesofproject/linux/pull/3236

So it's actually supposed to end up as two different cards which can't
possibly be interlinked?  That doesn't seem to add up entirely given
that there's stuff being moved out of the current card, and I thought
these systems had a fairly comprehensive audio muxing capability.
Trevor, could you be a bit more specific about what's actually going on
here physically please?

> But indeed if the same interface can be managed by the DSP or not,
> depending on software choices it's a different problem altogether.

> We've looked into this recently, if the choice to involve the DSP or not
> is at the interface level, it might be better to have both components
> expose different DAIs for the same interface, with some sort of run-time
> mutual exclusion, so that all possible/allowed permutations are allowed.

Yes, if the interface can optionally be completely hidden by the DSP
that's adding another layer of complication.

--xu7RSJUInac+5dPD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGFXs4ACgkQJNaLcl1U
h9BRSAf/SkjWUf/cCKGy0zPR/tNt3CMqLlX0YCzYqYiswj6dKfU0LWjOlsXEClp2
xvBonvHD9Ni048rh/n5re028LssK5IYCcxqNfi3WMM+g1nTe7msKcRWanYElCx1U
vmZUv5k7H/1aYktEU5/KjPhz6YlGi4eJqGPLl397gC0fQX9GReu4b9tdipO+AJ+p
UzDeHJ+pP/rvbpSiUcRKxA4MrFXYq17gd0xaRuUbrdOvNH6yKUfaeDcz8MBW29ex
c5gA39zLIqFq9VsEmww6uDWqX0WattYGTzErTm2y2unLpvoxVdsidUgEESNtimpS
AXlgO4XPiIZSX96+ACgiOB/MBzFFsg==
=iro5
-----END PGP SIGNATURE-----

--xu7RSJUInac+5dPD--
