Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329B1C5B572
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:24:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A85E60214;
	Fri, 14 Aug 2026 13:23:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A85E60214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786706644;
	bh=rTIiYGCTRbexi9EneEl3LcARzZARKdEb0plhunygDSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fTfSzS7JxmsylmWkkeSbDV1+FYIFtnagKHW3wgH8EggMK/en6sGkPnVSzjKhTTmSE
	 nthbv0vGNn1ONIkFqew1/GZVAN1Ex/3snjOZaU7BJX9ZwKNZ9AI3X7jeuGRydtlHt2
	 jdOtjL4rXD98xXdq4HTnNpY58XWwncQNRC3bTjKI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16771F805F7; Fri, 14 Aug 2026 13:23:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C1D1F805FF;
	Fri, 14 Aug 2026 13:23:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A38E3F805A8; Fri, 14 Aug 2026 13:23:21 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786706601;
	b=PLDDksotWbDsy2iWXXwD8AlE5FeP3IGmvN7EP353YOdX3R8FNxl3t4umTBzkNTuL/vnl
	 5Gi/rA9AnjJog0jYDLSHtTPzs9+FGeqqKBMlJWH72BGZFg2JK3U7mykbAGQC/WxjTpZ3V
	 Ez0QgRzc+XzL/sO7By+EYP9AFlSK6I+u3AIJCwAa/MNrFfTCcwZ+liDhEyrNcsIedrWsF
	 k40i9l7vp9GHpHeqT/oABxD4YASnQie6El4juQ56miHyrUlqkWpQjxyg2F9anyiYlaJgj
	 gLTjlPJsNHUK6uaunMnSaJHq+P0MMQRK41jtDrRI7gAW3NFij3533Sqh7BgQVTwd2dg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786706601;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=rTIiYGCTRbexi9EneEl3LcARzZARKdEb0plhunygDSA=;
	b=IBOUH+BOLyaFNcPnFjXVO86Br/Th4NQQTErfTXfnmqlt7AwfWsLewQUU0ThVpdkSD9c2
	 +jwpWfj/bEA54VdAsxbi9DQ+oc1vHaFw9FW3lbEoeT4YwT4OzLPIdchjDmtGAuwMNRyKv
	 yjiYnZTsOoPUkJ4NIKJ22yhuyJisG/qarbZ88loHm7hf87MbMg2GZkC2dFRzqazt8L8vm
	 sr971SMAAwb6idFcuiDYWAYklDxm4pC4eyUJkONxRpfGdy1cr09Lfd+5oXxcgXABSUbh8
	 15jOc3beigUjaqMnhulePy3i28CWSf99zKsQZOqcAZLSjNGlN/7ln6FDmHWKHvj/GZg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KlxnxoWw;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CAA94F80027
	for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2026 13:23:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CAA94F80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KlxnxoWw
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4BEA340E1A;
	Fri, 14 Aug 2026 11:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942321F000E9;
	Fri, 14 Aug 2026 11:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786706596;
	bh=KkS5iqI1KCXVRQiNSG/qGktdgLMbfW5BJqBMCcW1WF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KlxnxoWwiFnLOegEg0BmEYN48DtQD4JcDYALypshCW+2qSLAxAjWoShjL+nwOO7eb
	 /wIksh7GHq9ZU2fGLUSdzdh4BzKl/Us44dbaiRbKdfvxThCLazATu0pCnXUJFffRrt
	 76bMXIPsCOuLVBGLppDM/tE4P7d535ds8B/XlmfF2HC0Zq8TJI9tX8QBsU0v1W88TW
	 i7RvyeAbi0aVhqGyYVKSY4U1BrQyxR5faDlrU3fbELtN+W4Kx+BT2Nl1WZhQPgK3+g
	 S2mIA3MJi12H3fakqj9Pzlb0wfsrwUbojCdDfzbs1V3MHtZlwaONn+NEtYa9oIpQHy
	 Gf0imusVJKAdA==
Date: Fri, 14 Aug 2026 12:23:10 +0100
From: Mark Brown <broonie@kernel.org>
To: "Xu, Baojun" <baojun.xu@ti.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"Ding, Shenghao" <shenghao-ding@ti.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Yi, Ken" <k-yi@ti.com>, "Lo, Henry" <henry.lo@ti.com>,
	"Chen, Robin" <robinchen@ti.com>,
	"Holalu Yogendra, Niranjan" <niranjan.hy@ti.com>,
	"pin-hao.huang@hp.com" <pin-hao.huang@hp.com>,
	"Syed.SabaKareem@amd.com" <Syed.SabaKareem@amd.com>
Subject: Re: Re: [PATCH v2] ASoC: tas2783-sdw: add firmware download status
 check
Message-ID: <8111a8c5-6413-4c04-bc23-db30e3b78b1b@sirena.org.uk>
References: <20260813021450.1897-1-baojun.xu@ti.com>
 <0799cd9d-a0ef-41da-80ea-3fb9b1ef0f7f@sirena.org.uk>
 <7ea690074ee94d9786ed21e2bdde43de@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ilGqQWldoOFjm/xp"
Content-Disposition: inline
In-Reply-To: <7ea690074ee94d9786ed21e2bdde43de@ti.com>
X-Cookie: Body by Nautilus, Brain by Mattel.
Message-ID-Hash: SC5C6LI47FYYGG5BN2QPCBVKGJ5UKLTE
X-Message-ID-Hash: SC5C6LI47FYYGG5BN2QPCBVKGJ5UKLTE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SC5C6LI47FYYGG5BN2QPCBVKGJ5UKLTE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--ilGqQWldoOFjm/xp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 14, 2026 at 03:45:20AM +0000, Xu, Baojun wrote:

> > What happens if the amplifier uses power (eg, over a system suspend)?
> > Though since nothing clears first_hw_init I guess there might be issues
> > there anyway...

> Yes, that is the purpose of this patch. It prevents the re-downloading of
> pages above 0xC60000 after resuming from suspend, as the data in this region
> persists across an AMP reset. Therefore, these pages should only be downloaded
> during the initial power-up (when first_hw_init is false).

That's only going to be the case if the suspend is a retention one that
maintains power to the device.  If the suspend is a deep one that cuts
power to the device then I can't see how it'll keep memory contents.

--ilGqQWldoOFjm/xp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp++p4ACgkQJNaLcl1U
h9BcMQf/frCo29taAXlKsrKWybhTMJnAVlIvkd/yZZkKeFVsNxApt3Z7oi+/k+oT
1fCWuURmA2TWC9i3JQl/fqT6ARzc2Mdr5jFxfP3giiipDljfuttZcvsNv4l/dyY9
aXR7sZspdaGGBBY7kHdxUNwej5JnEf5U/zX26PvSp55G1pqArDt6wMv4mCCI/Ipt
JgIuclS7oOu6BzxdKBJt8GsubUY3AMGLfggHCxHeAu+/1FZ24HWWCNbM2pjarwm8
GH+ps+5nOVqhNVdXuOP3QdI6FsOsXhu3ydV/uS0TxZqoGiI8Jj/+NNIt4255lqq7
E/wEcvk7/8QWNfdoZ0QQJhwwjjwwfw==
=elVz
-----END PGP SIGNATURE-----

--ilGqQWldoOFjm/xp--
