Return-Path: <SRS0=Q+Fc=4C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90B8C2BA83
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:52:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C02222C2
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 11:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m/eSuk1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C02222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77DF6165D;
	Fri, 14 Feb 2020 12:51:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77DF6165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581681135;
	bh=2nuMWCqlHc2UMVm8PfWEt8mzNQytKcvb9ah+nyQAhio=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m/eSuk1LKqnfrl75NTbrC27aLNQAo/dfMSPnc0N9vRKyxhBIFmDfnWsoZHoLKfA9H
	 /onyC/1acBLxTJtgXY4D1r4dFK+tfuLDKBUV9fIFRMKXjV4nsxpiHhloO5ddJ7EnPc
	 eUTJU2RtDrZhLAB/dkdtr4TYEGFDOkhdzPayIWQc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F40EEF8013E;
	Fri, 14 Feb 2020 12:51:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64911F8014F; Fri, 14 Feb 2020 12:51:23 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id DDDC2F800F0
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 12:51:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DDDC2F800F0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B36FB1FB;
 Fri, 14 Feb 2020 03:51:18 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36ED33F68F;
 Fri, 14 Feb 2020 03:51:18 -0800 (PST)
Date: Fri, 14 Feb 2020 11:51:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>
Message-ID: <20200214115116.GC4827@sirena.org.uk>
References: <2fe07b2c200f43bc81de61f4e6c780ac@realtek.com>
 <20200213210404.GM4333@sirena.org.uk>
 <7a6ad579cc9044778d8d515d24a2b448@realtek.com>
MIME-Version: 1.0
In-Reply-To: <7a6ad579cc9044778d8d515d24a2b448@realtek.com>
X-Cookie: Shipping not included.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Oder Chiou <oder_chiou@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 =?utf-8?B?a2VudF9jaGVuQHJlYWx0ZWsuY29tIFvpmbPlu7rlro9d?=
 <kent_chen@realtek.com>, =?utf-8?B?6Zmz5pi25b+X?= <kenny_chen@realtek.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
 Mingjane Hsieh <mingjane_hsieh@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt1015: fix typo for bypass boost
	control
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
Content-Type: multipart/mixed; boundary="===============3856593014287766936=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============3856593014287766936==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2020 at 09:28:19AM +0000, Jack Yu wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> I've generated the patch again from latest "for-next" branch but still get the same patch like attached file,
> not sure what's wrong with this patch? Could you please help specify what's wrong with this patch?
> Thank you very much!

Applying: ASoC: rt1015: fix typo for bypass boost control
Using index info to reconstruct a base tree...
error: patch failed: sound/soc/codecs/rt1015.c:444
error: sound/soc/codecs/rt1015.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Patch failed at 0001 ASoC: rt1015: fix typo for bypass boost control

Is your mail client corrupting patches?

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5GibMACgkQJNaLcl1U
h9DOqAf+JisAcTCs44A8MKDOgUDofFR/XlBBK2RbxVQm8lHPfV36GXhwtIKbJzzZ
KlReL2cIX88Qvrkyw3tO+afs5bjaHC6aTmq2iiSK7VLyY+4Vp41HaFGuaNCD0A1+
3Euun9K2vcHZLwHwUU0E62+js20kKZSo7o6b91DM2viopDZ5HfN/X0eKpYCsZyAa
wmD9vQLsBDLk7lVSHcwTjKQlywaI/E8pe4I7M3icAz7dUZhuzba/jucT3t4rGKun
8EVaxr3kwmCm37LKpIfnggeZLs8Rxh4rc3ggSPBWdq+AH301Ld+7chnic2udtBAz
Hk41ci+zsbeS42yvUVXf7gvaiDPKSA==
=Goj9
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--

--===============3856593014287766936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3856593014287766936==--
