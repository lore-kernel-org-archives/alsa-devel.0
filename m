Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A442C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:29:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFBD960216;
	Thu,  9 Jul 2026 00:28:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFBD960216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783549738;
	bh=lJCMvKbuwbG0zzJV14C1oceEEjy0QBMc3S2SWO7tPa0=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=H1cY1Ou2XIN8V+hRYwmCu/mWSdShzb+aHiU1P9uCOQaVFL8C+fwIak8LqrrxgMod4
	 tQysXEkNX2qwWqE9e3L4JOIYZIlKxS1wmR6+t4Tv23HHgwTJ8DnYw2+l4DWpNjz7M7
	 V7IbJ6gt7KezYPz8lyJcMGKNi2LSBe8hx6XPwBag=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51C09F80602; Thu,  9 Jul 2026 00:28:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E49D2F80495;
	Thu,  9 Jul 2026 00:28:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EF7B3F80495; Thu,  9 Jul 2026 00:28:17 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=213.186.235.122
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783549693;
	b=bZ/9L/DxweX2UEMYi6RlKooF+gsufwPWlO9wR8T7pRrDU2oG8foFoQlq90oHG3RCXeA/
	 wlyhjj7rT2Tdre/KjH0geOTXxZMP5b1OOENm+1KgHwVeE6/nLNtGfzEGNwuGF8Z2J/W30
	 aDMJkO+KNYaQJLf285C/ev9nNndPxsuDu1/PGFXQa18NGDRALvBYwzyaUJfxiiB8etn8k
	 A8KNsQPMfGbwdz/UHfWCidXJkRIfmUsAAcyFBZe6egFwalhcw5/NuaLECsIXyJ29qVHbd
	 fB0ZxNB5EM920sOsffQdk9J1UTGjuGa4wPa5QkZqtQMDNwr7zdQCLR2H/LFr/QbEHtA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783549693;
	h=DKIM-Signature:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=lJCMvKbuwbG0zzJV14C1oceEEjy0QBMc3S2SWO7tPa0=;
	b=eK8VlnJC/7tY6Wn+PKnuOQWmN5VPRAoOz3bNAAmOn4aDjeepfTM03yAMTf+zc2Zs67CW
	 jOo3R1FPh5SrHZM5cKnwWhRmF6yB8TRnKcAD6XTg4Y26YTdDBcfZOwkmS/KZKNElPEtcq
	 gqBdCC/w3IiPtOMKW3wBugcOOe9owUUQVbLhm4P6evBq+sVVBMhYWfkENaRy/PZnzxl0d
	 pnwS4MjlHZds4cKaAZJielF3auwVL7UO+jH4PQ0yRdj7Jla55AaQLRd6mcX1pdM+lFEnh
	 NyqGBsI5OGHjscfiaUsQ+OrX7HNwnP/Nj/05VG+3Cebz44PbaGYud9lDMphqkgeFDUQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=sonarnerd.net header.i=@sonarnerd.net header.a=rsa-sha256
 header.s=dkim header.b=8YsOFpDo;
	arc=none smtp.remote-ip=213.186.235.122
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [213.186.235.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 92257F80124
	for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2026 00:28:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92257F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=sonarnerd.net header.i=@sonarnerd.net
 header.a=rsa-sha256 header.s=dkim header.b=8YsOFpDo
Received: from smtpclient.apple (unknown [213.186.235.123])
	by mail.sonarnerd.net (Postfix) with ESMTPSA id A8C2C231138;
	Thu, 09 Jul 2026 01:28:10 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.sonarnerd.net A8C2C231138
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonarnerd.net;
	s=dkim; t=1783549690;
	bh=FqjxE4xFrVtuCRKim3xbqoI/9Sz1SAg0SWh0CexH1C4=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=8YsOFpDoYrgEYhAfU6WAJ3Ts8RZIl4N9IUH+rG41r6IcEazN0IEs7OMAW5TJFLfSm
	 M5yD/xMBDV9Pp+I8Gwhl6QOXCK7du0F35n1F04lnbPY4COdEXCv+/dwgI48PIwUrHF
	 /9InkhGkb/QnPs4jPNwCJ/AnJOyO4/5yF//dz9At23sDqaqfAvQ1VQsS3EI/nK3Bj7
	 YVaaCSHtub/3nuCgqsaIv4hKEbAMr8UZzAQQYCmfeUap+xIN8moWOyQLMKg9FoGPJH
	 B012r77BMC5FNIjigePa6hPSW8g7r5Fq1V4omZm9MzO+GmBq8+wiGqAPNhn3HqTfes
	 mrP2YqJn9LJVQ==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [REGRESSION] snd-usb-audio: commit da3a7efff64e ("ALSA:
 usb-audio: Update for native DSD support quirks") breaks DSD playback on
 Musical Fidelity M6s DAC (2772:0502), plays ~8.8% fast
From: Jussi Laako <jussi@sonarnerd.net>
In-Reply-To: 
 <CAOdyq+qFaqCh=tK_wNnA64hv5pQuA1Y09ANxQ=xK8yR-t4mf9Q@mail.gmail.com>
Date: Thu, 9 Jul 2026 01:28:00 +0300
Cc: alsa-devel@alsa-project.org,
 tiwai@suse.de,
 regressions@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A4C8B42-D8BB-44D1-BE0B-CB5B4617F29E@sonarnerd.net>
References: 
 <CAOdyq+qFaqCh=tK_wNnA64hv5pQuA1Y09ANxQ=xK8yR-t4mf9Q@mail.gmail.com>
To: Salvador Blaya <tiniebla6@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Message-ID-Hash: 2EO6DAOK5BIWHEUUU4QMPJRMD4HW6WRQ
X-Message-ID-Hash: 2EO6DAOK5BIWHEUUU4QMPJRMD4HW6WRQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2EO6DAOK5BIWHEUUU4QMPJRMD4HW6WRQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

I don=E2=80=99t think we currently have exclusion method for devices =
with buggy firmware, which claim to support native DSD, but do it =
incorrectly. And reverting with device specific white-listing is not a =
good approach for future maintenance. Having to device-specific =
white-list each new device appearing on the market from the manufacturer =
just because some old device is broken is not really a sustainable =
model.

So I would just suggest using PCM with the device if it=E2=80=99s DSD =
implementation is buggy/broken, while it claims to have such. Or =
alternatively update the firmware with a fixed one.

Newer MuFi devices work fine though, like for example the M3x DAC I have =
for testing this, and the M6x you mention.

Additional challenge is that many manufacturers use the same USB =
interface implementation with same VID:PID on multiple different =
products. So it is not even necessarily possible to distinguish a =
particular problematic product.


Best regards,

	- Jussi


> On 8. Jul 2026, at 19.33, Salvador Blaya <tiniebla6@gmail.com> wrote:
>=20
> To: alsa-devel@alsa-project.org
> Cc: tiwai@suse.de, jussi@sonarnerd.net, regressions@lists.linux.dev
> Subject: [REGRESSION] snd-usb-audio: commit da3a7ef ("ALSA: usb-audio:
> Update for native DSD support quirks") breaks DSD playback on Musical
> Fidelity M6s DAC (2772:0502), plays ~8.8% fast
>=20
> Hi,
>=20
> Commit da3a7efff64e ("ALSA: usb-audio: Update for native DSD support
> quirks") added VENDOR_FLG(0x2772) with QUIRK_FLAG_DSD_RAW for Musical
> Fidelity devices. This vendor-wide match also catches the (older,
> discontinued) Musical Fidelity M6s DAC, USB ID 2772:0502, which =
exposes
> a UAC2 altsetting with bmFormats 0x80000000 (RAW_DATA, 32-bit) but
> whose firmware cannot actually clock DSD playback correctly in any
> mode. As a result, since this commit, applications like MPD prefer the
> newly offered native DSD over DSD-to-PCM conversion and playback is
> audibly broken (runs ~8.8% fast, raised pitch), where kernels without
> the commit (e.g. 6.12.x) play correctly.
>=20
> Could 2772:0502 be excluded from the vendor flag (or the vendor flag
> be narrowed to the specific products that support native DSD, such as
> the newer M6x DAC)?
>=20
> Evidence gathered on Debian trixie, MPD, direct hw: access, no
> resampling:
>=20
> 1) Native DSD (observed on 7.0.7 through 7.0.12): host side is correct
>   - hw_params shows format DSD_U32_BE, rate 88200 (correct for DSD64)
>   - but playback runs ~8.8% fast with raised pitch. A 4:41 track
>   finishes in ~4:15, matching a 48 kHz-family clock (3.072 MHz)
>   applied to a 2.8224 MHz DSD64 stream (ratio 1.0884).
>=20
> 2) DoP (6.12.9, MPD dop=3Dyes): host side again correct - hw_params
>   shows S32_LE, rate 176400 - same ~8.8% fast playback. So the DAC's
>   internal DSD decoding path is misclocked regardless of transport.
>=20
> 3) Control test: the same DSD64 track converted to PCM FLAC at
>   176400 Hz plays at correct speed/pitch through the exact same path
>   (S32_LE @ 176400). The 44.1 kHz rate family is fine for PCM; only
>   DSD decoding inside the DAC is broken. This rules out any host-side
>   rate issue.
>=20
> 4) The same fault has long been reported for this DAC on Windows 10
>   with the official ASIO driver ("DSD via DoP plays noticeably
>   faster"):
>   =
https://community.roonlabs.com/t/musical-fidelity-m6-sdac-dsd-issues/39450=

>   including a follow-up for the successor model (M6sR). This is an
>   OS-independent firmware defect that the manufacturer never fixed,
>   which is presumably why this model was specified as DoP-only.
>=20
> Working configuration for reference (correct playback): MPD with
> dop "no", MPD's dsd2pcm conversion to 352800 Hz - i.e. the behaviour
> kernels without the commit provide by default for this device.
>=20
> Since these quirk updates tend to be backported to stable/LTS trees,
> please consider the fix for stable as well, so that currently working
> LTS kernels (e.g. 6.12.y) don't regress.
>=20
> Full lsusb -v output attached. Happy to test patches.
>=20
> #regzbot introduced: da3a7efff64ec0d63af4499eea3a46a2e13b5797
>=20
> Please CC me on replies, I'm not subscribed to the list.
>=20
> Best regards,
>=20
> S. Blaya
> <m6sdac-lsusb.txt>

