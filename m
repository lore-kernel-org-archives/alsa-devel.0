Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77534C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 15:33:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E4636127B
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 15:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E4636127B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A43FD1675;
	Tue, 24 Aug 2021 17:32:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A43FD1675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629819220;
	bh=useLE5bRaimi6Kd/BLq7pD9m3sUa/LB25LdOW1tuUa0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gphc+lhVAQxtPzcPPS/7GB2Bov6X5sZo9g7WIBNr98G3rzZ+l31erME0i0eHN2N1F
	 EmmWfzN9sag5YZxQqMOiz4PfAcFfET4nB57pkn6TlZ/vgcQtz6xetkZHW1yuql9bA4
	 XoHXbX9Y8aqSJVNxLqXUDBfpc3s0jO4aRZIGjeNM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36E62F801D5;
	Tue, 24 Aug 2021 17:32:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8E541F801D8; Tue, 24 Aug 2021 17:32:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97280F80087
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 17:32:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97280F80087
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HejrD8UY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5BD661265;
 Tue, 24 Aug 2021 15:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629819159;
 bh=useLE5bRaimi6Kd/BLq7pD9m3sUa/LB25LdOW1tuUa0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HejrD8UYIOrPlQGN8MRhEgMLf8UMem1Tdl6Wexbdow2MWDWML+WlVo9Q42tua7LYz
 YDbd8ufOgQcdWlRCZsSLPrH//U3QXqaZnk5FBLzx0poUyQfiZDnzICRPgEMaP//1VV
 q8kfPtLvpLDpCtgbceNA+eUJc31JSCZgGjTWn6bCHOcNuxjsoE3ZGbO1X/CFtmu7oi
 kCLSVUa1xidLlOqz+M0DaR4eyn2Gc12P0GmbJcG5pJSUu2rtWWOM8UhFwuf/Qvw7DM
 E6jUtXHeERRM8iYHbO09tnz7a9Cg8CQDI2ARM2gc7o5pP1L8bvXJtTYQBbwQ4hewLo
 65t+fDM+NOPbw==
Date: Tue, 24 Aug 2021 16:32:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH] [v2] ASoC: Intel: sof_rt5682: Add support for max98390
 speaker amp
Message-ID: <20210824153211.GC4393@sirena.org.uk>
References: <20210824132109.1392-1-mark_hsieh@wistron.corp-partner.google.com>
 <a2cb1661-328f-81ac-813b-7629a28ed766@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <a2cb1661-328f-81ac-813b-7629a28ed766@intel.com>
X-Cookie: Sentient plasmoids are a gas.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: lance.hou@intel.com, alsa-devel@alsa-project.org, mark_hsieh@wistron.com,
 kai.vehmanen@linux.intel.com, linux-kernel@vger.kernel.org,
 yang.jie@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>,
 liam.r.girdwood@linux.intel.com, mac.chiang@intel.com, brent.lu@intel.com,
 bard.liao@intel.com
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


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 24, 2021 at 03:59:44PM +0200, Cezary Rojewski wrote:
> On 2021-08-24 3:21 PM, Mark Hsieh wrote:
> > Configure adl_max98390_rt5682 to support the rt5682 headset codec and max98390 speaker

> Unsure if line-length for commit messages has been extended to 100 as it was
> the case for code parts but this line certainly exceeds default.

There's certainly no reason not to wrap this one.  Even for code it's
not something to actively aim for.

> > BUG=b:191811888
> > TEST=emerge-brya chromeos-kernel-5_10

> Are these two tags meaningful for upstream kernel?

No.

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmElEPsACgkQJNaLcl1U
h9AARwf7BfAXV7Wkz0THiqAGF4w7gvMC27/IySbGoRAIhO2uzfCPnsbe/tV9vDao
TU77q+FporDjyxLMA3nBquq/5Wzu/byNIhLtF3Y3QUqMeUiLr3OpLjxUcaxStlVS
2tWbDEHPfMC2SGht+q2iVE+Nt4uUNM+vcF2vAn9h9DFpX9EarZGz0z9N/MZw42J6
EU0ryLqTeJHLVaQRdHu9W4qMkLEOXuoKup2TMW/8W5WkQBqgg66NW9kpV1ReR3l8
uWJhSW351c7UCkRL5mOYdjvgi3We94RwfjwOk8bTK9007ymJkAPhIrztK8LPgzVR
N9vY6z1Cnq3V4OWgltULn+MI9Mjweg==
=um1i
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
