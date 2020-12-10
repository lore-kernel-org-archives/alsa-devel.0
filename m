Return-Path: <SRS0=UiOR=FO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2EFC4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 15:43:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56ABA23770
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 15:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56ABA23770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B05BA1668;
	Thu, 10 Dec 2020 16:42:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B05BA1668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607614989;
	bh=o1vHR85L1PmnJia7WdCm8hPCTS9+17L1Ezqb19hWoPs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kI32F8xglyh5bnWML3XC7+AfjKLz+FDxE/XuK1rLAmU6OLODtm+LZ1sgrGBoVkPTX
	 ZEX1Vzv2GZ01aBue8lG7O1RPHPea/459NAWc627of01sdgpMTZxggHLC6F2tjneswb
	 4vtxA39OBxHOW/1XieHfFnoSJ3QZxXafqZzDxTI0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21A0EF80164;
	Thu, 10 Dec 2020 16:42:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39037F8016E; Thu, 10 Dec 2020 16:42:17 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07164F80105
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 16:42:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07164F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GqDa6c9R"
Date: Thu, 10 Dec 2020 15:42:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607614928;
 bh=o1vHR85L1PmnJia7WdCm8hPCTS9+17L1Ezqb19hWoPs=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=GqDa6c9ReZGYpyKO3D01S5khMe9U0xYoSvtJZHWoGkrfWvTHb+RuY3HKmIsWI84jT
 Le+nrCcVLOvz4t7GlK3ee00lH+hDZWkQ3Iq3m8mC+Bev8VdnpzOgSs2+VeMbGO1Fx/
 V6p0IV9S17ytXAaGdwkqUJSrLgR8A/dcTtIstwjTETOfdBhedYRxJjB2b6DIIs+5xy
 R3uPbZjsXN01eMt4gGPy1FenVnDE+OpZT+ExfWi2IfDMox7fKQh/A6FyO+nCx9DQtB
 /RkEI4pTaAp1moHn10bVbbi+YWcK2LIKMRrcWDgml4O3kX5jUcnChtRsta8tY+DJIk
 shKHIjaigkeDw==
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH v2 2/2] ASoC: rt1015p: delay 300ms after SDB pulling high
 for calibration
Message-ID: <20201210154200.GD4747@sirena.org.uk>
References: <20201210033617.79300-1-tzungbi@google.com>
 <20201210033617.79300-3-tzungbi@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
In-Reply-To: <20201210033617.79300-3-tzungbi@google.com>
X-Cookie: Your step will soil many countries.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org
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


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 10, 2020 at 11:36:17AM +0800, Tzung-Bi Shih wrote:

> +		if (!rt1015p->calib_done) {
> +			msleep(300);
> +			rt1015p->calib_done = true;
> +		}

Might we need to reset calib_done over suspend?  If the device looses
power I guess it forgets the calibration.

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/SQccACgkQJNaLcl1U
h9CR4Qf7BqSDTdGuaHiMYO7pwsDwCxVqcV2R1W+Cu47PDXDAAlCXyte0m/K8bCll
cSuze1PvAdgzfG1FrlGthboyxs/7+MZCWjb/1b23Gdlud7eEWLH4Unjw+CyGrbV2
j3PfI6fTPRmQrWfYltUxya71KZt9ggNxbUuvqjGtRZJL3nOS6Qo61VZWzjK2IQH+
2hAQilI8+zpKkC1WfZubGJH4DJHWohcw98s2Nhi2MD8+8rQ7n4K4/+a6PjjRwtRk
x2H/3hdR3diyHNpY59XtnuI5J9IJ1f96n453nzNzXBQcq+ZtbhkbncDByc1Q7zap
HSJDdl5V54IIDWmZTn+HnrJbUrRWrg==
=YOuB
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
