Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F26CD4851
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2026 07:05:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1974B601D5;
	Wed, 13 May 2026 09:04:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1974B601D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778655900;
	bh=JdybGMjoEfFjHhiA83UI2Cisq1qBWmWcMZwi46Pz4IY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=l3XgRWhh0owUIWFXv62GoOka1SZflaOiDQHdSf2qVJOhD2W3z/SQaY0OVb/RYbc+h
	 mVqqm4qASX0u9x+9yKHkHmqf0fDJ7ceDNKo8w6++Mkwk5P/0fwIyN57VyLNnHQ+K3l
	 sDI0J3yEqFwiNR4VsFlPGX5ntHukd6BQRKLxgcGA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E0BAAF805E7; Wed, 13 May 2026 09:04:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 19466F805F2;
	Wed, 13 May 2026 09:04:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E46B6F80535; Mon, 11 May 2026 22:50:23 +0200 (CEST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 936A3F80171
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2026 22:50:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 936A3F80171
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HU4/2knI
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-67c3cb1433cso8412745a12.0
        for <alsa-devel@alsa-project.org>;
 Mon, 11 May 2026 13:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778532620; cv=none;
        d=google.com; s=arc-20240605;
        b=IU8VOuDIsVyjkMgvn3kpBHCTxsm004X4GiUrwVqQrQ/L7Q60r2faKhKfa4wP6WGbrx
         TH28laU4YSlEw+aJnMEs+hMsz5XHG3RfnM0pILP7TFoebGAEcr3ujgUtG6+7+gxz4cFN
         5/4z/G70EpRWIHWTtF4zfEnZxKCZtK8z9wJV5C/DLKxjgKLZnPsxz4HLU/4xDaCrF55I
         47qwEHzA/4Cx429vcxrcajcdMTTrZMTR/NPCaCluIegAkVTm8jfnDSCVck7GkpuchQ2f
         YgsaxS2WhuN3SLSgU43oD5vUfJWxvs5ySLtju76sL3TAx8Jy6HwGjgDNSTIXlSU+Yf51
         TT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=l+xnJq2hSmaRDn4RQuc2BIoz7jnssgs+AG8SuM5OYmE=;
        fh=49LBvPODLmkNfyC+xK+g41Fb2O2MHSMnoQQ94Dy6jxY=;
        b=VB9bMzPto32LZ8ZB+5FIJxklBjqIbfSztPNyJ2huTEvNcdvRjqnWAn2qtl73I7bqrl
         XZ9NKnlD7gz1DnY1ouGH9sC3OlR9t4N8iqhGZZKl4oxzrHoObWAihGKkHOqOfY6xMx2k
         5yLqz4H3KjFhfgqm+IdVJRa+9uQ1xqqhsonHO4LiL0spqp+SLx/pGCK9rtiavskUv/qP
         5kosf0LUoqNTPXfnKEHTQXARHglGpKDDKSpl1EoC7netNWFbMX8QBl5IZ1rxu83xJQDD
         1Dh3p+XSBfzvEBORV2mCb10Soo1wv0y2gyQ5qvpajPJS+FU15PG7kJp9qXoXpcSZ3UkC
         mk2Q==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778532620; x=1779137420;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l+xnJq2hSmaRDn4RQuc2BIoz7jnssgs+AG8SuM5OYmE=;
        b=HU4/2knIm6Xlr9kmqssPtTpIxGfYyg8Tj5RTjnr4wrgixgai/DC6Yo6Gr0bpFrMtaD
         fWw4GdwDyHlWEcVjUsnudtTrEE/MlEZIdDaHggiuiQWjpp4Z3BMmY3XRcC8mrVxyTnV4
         8NDDfZGQqprUojFB+LWymKgETz84eBHFFZe+W0fq4hyaZjtuHBiZSClPnkEK1x1ya36y
         o2YTwvQPCfAQoT7gi+glIZKTh7NKijo9Hb/QJnplokBkxR/SPtmChdJAuYgubGTyBgGu
         mqjWh2bcSMlcB0hzm6jDfOsGIw21xl/Pmt3Toq9yzY9JpWt3EG11+GNUFVTmiGUtGA24
         5h9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778532620; x=1779137420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+xnJq2hSmaRDn4RQuc2BIoz7jnssgs+AG8SuM5OYmE=;
        b=kmwSG3+lxaayBbpEdSOOd/qp5D304dfCZzTiaTJ1EmhNpnEwOliIaPSJza5P5LkGsA
         lvkjllwlNepcRJfn5/dW4Fwm9r+K1EYy1hzq3Zgvwjr/0diSnzhDHI6rJyGeeokLuqKy
         w/wT/eEhRiun24ixE/mRODV5EUROKRRLoXWqfZrpY5nrl6N0iXlhgylTiI5+5jpcEC8s
         zqOgsqZxAwLOLwPEbHAagR4wjOgN5CB/V+dyl3FJgTRrWV36tohhrgq+GdvTMCuwvvpr
         KX8cvzOUbCJx5yJF7TS9YP3SkobLAviu/2+oFW2+i1wTjT/uy5SQCrXveTffhDj8QV51
         JDLA==
X-Gm-Message-State: AOJu0YxZmAazn5MM2+XDrFn0ZLBgbl9LqelIRdTSSyNFbX5AjhGQjqK6
	x7xUW/21lu3g/O5gKN41iM4oSSgnhu8+lVCnEAHe0OviOXxdNA9WskhPjJ5xaQwPoT9BWzxTUEo
	7pETTYIi4j4L2RyZgZRafZHBcTSCoyOU1R24tY3U=
X-Gm-Gg: Acq92OGfS/bncxMHD9QJDUFu+hLTlikdB7t0Edt43SM63EfiGOjKT6/2S7zgdaQHvEP
	CFFsnNcdGhxXDZ0HyjOKnrsKagwcQJnVg5+0vSqLwxOjdCV+zcLYnBn1xNanbrqdzZCuUXPlpe6
	0RcQs0h2XF5pb0uvOQPJjxDiLPvssCSuPia3dU0+ej/BQiUuzZHjqTf0UUVRuB28VJ6lU20yt0v
	UWo9hbR5NrCRcmWfg3fB93QOz3FodKI7f2a1qml8enfFUOmrwQgMOqyWswee1pIk9FG/zv44sWS
	Cjvs
X-Received: by 2002:a17:907:d23:b0:bd2:2b6a:81cc with SMTP id
 a640c23a62f3a-bd22b6a82dcmr106736066b.10.1778532620090; Mon, 11 May 2026
 13:50:20 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Alen_Ti=C5=A1ljar?= <alen.tisljar@gmail.com>
Date: Mon, 11 May 2026 22:49:43 +0200
X-Gm-Features: AVHnY4J2dlwx7VlMm_xOkwtZlv8sDRXLmN3NikCnKtip1LQyzQryBPy0QrJOE3s
Message-ID: 
 <CAKxS5A_OhoDGvVXZUnvUtv=j0zQ5Txq8g9_ScCPw12ZKfrmxOw@mail.gmail.com>
Subject: [BUG] ASoC: amd: yc: HP Notebook 255R G10 (board 8D22) missing from
 quirk table
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, Vijendar.Mukunda@amd.com, Mario.Limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: alen.tisljar@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: TGOWBS4M76EQFMEINRHWTNLULKS6J3UA
X-Message-ID-Hash: TGOWBS4M76EQFMEINRHWTNLULKS6J3UA
X-Mailman-Approved-At: Wed, 13 May 2026 07:04:15 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TGOWBS4M76EQFMEINRHWTNLULKS6J3UA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello,

The internal microphone on the HP Notebook 255R G10 does not work on
Linux because the board is missing from the ACP6x DMI quirk table in
sound/soc/amd/yc/acp6x-mach.c.

Hardware:

Laptop: HP Notebook 255R G10
Board name: 8D22 (HP)
Audio coprocessor: AMD ACP/ACP3X/ACP6x
Analog codec: Realtek ALC236 (working fine for speakers/headphones)

Symptoms:

Internal microphone is not captured.
No acp6x DMIC device appears in arecord -l =E2=80=94 only the ALC236 analog
inputs are listed.
In dmesg, the ACP6x PCI device is enabled.

Tested on:

Ubuntu 24.04 LTS (board 8D22 is not present in the mainline
acp6x-mach.c as of today)

Relevant dmesg output:

    snd_pci_acp6x 0000:03:00.5: enabling device (0000 -> 0002)

no further ACP6x/DMIC messages follow

arecord -l:

**** List of CAPTURE Hardware Devices ****
card 1: Generic_1 [HD-Audio Generic], device 0: ALC236 Analog [ALC236 Analo=
g]
card 1: Generic_1 [HD-Audio Generic], device 2: ALC236 Alt Analog
[ALC236 Alt Analog]

Suggested fix:

Add the following entry to yc_acp_quirk_table[] in
sound/soc/amd/yc/acp6x-mach.c, analogous to commit 0c6498a59fbb
("ASoC: amd: yc: Add HP 255 G10 into quirk table") which handled the
closely related HP 255 G10 (board 8B2F):

{
    .driver_data =3D &acp6x_card,
    .matches =3D {
        DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
        DMI_MATCH(DMI_BOARD_NAME, "8D22"),
    }
},

I'm happy to test any proposed patch on this hardware. I'm not
currently set up to submit a formal patch via git send-email, but if
no one is able to pick this up, I'm willing to submit one myself.

Thank you,

Alen Ti=C5=A1ljar
