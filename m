Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AFEC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 15:26:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62B664E56
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 15:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62B664E56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61C201675;
	Mon,  8 Feb 2021 16:25:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61C201675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612798005;
	bh=+WGRxfTf3SmVnOnMu2BEXZkFM4poWL99zz9p04NYNew=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HpOtML1L+Vb2HEHhsjnOFLlFVOwfJiQ6EJ4cyv0eaOXdsIhhEwf4NBipNkFow89PO
	 7AlTHkAyjvOJn86IitDLLuNLYrl6sBxmcQySgb+bCrJr9zYElAuJT1vW3FS530g2Ld
	 TA3tP7c1ERUjcO8VVt8Qeu7VdWIq6M5q6ORnDdBE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9446AF80169;
	Mon,  8 Feb 2021 16:25:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04E6BF8022B; Mon,  8 Feb 2021 16:25:54 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D33FF8013A
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 16:25:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D33FF8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="NkFn+etQ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9205664E88;
 Mon,  8 Feb 2021 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612797947;
 bh=+WGRxfTf3SmVnOnMu2BEXZkFM4poWL99zz9p04NYNew=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NkFn+etQECgOBWC7AHCUONlfgYrTpB7REwo3Dx2gyTEr07MvWLVOyQAaUw1GhJttP
 HmHUw+dOhngtE2AZYgxtxvfrYsds8ed+AYuPkEdlRKR9xr/bCcCPjbJsfBju5wUDld
 tGwAwq5MHfLU5Xc+bxeZMg/pRCQjbjOzDhKNwMgW5/fjtzJsXrTUtPToVhCRM2NNIF
 IrQdFmGmpyABU57iCM/x35usc5QNuJj6+zjnUPY/HWyQ74nGYk0VLv5nZGBX2H3mdr
 ytCPq53Q3K9EwpfRdPNLfNZ7JEqO4v8kLomU2eUi0DUieIpYIUj2EvI3IdiNcDGrf8
 IePqUKcO6AjEA==
Date: Mon, 8 Feb 2021 15:24:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 4/5] ASoC: Intel: Add DMI quirk table to
 soc_intel_is_byt_cr()
Message-ID: <20210208152455.GH8645@sirena.org.uk>
References: <20210120214957.140232-5-hdegoede@redhat.com>
 <20210204135616.GL2789116@dell>
 <20210204140515.GC4288@sirena.org.uk>
 <20210204150456.GN2789116@dell>
 <20210204151139.GE4288@sirena.org.uk>
 <20210204154058.GP2789116@dell>
 <20210204194213.GG4288@sirena.org.uk>
 <20210205083416.GR2789116@dell>
 <20210205211101.GL4720@sirena.org.uk> <20210208083350.GA4766@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Enx9fNJ0XV5HaWRu"
Content-Disposition: inline
In-Reply-To: <20210208083350.GA4766@dell>
X-Cookie: You will triumph over your enemy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
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


--Enx9fNJ0XV5HaWRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 08, 2021 at 08:33:50AM +0000, Lee Jones wrote:
> On Fri, 05 Feb 2021, Mark Brown wrote:

> > No, it's that there's plenty of drivers like this that are listed in
> > MAINTAINERS but still generally go through subsystem trees - this is
> > also true of for quite a few MFD drivers, you tend to get a bit annoyed
> > (quite reasonably) whenever I mistakenly pull MFD changes for them into
> > one of my trees without syncing with you.

> Driver Maintainers in MFD don't sent Acks.

Ah, that's not the case elsewhere (and there's the case where the driver
maintainer is sending patches for their own driver which causes a bit of
confusion).

> > I guess, or at least a pull request so it's in my tree and I'll notice
> > any coverage issues.

> Okay, I'll process it.

Thanks, pulled it in now.

--Enx9fNJ0XV5HaWRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAhV8YACgkQJNaLcl1U
h9BUlgf/U+gi/WKLvvsMpVe1g3YNDDGoBm2fcVXM446X3TG4lLtzw1bbeLtOXagm
m+s6zM8Hcw3mD9gZzINHbnMyv/DVmJ/4a/oc1PFlX7y/nVNjxbNQzolruFwDoCaW
mVG72RJ5XWdOASUuvwRi1V7BesNLhGjHzvfR1Wp+l/eSl8+L6jbqf58i5kzeFOOA
TSYfowD80iu2dRTxcN5Rg8gpafuM5zbjqWo6oz6zC7BZ8X2C9OENi0imPJj/YjLS
5j3Lc1gfumC8wts7vBjuYMU0g6oVfflvJvAT6BGUVaFO3w73yehcyx0ZyTtULyEN
zaJEesqjbat/0sDdNFnjsp8Jx2w6Cw==
=EzRc
-----END PGP SIGNATURE-----

--Enx9fNJ0XV5HaWRu--
