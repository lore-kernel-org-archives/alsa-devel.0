Return-Path: <SRS0=NlLR=GK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA2CC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 16:44:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1680223435
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Jan 2021 16:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1680223435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CEC3168F;
	Thu,  7 Jan 2021 17:43:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CEC3168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610037889;
	bh=vuM9vAjQJkgCU4xBUoFmKddeaCN97wvKiCrb9wFq5Rs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JNUfAXOahCRxbETISvb3NMSA2Rw3ISkZ8jrO9nkYpUcxmDl2Ob4LMNBVRYfMLE6ol
	 wArah8SX3Pi3Qu3DiI9pQXfIlUCb6SWEloS0Ef26HK5E70oq1PLXBa7hZDAwSyKWOs
	 NWCvDqXuTT9wWHqMoTu8cHTnucGubqXf+f52uc+Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FEEFF801F5;
	Thu,  7 Jan 2021 17:43:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AAA26F80258; Thu,  7 Jan 2021 17:43:57 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B391BF800E9
 for <alsa-devel@alsa-project.org>; Thu,  7 Jan 2021 17:43:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B391BF800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="D3c+nbeK"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06DA923403;
 Thu,  7 Jan 2021 16:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610037832;
 bh=vuM9vAjQJkgCU4xBUoFmKddeaCN97wvKiCrb9wFq5Rs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D3c+nbeK0+kwJq39ghmw5I0A2Sw54HCgrv/tFM+DIHWYNS3ROj+9a3hGG/ymGzI+U
 Pu/rXvAE/ZQSwa0q//9N/EPrkdjLh0vVY7DxaJ2Dl397bBnVDmJKFh9D/VwUypQUdp
 Koza40wb43KKwHbactJTZwJb6+Lfd4gI28RLFuDEu4ytqWPOykodoaP3uyYKRp6H49
 IqdKD5U5ReSi/UR6ny56E3jUPVg35RtPdVfWOd7PdDhiZ5cDQsI/at36xOfyfq17CN
 A9Y2/u0XWCDapFMk+HKm9WPeJuUFo5n6Ahsnik1mLa3Q2JgipctO2/gyBqRrmfOu5f
 yF6y3JnRGKLFA==
Date: Thu, 7 Jan 2021 16:43:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH resend] sound: Convert strlcpy to strscpy when return
 value is unused
Message-ID: <20210107164322.GF4726@sirena.org.uk>
References: <22b393d1790bb268769d0bab7bacf0866dcb0c14.camel@perches.com>
 <s5hpn2j2rr3.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uTRFFR9qmiCqR05s"
Content-Disposition: inline
In-Reply-To: <s5hpn2j2rr3.wl-tiwai@suse.de>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel <alsa-devel@alsa-project.org>,
 kernel-janitors <kernel-janitors@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Joe Perches <joe@perches.com>
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


--uTRFFR9qmiCqR05s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 05, 2021 at 06:55:12PM +0100, Takashi Iwai wrote:
> Mark, could you check the ASoC part?

Acked-by: Mark Brown <broonie@kernel.org>

--uTRFFR9qmiCqR05s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/3OikACgkQJNaLcl1U
h9CliQf/fWBovJb9ILFKC38hv8wOmoZfK1W6JdCZ51RizmOwpB+ucVe7GG03haN1
hrh54Tj0NzpYo3cuAEWPMRIXiWisE77mm2MOGuf005H8oB58ETQ1B6GM/odbNEuA
MiHC0MdNL87krLHKIKQLKfx0FZ8K1T3VjvmJminiHTKtP90SPWWh+m260M7rFaMN
IreAoGI0QSZd2QYlX4/rcLgcAWhQdGBBSmn5L0bzHD41sobO5Cy74nJfIUovvtMQ
HZsgPZH/VmGJm931ztYmln9NuI9vhi76GYVeWlXvo8NNa+1zzGqpyQMjp9I8vUob
Nc1ec/s5nRsTNcrfpEiiUwOd5EMVCg==
=u4EK
-----END PGP SIGNATURE-----

--uTRFFR9qmiCqR05s--
