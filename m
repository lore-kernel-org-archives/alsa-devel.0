Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0428DC4363D
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:55:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B07206FB
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BtKO+saZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1KkE58Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B07206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8231E1738;
	Wed, 23 Sep 2020 16:54:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8231E1738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600872935;
	bh=hGNMwKlZkIkVAjO0KlOR5dGVWj4RUOhJMAvljVAG8IA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BtKO+saZMP6p28jnoNRQh++QHoogquV5KISab2K3PruXPY+7YB9HplZ0MphmT0x9b
	 6ox6XOCCcPmDDlpEp5Tywj1yjQ8Sbq+EBD6WA++wMmXJN2wuPDG6gFSnHXDlAPBb6I
	 +/E4Vhf+GX+xgjSk9nZ2+qXDLVhKGdKtOJZo5Eus=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10981F80162;
	Wed, 23 Sep 2020 16:54:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C75EF80171; Wed, 23 Sep 2020 16:54:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33E33F8010A
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 16:54:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33E33F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="M1KkE58Z"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6497B206D9;
 Wed, 23 Sep 2020 14:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600872870;
 bh=hGNMwKlZkIkVAjO0KlOR5dGVWj4RUOhJMAvljVAG8IA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M1KkE58ZDkPz1Bk5ZlX22yvCNoh/VfZuUfr1rpGsPwkxgR1d1NlW4EdrJOEvODzYy
 23N9CDGbwGqryEEvly1pu+PVNiIAuswV4tuT7JH+WOBqOux1cpf9fO4xMtYAIGu1We
 hSx0UI4slGFjB7m3t9HUtpD3wBIEDvCY5JSP1IYU=
Date: Wed, 23 Sep 2020 15:53:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v8 06/14] ASoC: Intel: catpt: PCM operations
Message-ID: <20200923145335.GB5707@sirena.org.uk>
References: <20200923122508.3360-1-cezary.rojewski@intel.com>
 <20200923122508.3360-7-cezary.rojewski@intel.com>
 <20200923135422.GM3956970@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <20200923135422.GM3956970@smile.fi.intel.com>
X-Cookie: This report is filled with omissions.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, marcin.barlik@intel.com,
 alsa-devel@alsa-project.org, filip.kaczmarski@intel.com,
 harshapriya.n@intel.com, gregkh@linuxfoundation.org, tiwai@suse.com,
 zwisler@google.com, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 filip.proborszcz@intel.com, amadeuszx.slawinski@linux.intel.com,
 michal.wasko@intel.com, cujomalainey@chromium.org,
 krzysztof.hejmowski@intel.com, ppapierkowski@habana.ai,
 vamshi.krishna.gopal@intel.com
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


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 23, 2020 at 04:54:22PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 23, 2020 at 02:25:00PM +0200, Cezary Rojewski wrote:
> > DSP designed for Lynxpoint and Wildcat Point offers no dynamic topology
> > i.e. all pipelines are already defined within firmware and host is
> > relegated to allocing stream for predefined pins. This is represented by
> > 'catpt_topology' member.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9rYW4ACgkQJNaLcl1U
h9BCDQf+IYfwYGluL7skI1vOY8g0rz1gsiDYaCnMxD/XIFUdom4hW29pAi5NuX7R
pPB+6YhkW+t2lMD4TSv4AWCaBx+nSwrzIOmVY4g2rNYVB7iUHuirj2CKUQsvixRC
hBzqPM23iYUSQyTzR6tvMaHR9woKH/hSnhyQK756frzEybW0IClU+cBRleLZqeHT
tVMQUmBl8RzSJNvSHneq2CDHMfHK3NsTyRVwhZee0CSEtyFP3bxR5XS6OYMa5iSl
S2+1czQg+0gXJ3/Hb5YBFz9dZLJgUxRml+B0OH2fyIQE6wEf5AKX0YbVzW1ua1df
e+rpKC3cqPkyNB5ujoe8DxCk58Qaow==
=qi4c
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
