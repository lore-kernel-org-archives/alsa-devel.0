Return-Path: <SRS0=lFLu=3S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346D6C33CB2
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:51:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A30F20732
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hjWnYSsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A30F20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A25C166C;
	Wed, 29 Jan 2020 12:44:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A25C166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580298304;
	bh=tr8vDExogJIQhze5QhWpYTWS0fWzjfmWy3g1o6WPFik=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hjWnYSszmzaRbHIbVstQbs5UsgQw4yCshv69j8HcSf5Je9mfM1nZMuCuAa4D7Tt/e
	 PlArZ+Bj/gE37+bMqlUvB2VKMuGwo7eoim58pMKdZOjEGho5aNkZFpt4o90F0fUQqi
	 t9wG9Qt6JYMIvUxJ2u1Tb1dGEhL6wH/aXA79EO2c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B91FF80218;
	Wed, 29 Jan 2020 12:44:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96CDCF8021E; Wed, 29 Jan 2020 12:44:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id C7C10F80123
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2020 12:44:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7C10F80123
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A19251FB;
 Wed, 29 Jan 2020 03:44:06 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2ACD3F67D;
 Wed, 29 Jan 2020 03:43:59 -0800 (PST)
Date: Wed, 29 Jan 2020 11:43:58 +0000
From: Mark Brown <broonie@kernel.org>
To: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Message-ID: <20200129114358.GC3928@sirena.org.uk>
References: <20200128104356.16570-1-cezary.rojewski@intel.com>
 <20200128104356.16570-11-cezary.rojewski@intel.com>
 <CAFQqKeWb4X1C0fn0HckOS-fsm6OTv2onUM0yYw4ETw0qFKsWbw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFQqKeWb4X1C0fn0HckOS-fsm6OTv2onUM0yYw4ETw0qFKsWbw@mail.gmail.com>
X-Cookie: Chocolate chip.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.com,
 Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [alsa-devel] [PATCH v3 10/11] ASoC: SOF: Provide probe debugfs
 support
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
Content-Type: multipart/mixed; boundary="===============3259393945073783672=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============3259393945073783672==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2020 at 09:54:41AM -0800, Sridharan, Ranjani wrote:
> On Tue, Jan 28, 2020 at 2:51 AM Cezary Rojewski <cezary.rojewski@intel.co=
m>
> wrote:
>=20
> > Define debugfs subdirectory delegated for IPC communication with DSP.
> > Input format: uint,uint,(...) which are later translated into DWORDS
> > sequence and further into instances of struct of interest given the IPC

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4xb/0ACgkQJNaLcl1U
h9DY8Af+NO4gs5nb0VA6mGYK1A7v3lX60E409vGN+POWWCt+VfpjsABz3oxm87iN
VaLpRvw8SvmJXJlOuW/HjZGpoY8LhmeSILjfo/9EMUWKA9ErxIth3ymAEkD7dG8+
4/UoWS07BgiUOw0ZmP0kPnmJJJeqS8jf1CayxTrNgT0RK8FlXkCiXoHykUm4npEj
OX+xXj0GvCT0n2GQSu4a1TjEUQqDr1L8CeGvPCvwIiA6JxFMEI+6uu1zH+vN4R/2
pcAiNF8BdUxypHCOWzcE4nPkq2TZN1CFkrYf9C4nAXHzhGozh2dfecQaN8xZDhWe
fggM6ystLxAPGQ++kPmZJ8nGdaPuJg==
=F6XX
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--

--===============3259393945073783672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3259393945073783672==--
