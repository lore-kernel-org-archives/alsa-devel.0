Return-Path: <SRS0=+0+W=NV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F97C432BE
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Aug 2021 11:16:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766AF6112F
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Aug 2021 11:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 766AF6112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 710A3171D;
	Mon, 30 Aug 2021 13:15:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 710A3171D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630322188;
	bh=NyYyKNuQkuQYhHpyfihpNQPI/JcjzacTLjVC2LrlJ98=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=txYxXfNZel8sE8xLZbVQSbbIdzby8Ut0YefV/ITXrGDcPx0q7wNtyZ4c3RV16K/ZB
	 Sddcc3SuYqmrnshHIbJAQAn1XujSTTlAy6rQKEfF1DIqqBiC8PT1HeGII6gz203Hvz
	 N3dVSuqSnmhOd4uesIlSjDhjBSVyYyW6V3vigc70=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00970F8020D;
	Mon, 30 Aug 2021 13:15:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25D2CF80218; Mon, 30 Aug 2021 13:15:36 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87513F80169
 for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2021 13:15:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87513F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="iO3Ttje7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NyYyKNuQkuQYhHpyfihpNQPI/JcjzacTLjVC2LrlJ98=; b=iO3Ttje7TRC+xHw6IJi+90271Y
 Cow65rC3yqKmeEfYxVCcbb1w5gKRQWum8EgB7HmIRK3QsdZD6hN/TpAN31jcODTKMB1gqPfTbvHrm
 SzyDGfpoW3RRRkxcYSQOaqlYP+a8iLb1V9Wze3AzT5guyLCXqlhVU+EYCm7T1zEqGzBo=;
Received: from jack.einval.com ([84.45.184.145] helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <broonie@sirena.org.uk>)
 id 1mKfGF-00H3kp-88; Mon, 30 Aug 2021 11:15:31 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 9A40AD1B485; Mon, 30 Aug 2021 12:15:35 +0100 (BST)
Date: Mon, 30 Aug 2021 12:15:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] ASoC: soc-pcm: protect BE dailink state changes
 in trigger
Message-ID: <YSy91xTP/5oSedrZ@sirena.org.uk>
References: <20210817164054.250028-1-pierre-louis.bossart@linux.intel.com>
 <20210817164054.250028-2-pierre-louis.bossart@linux.intel.com>
 <163000225499.699341.16303629557242399115.b4-ty@kernel.org>
 <27b9fe7a-18cc-61ee-1e4d-72282d8eaa82@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KbF+CK+GgO/eToBg"
Content-Disposition: inline
In-Reply-To: <27b9fe7a-18cc-61ee-1e4d-72282d8eaa82@linux.intel.com>
X-Cookie: I can relate to that.
Cc: alsa-devel@alsa-project.org, Brown@sirena.org.uk,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, liam.r.girdwood@linux.intel.com,
 vkoul@kernel.org, Mark@sirena.org.uk
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


--KbF+CK+GgO/eToBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 26, 2021 at 02:24:19PM -0500, Pierre-Louis Bossart wrote:

> Ah sorry, there were still some issues in this RFC, we did more testing
> and came up with a lot of improvements. The intent of the RFC status was
> also to make sure it wasn't applied before the merge window.

> Can this be reverted in your branch Mark?

Ugh, right.

--KbF+CK+GgO/eToBg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEsvdYACgkQJNaLcl1U
h9Aqrgf9EqS8ghLiE431Ff8LEj0Cc56w0GFY5ljKjEOBU0VDBAZ+jQIoCJLMvImw
AeOd2roO7f1P1CFWm6Dn3Nd2aCfcemNX9SmUmwZNa1Frhr6lvo8/StQjezz8ReIU
gHMsUafvjtwXpg+utcbwOmekXrwWtJ1PfMyNR+4HHjEbk1WZ7FFw3Podk/NTOkMR
L0p8YCV2JoFyjm6Q30sOehuud4a2PX8FTumfSW+iC271IT/gGitBE78F1fmrJ1P+
BxPOSdO0EGUhZPjTDRKaIz/ZvnGTCzqO5vIE7RZb+JfYlj9rUd5nnJys7B64YeO4
Y11z5mNXeRi4jwFznwao3mR0xNRfNg==
=wzKS
-----END PGP SIGNATURE-----

--KbF+CK+GgO/eToBg--
