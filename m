Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96EAC3DA4A
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Aug 2024 16:54:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1965982B;
	Thu, 22 Aug 2024 18:54:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1965982B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1724345666;
	bh=zCL8BOiSor2S8krSkSQzSMg+Yl4KUmp/Mikep+pQtUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UfQqWivlAXUN/jDMFprQ/5b+zxJG6j2B9XoJpvZmpcWgB3kSg9wldLf9vKzDwW7cb
	 mqnPaBoMMTDQNdtApvmkyzENDkL0BFSY4zZu+LC6kAGUopuNEB98bpffYH1+/0Dojq
	 DSLoklxlnAkOdVueMUNMpCsNqjWrs95OyDw6kedc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 92D52F805B4; Thu, 22 Aug 2024 18:53:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0ED7FF805B6;
	Thu, 22 Aug 2024 18:53:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E267AF80496; Thu, 22 Aug 2024 18:51:33 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8336AF80107
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2024 18:51:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8336AF80107
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=kLxVX1/v
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 04D9CCE0FD9;
	Thu, 22 Aug 2024 16:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA897C4AF0B;
	Thu, 22 Aug 2024 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724345480;
	bh=zCL8BOiSor2S8krSkSQzSMg+Yl4KUmp/Mikep+pQtUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLxVX1/vRZz/4rqoFjsDSvYl8RsXq96QiCjjD9XZUXZo/In85No6he3E+9oP06x6F
	 se4YOv3BJ/05XmDOJpH3AIZZmw94qpo/Xhh3DB1csE/72LUWu4NAxS1gFyTkDdZ8kW
	 m42koYM3qlU7yLMOSda6htbXZgasyk7cspvl6hXx8Z98ZuqQrtSHovwYMXp48QgSAI
	 nmz0CxC6lLcQBq6/Mb7t6ZsmepYqKoDTe0Ldzm6QOWUJ5XJW6HbTyRWHJke6UbPtrz
	 tuS/7uP7ISDLoZh2nose8/9GVjkRFkKAU0iiwmMN2MoqsgfYopWQ0gh2nToSRZp2Ih
	 JDfSya0EHs1oQ==
Date: Thu, 22 Aug 2024 17:51:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	tiwai@suse.com, perex@perex.cz, amadeuszx.slawinski@linux.intel.com,
	hdegoede@redhat.com
Subject: Re: [PATCH] [RFC] ASoC: Conditional PCM support
Message-ID: <ZsdshATQbagl5x-x@finisterre.sirena.org.uk>
References: <20240821101816.1494541-1-cezary.rojewski@intel.com>
 <83f81553-6dfa-46a3-9ca2-d42f54295eb1@linux.intel.com>
 <d5db8a15-64c9-45be-8f8c-977fd5ed282b@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1//dFWn0m5G98Ntw"
Content-Disposition: inline
In-Reply-To: <d5db8a15-64c9-45be-8f8c-977fd5ed282b@intel.com>
X-Cookie: Your love life will be... interesting.
Message-ID-Hash: 7ZAUFMMM2IUUJAK3HHHF4DR25CZA2PLT
X-Message-ID-Hash: 7ZAUFMMM2IUUJAK3HHHF4DR25CZA2PLT
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7ZAUFMMM2IUUJAK3HHHF4DR25CZA2PLT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--1//dFWn0m5G98Ntw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2024 at 03:57:22PM +0200, Cezary Rojewski wrote:
> On 2024-08-21 2:43 PM, Pierre-Louis Bossart wrote:

> > The point about dependencies between capture/playback usages is
> > certainly valid, and we've faced it multiple times for SOF - and even
> > before in the mobile phone days. I am not convinced however that the
> > graph management suggested here solves the well-known DPCM routing
> > problems? See notes in no specific order below.

> While at it, do we (Mark perhaps?) have some kind of a list with major
> problems troubling ASoC? I keep seeing "DPCM is problematic" on the
> mailing-list. If DPCM is indeed in such bad state, perhaps we should address
> this sooner rather than later.

Honestly I think DPCM is the only major problem we've got.  The problem
is that addressing it is very non-trivial, we've had a rough design for
what we want to do for about a decade (look for some of Lars-Peter's ELC
presentations for some summaries) but what we're missing is someone with
the required combination of time and enthusiasm to actually implement
it.  A lot of the refactorings that Morimoto-san has been doing which
move everything to be a component rather than distinct CODEC, CPU or
platform types has been preparatory to the main refactoring.

--1//dFWn0m5G98Ntw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbHbIQACgkQJNaLcl1U
h9APRwf/aFPJucbWjf/SZvqRf3Ve0/qKoi4XbIuSlNg7yRapIByAwfLNdp8q2unc
zofsQT/GXQ+52+J+a1dS3MYpbJycIBshgCjO6hJxPPNbB+Jv8V31JGKgdIbAvsqn
AYRDZj7sovpxDhcG1tFx7324pILM4duKfQ7SvLVkh6WXvV69YEGzfaHjjbo1KEC/
p8lUOSCJ9Q1FNtuL/auA6lML8ISYGXtxpsmklBHep7B0I3Xs/egVE2TOsUH1KrGk
dQspA5MtfaJ+g2d/D8SypbIT1/2eQJr623DaFAPS6ynwhRo/kuru5h/fy9sB8qNB
tjHjXnfyw3MQRsqj0azCkVzQipDkDQ==
=EvG7
-----END PGP SIGNATURE-----

--1//dFWn0m5G98Ntw--
