Return-Path: <SRS0=ZkCr=I3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687EEC433C1
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 08:13:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29616196F
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 08:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29616196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0BD81614;
	Mon, 29 Mar 2021 10:12:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0BD81614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617005608;
	bh=9bRCGq90r+p78vA5d4jceQEM52+HuLa+aFCpbZ7xd6Q=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YvnFlY6QjAC64OitP+szex0tysnlHQalonyru2vCumfFeOYZfDV25lHADsOCaK8CM
	 WJ/fgUASPglRYmHFjrXl4+OrRgEJEPQII7GEZngW9JM0H9mjTRJo0jeFIupWq0IaRQ
	 NA5cxP1V0Yb3laM0MubEEHlk6dMI1+93vwKs5Uyo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5AEE5F80157;
	Mon, 29 Mar 2021 10:12:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D109F8015A; Mon, 29 Mar 2021 10:12:31 +0200 (CEST)
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F885F800DD
 for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2021 10:12:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F885F800DD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech
 header.b="GjY7Jcgz"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="OKoiPS7d"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailnew.nyi.internal (Postfix) with ESMTP id 276165807E7;
 Mon, 29 Mar 2021 04:12:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 29 Mar 2021 04:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=oqsVx7Wa9B3yL9HqcD5l5oz8SUz
 RLcA2I7HU56LTzCk=; b=GjY7Jcgz1iDDJqrMJX7TE7dg8hs4xL+gJIns2/d0GYN
 Tu8Q64JfeinRu244wd6gRP4/2sFruUqc2Joo8Rn+OY/5o9+XbtPiZJP/CQSgwkeH
 a2LyYQrjOctpd4sfhSkemNYbQwlyw6zH1ZI5O+4NlT7YJKJYjxs7Jtyt+HAJkndU
 rmXh3MDfG1SuIgJlRIMdd1y/1opMPzDrNk9TpM2urYqSJ3cM42Bj9cBkZqxEJ2pT
 W2F+irrpWfwwhCEZI+gss+jfDHPynvAplgMbeGYZzRRmX3wKG3HTO/oIhFAAVoJ5
 yrpWDiaiXd1lgL2Tm1+zdUYile5yXBv5rokcvIe0XTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oqsVx7
 Wa9B3yL9HqcD5l5oz8SUzRLcA2I7HU56LTzCk=; b=OKoiPS7df+NHR9dTJqSc5U
 szrjSfirFd8YXJeVZ+TNqeW41QpaR26yLx+VmxRCTBwgnJMA/hPu/is+Niu1lOvS
 3if1wOtng48/HhduveCnox3WYYNyvjjMv7ardEiVUJzfTH5i4du2NgkSJ8v7zM1S
 aHC2wMvCtObg3vkZuxUSQ497blWcGTItBRgzKKYw0FakGiBY9NsM8FX+SI7tZz2K
 I7Uax1tKwrIxNOTXpEAvdzvOdcNW0T3YeNgEXymwE8vBGpzaQy1LNnBmcn6resXr
 lRQ/DBcIjQzKeszAzF8Kni6WkfCOf+7Pa8sQo69Be4me5yQZWx3qEyQmJj1RN2jQ
 ==
X-ME-Sender: <xms:24thYAr6X_Ta7EhcfenGGbn_wiLPA9uoY3Iy8ryogOyPuWKbiep7NQ>
 <xme:24thYGqOsLxTkPUmx7-0_MPFE6Q19hV-9UBnK2xhn0YI612BInB13XBXZL67J11gf
 qmYiNqwWgQZBicYRtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehkedgtdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
 htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
 gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:24thYFM3OCQDEbyYTF0PEim54NUusJVevjWQF04NrY3psnXYWrUUEw>
 <xmx:24thYH6MCy0RS2AlM2boTE6I5kHydWEjQH0IpEpX33LuezH97Ox4MQ>
 <xmx:24thYP7Jj5K0UHtzjI5u61CrzOUu1l2-XxI4oVcsABpo1TspaVz2eg>
 <xmx:3othYMHINI3lBy9KMK0ysKQ8PRgzauuVZo3S0NxsLHdk3orOUiQJYA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 657CF240057;
 Mon, 29 Mar 2021 04:12:11 -0400 (EDT)
Date: Mon, 29 Mar 2021 10:12:08 +0200
From: Maxime Ripard <maxime@cerno.tech>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 11/17] ASoC: sunxi: sun8i-codec: clarify expression
Message-ID: <20210329081208.dptewcdyfmyiph6b@gilmour>
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
 <20210326215927.936377-12-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zkapbnitichvusdi"
Content-Disposition: inline
In-Reply-To: <20210326215927.936377-12-pierre-louis.bossart@linux.intel.com>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, broonie@kernel.org,
 Samuel Holland <samuel@sholland.org>,
 "moderated list:ARM/Allwinner sunXi SoC support"
 <linux-arm-kernel@lists.infradead.org>
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


--zkapbnitichvusdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 26, 2021 at 04:59:21PM -0500, Pierre-Louis Bossart wrote:
> cppcheck warning:
>=20
> sound/soc/sunxi/sun8i-codec.c:488:28: style: Clarify calculation
> precedence for '%' and '?'. [clarifyCalculation]
>  return sample_rate % 4000 ? 22579200 : 24576000;
>                            ^
>=20
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Thanks!
Maxime

--zkapbnitichvusdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYGGL2AAKCRDj7w1vZxhR
xSEyAQDnB6Zo9u/iq0gHRIh8hjG34eg0RyxBVTAKQ3GY0LiocAD9EIAusS+HWyRH
dhe6wdMSsmoo0o/6HynyBoKaPodJewo=
=9pff
-----END PGP SIGNATURE-----

--zkapbnitichvusdi--
