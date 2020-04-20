Return-Path: <SRS0=3aoS=6E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB317C3815B
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:02:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6741B221F4
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZMkgoGpz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2ReP00+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6741B221F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B391B167D;
	Mon, 20 Apr 2020 16:01:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B391B167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587391355;
	bh=JIEc9NL+YGHp5avkzPHDLltDVnHfQiZu6/QeeqDEzTE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZMkgoGpzbheF1M7pco8NbnOEyAclmvHBV9a/g5R6dzSHXI7y0ysEtPzk5oRfVmUJ2
	 KWUsziybT8BWDxp1md/VmHt6I6xA6ZcSGjprQ6D7TiuF527XGPk7ESppq+KAvwMYKZ
	 jypCAV0JhLWWrS6bZIMtkpXTkA0nOUTB2HHecLTo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A73AF8013E;
	Mon, 20 Apr 2020 16:01:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20ACCF801D9; Mon, 20 Apr 2020 16:01:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 759A7F800E7
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 16:01:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 759A7F800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="2ReP00+K"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 67E1720722;
 Mon, 20 Apr 2020 14:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587391298;
 bh=JIEc9NL+YGHp5avkzPHDLltDVnHfQiZu6/QeeqDEzTE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2ReP00+K/mNd2j2m1umhFZPjekFioKVHUMeATnOkOVVRwBvS1n8IBVHScYhlGh5fl
 5dWzGq1ZBKB5r8komqr/siCzwONV6ndKIWgQVGQLDRjMsevbPD1i9CRHdRqiuHQhrl
 SvOI5HuM2EF7EmMY9cxptl4lVk1JT3tPvMWhHp+8=
Date: Mon, 20 Apr 2020 15:01:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] soundwire: intel: use asoc_rtd_to_cpu() /
 asoc_rtd_to_codec() macro for DAI pointer
Message-ID: <20200420140135.GD10045@sirena.org.uk>
References: <87y2qqvdxu.wl-kuninori.morimoto.gx@renesas.com>
 <20200420070816.GU72691@vkoul-mobl>
 <20200420120348.GA6507@sirena.org.uk>
 <20200420121752.GY72691@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <20200420121752.GY72691@vkoul-mobl>
X-Cookie: Hope is a waking dream.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2020 at 05:47:52PM +0530, Vinod Koul wrote:
> On 20-04-20, 13:03, Mark Brown wrote:

> > > Applied, thanks

> > This fix is needed in the ASoC tree - are you OK with me applying it
> > there?

> Sure..

> Acked-By: Vinod Koul <vkoul@kernel.org>

Hrm, actually this doesn't seem to apply against the ASoC tree - looks
like we might need a cross tree merge if there's still issues in -next.

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6dqz4ACgkQJNaLcl1U
h9C1OQf+MHwo1vgtr2S63TReVr+n0rVxeCKflOFkzT3yNEOHYpRgpoYgWg5iSZxM
hdjvyUVt/ajvFDgx3rfTygqddvoYeZILb7GTmcAQ2KNy7OhtdSGIXohiZGY3+1by
IBdzI8uteoh6Bv+FiyIsClFzez2DvPRd2oNJywKQ7lVByBlqMPscIJLXfCbY81dc
I2m3ISJrt97mpDkoq9bweSKxgiscWJ+BsTKsB849LNU453Abim+JkC0IZ944WeUw
LREfpN8Btfgaji/x+o6oWEDQOdN3hl8rgUdEIQMe/nqH91bE3k5q/kzq4ikPJj7W
i3kPCrvHIcERSOadrvOV6SawOmkW3A==
=NMpD
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
