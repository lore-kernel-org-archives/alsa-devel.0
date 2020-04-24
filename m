Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE5FC2BA1A
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 11:28:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DDF20736
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 11:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dEgpwJ34";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNQ3y7fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DDF20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE8A616B4;
	Fri, 24 Apr 2020 13:27:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE8A616B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587727703;
	bh=eYrt0DhfHL8MzWet8ARA3Z7MX9CJmIusw5TyDe1J3G0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dEgpwJ34MscVybX11+1uagRlOD1Z/UfSUEKGicUfzDdT06lmimCF+reDODbzePEWE
	 ysJ2AuaCGnQI3LPFVtV4GhYv70kiipzWzWt2bGAsm76SQQH42FtqiGxtBuIwLb4KFG
	 4b0zRc2wvHQQtRuPMfpKf/3MwUXD+03ENg68HpfI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C817F800BE;
	Fri, 24 Apr 2020 13:27:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 221C8F80142; Fri, 24 Apr 2020 13:27:31 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF3A4F800BE
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 13:27:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF3A4F800BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UNQ3y7fr"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E269A20736;
 Fri, 24 Apr 2020 11:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587727645;
 bh=eYrt0DhfHL8MzWet8ARA3Z7MX9CJmIusw5TyDe1J3G0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UNQ3y7frkEdbQB788zY0uvD9/hKmaoZuJouQlQG01g3AcMBPpzGoDxLdQDeQSiG2m
 5p8VT9dQ+tHhcH4xA2Ij/3AoT3PdNnY6xzu+mpOPfETjtMhXyfgDVABT06ej0RX6p2
 zK43/uQcri+uI3KL355IIC0P/P9ixgBtAi5PGVec=
Date: Fri, 24 Apr 2020 12:27:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Subject: Re: [PATCH] ASoc: nau8810: add AUX related dapm widgets and routes
Message-ID: <20200424112722.GE5850@sirena.org.uk>
References: <20200424071739.20854-1-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0H629O+sVkh21xTi"
Content-Disposition: inline
In-Reply-To: <20200424071739.20854-1-wtli@nuvoton.com>
X-Cookie: Information is the inverse of entropy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, KCHSU0@nuvoton.com,
 lgirdwood@gmail.com, CTLIN0@nuvoton.com
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


--0H629O+sVkh21xTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2020 at 03:17:40PM +0800, Seven Lee wrote:
> This patch implements the following features:
> - AUX input for recording.
> - An input AUX output to SPK/MOUT.

This fails to build with current code, please check and resend:

In file included from /mnt/kernel/sound/soc/codecs/nau8810.c:24:
/mnt/kernel/sound/soc/codecs/nau8810.c:359:3: error: 'NAU8810_AUXSPK_SFT' undeclared here (not in a function); did you mean 'NAU8810_DACSPK_SFT'?
   NAU8810_AUXSPK_SFT, 1, 0),
   ^~~~~~~~~~~~~~~~~~
/mnt/kernel/include/sound/soc.h:33:39: note: in definition of macro 'SOC_DOUBLE_VALUE'
  {.reg = xreg, .rreg = xreg, .shift = shift_left, \
                                       ^~~~~~~~~~
/mnt/kernel/include/sound/soc-dapm.h:293:19: note: in expansion of macro 'SOC_SINGLE_VALUE'
  .private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }


--0H629O+sVkh21xTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6izRoACgkQJNaLcl1U
h9BinwgAgJtC+2LXhyn/Z7PsU7+JTztlh16uvw6S5l8cTC8XSpUhbTQmQ4WPnoNN
n8ctxd2u58Rns5RIZfKHxGsRpws3gcsK3hnUnXOKxNTO6Fz77/qQaLmGlnZ0bEyh
YObSMiwTX0aSp6bhB2jMsjWda+erzkMaQ0t0PSoW/diLtgqJ4L0JEq0FcyaMSBjM
R8p7aLCsyPDXNJp98RmekfX+bUFRitZDF/VRM0Mz7KaiYN5hNV+OK7wCW1zt06Rw
xPzZfhUYHBpy7VuU7hcFJqafNAPm3TzlSmYTDn2vEvKUvKLg7JLvi+U5tflhQSDp
8g04etgAtILzW50sqHUkgQ+bS6KmyQ==
=ktGr
-----END PGP SIGNATURE-----

--0H629O+sVkh21xTi--
