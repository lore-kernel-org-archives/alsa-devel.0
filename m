Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924D1EB64DD
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Aug 2023 12:48:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8521ED8;
	Wed,  9 Aug 2023 14:47:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8521ED8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691585314;
	bh=bbxyQTY2XnT/Ku/iw96KB+0yimTrBwz+HkP7RNM4YZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BJlUJt7ubhTVEylNXirqHpTD9pJAG6BdXZUA3R6QM1CBA5xYTHZ+sQba8mcu3uCoi
	 DEvGDyp0dGoO4Yd7KUwJITDhYPP+c77IwH6NWwWsWVwaNI+VTmJqLyszGo/VKrgHwS
	 PSttVNcOkNl+R75XQ9IcWVOGehyJ4huTSe4W+6MI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4A645F80552; Wed,  9 Aug 2023 14:47:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CC8C5F80134;
	Wed,  9 Aug 2023 14:47:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AA014F80134; Wed,  9 Aug 2023 14:47:11 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5D523F800FE
	for <alsa-devel@alsa-project.org>; Wed,  9 Aug 2023 14:47:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D523F800FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ngd+Qu23
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 43CE563919;
	Wed,  9 Aug 2023 12:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B016BC433C8;
	Wed,  9 Aug 2023 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691585223;
	bh=bbxyQTY2XnT/Ku/iw96KB+0yimTrBwz+HkP7RNM4YZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ngd+Qu23ylsYRP9uMoAOmqK9qtWApY8zb0+lbepTjEd+IUyLHG0GRW8teTS2htsOV
	 m/xp5zePY0HwPzx8TthEwklPNYH68945Foc7sGcSK7o23m436jf9WcmDVOXugPgW07
	 GRyOTcf1hdZw5HAc1NwVtsZxssHzkIlVYEdzfUc9zNsrK5eb+bFbmISUdHrrjRj8wl
	 t8rGmM4Xe2Pur2YfQQ8g0Lg+MfYP71U+FNAQ/vdG68Y9CEKJdmRETprv0ytmmWj3zm
	 94f/9yOJgbHspAQO3D+JRDY54AR1HNs9Lf97gJsvkFjn4l+D3HDwwkF/kShT+XhN3e
	 57PEaJD5WyhRg==
Date: Wed, 9 Aug 2023 13:46:58 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.intel.com,
	ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
	adrian.bonislawski@intel.com, yung-chuan.liao@linux.intel.com,
	chao.song@linux.intel.com
Subject: Re: [PATCH] ASoC: SOF: ipc4-topology: Update the basecfg for copier
 earlier
Message-ID: <01f0062f-7b38-4521-88cb-9abf4989a984@sirena.org.uk>
References: <20230809092343.12666-1-peter.ujfalusi@linux.intel.com>
 <cacbebb1-8c0c-4a4a-82df-00e932df3e7b@sirena.org.uk>
 <964ac79b-b56b-4cfb-8b52-2deb03abb46b@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9YUl4Ia4XuK/ohhn"
Content-Disposition: inline
In-Reply-To: <964ac79b-b56b-4cfb-8b52-2deb03abb46b@linux.intel.com>
X-Cookie: Down with categorical imperative!
Message-ID-Hash: 7JPVVXW3F7R55236KLTLVYD6M2HA3A5F
X-Message-ID-Hash: 7JPVVXW3F7R55236KLTLVYD6M2HA3A5F
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7JPVVXW3F7R55236KLTLVYD6M2HA3A5F/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--9YUl4Ia4XuK/ohhn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2023 at 03:31:41PM +0300, P=E9ter Ujfalusi wrote:

> If that's OK, then I can re-create the patch or I can send w/o the Fixes
> tag to be on top of your -next

Well, is it a fix or isn't it?  If it's a fix we should send it for
v6.5.

--9YUl4Ia4XuK/ohhn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTTisEACgkQJNaLcl1U
h9BP8gf8D8oF+DccvA8DBgqbHkt+v2WmNoyfR1lUlPDfTJuWT5IL5UjR0UXM8p7b
9HHDfkatLDSINqRnYatu1ubT7g2nQeSdqe65QgXNqB5ZasbppmzqtnMllFCFU1al
gJIUeCpMu8F+mrP1vfbZ4spiIZtHzYlnIPC1d7KiTAu8JU0b869HnU1OpsqYl7dI
MAXLosDfiQ1Cj6mCNAjKRGScn0CbpBnUG092h8DpAJ2VnDDmAJx0A8XhVM884uLf
CRTqj7JaFeoMI1oyqlLCBZZ3G+/zQGkeJAzdsHP6BYx6y0RimZbLqlCs+AjaJsab
LotpOi1Yps0+/BwnJCpnZjRfJ5/Mhw==
=j+MJ
-----END PGP SIGNATURE-----

--9YUl4Ia4XuK/ohhn--
