Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB051C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 12:02:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0695F20776
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 12:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G84YLuAM";
	dkim=temperror (0-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="tzCd4XNq";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e4gSgW+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0695F20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F19E1671;
	Mon,  5 Oct 2020 14:01:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F19E1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601899368;
	bh=3/H/39oxCLXovEWnpX8PI6zHWcXeyqwfHyRWts2U2fM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G84YLuAMde4TStNTTzANZHFG8zW4VqE0pVpe+SehCFqhUk3oxqPhCfy95LEfJwC2y
	 BrCfxfYYHdm0dSe7WRfQOXD1C2VGiHkgawPzZMz4kv+0SYKrPmdAO3AmTHL4Lz+3+N
	 ed9BxyD23p7rEe2DxBRX/6Xy84++XvmRQ557Fw3U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22212F80260;
	Mon,  5 Oct 2020 14:01:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8BF34F80260; Mon,  5 Oct 2020 14:01:57 +0200 (CEST)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 085C1F80121
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 14:01:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 085C1F80121
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="tzCd4XNq"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="e4gSgW+l"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id BBC295C0174;
 Mon,  5 Oct 2020 08:01:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Mon, 05 Oct 2020 08:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=3/H/39oxCLXovEWnpX8PI6zHWcX
 eyqwfHyRWts2U2fM=; b=tzCd4XNqUTmbWNU5fbF1TR29JdwpF3+pukn2b+Risf/
 R1Fr4x4FJhWUjscdTbyJBOU3sD7XqhGglk3g3T/5MO5HBVSibOayD+nflepicYzL
 Nfgxaz/HrVlxSR5R69/FRujb3SdhhT7RTmMlLqzXZJWECgVjodJmLv/BBVUMfoKn
 nadJrXfUQD1k94Ln5CBU1tJJ/xnXnbb9q/p49MY/Im3moSXE+TPlmVTTXxSMp/7t
 1/T8UxCMnUfGhMRG57Tuu93qHvhPHO6S4fSdK3PVBC8WEBgQFHXWSbFSlGPnlmCF
 JlbpWg++Xg4ulOnZBaS410CEgA6rz/38HZvoEugi81A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=3/H/39
 oxCLXovEWnpX8PI6zHWcXeyqwfHyRWts2U2fM=; b=e4gSgW+lJRcnZ5P4RCeDy1
 YT8CcTBWOMBy5rrxFfFR76Siq5FAHdhT4yBDMptPwmV9BgHDDHPBh3IVeLoyKIuL
 jtQEmJqcCz29iT+1ehrzme4XFsJNpT40zfOgybRPR+XRGn1q9IKbIV+W14KeT7/0
 lFGq+7CCgOPvL7XxAYAXXtzdmrvqfnU/KrVG1RpBqA8ZqVer7fyQGzbRPrSIxcmN
 AA3tK1oylf8xIqnBzkzPTIf4+Ufs8x1f5m4dCoOtOicGtPYLc72EZdfJyRHyVeqj
 QnEclISrsmoqA+6t4NAKVuL8wRtZdr/fvXe0TXZyS6dPW1ztOc9Evad0v7dFHO2w
 ==
X-ME-Sender: <xms:KQt7X8K3udJFBwyKnZrYZ8D9fWiNjn3YdECbJYJKPMeiQ7QxiGlDxg>
 <xme:KQt7X8Kl-X4mpUxOaBTqQ7zRytSW2_EumvrMEXmJh--nNPcCrznB8o7eB1KuPnK0w
 h6lwMC1pfYExy18Asc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdeglecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
 ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
 gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
 udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeefnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:KQt7X8s3cF2JEK3rXCIICvX8OR3P9g97Ibd3Ooi7liWm_dS-Ph9yiQ>
 <xmx:KQt7X5aP71isW2ch5U4fijcF7B-FnrMtRaksBBzyEOJVRYU3E4ouZw>
 <xmx:KQt7XzarjMeGSpX1qQhzSBI1SL_HtmWbFyBo5p68hS0AT3Eu545GZw>
 <xmx:KQt7X34kAP-iGMjy63BYhJyxscVu1RCtxC-_T9P0VXBk0UBjZXlAgQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 3A66D3064683;
 Mon,  5 Oct 2020 08:01:45 -0400 (EDT)
Date: Mon, 5 Oct 2020 14:01:44 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 21/25] ASoC: sun8i-codec: Require an exact BCLK divisor
 match
Message-ID: <20201005120144.2fgkyrx7fkpd476i@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-22-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nlxn7rikredzkrun"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-22-samuel@sholland.org>
Cc: Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
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


--nlxn7rikredzkrun
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:44PM -0500, Samuel Holland wrote:
> Now that we guarantee that SYSCLK is running at the optimal rate when
> hw_params succeeds, and that it will continue running at that rate,
> SYSCLK will always be an integer multiple of BCLK. So we can always
> pick the exact divider, not just the closest divider.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--nlxn7rikredzkrun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sLKAAKCRDj7w1vZxhR
xaP+AQDSfmb1WdHbLnosBAzOuSmNxcUnAg+f3Sum33yq/W1gXwEAsjekGxOguqkP
4Vz8tWyglH4rjtvTAKk0+AFDmbnhjwc=
=t2Ji
-----END PGP SIGNATURE-----

--nlxn7rikredzkrun--
