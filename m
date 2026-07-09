Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A15C43458
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:35:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 008E460239;
	Thu,  9 Jul 2026 10:35:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 008E460239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783586142;
	bh=NYRVenukqz40PT1ePEaJ4fI3HMqgJj2jGsXcYsqoaUc=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RkxFQSDtRdo/yslews9xWhJrGY5SeKcDU+fil0VbxAyLKesGbCUDieib/m0mDA53K
	 RuAifEb9a7mofMlA/uX1DSd4YiQJyvexnCcbqpKXfw3BBaHRWx3IrQNpGXpAYetoM3
	 1PcCk7FSmX/UxuiGhE62QPAvV1affxCDkhqP8a0E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 155D1F805FE; Thu,  9 Jul 2026 10:35:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F0BEF805F6;
	Thu,  9 Jul 2026 10:35:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2341F80495; Thu,  9 Jul 2026 10:35:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=213.186.235.122
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783586097;
	b=m9dbq/ftSzRP8piZ7BuvQJAJVZvP0Uh78QCuOF/uSsOsKkqj9JtsIWPFgpJuLjM85tv0
	 NVS/t1LO69MhQjIWkqJxNS++8USfG7JYpgyoUC7m2jJJwO3EddTpFyzEvcsWveol3Hw5f
	 jBRxOOWTjSCzfaaVt2zbr93FpATAS90ueoNNWSekrMZk9u3/Ps8cHN0uHK9ZZAm8fHggX
	 mzE+PQg81kfsLm93ItyrQM/iddWqDa5T70ATwZW0DPQfRmx+4S05AbiQJ2EcUvmJejj1M
	 Us2O4JjKutHlOY8vgw+/ARQ0ap30Wz1Gxtiy2WBgWAM7+4Y1XUcWvgZi7pdkfQ3bjNQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783586097;
	h=DKIM-Signature:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=NYRVenukqz40PT1ePEaJ4fI3HMqgJj2jGsXcYsqoaUc=;
	b=qzuYVv65ogPTBKEtVf17MGkSa1dZ/NH1M6PrWAnPO+5dSUFlFqu7ZVP1xRNZz4rD+nwf
	 ei27w5a1PZw90+hjhL9fwe8zRuy5Ve/8nnYW1E46jLFqK6jWteiow/1udGgnDx9DWwQgd
	 bJ+DmuwC5ai11JfGFIEXCOfiEk1sj893Q39HCXIM1o0esEKi4WsR9JohJ/EL9EbvTCQYd
	 jSly9zmtHu1hPoLe4HhS4BnrZK8SjXqjfHYA9mdcGwsWlRGFlBSmv/YlpiCab+A3cfX85
	 fS9seTmIQabgB5d0twec0URP32cKp3g4KEoPTCSe1Jw3IM/3Ja6ReMjxfc9wZxdo4JQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=sonarnerd.net header.i=@sonarnerd.net header.a=rsa-sha256
 header.s=dkim header.b=5Lt6ZVt2;
	arc=none smtp.remote-ip=213.186.235.122
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [213.186.235.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3C442F800D0
	for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2026 10:34:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C442F800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=sonarnerd.net header.i=@sonarnerd.net
 header.a=rsa-sha256 header.s=dkim header.b=5Lt6ZVt2
Received: from smtpclient.apple (unknown [213.186.235.123])
	by mail.sonarnerd.net (Postfix) with ESMTPSA id D7918231114;
	Thu, 09 Jul 2026 11:34:54 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.sonarnerd.net D7918231114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonarnerd.net;
	s=dkim; t=1783586094;
	bh=ZAAkhbKWvNqd/b8grpbrTpH7nLcwXHsjvIsE1piJsc8=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=5Lt6ZVt273pn8D8BkElVxsgps1JzMiIPwDplnN6RhDi9l2sW+Yq9/DQ5fd6hVnptA
	 l1ElRbsd1GTqjHKiUlONrNnXqL0lUq3KTD58h5ff7WprJxeRhA5+mouwvMTs9J3ihA
	 vAVkRD1t0dOtdmKekv2W5cwOWBqd8aNUNxBi7PJlXmxN966S4652ntTKPyNe6wCWUu
	 MAftfIQ/6RyJWLrjNA7Ty8ClYchHd6WB+p2naKc9YgSUbH45am5hTh/ASetIVJuEjn
	 /tSwxgvinLAofYF1VX5l7EgYzeeh+1Mzuf9g2vkRZ35y1JgEclS9XMTHiJfCgSwWUZ
	 dUh5sY0qnW4Gw==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [REGRESSION] snd-usb-audio: commit da3a7efff64e ("ALSA:
 usb-audio: Update for native DSD support quirks") breaks DSD playback on
 Musical Fidelity M6s DAC (2772:0502), plays ~8.8% fast
From: Jussi Laako <jussi@sonarnerd.net>
In-Reply-To: <87bjcg4nyh.wl-tiwai@suse.de>
Date: Thu, 9 Jul 2026 11:34:44 +0300
Cc: Salvador Blaya <tiniebla6@gmail.com>,
 alsa-devel@alsa-project.org,
 regressions@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B949249-CB61-4D76-BD4B-6C9B467E97D6@sonarnerd.net>
References: 
 <CAOdyq+qFaqCh=tK_wNnA64hv5pQuA1Y09ANxQ=xK8yR-t4mf9Q@mail.gmail.com>
 <4A4C8B42-D8BB-44D1-BE0B-CB5B4617F29E@sonarnerd.net>
 <87bjcg4nyh.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Message-ID-Hash: FDY5KGWDLQZRC6SOOSPMUFS6BQUJ2E43
X-Message-ID-Hash: FDY5KGWDLQZRC6SOOSPMUFS6BQUJ2E43
X-MailFrom: jussi@sonarnerd.net
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FDY5KGWDLQZRC6SOOSPMUFS6BQUJ2E43/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This is of course OK for me if it works. The newer Musical Fidelity =
devices work fine. For example M3x, M6x, M8x, MX and likely upcoming new =
ones.

So I would rather go with blacklisting broken ones.


	- Jussi


> On 9. Jul 2026, at 10.33, Takashi Iwai <tiwai@suse.de> wrote:
>=20
> On Thu, 09 Jul 2026 00:28:00 +0200,
> Jussi Laako wrote:
>>=20
>> Hi,
>>=20
>> I don=E2=80=99t think we currently have exclusion method for devices =
with buggy firmware, which claim to support native DSD, but do it =
incorrectly. And reverting with device specific white-listing is not a =
good approach for future maintenance. Having to device-specific =
white-list each new device appearing on the market from the manufacturer =
just because some old device is broken is not really a sustainable =
model.
>=20
> While I fully agree that white-listing all needed devices won't scale,
> blacklisting the broken device might work.  We can an empty quirk
> entry for 2772:0502 for skipping the vendor match, something like
> below, as an ad hoc fix.
>=20
> Though, this blindly assumes that there aren't so many broken devices,
> and there will be no firmware fix or another model that works with the
> same ID.  If a model is relatively new and/or the vendor often updates
> the firmware, such an entry can be risky, too.
>=20
>=20
> thanks,
>=20
> Takashi
>=20
> -- 8< --
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -2463,6 +2463,8 @@ static const struct usb_audio_quirk_flags_table =
quirk_flags_table[] =3D {
>   QUIRK_FLAG_DSD_RAW),
> DEVICE_FLG(0x2708, 0x0002, /* Audient iD14 */
>   QUIRK_FLAG_IGNORE_CTL_ERROR),
> + DEVICE_FLG(0x2772, 0x0502, /* Musical Fidelity M6s DAC */
> +   0), /* for avoiding QUIRK_FLAG_DSD_RAW with vendor match */
> DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
>   QUIRK_FLAG_GET_SAMPLE_RATE),
> DEVICE_FLG(0x2a70, 0x1881, /* OnePlus Technology (Shenzhen) Co., Ltd. =
BE02T */

