Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C2C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 13:45:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28EB364F1B
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 13:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EB364F1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B89A61694;
	Thu, 18 Mar 2021 14:44:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B89A61694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616075115;
	bh=ThZ56K23XfP9mESpSvPAQwDEoQinUtf8ThcRaMJUVro=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O34S8Te17Dq+4dYkzdMWRbEosUYazUNmPktuvDdUx4mjXqAjjX1ghQTTfC2Xn5Pa7
	 cNP0AYpbeZgfXhHUgK1XmevQ2QiKI4d680gfmw6R7dEB3yiYyQD19dQok6vNVOyZGt
	 7GkW52ZX6m9pkFQVzkP3AQwJEzWGPGOX9dq8gNXU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28CE5F80163;
	Thu, 18 Mar 2021 14:44:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A834CF80165; Thu, 18 Mar 2021 14:44:23 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3935F800E0
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 14:44:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3935F800E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kTZIxJ3k"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C35DB64F04;
 Thu, 18 Mar 2021 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616075057;
 bh=ThZ56K23XfP9mESpSvPAQwDEoQinUtf8ThcRaMJUVro=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kTZIxJ3k/BfP9vDUw71hUe6YfWCzjl1+KdxoE/H3top9oIxhGR+USgGvOusQ1SJYc
 eQo2hrQjAC3/5zdmqvZvGnTNlMit0vFEPg/r3+IFMeAwG7fodVgU0NSnvskjPTMdLp
 puEZ55YzJtJlXT0a/SvXtVYAl8AZEkh86Cqpv1too4pv179eGb5fB37j1w/IoGu79o
 aU0ePBYDk947z/s7vVw4ax8G4xLAUTGny1FOftGXgadcHSWCJm0vjXdfAaX0XExsBC
 oKLyD6oOQPyYwNwHWdopMZuFbwCL7xNGUEJMJIjV0UOKtHrrtQjFxAFd4ePWQp+40d
 Lgc/oowUUe61w==
Date: Thu, 18 Mar 2021 13:44:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: ASoC topology loading vs card bind
Message-ID: <20210318134413.GK5469@sirena.org.uk>
References: <09c77d7e-3def-0643-b838-94d748529333@linaro.org>
 <4a4c96df-b145-5bb7-ad91-e5d3644f704c@linux.intel.com>
 <5b10ad71-44f0-d0f7-431e-18447e11596b@linaro.org>
 <27b526b6-9432-f014-d639-d3c80af191d3@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5V5c01chtBAiSHoy"
Content-Disposition: inline
In-Reply-To: <27b526b6-9432-f014-d639-d3c80af191d3@linux.intel.com>
X-Cookie: You are false data.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
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


--5V5c01chtBAiSHoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 18, 2021 at 07:40:08AM -0500, Pierre-Louis Bossart wrote:

> > Lets say we have a dai link in soundcard which has cpus->dai_name
> > pointing to an FE dai ("MultiMedia1") available in topology file.

> Why would you want to do this? You are hard-coding an FE dailink in the
> machine driver, when it can be described in the topology.

Indeed - if the FE is defined entirely by the DSP firmware it seems
sensible for the definition to come along with the topology provided
with the firmware.

--5V5c01chtBAiSHoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBTWSwACgkQJNaLcl1U
h9AYAwf/UsLEelBi9+HZO59Tte+ONVIoFA8jvXFfRrOhxa1ce5Unlaasv1xnbQic
SNO0KZXhVGlC4Rtv88nAMx+L9GOqHBdBBVSh6BBBH6A1siAnZWNHSTOH0apJcf75
lpzotuCR0y83EeSwbDwZoTKVcoOrWhp635lHCeFPLwjOOSN109lF2OYAVlvqoRyl
36733BAbhkHeCXofZzcYlkIHxV6Nj7uVZYypakzGvE0exRCx8xyjducVZrHs1JQE
oxL3qnwlaaYxgszWw/dkegi83R3KEftGOc+jCIhNesweHHETyWb2CgatsrN2ApqR
3uj+ocsLDh0or1BJOncZY0Jz9rq5SA==
=gmr5
-----END PGP SIGNATURE-----

--5V5c01chtBAiSHoy--
