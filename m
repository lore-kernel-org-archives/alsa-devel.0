Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E36BE7E37D
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2026 11:56:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03CA460146;
	Fri,  3 Apr 2026 13:56:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03CA460146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775217372;
	bh=a4ntCKvudUWsvaczdKQvSMufCMJA3BORYS70EtrlLM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=E55JRJGJ5vUx2vDiAWZ8ozRGEoDhS08oJLpbVpXeet6eHnezliGMHRVnY2pGhwBSl
	 BGYcP70eJT6SDNHufJx4oNrs6f5dm5uF1nebu7SAc+eZe4do5uTTmSw08B/QipwwMX
	 2uzzAzYGoStdZwUb2vWxnlYYupjI+S9azzfBRCxQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30B98F805F4; Fri,  3 Apr 2026 13:55:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FD44F805F2;
	Fri,  3 Apr 2026 13:55:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5852EF8055B; Fri,  3 Apr 2026 13:55:28 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F291CF800EE
	for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2026 13:55:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F291CF800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Q2FMUSYB
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0F39A60008;
	Fri,  3 Apr 2026 11:55:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26EBC4CEF7;
	Fri,  3 Apr 2026 11:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775217322;
	bh=a4ntCKvudUWsvaczdKQvSMufCMJA3BORYS70EtrlLM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2FMUSYBEMjDKqvqYVcpO32RUFKtB34Wp1zxFwCXtCHpbbZlJczfkXOGyEZDzOveD
	 fuygHifEECMZC8yb9iVyPzTk81obgVIj0RqGkhsJWC4z70s05NhVXFRxssUIh50Qga
	 iweQuk51qK/ZFNZGu5fsnukE0Mu/adsWf/eymx4GVcJAZe6SUthW7HWWqHoKPtAtIC
	 lNBfPHRCI6WpjW6zqJGamAXgRCa4os+RsAgNT8jQZfXW2VdAuE85/uSX0aehtiVXQ/
	 oduqlwyHsZmE5CvtCyY4BsINBTxa+VVZSa96MfXSkKNv1XxYTFYDCwhU1HGPcmts3Q
	 Uy5yRJ+U+5/Cg==
Date: Fri, 3 Apr 2026 12:55:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Syed Saba Kareem <syed.sabakareem@amd.com>
Cc: alsa-devel@alsa-project.org,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Sunil-kumar Dommati <Sunil-kumar.Dommati@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Hasun Park <hasunpark@gmail.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Kees Cook <kees@kernel.org>,
	"open list:AMD ASoC DRIVERS" <linux-sound@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ASoC : amd: acp: Update Quirk for Lenovo Platforms
Message-ID: <fc7cd530-2199-4c12-af75-6ea17997777c@sirena.org.uk>
References: <20260403100948.678548-1-syed.sabakareem@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NrKc2B8N53SKaFhC"
Content-Disposition: inline
In-Reply-To: <20260403100948.678548-1-syed.sabakareem@amd.com>
X-Cookie: The Korean War must have been fun.
Message-ID-Hash: 22RWWGWWRYU365L5UAHL6NYA5UIVLZOH
X-Message-ID-Hash: 22RWWGWWRYU365L5UAHL6NYA5UIVLZOH
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/22RWWGWWRYU365L5UAHL6NYA5UIVLZOH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--NrKc2B8N53SKaFhC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 03, 2026 at 03:39:38PM +0530, Syed Saba Kareem wrote:
> Use DMI_MATCH instead of DMI_EXACT_MATCH for the Lenovo SKU,
> So the quirk is applied to all variants of this model.

I only have patch 1 here, what's the story with the rest of the thread?

--NrKc2B8N53SKaFhC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnPqqMACgkQJNaLcl1U
h9AMRQgAg/4zIdSESnxvHT7boPLPXWNLMDskFNfswDSMEMu1StTQRgrwk0Xa5Zpb
fypATmN01D+/g+F9NxGVrdPwjq3ml0rAtGbCdAGvlVvu2ANLbfwtyJhfF5ccGEIK
TCV0nVD2EQF1lRBCtZxdw/1vffIJEsTYf7WL1UfKKAfqAcYF1UVqHqeS6lWaJuUM
lKUZfwL0RptIpLoy1suTr+g2jBl2AJpw9S9I3plqo5ylzbMbFjVBgBnLaPP2qCDG
auKxaZ5Z5IBRR3JDPHyFuK9npCbQBzs7rV4fjHmR6H4jV5i6KxiaFue0O8WcMn0b
NxOrYucvQ7PCCLBncJA6blv2jI/qCA==
=2mS0
-----END PGP SIGNATURE-----

--NrKc2B8N53SKaFhC--
