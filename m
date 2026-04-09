Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F72AF3ED53
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Apr 2026 20:25:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBA0C6020E;
	Sat, 11 Apr 2026 22:25:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBA0C6020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775939141;
	bh=e3eixAChUF7G2BhgzMzYctyPjnC+cERIhvt3IsKY2IU=;
	h=Date:To:From:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=R68Qmf7b8SIsND2lsQLn4VBO5UEy7zAbFNLq63lkwHkAjYljxzBKw2qgjtnDPsa/B
	 xM44uzGSwtLugLkstNROPKArtVgG/04HYkpzs+h0Hp3ixI7yj0OWJIS9XY3f12rj6t
	 GAiblJzOLfelfmosucBHVsA/o7ABrSazE9v6bDgg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B2A2F805EE; Sat, 11 Apr 2026 22:25:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 17B2FF805E8;
	Sat, 11 Apr 2026 22:25:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 940FEF8052D; Fri, 10 Apr 2026 00:32:22 +0200 (CEST)
Received: from mail-106103.protonmail.ch (mail-106103.protonmail.ch
 [79.135.106.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D94F4F8021D
	for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2026 00:32:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D94F4F8021D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=bk529zKn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1775773938; x=1776033138;
	bh=e3eixAChUF7G2BhgzMzYctyPjnC+cERIhvt3IsKY2IU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bk529zKn5VMZ3zGJvHmnGV68cKOq/yhvwY1BNdS6eYRvjys+v5+Nux5ZSDHzuTvYD
	 0i1dFTe9G4ETn/tTGLcs7uQSAzhzlXKDe5xaLXjlzUIv7pzBcavl+xjVF8CVhA5whS
	 6PS1FUa2s7lOPhftI+srC2udcFIFBjPKmcHWKe1hYoF2J5Vp3EHRFEuK5TrsPDyJ5T
	 SppqqvjN7q9rdgjAws8EgbzvU63raiE0TB8MeVPxJmqhX/Z/C/P/9CWWss5D55fJxN
	 KmgRmm6NCtWUtlGZf+NodjS4Z8myrHGH7bzplE1SKMUzJqBllg9OT8+mA3korx5zEI
	 /Zj39QnfUNjgw==
Date: Thu, 09 Apr 2026 22:32:16 +0000
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: "marco.mco" <marco.mco@proton.me>
Cc: "7rebel@proton.me" <7rebel@proton.me>
Subject: Re: ALC287: Missing fixup for Lenovo IdeaPad Pro 5 14AKP10
Message-ID: 
 <8LbtTPDB95dWV2XV10ydcO2VWxeCEjDzJFogw2IsJz7fEWJjn-hWYkL1RNf3NpXvufOi843pkUR2DWIPYg3pQXVWvNCmz-dQTxSZB1Y2x8A=@proton.me>
Feedback-ID: 191679111:user:proton
X-Pm-Message-ID: 494297cd6bc5a880af07036bc5b0655cf63ba252
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-MailFrom: marco.mco@proton.me
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 5VZTBYBINWB3JGBNRMDGMQW4TOG3EYJP
X-Message-ID-Hash: 5VZTBYBINWB3JGBNRMDGMQW4TOG3EYJP
X-Mailman-Approved-At: Sat, 11 Apr 2026 20:24:58 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5VZTBYBINWB3JGBNRMDGMQW4TOG3EYJP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello,

I am writing to confirm that I am experiencing the exact same issue on my L=
enovo IdeaPad Pro 5 14AKP10 (model 83JL) with Ryzen AI 300 series.

Like the original reporter, my system suffers from severe electrical noise =
(buzzing and hissing) from both speakers and the 3.5mm jack. The noise only=
 stops when the output is muted.

On Windows 11, the audio works perfectly with the following identifiers:
- Hardware ID: HDAUDIO\FUNC_01&VEN_10EC&DEV_0287&SUBSYS_17AA3912
- Windows Driver: 6.0.9879.1 (oem22.inf)

On Fedora 43 (Kernel 6.19.11), the kernel incorrectly identifies the PCI SS=
ID as 17aa:0000.=20
In my alsa-info, the PCI Subsystem ID is listed as 17aa:38b2, while the Cod=
ec Subsystem ID is 17aa:3912. It seems the kernel fails to map these correc=
tly on this AMD platform.

Here is my alsa-info report confirming the mismatch:
http://alsa-project.org/db/?f=3D93821cc4108e0ef63356dc343b73a5709bf44f57

In the dmesg section of the report, it is clearly visible:
"snd_hda_codec_alc269 hdaudioC1D0: ALC287: picked fixup for PCI SSID 17aa:0=
000"

I am available to test any patches or provide further information.

Best regards,
Marco
