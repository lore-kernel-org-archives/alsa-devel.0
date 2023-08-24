Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786E5C88CB2
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Aug 2023 22:31:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71C6284B;
	Fri, 25 Aug 2023 00:30:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71C6284B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692916306;
	bh=QaYenCUGH/4gvVh2DigJUcC1xQTgH11CBaz0ncrn710=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hRq8EAgRzvJqy21HOgqiOQjYCqaipyHzXrd9h1Qyy+PyW22FK+qM3uR1fBMMYU7y1
	 Ew1Jb0wzP5sNaUA05i2c8+tIuul6+6bftIQvN+qZZsiKW6r4BL3HWA4k/UXyRlkUBY
	 JQaBc4JYEQsVIW217ZQOBpM58020KaaqL8HJTcoY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9CBA6F80557; Fri, 25 Aug 2023 00:30:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EA517F80557;
	Fri, 25 Aug 2023 00:30:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A30B6F80537; Fri, 25 Aug 2023 00:30:16 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 49B97F800AE
	for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2023 00:30:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 49B97F800AE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IPf/5w17
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1F9BA659FB;
	Thu, 24 Aug 2023 22:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB1EC433C8;
	Thu, 24 Aug 2023 22:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692916211;
	bh=QaYenCUGH/4gvVh2DigJUcC1xQTgH11CBaz0ncrn710=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPf/5w17JdoXN1I+JcVeNEZu2NDbh80ZhVvVmlp5Tx7vXXlRfdPojy4xVFZepgm5F
	 8C2oR6otc9LRDDxS9Yn8Ad1PilSaD/6lk5HyWS+RmQfEme6nsufq8Hdqx1VDb8H6g6
	 xmEv0oJDh5a4Az6j1SBptv1INSdPcKCHMM/Tl+e2h6Ajl+pbgqIbjlCRd4pqmmWYAZ
	 jpVxvD70lN5hSdenH9GSdX8w/FUg/tXHuSUqB8ayFgj1GPlt2TpxRCoQHp4++keqpp
	 lZ0lnGOaRIbdjwZFqr3VYwgCMm7JTP5VW+drPCt7FdCk7R+z/DoT4mryT82bb1HuRU
	 VA8h5hqxvrGQA==
Date: Thu, 24 Aug 2023 23:30:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com
Subject: Re: [PATCH 11/17] ASoC: codecs: hdac_hdmi: Switch to new
 stream-format interface
Message-ID: <ZOfZ6wjywvvOlb2O@finisterre.sirena.org.uk>
References: <20230823080546.2224713-1-cezary.rojewski@intel.com>
 <20230823080546.2224713-12-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gmZfXZVCyvT2NOBk"
Content-Disposition: inline
In-Reply-To: <20230823080546.2224713-12-cezary.rojewski@intel.com>
X-Cookie: Give him an evasive answer.
Message-ID-Hash: ZCHYUIBY6QIIVJ57LK4UVG6CI6DPLNX5
X-Message-ID-Hash: ZCHYUIBY6QIIVJ57LK4UVG6CI6DPLNX5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZCHYUIBY6QIIVJ57LK4UVG6CI6DPLNX5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--gmZfXZVCyvT2NOBk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 23, 2023 at 10:05:40AM +0200, Cezary Rojewski wrote:
> To provide option for selecting different bit-per-sample than just the
> maximum one, use the new format calculation mechanism.

Acked-by: Mark Brown <broonie@kernel.org>

--gmZfXZVCyvT2NOBk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTn2eoACgkQJNaLcl1U
h9DRCQf/X8ZIDADeyG97g5Hl+irzArnCFKp9oF5Lqyy4FtKbT4CJm0+YwCbWj5b+
JALVQQfs2t7soisFfZbUIETrZyselft3mko2REo8AhRAdV+K53zFsUtesFalR4qR
dqOf2z7a6VYhrLhEHFXh1ITKghmQSC0avr69kqm6v9nI6sGCAzlimrfABJuDtzCg
VGC/X0Wq9URhYcEjk41ZAD5lJItf23c//no5WK1cCqMkJtwSGCy4fcfZGGjp29of
pI7/clLukA/mMV3U1MTUYekToNyVZCP/dr39dG8X2zFR2kh49AOZ7qbivRGSQAfJ
Ud49yF0mqIkvt96pwmC+e1U1L0vLgw==
=LNhB
-----END PGP SIGNATURE-----

--gmZfXZVCyvT2NOBk--
