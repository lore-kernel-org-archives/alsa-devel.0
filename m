Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A985EC43458
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:30:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 308F860229;
	Thu,  9 Jul 2026 10:30:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 308F860229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783585810;
	bh=R974s/4pHjjOnoC6q3RCzHhM8pjhVtzOZdqKQrbHE/I=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=GI7HIUv3ciI+zdefHnJReJ5q9WZdkISbdWxg5+rt1UpPD2HmjOMl1IH8bV8HK08Wm
	 0qP7fp8ZzGKY9k80vwMVGSaDheah5ZT2Nqrk6ZFCdak+eMXDPfB8Jl4uI2oYNctVZ/
	 j3rawmf7BSAgijMKlEC9zBRkeOBoS3fLEl+FpzPQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1288F805F2; Thu,  9 Jul 2026 10:29:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A0063F805FC;
	Thu,  9 Jul 2026 10:29:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 48151F80495; Thu,  9 Jul 2026 10:29:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=none smtp.remote-ip=213.186.235.122
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783585763;
	b=L2JK20eHXE/Gbsfa8E5qmHUorL4C0hcu4VEYGs1IlARbDpnyGcngyjJAdgwi1OKv2gNb
	 R0fTUQv2cSjoxRtuIneplrlpdnfy1zxKfnBp5z2M9FAZMlLSicW3js7DdUg/LuQzPBSod
	 xedGBqrBGjKHnuCQyqf1CJ07V8U2OWIL55ezn1DbmQRkgU+tDZNnGhQoJNjK+QXEkHMjj
	 tQSCSr+w8b8JLXt4YyNeydIyXxEJx3vVTn1T+X8Gj6RaAij6Sb5UvmnDujuLc6ynuuYb3
	 +EBnuh7eu3bAF4bY5STN1j5AcWzHBNQfMLEzQg/RWpfPBf507f4QguPZEUWR7pnjYsg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783585763;
	h=DKIM-Signature:Mime-Version:Subject:From:Date:Message-Id:To;
	bh=R974s/4pHjjOnoC6q3RCzHhM8pjhVtzOZdqKQrbHE/I=;
	b=cjwUY881zU+AQhF7eqFuERPnlBCua0SB8Vau7CB65N2DalGZJHJyWadgk6X3Suu+rpgn
	 WXlTweqxd1eEPXtXaMLWE6alcWYBTpNX+emOjIkCKD+eKu+AfAyPqP/nwLbA63HFk0w5H
	 nSNHuEyF5TDSCm8fxMDmVtLtYIHCzCZKoeeiSNWhtonE/QtrBm7E1AHu0tkr09IBws3Wj
	 Bj0HlFZAI4ofvMCz4Lcmg3DAEqKeTHrOno4wZifhYQZ29O7/qkLac1QZ5vt5OBuP+9gug
	 G0gVTkM5TYwF8QISSRwaPrn1ru99EeNaRQknec/yMu5Nv60OxqinkJltnpAY90yHSWQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=sonarnerd.net header.i=@sonarnerd.net header.a=rsa-sha256
 header.s=dkim header.b=LmBRAfLT;
	arc=none smtp.remote-ip=213.186.235.122
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [213.186.235.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BD063F800C1
	for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2026 10:29:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD063F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=sonarnerd.net header.i=@sonarnerd.net
 header.a=rsa-sha256 header.s=dkim header.b=LmBRAfLT
Received: from smtpclient.apple (unknown [213.186.235.123])
	by mail.sonarnerd.net (Postfix) with ESMTPSA id 3AB84231114;
	Thu, 09 Jul 2026 11:29:19 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.sonarnerd.net 3AB84231114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sonarnerd.net;
	s=dkim; t=1783585759;
	bh=ZxfXkxnbNzv9XLIz5WqNGsVr1Sb4iS8hZJ7vf6d04+M=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=LmBRAfLT6qN1v9jF17vFRkV37l9Br1faVibY7GXC1GQ81PyRUVufGKFXa4mEfXnrj
	 j7t1GeZDbHQxtyOpnx50ZRgZeWXJ6O+MdIDPU8R1Q74LIfijFzbDsnn87yqCnGD6Yl
	 KI7plc1Nj8pt6L81bkNiCcRjBcc4FqWuAGR3N35vOMIrQPrqw3xCZdWo18f07KqEXq
	 OdDDH3D3daEKr+zkc3BWXJfECyMMpo5qsPSHQeFHUhBa1aKMeEwOmInYd3gKWa32eN
	 FzV4Y10TpDd5gjDeAZrlzINPZ1gNjxNxSOVpqSz02jd1P9juCoJ33FVr2F+k8VfFEW
	 D274RkuXY5R0g==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [REGRESSION] snd-usb-audio: commit da3a7efff64e ("ALSA:
 usb-audio: Update for native DSD support quirks") breaks DSD playback on
 Musical Fidelity M6s DAC (2772:0502), plays ~8.8% fast
From: Jussi Laako <jussi@sonarnerd.net>
In-Reply-To: 
 <CAOdyq+ook_mDq_5wc_Na182bLvxZ1YJUJEchJ6MochU17QecQA@mail.gmail.com>
Date: Thu, 9 Jul 2026 11:29:08 +0300
Cc: Takashi Iwai <tiwai@suse.de>,
 alsa-devel@alsa-project.org,
 regressions@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <F93B45B8-79E8-4A4E-AE13-70173A2EB2F5@sonarnerd.net>
References: 
 <CAOdyq+qFaqCh=tK_wNnA64hv5pQuA1Y09ANxQ=xK8yR-t4mf9Q@mail.gmail.com>
 <4A4C8B42-D8BB-44D1-BE0B-CB5B4617F29E@sonarnerd.net>
 <87bjcg4nyh.wl-tiwai@suse.de>
 <CAOdyq+ook_mDq_5wc_Na182bLvxZ1YJUJEchJ6MochU17QecQA@mail.gmail.com>
To: Salvador Blaya <tiniebla6@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Message-ID-Hash: 5WNBTU3QDCGY3B3HIENNAC2AY44KDHTY
X-Message-ID-Hash: 5WNBTU3QDCGY3B3HIENNAC2AY44KDHTY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5WNBTU3QDCGY3B3HIENNAC2AY44KDHTY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Salvador,

No, native DSD with the M3x and M6x for example didn=E2=80=99t work =
before I added the vendor flag. That is precisely why I added it.

By the way, you can also just convert everything to 48k-base DSD during =
playback and then the playback speed is correct. It is common that DACs =
play 48k-base DSD with 44.1k-base clock (or just go silent or play =
noise), but in this case it seems to be another way around.


Best regards,

	- Jussi


> On 9. Jul 2026, at 10.54, Salvador Blaya <tiniebla6@gmail.com> wrote:
>=20
> Hi Takashi,
>=20
> Thank you - that approach would fit this case well, and the risks you
> mention are fortunately minimal here:
>=20
> - The M6s DAC has been discontinued for years and the defect was first
>  reported to the vendor (via their Windows ASIO driver users) back in
>  2018, with no firmware fix ever published. I have an inquiry open
>  with Musical Fidelity about firmware and will report back if
>  anything changes.
>=20
> - The only other model possibly sharing this ID, the M6sR successor,
>  exhibits the same defect per the Roon thread in my original report,
>  so an empty entry for 2772:0502 cannot break a working device. The
>  current MF models known to work with native DSD (M3x, M6x) already
>  worked before the vendor flag was added, so they use different IDs.
>=20
> I'm happy to test the patch on my unit - both that native DSD is no
> longer offered (MPD falling back to dsd2pcm as on 6.12.y) and that
> normal PCM playback is unaffected. Just let me know.
>=20
> Best regards,
>=20
> Salvador
>=20
> El jue, 9 jul 2026 a las 9:33, Takashi Iwai (<tiwai@suse.de>) =
escribi=C3=B3:
>>=20
>> On Thu, 09 Jul 2026 00:28:00 +0200,
>> Jussi Laako wrote:
>>>=20
>>> Hi,
>>>=20
>>> I don=E2=80=99t think we currently have exclusion method for devices =
with buggy firmware, which claim to support native DSD, but do it =
incorrectly. And reverting with device specific white-listing is not a =
good approach for future maintenance. Having to device-specific =
white-list each new device appearing on the market from the manufacturer =
just because some old device is broken is not really a sustainable =
model.
>>=20
>> While I fully agree that white-listing all needed devices won't =
scale,
>> blacklisting the broken device might work.  We can an empty quirk
>> entry for 2772:0502 for skipping the vendor match, something like
>> below, as an ad hoc fix.
>>=20
>> Though, this blindly assumes that there aren't so many broken =
devices,
>> and there will be no firmware fix or another model that works with =
the
>> same ID.  If a model is relatively new and/or the vendor often =
updates
>> the firmware, such an entry can be risky, too.
>>=20
>>=20
>> thanks,
>>=20
>> Takashi
>>=20
>> -- 8< --
>> --- a/sound/usb/quirks.c
>> +++ b/sound/usb/quirks.c
>> @@ -2463,6 +2463,8 @@ static const struct usb_audio_quirk_flags_table =
quirk_flags_table[] =3D {
>>                   QUIRK_FLAG_DSD_RAW),
>>        DEVICE_FLG(0x2708, 0x0002, /* Audient iD14 */
>>                   QUIRK_FLAG_IGNORE_CTL_ERROR),
>> +       DEVICE_FLG(0x2772, 0x0502, /* Musical Fidelity M6s DAC */
>> +                  0), /* for avoiding QUIRK_FLAG_DSD_RAW with vendor =
match */
>>        DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
>>                   QUIRK_FLAG_GET_SAMPLE_RATE),
>>        DEVICE_FLG(0x2a70, 0x1881, /* OnePlus Technology (Shenzhen) =
Co., Ltd. BE02T */

