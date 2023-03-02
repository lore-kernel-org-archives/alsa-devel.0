Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45134C6FA8E
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Mar 2023 18:10:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2265C828;
	Thu,  2 Mar 2023 19:09:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2265C828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677780609;
	bh=jzmw41TzLfX6n+F+JhK7GaN6lIZTZscm57eSTd8Ngdg=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Rc3fMyaDfNkhTzQeAFZidRW3YopAS3eBTOOVTGNNoaQ3byGa+zpRVpV7JUPgmpPSR
	 ax0u5tr+A1bn2mUVFptp35hUeUcmdJenPW2CJ3wLlRAHLev856BEs040pjrwYlxOj3
	 Qo9e6eXTCOdXafWMfC8AJra7m6PYv7GIsnDGyNBY=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B7244F80266;
	Thu,  2 Mar 2023 19:08:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3912DF80266; Thu,  2 Mar 2023 19:08:52 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EF06EF800C9
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2023 19:08:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF06EF800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=o3/hJdTg
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 7F557B811F8;
	Thu,  2 Mar 2023 18:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05F4C433EF;
	Thu,  2 Mar 2023 18:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677780526;
	bh=jzmw41TzLfX6n+F+JhK7GaN6lIZTZscm57eSTd8Ngdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3/hJdTgWu+pto4jfAakeMHgqcKZc8RbTCB1DNaqG2vznK98jPI2Zs/htudYmuAWC
	 9oGlaMStrbDTEhTSuzsJHOmMNujFe+2JJNYoJ6oUDmvZWDXErORHCMOMG2m2HOqknZ
	 iCSbG3NuG4RFPpvlswvqgt11sAiZauUl2ETjEO1y7SzQQ7sHgho264OYsEAWZbQMG2
	 omfr2/Aqd5iGTKar+RVv8ZUrB9mW+daSQQWHQQgEv0W1UfGcs8DcWpBlfLwqRpuMWU
	 ur5760JqkIRRlcKvbTJy7DoPrSTPJMZwcgcSt5dLPp/NbCd1tlt9mXxIsClrusC6NP
	 Xxvp2wfjANi2w==
Date: Thu, 2 Mar 2023 18:08:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Subject: Re: [PATCH 5/5] ASoC: cs34l45: Hibernation support
Message-ID: <1f9fd2b8-f5d5-4a9c-8c52-63386c85101d@sirena.org.uk>
References: <20230302171154.2342527-1-vkarpovi@opensource.cirrus.com>
 <20230302171154.2342527-5-vkarpovi@opensource.cirrus.com>
 <8aef2c0c-9bd0-4c3a-86e1-7732ddedabfd@sirena.org.uk>
 <6f34d2c8-21b5-5b75-a3cd-15f88ba0f760@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bw+2Y+cFSWr2P+MI"
Content-Disposition: inline
In-Reply-To: <6f34d2c8-21b5-5b75-a3cd-15f88ba0f760@opensource.cirrus.com>
X-Cookie: Who messed with my anti-paranoia shot?
Message-ID-Hash: D4CZ57SFSTFEMRV3PXPR4YNSEY7WKV4Q
X-Message-ID-Hash: D4CZ57SFSTFEMRV3PXPR4YNSEY7WKV4Q
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D4CZ57SFSTFEMRV3PXPR4YNSEY7WKV4Q/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--bw+2Y+cFSWr2P+MI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 02, 2023 at 11:59:05AM -0600, Vlad Karpovich wrote:
> The CS35L45 features a low-power Hibernation State. In this state, all
> register contents are lost, but the contents of
> RAM are retained. In the Hibernation State, only always-on digital functions
> to support wake-up are enabled.
> Entry to this state is achieved via the register interface (either by an
> external driver using the control port, or the
> programmable DSP). Exit from this state is triggered by activity on device
> GPIO pins, intended SPI transaction, or I2C
> transaction with intended slave address

OK, so it's essentially just a faster mechanism for bringing the device
out of runtime suspend?  I would suggest doing something in the code to
clarify that this is not the same thing as system level hibernation,
having references to hibernate in the driver is likely to lead to
confusion down the line.  I'd also include a bit more description in the
commit message too.

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--bw+2Y+cFSWr2P+MI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQA5igACgkQJNaLcl1U
h9CtRwf9HCboECzM6pBl/mxSQdEdk/SfhRbi2BG8Pzo3RmLDjqY9oD09N3EE2cTQ
1hYHnGPuACevtpguasyZIz6zVFQfdtSAYUjq3Bqnk9s2heiWkAX5x3G//NejFK25
8Wr0OVtm+B7BTZChSfV/+CGEYjTseTCKJ4fr40Gme/9KwDvbW2y0qsgfTZaAVhLV
7gOkhGYLceDXJym0Ub01fDrl5l7m+MJ7QnieRE5HGFjdgxFO+rYT4aOspQyxpXW4
XYVSPgcKke7DPFHaFaRT+9dukghgdpb1Icm0lMY3lITwMsd0A+OrarWCIDdbAHWu
uiSa1M4e4xxybXdDeNqHvmczuwRLdA==
=04h1
-----END PGP SIGNATURE-----

--bw+2Y+cFSWr2P+MI--
