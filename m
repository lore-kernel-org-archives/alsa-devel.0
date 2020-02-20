Return-Path: <SRS0=8DMN=4I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444D0C11D1B
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 19:45:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA35E206F4
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 19:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sk1Ts9UO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA35E206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27AF6820;
	Thu, 20 Feb 2020 20:44:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27AF6820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582227925;
	bh=jy8tDLfzTXTYRcXEUoi81f9eEPJ1OWLxv/i9o6EZz5k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sk1Ts9UOjoJEQKKMF3qR7RDL0tevP7Kg7mfqdq/jOvbyVznIcxJXclsSOkMUt9Q8Z
	 wpYeOcCn2TCZ9WOro0X34Buj8Arlw/k9IuF0Oljz1odLVfU1E0i+cqP+orckPXgu6t
	 BGg2i14YzJsafWBhCNJwe9flPJ/iCk4rx1ZLKOfI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4EB1F80145;
	Thu, 20 Feb 2020 20:44:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9125AF80148; Thu, 20 Feb 2020 20:44:32 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 1C7ABF8011D
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2020 20:44:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C7ABF8011D
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E58B30E;
 Thu, 20 Feb 2020 11:44:28 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 585C93F6CF;
 Thu, 20 Feb 2020 11:44:27 -0800 (PST)
Date: Thu, 20 Feb 2020 19:44:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v3 0/2] Introduce the TLV320ADCx140 codec family
Message-ID: <20200220194425.GJ3926@sirena.org.uk>
References: <20200219125942.22013-1-dmurphy@ti.com>
 <1d2b79f5-a928-adc5-b6f8-e73e0c061f75@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ofZMSlrAVk9bLeVm"
Content-Disposition: inline
In-Reply-To: <1d2b79f5-a928-adc5-b6f8-e73e0c061f75@ti.com>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 lgirdwood@gmail.com
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


--ofZMSlrAVk9bLeVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 01:24:14PM -0600, Dan Murphy wrote:
> On 2/19/20 6:59 AM, Dan Murphy wrote:

> > TLV320ADC3140 - http://www.ti.com/lit/gpn/tlv320adc3140
> > TLV320ADC5140 - http://www.ti.com/lit/gpn/tlv320adc5140
> > TLV320ADC6140 - http://www.ti.com/lit/gpn/tlv320adc6140

> Please let me know if there are any additional review comments on this code
> I have 2 more feature add patches on top of this patch that I developed a
> couple days ago and don't want to submit them for review until this driver
> is integrated.

You posted this just a bit over 24 hours ago...

--ofZMSlrAVk9bLeVm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O4ZgACgkQJNaLcl1U
h9Bvawf+N0d9mAzg22+fazMaFpDweaoHxUZbPEW2IwwhC4GBJ95/Z80s2bfVxRgN
Tdw4akcgXjSzh358u0LZsuAee0G0uNA4KDBLn/SShioH2tdoWpGCtYGNEToJocxS
hhTEk6xnSfIfJz0gOATZZ2JD8+FdbO3d9GxiuAKQnqa04540oaYbE3MfFHn/zb2t
o+756jzCn60wXDG6qX1Nb4vvRwZoenkPku7R8zK9h9dp/8CiPXZm9EDz4dFSifCJ
wv37xTF5niLrs+wdWoXZPv/M7rhP2Y4dT0Vm9lgk56awZqHi1P6SgajisjTTUYHm
ormGVILCOhrjurk/IqptKkPFs31mTQ==
=pCGf
-----END PGP SIGNATURE-----

--ofZMSlrAVk9bLeVm--
