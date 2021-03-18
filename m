Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E59C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 13:03:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DDF64F01
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 13:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DDF64F01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEFA81694;
	Thu, 18 Mar 2021 14:02:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEFA81694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616072607;
	bh=ZFQF+laYvm+ZClm6EkbR9Ee/ERLjMMRX4Nb3NdC/5Xg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WEQA80MBlrdbEpwRvjbDuq7+j7FcVcBVy5+TxR7z4wzqrsvKuJwp+VSWY+cd0tw3n
	 cIu0joV8ujOsGWeTEDNkFY9oH04zXj05sj0zt5urz4V7VXlRPTFJ+fAl9X0NNRdVln
	 x/6zbE8VfsWwshplot/Mmr+GSa7O0ns/nuwThmgs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FFFEF80163;
	Thu, 18 Mar 2021 14:02:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61931F80165; Thu, 18 Mar 2021 14:02:35 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9415F800C8
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 14:02:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9415F800C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="iB2Lu8Vj"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F27764EE2;
 Thu, 18 Mar 2021 13:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616072550;
 bh=ZFQF+laYvm+ZClm6EkbR9Ee/ERLjMMRX4Nb3NdC/5Xg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iB2Lu8Vjwd/thYCWHV3yxujGYt/KZkp8h4k4qVXzIgoP1ypB1ZaKSiIWc1NJGVqRj
 32SiqcswjrDWqO3mlj7d2ylDGhAMakrrtMuHz11/SVZsZeUZf2ijBbWnJZA3neSNev
 0Wjz/Cf0y5vja7/ZiwR0KuB7VaEQGPW1vO8ay4lVMa2+HjgaZAH4OaGNYc3wIcqIrD
 cfG3xcXV+7evtVx2MXZAiE783tP+9tno15vygWV5NdOFLipeAv/hpIKuvrvGNYkAaC
 DOxDOvowsx3a9C/Wur6qbKnHWfNETv3P8iMevSR4KlHWyjMGC/GdBOk3GbJSuqkE2H
 JWb6VsX6HGpIw==
Date: Thu, 18 Mar 2021 13:02:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH v1 2/2] ASoC: amd: fix multiple definition error
Message-ID: <20210318130227.GE5469@sirena.org.uk>
References: <1616013238-12254-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1616013238-12254-2-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
In-Reply-To: <1616013238-12254-2-git-send-email-Vijendar.Mukunda@amd.com>
X-Cookie: You are false data.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, Basavaraj.Hiregoudar@amd.com,
 Takashi Iwai <tiwai@suse.com>, Chuhong Yuan <hslester96@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com,
 derek.fang@realtek.com, shumingf@realtek.com, flove@realtek.com
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


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 18, 2021 at 02:03:47AM +0530, Vijendar Mukunda wrote:
> make W=1 ARCH=x86_64 error:
> acp3x-rt5682-max9836.c:(.text+0x840): multiple definition of
> `soc_is_rltk_max';
> sound/soc/amd/acp-da7219-max98357a.o:acp-da7219-max98357a.c:
> (.text+0xd00):first defined here

In general you should put fixes at the start of the patch series, or if
this is a fix for patch 1 that was spotted by the bot when it was posted
on the list then you should just roll your fix into new versions of
patch 1.

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBTT2IACgkQJNaLcl1U
h9BS0Af8DcLM2FIfs4Rv3pWvsFaF/tPu+0hRmIk82qqi9HQoGqOxL/G4LueA+Kzu
NL98mcpzwCRFt/trUJ06UziT7hfLdvUZbexm8KmhVtVE4zX3pL/aIqlKtkWcbxPw
j+36ScveHc44qMpL1RNjzHqPqPtJLwZUEBOKRWa5NEI/GHt773dV+JAX8+8/LpWE
BD6SPelxK35BKzS+dVCguUj6rrp4XQnZOo5KDP6uNVdkjL2LYEbMaG5RRq5V7W5y
3TlkCVqprM4s0ft1GvaPSxgwtokbt1ayQIaQXvQn0vwq5IdVonZ5mKuChHRfMk1n
BeKioPGGxfUDmioGd8ETQajjkVXDEQ==
=wlPn
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
