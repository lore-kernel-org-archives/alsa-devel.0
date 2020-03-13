Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C5BC2BB1D
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:47:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202AC20749
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="r+W4qLex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202AC20749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E532180A;
	Fri, 13 Mar 2020 15:46:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E532180A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584110843;
	bh=D5HZH5b9iGxveIEyt0AlMCu9M4bDSPTxxRh/zkB2hqE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r+W4qLexVrlpLC4+dV92Wtzk232dk8DPkzdq1hD5XNQ7z8QII4jr36w9kHX0KFqI+
	 YW+pEcHBFrISuZykpYbzClmiI07RhxcHbpxi159gzb6ypTSPwMcyGMBCWqJwjHnhhH
	 7IWa4gCHJtaiYaT5pmZqs9XeEQqY3vs545igxLyc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E37B2F801A3;
	Fri, 13 Mar 2020 15:46:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0795BF801EB; Fri, 13 Mar 2020 15:45:35 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id ED993F8013E;
 Fri, 13 Mar 2020 15:45:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED993F8013E
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 558A730E;
 Fri, 13 Mar 2020 07:45:30 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C93A63F67D;
 Fri, 13 Mar 2020 07:45:29 -0700 (PDT)
Date: Fri, 13 Mar 2020 14:45:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH 08/14] ASoC: SOF: fix uninitialised "work" with VirtIO
Message-ID: <20200313144528.GK5528@sirena.org.uk>
References: <20200312144429.17959-1-guennadi.liakhovetski@linux.intel.com>
 <20200312144429.17959-9-guennadi.liakhovetski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ogUXNSQj4OI1q3LQ"
Content-Disposition: inline
In-Reply-To: <20200312144429.17959-9-guennadi.liakhovetski@linux.intel.com>
X-Cookie: This page intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 sound-open-firmware@alsa-project.org
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


--ogUXNSQj4OI1q3LQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2020 at 03:44:23PM +0100, Guennadi Liakhovetski wrote:
> In the VirtIO case the sof_pcm_open() function isn't called on the
> host during guest streaming, which then leaves "work" structures
> uninitialised. However it is then used to handle position update
> messages from the DSP. Move their initialisation to immediately after
> allocation of the containing structure.

This is good practice in general, independently of anything you're doing
with VirtIO - it makes it harder to introduce bugs.  I'd split this out
and send it separately.

--ogUXNSQj4OI1q3LQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5rnIcACgkQJNaLcl1U
h9Bnrgf9FSm0GUij0oKPkjiOKQQLTabZlO1ol5xCg7TsNNv1+VtMiMbxUQINsiQ2
yfFLoRZjlKUGaJOYc7cIpXjX5Q7BOmS2Zx0S4pHR1NEe79Th/75UjxLYxJnwweS2
a26XwnhA1iO/7xWqZnvfdg0XuT1aa6bZLQCDwjVZvV5xeZvAbEuSOnen45e+VHy2
dnrmXuWkgIPtEm+lGvqf5jmGn6DrKveECnfJA82y3U/ls/oyu9DdY1zHD+ZLEtTF
ppW6omfz+qUlGdYDSRo/UXIT6FmOo+gkd8dvPnTIOYwEsyOoZcz2FjND5gjZvVVX
GvM6pZgHCyDXTGayuZT815oy6EM3Yg==
=cOwM
-----END PGP SIGNATURE-----

--ogUXNSQj4OI1q3LQ--
