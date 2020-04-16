Return-Path: <SRS0=OoyA=6A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB14C2BB85
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 09:37:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394E021BE5
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 09:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H0xjz8HY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0IjzBIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394E021BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B91D15F2;
	Thu, 16 Apr 2020 11:36:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B91D15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587029818;
	bh=8AFD3plu+KjEQrKRRIW/WPjAt6mrEDHJMoiYPlXMdsA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H0xjz8HYMt/BRS/N/RAZAbp3t+ZfQA64OlY0dHngBUAsR2ue5eXijLaARKALRZB9y
	 Vb7ccjaYjm1TA998iGafYej4MBZ91fYd80edfHA8iSVmudiu3kwl0bKM8U0aV/A8yO
	 zj+2tOUlRIVlwFqiItU3z3weDAKxxxvtpYjXdnpo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B5E6F8012E;
	Thu, 16 Apr 2020 11:36:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9616AF8016F; Thu, 16 Apr 2020 11:36:06 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59C51F8013D
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 11:36:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59C51F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="a0IjzBIG"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A7AD621BE5;
 Thu, 16 Apr 2020 09:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587029759;
 bh=8AFD3plu+KjEQrKRRIW/WPjAt6mrEDHJMoiYPlXMdsA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a0IjzBIGZOxVe1GHgJjUAzkRmKA0r5kDh8Nr7oICMwcdzUH7YneNHH72cx7RASZiS
 j3cuL/YvRXpslmP88sumAU/EOcBQ+Ljt5i3GBS1uOisUHO3WwjkEPmqyL8Z8NloauQ
 jMwFF3ysBTPYnXZ6lXlXh7A25hhFFc5TxTaJZ0ZU=
Date: Thu, 16 Apr 2020 10:35:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: lpass-cpu: support full duplex operation
Message-ID: <20200416093556.GB5354@sirena.org.uk>
References: <20200306130147.27452-1-srinivas.kandagatla@linaro.org>
 <841cb73b-82d3-9fb9-0ed3-547882872085@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <841cb73b-82d3-9fb9-0ed3-547882872085@linaro.org>
X-Cookie: Tempt me with a spoon!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Takahide Higuchi <takahidehiguchi@gmail.com>,
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


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2020 at 09:05:55AM +0100, Srinivas Kandagatla wrote:

> Looks like this patch was missed in last cycle, Should I resend this one =
or
> are you okay to apply this. This patch is required to get full duplex on
> msm8916 based platforms.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6YJvsACgkQJNaLcl1U
h9BgUAf+P5xci/XZM3xcqCLxrOBiDlbEAw2QYHpY+orX/gMgPJIya4k0/3KNlPsQ
Vr/987zEpqJApIrM6F3CYgwslsTcnLZzRvTJp/QxO4FR94Jb0guaZ6l031is7wHa
N5rNI9lO7hXE9zoOoHGF8E+7Us0cW4xfZOgpJq19Tos9vVOzn+rFVowK5E5BIcoA
k0oJ1MLNiUOq0lFIkwETNmvab9OVT9VJU+FpIvMqSmTh5CmaKtSx4W+HQGPbeWko
0UmjJlrJBgfMYZGEnLiy98dUjlod1OclUMLbj0TZZdxT3kAaqNP/agjZNUXBfNM5
FXtoMFWLdN+eJCtmhr1ABez71lygpQ==
=BL6m
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
