Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88B0C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:57:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7672245A
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="erOUs21D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/vJsgLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7672245A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C033A17DA;
	Fri, 20 Nov 2020 17:57:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C033A17DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605891471;
	bh=81bAv9ZK1UGPQKGMPKiVWesuqekUngu9SE7Z5LHy0Lg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=erOUs21DYFHSBm96Ad0/MzkPauKdjYtvb/LrBn2uK7bVLJSi1DOUNcOebnZ2lv6E2
	 +M3OUHOoU10u2bhjhT2+cyUoQ+G74Z9uuJ+q3pN4gLhM3HP7t7hgx/C75WWVsSa5+J
	 rAj9i9uvw6VqAPp+jRcpKYVGAK9uzdaLaDv3iaaE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D937F80168;
	Fri, 20 Nov 2020 17:57:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D91CF8016C; Fri, 20 Nov 2020 17:57:00 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBBD8F80166
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:56:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBBD8F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="e/vJsgLe"
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 [92.233.91.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 485FE2225B;
 Fri, 20 Nov 2020 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605891415;
 bh=81bAv9ZK1UGPQKGMPKiVWesuqekUngu9SE7Z5LHy0Lg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e/vJsgLeAOwe6LOvO+cCMxSsaVj3a/1ZKes+N7nx0ftzSl8fv5+P+NfVTS0Gpl3Yl
 dVZfwIIK8fvhMzuS03aYrCVYjYLGuz/XssrW6XljGViUAZQH3v19AFXa2dYdRzGVo3
 rnqNILL8IET5wmwym/g2lSv0ZvnGYCIT3DIacZqQ=
Date: Fri, 20 Nov 2020 16:56:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id
 table
Message-ID: <20201120165202.GG6751@sirena.org.uk>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D6z0c4W1rkZNF4Vu"
Content-Disposition: inline
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
X-Cookie: Have at you!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>
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


--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 20, 2020 at 05:16:15PM +0100, Krzysztof Kozlowski wrote:
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it is not relevant here).  This fixes
> compile warning (!CONFIG_OF on x86_64):

It would be better to fix these by annotating the table as potentially
unused, if nothing else it means if someone wants to add ACPI support
(or it just works on their ACPI system with the plain old I2C ID) then
they don't need to revert this change.

--D6z0c4W1rkZNF4Vu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+39UEACgkQJNaLcl1U
h9CgmAf/TTilda96a36q485f2SyA+IVRXAggLG/0IGEmSeyFkPP8BmZuQnO2upBd
nym7EJHvUPEUn+Fb+Y9CaHG773ncymC/+L695gqlaf4LZNph2FmatHUhQE001ULh
07CC9JJ1CMMRQblKn6wKrLN6D8MvdLXAMI+NOyk+mINvH418nEXRnLZSmhvK2poa
w+gU7sM6xBNc8dcrOXSUB4GeWRSk5e5o3zGIB3CkPQaomoEH81bINbKw1wGbyHuC
r7xRgGrCr2UV2SMQHz74EXvCx9dsGwc7G6nHaN6AqLeyUkHBXojKet8kJsOxwFui
c1rPK+vfugjrmYf7IsLKPizFuqozqA==
=/Bw1
-----END PGP SIGNATURE-----

--D6z0c4W1rkZNF4Vu--
