Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF9AC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:14:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB61207E8
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CIFPjr+X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgTrurpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB61207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C35C177D;
	Thu, 18 Jun 2020 14:13:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C35C177D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592482480;
	bh=zlMHpKPW0q09W6RDM2ggzLUYctacuDuqAbHYFurGPzg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CIFPjr+X1uWI8FGoqYnk+0BsFbfOfdaKLupR3j2a2BcoaAVzPPkRXYHiln5jLk35h
	 adObXE2WyqK5u7SqtwWWtQ1nng9cVmkT/gp0hjowMVN7lFOU9Lo9rmO3p6liJnuFQD
	 v8vtZ/Y0LoH9aWfqzFF2H9blQla/dsWqJZ45DGpk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0276F8010E;
	Thu, 18 Jun 2020 14:13:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9AD8CF80116; Thu, 18 Jun 2020 14:13:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09F9DF800D1;
 Thu, 18 Jun 2020 14:13:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09F9DF800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MgTrurpY"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D0F31207DD;
 Thu, 18 Jun 2020 12:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592482422;
 bh=zlMHpKPW0q09W6RDM2ggzLUYctacuDuqAbHYFurGPzg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MgTrurpY2WwRFZMiFOLuc/+EX73he9w5/j8XNdxcMhxek2dHNTznYTzwpPoDCAUkM
 3WUYySfhviMyex2qyhsZgUM/Vu50MXK3YJnnuwryA2FLP4X2eAlASLvfXXEP4TOYQq
 U9KVJQcYYf1syoJnX5w9cJn4RYObOuhyjQB5cvws=
Date: Thu, 18 Jun 2020 13:13:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH AUTOSEL 5.7 055/388] ASoC: SOF: Do nothing when DSP PM
 callbacks are not set
Message-ID: <20200618121339.GH5789@sirena.org.uk>
References: <20200618010805.600873-1-sashal@kernel.org>
 <20200618010805.600873-55-sashal@kernel.org>
 <20200618110126.GC5789@sirena.org.uk>
 <1d1041f9-521b-98f5-a6ef-12d43615bc13@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y0Ed1hDcWxc3B7cn"
Content-Disposition: inline
In-Reply-To: <1d1041f9-521b-98f5-a6ef-12d43615bc13@nxp.com>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Sasha Levin <sashal@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
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


--y0Ed1hDcWxc3B7cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 18, 2020 at 02:44:18PM +0300, Daniel Baluta wrote:

> Indeed can be seen as an optimization, but it does unexpected things which
> can cause trouble

> and weird behavior for people not familiar with the matter.

> For example, as explained in the commit message if you only provide

> System PM handler but not runtime PM handler, then the DSP will be resetted

> even if this is not the intention.

The user shouldn't be thinking about if the DSP is reset during runtime
PM, or if it's being reset...

--y0Ed1hDcWxc3B7cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7rWnMACgkQJNaLcl1U
h9CkHwf/fzvqyfr+cua8XR1XxSJiEGTyXJ/VvKSilf0hGJm5j4pkchTP+QMu+u84
NJ05+mKUW1R9f5iHvCFhu+DvcSnUqPwP5cNDwqNNG2LgiMVV7ncOdmfVAx0iez/9
LWr9pv2xR7OoeZUWBGButW0vR+Db7otynZ0g4KJUK32rQDdV7fDhd83v3PxZLZAT
ihIb7y2cGeyXAXNqxLqCqPnuPRnC1dzYdMxT9J5OKH2kfahG8O1pAuu4XZtAE68l
vFCQ7SgIqkq2HxAhen6J4rd+bTb0W9hpEL+/ltebF4Q1gw7nkruhZaEheiKrj6Ex
hUY08U4sFWY1/kA0scUxNk1+iGvIRA==
=wOoM
-----END PGP SIGNATURE-----

--y0Ed1hDcWxc3B7cn--
