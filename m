Return-Path: <SRS0=jeit=MH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BEFC1B08C
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 14:19:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36A56136E
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Jul 2021 14:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36A56136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE79E1676;
	Thu, 15 Jul 2021 16:18:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE79E1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626358761;
	bh=6Tn/bHMMoFMkTpR5Cc+yMgZwnfSPFP99ggxrB8ZaDts=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=funJILS8VUFikTX9p7U7KN5XUIzH6AWJf785UzG6bvfq96oaR4KZ6cH5qHVISaJj6
	 ao3mFh3Enkr9ZM37UhAxz+k43880yvC4oJ+Rixsi0kmYYru9PCevJEMP6DaxhRwaq9
	 Hl1G5JjfpBqdHL6MRA2dRw3hnXNvWnDHVkKPNZX8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EB56F8020C;
	Thu, 15 Jul 2021 16:18:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A962F80217; Thu, 15 Jul 2021 16:18:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9ED7F80095
 for <alsa-devel@alsa-project.org>; Thu, 15 Jul 2021 16:18:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9ED7F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lt1+xDmj"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0B9B6127C;
 Thu, 15 Jul 2021 14:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626358698;
 bh=6Tn/bHMMoFMkTpR5Cc+yMgZwnfSPFP99ggxrB8ZaDts=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lt1+xDmjNlKpUQJ4DVBCaZQXeM4xO/RTBAFX0h0daQaABwztUHGNrS80LLRIpUn8l
 iQ8m83UftbZPLae6PtV/AAQGkX3U81e9NsaT1TAPO583x79IfvzKnHM0XukQozjue/
 datrukQ46KWvo0TpJJddvluztrTKMz4lpMpcozyrBtalAIhW/7/wXvmmg9tLf3ZO7S
 ajHkydWWux7qTJ1xF73x0AX5+U+HET/ghqg6/4fq05QS7zmTmDU0V9jeCF0xJc30Gc
 pvmC5unBHkLJ5EOdPdiG5RGM/L036H8LS75cMFedSEJEK+ea/Zp1wzGusU2RHL63dB
 +Dwt2OqyM7uZw==
Date: Thu, 15 Jul 2021 15:17:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <vijendar.mukunda@amd.com>
Subject: Re: [PATCH V3] ASoC: add a flag to reverse the stop sequence
Message-ID: <20210715141740.GC4590@sirena.org.uk>
References: <20210708175529.13313-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <20210708175529.13313-1-vijendar.mukunda@amd.com>
X-Cookie: You look tired.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com,
 amistry@google.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, Basavaraj.Hiregoudar@amd.com,
 Takashi Iwai <tiwai@suse.com>, Chuhong Yuan <hslester96@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com,
 nartemiev@google.com
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


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 08, 2021 at 11:25:27PM +0530, Vijendar Mukunda wrote:

>  include/sound/soc.h                  |  6 ++++++
>  sound/soc/amd/acp-da7219-max98357a.c |  5 +++++
>  sound/soc/soc-pcm.c                  | 22 ++++++++++++++++------
>  3 files changed, 27 insertions(+), 6 deletions(-)

This should be two patches, one adding a new feature and the other using
it.

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDwQ4QACgkQJNaLcl1U
h9ABpQf/XSip+BC68mqysPaI6+TXiMCNF6fKsG5ZD8dvlFh+bGqRrm+qOG/CHnqd
IjTNrzxysPvNM19HhztFyrUyv0rAETY+4hpOFoOng4MruSnCgMOq0qBj/Xt7cxMU
6mdWVWy9JZdFLzEUrWg6G49yr9LysgwY6HQcUVMrisi+spm6m+IG+YDGTgb5CHG5
wqpatcj2DSoLVeOlZW9BuSZZ8+SXXcE4yy0Zh3Wm6Q7LmTw0GR4uLEoNGeQAl870
vuFXYREMa17MCBSY83f/AWfTGJPHSneO4n3+axyfUEvQ8NKgCmScl78o8lhWi/dg
SAQCw5LHw8j3qOhM7nFWDhAJg9raWg==
=8oKq
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
