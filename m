Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CFDCE7A95
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Sep 2023 12:30:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE524DEC;
	Mon, 25 Sep 2023 14:29:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE524DEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695645013;
	bh=8xLm/ov7SgQFJ78o9yw5y2BHUeMoy9p77Wt/p3DwJa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=efWOgobATW+pw/1sYi5TcIR/Z9y9wy0hz2bfx5eEdZ0a1KKUmqBmWbsiJwTWGvrCZ
	 bG/yXuoDYxnJWEmcDv8VW9x7nCrMPHGGgWNawtEW0b2ROVLsCQJKt/UIhy5LTAaKF1
	 837crFLaLzC5Hb1JAbzL+OP0I2S+bOoPrEMj4Cbg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F77CF80290; Mon, 25 Sep 2023 14:28:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A87BF8016A;
	Mon, 25 Sep 2023 14:28:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AFB50F8016A; Mon, 25 Sep 2023 14:28:46 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C5A17F800AA
	for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2023 14:28:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5A17F800AA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=uliL0z74
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E8D30CE0F6D;
	Mon, 25 Sep 2023 12:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC015C433C7;
	Mon, 25 Sep 2023 12:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695644917;
	bh=8xLm/ov7SgQFJ78o9yw5y2BHUeMoy9p77Wt/p3DwJa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uliL0z74cXWyF4y8IuxubedR17ddE1bKuwMKOBjYyvDun5K09fEAJfBNGOXMG6+rr
	 7SWH7Pb5RmxUuQB0srR4DMY4AY9JPxKqPEvh3cLpDMIXL0AyKauAg4Wm4RVNI4/Jd9
	 lEj4JPYqVNjEe+k75TCRKB9sRSseUD8zHAo7QVsAlRzoLkUA96gn83o61redwc8x0r
	 e9esCHANZxzw/M0lTwlcHsz3I6LBoK7C+8zLTjUTeXp9RqdvrrrND4Ahe5x9o3Lsjt
	 wqXN6Twx21PEOJ44Yowfr/VHn4gPY0PcDJxLTjSxtZ4IeXW6r+Ap6OsGO3uU3M7UvB
	 j9RaYr7T86hew==
Date: Mon, 25 Sep 2023 14:28:31 +0200
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: tiwai@suse.com, alsa-devel@alsa-project.org, perex@perex.cz,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com
Subject: Re: [PATCH 3/4] ASoC: Intel: avs: Use helper to setup HOST stream
Message-ID: <ZRF8794m/p9j+/Pc@finisterre.sirena.org.uk>
References: <20230925115844.18795-1-cezary.rojewski@intel.com>
 <20230925115844.18795-4-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7bfYu1KkbIFTMkZJ"
Content-Disposition: inline
In-Reply-To: <20230925115844.18795-4-cezary.rojewski@intel.com>
X-Cookie: Save energy:  Drive a smaller shell.
Message-ID-Hash: JEB55UGQE7YNJBXAUHPJU5XC7SP42WBS
X-Message-ID-Hash: JEB55UGQE7YNJBXAUHPJU5XC7SP42WBS
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JEB55UGQE7YNJBXAUHPJU5XC7SP42WBS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--7bfYu1KkbIFTMkZJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 25, 2023 at 01:58:43PM +0200, Cezary Rojewski wrote:
> snd_hdac_ext_host_stream_setup() abstracts the procedure details away.
> Simplify the code by using it.

Acked-by: Mark Brown <broonie@kernel.org>

--7bfYu1KkbIFTMkZJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmURfO4ACgkQJNaLcl1U
h9AINQf8Ds6Q5AcSkGflwFZCfjhURfKeasEDCXRy2sqqeqNHGU6UGppm6rOQrWF/
oN2ITSHcypr/RR2njcZG+W9RS7UoP8YFtIvVAUUViZrvd3P1YtScf4t7D2zmQpxj
y94e7pzB1hIfnn2Kb4PpdtfuKRUme/7e/9L2E+BcIE5yUNYDecjiU+fVrbbhIQfp
T5oiX7nfyii/emkWT5mA/pGK87QRLV9yl98GAmtnvaQYF2fGXIwE0tXMga6XEoWG
WTsE9Lra9xmGVR07Yd1K8NCe8X+S9exSlv9loBYmyn4OfWbjlnsnyEWwiOMrlniK
EwLs5HxT+Ojobzvqsar7wv6ycpf0aw==
=pZX5
-----END PGP SIGNATURE-----

--7bfYu1KkbIFTMkZJ--
