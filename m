Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025A8C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 14:30:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7788A64FB2
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 14:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7788A64FB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1092F829;
	Fri, 12 Mar 2021 15:29:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1092F829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615559430;
	bh=Ew7I58oO5yr5QKDwsafuutxkOSwTubXEyD4x83nFw78=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qGjHAjPAm7hPwQDlPPjdSlmJlGodezvdM9S04qzoadJ+l/FbN0PLfdqqyl5+EKf6H
	 jad40bI0JbUmbcl8LNzVvU8ms9RMJMmIRFAOBq/azM/qQxYfG2FsGM3dH4NTM1XkGv
	 2eMs6v2N46L0nTnkkUDZd1nK1wOeSrbzazjNK7DI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8447CF8012A;
	Fri, 12 Mar 2021 15:29:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EAD8F801D8; Fri, 12 Mar 2021 15:29:30 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A1645F8012A
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 15:29:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1645F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="oCSuOW4E"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4315664F59;
 Fri, 12 Mar 2021 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615559365;
 bh=Ew7I58oO5yr5QKDwsafuutxkOSwTubXEyD4x83nFw78=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oCSuOW4E3jjZyMZfdproKJsHPBIMYMTekMwkUJKwMTZD7p2PfuXByZiGfP6msAKJo
 2aXt14/Kp1L4cULfb3xgaQ6Y+guXK1iqrbyKo9fT84iphstD2vYQ3hvexMySdjX0Tu
 FMo8iWD2kXw4aENMXJAFIB84kVwppx1Lf5O/Wu2A3GSm8XXUxbxEPBrrSTiln7ZTV3
 3QLCwWZJ/KqlNyPWGcbcMnvuL3Gcv1nk9u6MZAXppgpkgq671DYgN6xbMqZP1KDFJE
 fJTaEGVQ36gbbpa3Gdf7Tqgunl5mSi0X+U/44pD7xPpxD8hnvTps+cQOyQVWIG3PaP
 kXrNMLYSU8ZRw==
Date: Fri, 12 Mar 2021 14:28:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 1/2] ASoC: samsung: tm2_wm5110: check of of_parse
 return value
Message-ID: <20210312142812.GA17802@sirena.org.uk>
References: <20210311003516.120003-1-pierre-louis.bossart@linux.intel.com>
 <20210311003516.120003-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20210311003516.120003-2-pierre-louis.bossart@linux.intel.com>
X-Cookie: sillema sillema nika su
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
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


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 10, 2021 at 06:35:15PM -0600, Pierre-Louis Bossart wrote:

> Fixes: 8d1513cef51a ("ASoC: samsung: Add support for HDMI audio on TM2board")
> Cc: <stable@vger.kernel.org>

Commit: 11bc3bb24003 ("ASoC: samsung: tm2_wm5110: check of of_parse return value")
	Fixes tag: Fixes: 8d1513cef51a ("ASoC: samsung: Add support for HDMI audio on TM2board")
	Has these problem(s):
		- Subject does not match target commit subject
		  Just use
			git log -1 --format='Fixes: %h ("%s")'

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBLensACgkQJNaLcl1U
h9BDVQf+JmTb2eFaj/+i3MC7LdW/OzcK4abEDlS+MLGWKruSdRPO5cPelqjWL5Xi
1pGsv6YvQus7jg/rfKEY1TY3pt+ml8X3vnTovWjfRhxODR2FSCVFoK7Wso66iRG8
mxwmWuRCXutmJtYD7sI8zGx84wvnDEOXlmFcDUz7pu+66D235Ezoa4xDSeAblxSU
kPrG6rkiSvm8QtlcqV/tjsEODNMWOQgnupg5LLuTYT2LVbPVGabZUTmzDjCu/hYz
unUlyTpJK8LKaYaiIzdz53+yxZzZEwuZEZPS4pPGJGqfV3rODhW66M6xNEsg3CJ5
iJ97ZZcyEn17BR45vU5fl675cvEToQ==
=qXba
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
