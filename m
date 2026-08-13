Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31746C5CFDB
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2026 22:20:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FA4C6020E;
	Fri, 14 Aug 2026 00:20:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FA4C6020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786659637;
	bh=h/cZz00/1/SlrZT7qQD3nro5SmE1NcuKx9YBM7GyRIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VG1WTAUTigeDgpH8FKlkKkTUhH9hhad/+m+wyA93fnISttrBBGsXxWwiKw3P/lS/v
	 xuwvOT99KreTYZZLnlzWkDXFOWZo/hHZ2XJFUsaLr/TCWA5xVJnkQoqM6fc6JtXEh3
	 xhgvMZp7pjoGSpJ/3PYJWQtYZw91/5w5fzErUqbg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 86962F805F6; Fri, 14 Aug 2026 00:20:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 906A6F805F2;
	Fri, 14 Aug 2026 00:20:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29B99F805A8; Fri, 14 Aug 2026 00:19:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786659596;
	b=UWvd2qBFTPqUY/vfs/Mj5FQv0Mm4DGdE6GeO2YymxMJLzhB5bwgarXut58hc5ovWLJz1
	 Yddi6o5basDHhbPZg7r3vQ4X+sjPvaP7cUU3oIrvYkigkPQ32ts1DYUMacClUiUy3Hb3D
	 qI56q839xYfyfnjv4zhCmaYz0hsR+xOcemxI/wmxpLzqJb0JUtJrxxU2PpKwersI60BNZ
	 GpQCdh8+OT8l+HeM/HkontOSRbgWBMprtX7wpFos0K8Bi+HLzM8E3vvq1t5oxKfyTOHbs
	 6YvRxO/ZMyZ1Vu5aP+ZSVjEI8ciA+XpjYXNx8QF8lvx9W7qP84EBZKRs+p7Dn+F85Iw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786659596;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=h/cZz00/1/SlrZT7qQD3nro5SmE1NcuKx9YBM7GyRIc=;
	b=KQAlcdf0TQ00AmQ6OuksAr0/O91AAfXRBvLNvrHavQqHxedWeYUaQzU4MaIk2xrL2Nup
	 gd33pDnoZtAAA8cRf64ieemVR57DIy4yBCrTpFEerNmDvPUJGGveZNF4pEfIJ3eTrtZch
	 Q1PIcdXTLQgOLvv/HdT2Vq30uikd6yNvKq6KXJZKB1MEuetf5hQiHzSbYUxbUYFCx5t/e
	 DCOfhpt8Dpvb6eJFln+9iFoWQBjmQfxB3z4Xf/pLrsPiOf9VQj8J6seRVwu0TSk5xeuZK
	 2jv5ESYzTxp4F5B6hDMXTNRhp9bLq8nLi79c0xNIW6XIMzL3cEKlhDpFaHrI7KanSYA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Sgho7mni;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 58C83F80027
	for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2026 00:19:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58C83F80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Sgho7mni
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D6EA5600AF;
	Thu, 13 Aug 2026 22:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2221F000E9;
	Thu, 13 Aug 2026 22:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786659592;
	bh=092Pna56QuSDIlIXeHtlF7qEbhj6KCNEOQrzLk7UiGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sgho7mni3TBN17WC6KkkhThtoxNoeBPs2p7X8EiJ3h8Q1DqA+Pdo7he7ATtQ20fo3
	 RpX4XiCWWdyAbvaSBJHKBiqpIYZOCjCO8IEzaKZc1G3HPehDNCk5r9/a3imQG3oIvT
	 wrR+160dVc8wjc/FFLX1vB9j/dL0YLyH4PJrV6+qdPdliU8JPWQRYlacRDAp6P18km
	 ehWfbpbgfOn205gPZ92qBdn+FXj/cV6/eIhVdzcJtpuzD/KluHmmAO3dnHFzUunz22
	 1o1Crn61PyzcWi41hUN8IH6G2HvpeYKeHeuStRl+U4RGoVblqxsXEno5yfpHJk1lqx
	 qkquWzIihW8vQ==
Date: Thu, 13 Aug 2026 23:19:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, shenghao-ding@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	k-yi@ti.com, henry.lo@ti.com, robinchen@ti.com, niranjan.hy@ti.com,
	pin-hao.huang@hp.com, Syed.SabaKareem@amd.com
Subject: Re: [PATCH v2] ASoC: tas2783-sdw: add firmware download status check
Message-ID: <0799cd9d-a0ef-41da-80ea-3fb9b1ef0f7f@sirena.org.uk>
References: <20260813021450.1897-1-baojun.xu@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KzoVrVZXOpkAwgp5"
Content-Disposition: inline
In-Reply-To: <20260813021450.1897-1-baojun.xu@ti.com>
X-Cookie: Immanuel doesn't pun, he Kant.
Message-ID-Hash: V7BFHUL6C2MUIGGVG6VHI5LURNTFRJ3E
X-Message-ID-Hash: V7BFHUL6C2MUIGGVG6VHI5LURNTFRJ3E
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V7BFHUL6C2MUIGGVG6VHI5LURNTFRJ3E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--KzoVrVZXOpkAwgp5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 13, 2026 at 10:14:50AM +0800, Baojun Xu wrote:
> Currently, the firmware download is unnecessarily triggered on every
> system resume from suspend, causing significant wake-up latency. However,
> this step is redundant if the AMP remains powered on. Furthermore, certain
> memory pages (addresses > 0xc60000) are skipped even after an AMP reset.

> +		if (!tas_dev->first_hw_init || file->dest_addr < 0xc60000) {
> +			ret = sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
> +					       file->dest_addr,
> +					       file->length,
> +					       file->fw_data);

What happens if the amplifier uses power (eg, over a system suspend)?
Though since nothing clears first_hw_init I guess there might be issues
there anyway...

--KzoVrVZXOpkAwgp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp+QwIACgkQJNaLcl1U
h9ANegf+JK0QxQwgfNUpmn4rEGyfPdGNwOIGZnhXTPQ1YQw0Z1HGeeGH/Xf7DHxX
0g8LX84V5NA3QMrDjlBCcJZSaFbBXNDzk1dQAp8ssgnOewMD7NyMp5UY1qs+/NpH
RtlfGxbEZdgj//sJhYLocDrKObOkKoXO1R59TM+A+1Ua0KK8exlfeCtBJMyL2uEl
PYlNslBO5GcB0yK8WCImKyFhM6Ijinhcds6fTgzbaNlUP6r1CeiYR697sK/HxjZp
nx0ACestXtzHlPNUYKNjGmQEN1fqijp5N7nLm1Wf7W3wIYSVY9O1Y0b0ObrPzYTu
AmcRVLekfBsYJvXw+Ql6Z1esLHPsnw==
=BSuN
-----END PGP SIGNATURE-----

--KzoVrVZXOpkAwgp5--
