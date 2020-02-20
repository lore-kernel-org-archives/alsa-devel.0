Return-Path: <SRS0=8DMN=4I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE045C11D20
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 21:15:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6031A206F4
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 21:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IohcGLqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6031A206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADBB116AF;
	Thu, 20 Feb 2020 22:14:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADBB116AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582233347;
	bh=WWyzUA1/3KGbFO+OnNgAC6QlyJprNA98Iyh36wKBubM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IohcGLqjfvAtUenTp6kwtAed5Gz+4Q/Ro3NqjuOVXSuH8MCIGzDBba+dMprRL9K76
	 wW80iFKxji8fv0tUqDJHcl2u3dgmitD8Ac7sTFKyey93yGSQ6iHpM+JsXuhqNnmzXK
	 d1pHqxbI2u/3OWY+QlBG0LT30/+X00+aKs/aWctg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 812FDF8027D;
	Thu, 20 Feb 2020 22:13:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FF8AF80145; Thu, 20 Feb 2020 22:13:15 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 53196F80148
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2020 22:13:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53196F80148
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5489D30E;
 Thu, 20 Feb 2020 13:13:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF1D33F68F;
 Thu, 20 Feb 2020 13:13:08 -0800 (PST)
Date: Thu, 20 Feb 2020 21:13:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v3 2/2] ASoC: tlv320adcx140: Add the tlv320adcx140 codec
 driver family
Message-ID: <20200220211307.GM3926@sirena.org.uk>
References: <20200219125942.22013-1-dmurphy@ti.com>
 <20200219125942.22013-3-dmurphy@ti.com>
 <20200220204834.GA20618@sirena.org.uk>
 <5cc47587-eae1-0b41-e91d-f9885a69d75e@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zHDeOHGDnzKksZSU"
Content-Disposition: inline
In-Reply-To: <5cc47587-eae1-0b41-e91d-f9885a69d75e@ti.com>
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


--zHDeOHGDnzKksZSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 02:52:11PM -0600, Dan Murphy wrote:
> On 2/20/20 2:48 PM, Mark Brown wrote:

> > This doesn't apply against current code, please check and resend.

> Ok this is against linux master should this be against your for-next branch?

Yes, everything except bugfixes should be against the current
development tree (in general things should apply on the tree they're
targetting).

--zHDeOHGDnzKksZSU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O9mIACgkQJNaLcl1U
h9AAigf/XSG3d+KNbLVuCL5Fw8T1HHOJG6NywlmHXJaZPJ0z2+gYsdvF2Kjm1hcB
odwSuIDhGOchTcn9O6d5F2TybHL6aPN46peEIogqTQyqO9/sJapVMsjnxtQ8XS4Q
4+gI1ppGi0mDcy3RdmZ47oiNwNNyfDA3cZYB4ebhTeQc0jakJGh3f9mVi01OyMal
r3mcpqgbFv+3Ab5gtpDmBmPN5xJJO0AERVsn8n8E/QGmapqeqn2GT1VFpPfSCzWC
K+d+CNzQ6Y/L6z4b2L8cU63W2iq72hVC6cZE7x4OvxbzPKZR9sy+tUJgV24B7srR
FcuVbqydSQRPeiB1Cffdw+OihXNvkg==
=nOnE
-----END PGP SIGNATURE-----

--zHDeOHGDnzKksZSU--
