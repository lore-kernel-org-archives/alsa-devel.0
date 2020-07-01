Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86676C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:45:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C0B20760
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Q5GMghMW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIQj0wsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C0B20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9AF381655;
	Wed,  1 Jul 2020 20:44:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9AF381655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593629148;
	bh=ROZuBgTtbObmcDDkfhG/XDenrnq/ObKsZo3jzb5MgfE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q5GMghMWxLTmhDvSgg/X+Yct4uqIbx6sEGIqCd69jj5eW6i+DdX4qlgcjstANHg/p
	 LwnF1u6yu2JwNc1V80r/O+kWX72N4iIOG1DIHarwC7fyudCJdkP/WsYW46clOJii4s
	 y0gsnBvaM5eBlvnv+Nram51EiBLfngCL/LcNpOd0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17F68F801D8;
	Wed,  1 Jul 2020 20:44:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25C5BF8020C; Wed,  1 Jul 2020 20:44:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58808F800EA
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 20:44:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58808F800EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bIQj0wsV"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D3CD020748;
 Wed,  1 Jul 2020 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593629092;
 bh=ROZuBgTtbObmcDDkfhG/XDenrnq/ObKsZo3jzb5MgfE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bIQj0wsVS6sT2hhRNF2jWPExe24kzGPqUZQdxlMuUFqItlb4VR5TYfAOonOJSsb+5
 jN5sK7+Vdk1rkyoXFhTp0iJCUmprP4Ck8ZoCIOLjhLQhdDR/gLsHpRhI1MO4hTOhew
 8OIPG7xgJrOOJRQ0CSAHVLKs1pQwO/vGycoi+YNk=
Date: Wed, 1 Jul 2020 19:44:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: Intel: atom: fix 'defined but not used' warning
Message-ID: <20200701184450.GB3776@sirena.org.uk>
References: <20200701183716.83314-1-pierre-louis.bossart@linux.intel.com>
 <20200701183716.83314-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <20200701183716.83314-3-pierre-louis.bossart@linux.intel.com>
X-Cookie: "Ahead warp factor 1"
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
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


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2020 at 01:37:16PM -0500, Pierre-Louis Bossart wrote:
> Fix W=1 warning. The VOIP controls were not used in the mainline but
> in special versions of Android. Keep and use __maybe_used to make
> warning go away.

Why not just remove them?

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl782aEACgkQJNaLcl1U
h9Acuwf/RzjeTL+DsbZOk5EPe+fQKxZ7C40/C0XlC5LNPVfBMgKRuxgpKBstqLX+
d2bO7sWo9r4hruXjGn/fiRAgPqlHPc2RQQe3CKp2RMTEx6IRVv2Bhmyj4BR8ZLhz
XdG762Lt42E3Q6G8nxB3SHIEKSBW5BMfjhixOcIK89FzVVdu8j4aElvGePsycv6P
+z4+qicc3KeCy+jXn/SaepoNRu0iS8E4FhNdGrDpXff1M018AeP2nihRP5xCoy4H
cekwzHR53mSEEpHMZHaoKdJkaGJrrIyTQFrfWWBp1ISEq2HYmTP2eKojryHnQ/N1
oGDlj01GMgynBGOHwKjJHC/LAqD04Q==
=Ak9H
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
