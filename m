Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CF4C43458
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:16:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E895601E8;
	Thu,  2 Jul 2026 17:16:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E895601E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783005375;
	bh=cvQYSD2ruGb1LOqO+He73WuZdMCY7pLYDaGYm3RyVOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Y/hta3h2g32aGfnKVn+rrMP9TTDUgtqoejYa2t5nQ5WP6Oqrz1DZ/+pxxB8myE+Zt
	 6cluv6pm6Mjz6ZDYy3TMEF7dZxWQbs0XBKB07B4uPm6aZv5R8LMJyMH4+YLL1ljBHo
	 dboMDMjEqegJSDpjVP0SZU1KTMc/QReok1i9aDLU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55C5FF805F4; Thu,  2 Jul 2026 17:15:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C432CF80602;
	Thu,  2 Jul 2026 17:15:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 825A1F805CB; Thu,  2 Jul 2026 17:15:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783005332;
	b=gVi2uLVmwQklogbnpJR0k/5xCMg7+qw7yUYFZKOLnoxSE6m4F9t1XgeWyQCSliIlRVx6
	 W/WzGgMiuErCTnyX635Uc7xpll4+fx18rUHInPaQvNaQzOOda/c6ksNaSXHgN47WeQIL2
	 iUN3oYD/8XOT9g7WCybrrU/fy7lYwtscv37+EkZmylLDK7LTE/gHAMkAd5uwJ3p/l7iuX
	 0guF/Jgs/vt0/wdQfffh7zhelMJRoSHWgwgP0bwE6BOr6m2S1cVKxRtO8WiZatEndualv
	 I/PPNu/mxnvZXbpzs6+28zkrzLN4Mol0ZEnzAKfuS//4CJLp23j35yxlaHYwqo8SL7g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783005332;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=cvQYSD2ruGb1LOqO+He73WuZdMCY7pLYDaGYm3RyVOA=;
	b=iMp/L22bRN6TUR/UoxqqmxyrgMpOVe6ZMVFJ3uf7GFGVc1HbChgXzVj4qzvveKhD5axC
	 gP8vKgavQGAdX96hBmvFDZxS7/UhMx/SpPhFKUMuQu1hui6MPQLiiwjCTuSLnFWKgAyXG
	 JHd5SKJMCSbiczl64xFtnoX3LkZwYzrw5K/kJggpWfH9LF+wQ7S3RPIteo1gLMEQ8yVAY
	 vb3jTZiuvia1TWIGsA+6WmUapcFdWM9VAtwW9pgPPyb29dbISeA3RsXFpksSJBcORpV6d
	 qJZ8DuVKqmn5f2KUNRK/B2Yw/w5ka1SP3oc9nAp0MyTyR1b2uWujGJuyiCqNkUOw2Xw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lWzfJRVK;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 88962F805C4
	for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2026 17:15:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88962F805C4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lWzfJRVK
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D6EE4044F;
	Thu,  2 Jul 2026 15:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D0F1F00A3A;
	Thu,  2 Jul 2026 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005328;
	bh=KrJNDv7MRfChraFB+59N59wiEXryhLetWz61hTOEUWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lWzfJRVKKtY5UA1tw309oGY11dc4lH476PDkJv0aBDXV+cybqT13SXxSa8QkRiyMB
	 YElIwkGkGPXhJgIzuPPLbJFwJihjj6VQqReQS2maWkfZy5H2QYjBht6glss+IEmWur
	 Tv+Au6qOvgdDV+1wqNO4pu0yP8XLecazJ0lc/glPZ+kdlq2dNIp09Gu21C5UN43ey4
	 T0NWuuyVVK2237mTYba4bH9HpENPk5nvoWTH20eLo4Bz4gV/Ww8aujKLjJSEJchH7g
	 ccInlcRBgZrGph4r/p0Vo0LDkV4iRaxOlWHnlifVUUwLOaHbt/xv/uf8lHYyu7NdhL
	 A5V4OLc5c534w==
Date: Thu, 2 Jul 2026 16:15:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
	krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	neo.chang70@gmail.com, kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v5 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Message-ID: <66ce56eb-95b9-4915-8658-a1e4d1eacd7f@sirena.org.uk>
References: <20260630021510.821919-1-YLCHANG2@nuvoton.com>
 <20260630021510.821919-3-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mQW7vruDQ/SLpDT9"
Content-Disposition: inline
In-Reply-To: <20260630021510.821919-3-YLCHANG2@nuvoton.com>
X-Cookie: Reactor error - core dumped!
Message-ID-Hash: HGGITSP5EXG75NHXF2NV2FO2NWG4ZMXI
X-Message-ID-Hash: HGGITSP5EXG75NHXF2NV2FO2NWG4ZMXI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HGGITSP5EXG75NHXF2NV2FO2NWG4ZMXI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--mQW7vruDQ/SLpDT9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2026 at 10:15:10AM +0800, Neo Chang wrote:
> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
> stereo 30W+30W smart amplifier with an integrated low-latency
> Advanced Audio DSP.

> +static const char *const tdm_data_length[] = { "16", "32" };
> +
> +static const char *const tdm_pdm_length[] = { "16", "32" };
> +
> +static const char *const tdm_data_n_length[] = { "8", "16" };

I would expect TDM to be configured by set_tdm_slot() from the machine
driver, not from userspace.  I see the driver does actually have a
set_tdm_slot() operation...

> +static int nau8360_read_device_properties(struct nau8360 *nau8360)
> +{

> +	ret = device_property_string_array_count(dev, "firmware-name");
> +	if (ret != NAU8360_DSP_FW_NUM) {
> +		dev_err(dev, "Missing or invalid firmware-name property in DT\n");
> +		return -EINVAL;
> +	}

> +static int nau8360_i2c_probe(struct i2c_client *i2c)
> +{

> +	ret = nau8360_read_device_properties(nau8360);
> +	if (ret)
> +		return ret;

This will fail the probe if we fail to read firmware-name from the DT so
the firmware name is a required property in DT (and ACPI systems will
have fun) even though it is not marked as such.  Either the driver needs
to tolerate not having the name configured one way or another or the
property needs to be mandatory in the bindings.

--mQW7vruDQ/SLpDT9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpGgIoACgkQJNaLcl1U
h9BtWgf/QSDMFRpRqoSYBjr7BcwBumFKqGVUqarsVAQTF/nbjDmHEnlq3F1IaFMm
jzPTQb50/VIMYe+VqQDzWFwQSwN0CiE4u7G5MoACeuxbOlQeHY1updgnQt/qkZtw
VM0Dntgb/AlusMlFld4FgXLiQzGMcpUSLc3Ek+4oNyEwDJk8ti1fX9W0nQ9Ja3xA
1lsCtJ8aSVGt0TwkT5Qe0XbxetmuNz6WkJArRVfAK3rH+p0TGp3K7uABjr6vjXG5
AizWn+pU/bcBm/D+wYl26SUg4RgnScGE2aEqQjkT1xl7JDrfuIup+b0r4fxrOZyR
le7/6mDUyoTfGv8BTTMMbj929UdUTA==
=1M6t
-----END PGP SIGNATURE-----

--mQW7vruDQ/SLpDT9--
