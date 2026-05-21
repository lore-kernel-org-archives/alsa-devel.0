Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9D0CD5BC8
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 15:14:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D39760252;
	Tue, 26 May 2026 17:13:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D39760252
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779808444;
	bh=yDh31zvaqbtfk5n1otOYA4jDqDUEAA1FZdL/xDq19z8=;
	h=Date:To:From:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qRtU5TNCOJ1OEw0KUzii9dAubTNbE8UppJnBkASrlXeUsfRqYq/GLUvPERxgcbfXK
	 60/xF0z+fyM6YW4T2zdRQWvKlUyWkepkA+X3lFafKYXLEGYbqXGTbI5/5y/hij6PuB
	 EHC4JNxvaFd9VyHg/xRXGA+kcvufRn+wSD7NH110=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 21159F8065E; Tue, 26 May 2026 17:13:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E3AAFF8065C;
	Tue, 26 May 2026 17:13:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24C10F80557; Mon, 25 May 2026 12:01:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6F4EEF8047D
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 12:01:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F4EEF8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmx.at header.i=t.malzer@gmx.at header.a=rsa-sha256
 header.s=s31663417 header.b=PCwQs2G+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.at;
	s=s31663417; t=1779703289; x=1780308089; i=t.malzer@gmx.at;
	bh=yDh31zvaqbtfk5n1otOYA4jDqDUEAA1FZdL/xDq19z8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PCwQs2G+FV1zvLtAtj5QFAUiUWyV+PoM1/aWirA1u6KXB8EWp2WfGUb+GDeiCbCO
	 Rxh03WzThjUQV37Cphpbe96i9kMVvDOGVK2EgC323gGzYInV0coeDiBn0Ootp5RTO
	 3vCt66p+lm8HNOUROSbX0ojBq9fQ+RA46oIbXu0WLjDEGspBlsG56pblFJ8BitDk0
	 rOAue9+KR9WAYW2nf8BAz1l7lVJxoresOXL3Uxr7Xq6uhXhp/6RfgkvOEoJyOl/Qn
	 mifoTnqFfSMWilDn1mQCiIkp6d5XybetJm5m1BOHPPMnLvtVZlXt93IlQwHWSIbVn
	 a9m80Y/WaOJ8TgK0LQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49lJ-1xPg9t2JRR-00saq8; Thu, 21
 May 2026 10:32:52 +0200
Message-ID: <7f3b61bb-e03b-4724-8fd2-c184003a51f0@gmx.at>
Date: Thu, 21 May 2026 10:32:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: alsa-devel@alsa-project.org, t.malzer@gmx.at
From: Thomas Malzer <t.malzer@gmx.at>
Subject: Bug report: snd_hda_codec_conexant: CX20585 Speaker Pin (Node 0x1f)
 enters D3 power state during playback
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xkdz631na9Bq/cIXbdJQcnFJhXekzv0B+HZYOaR1zqQ5IuuN87V
 cSoLDGPoBLEBPQpr3WXi0KgZtj++Ssr/wMU7yEG+DAJabQjUh1RqA1Ga6gK7cqJ344eV8wa
 EjBUhZS5oY1HRU56UIGtkYejPzpZ1t0RwyQUrKeWWnyKxY91mmiILlMIXMnjr93KHZ1RYW/
 vr99PFWqgdm3xAMAhkH8A==
UI-OutboundReport: notjunk:1;M01:P0:sI6GmPoF2zI=;QPX0BNLDXmZwrvyWjnoabk2eCFr
 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
 Gg7QRMl6xKpa+22pQw=
X-MailFrom: t.malzer@gmx.at
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: QMNZASGAA6GVGJXNCYY2PQO2KO5UN5D4
X-Message-ID-Hash: QMNZASGAA6GVGJXNCYY2PQO2KO5UN5D4
X-Mailman-Approved-At: Tue, 26 May 2026 15:12:59 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QMNZASGAA6GVGJXNCYY2PQO2KO5UN5D4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello,

I would like to report an audio bug affecting the Conexant CX20585 chip.

Hardware: Medion Akoya E7220 (MD98740)
Audio chip: Conexant CX20585
Vendor Id: 0x14f15069
Subsystem Id: 0x1b0a20af
Driver: snd_hda_codec_conexant
Kernel: 7.0.0-15-generic
OS: Xubuntu 26.04

Problem:
Internal speaker audio cuts out after approximately 12 seconds of=20
playback. The issue also occurred under Windows 10, suggesting a=20
firmware/hardware bug in the CX20585.

Root cause identified:
Node 0x1f (Speaker Pin Complex) transitions from D0 to D3 during active=20
playback:

 =C2=A0 Node 0x1f [Pin Complex] wcaps 0x400501: Stereo
 =C2=A0 =C2=A0 Pin Default 0x90170110: [Fixed] Speaker at Int N/A
 =C2=A0 =C2=A0 Misc =3D NO_PRESENCE
 =C2=A0 =C2=A0 Power: setting=3DD3, actual=3DD3

The following command immediately restores audio:
 =C2=A0 hda-verb /dev/snd/hwC0D0 0x1f SET_POWER_STATE 0

Note: setting power_save=3D0 for snd_hda_intel does not prevent the issue.=
=20
The pin returns to D3 regardless.

Workaround: Manual execution of hda-verb after each audio cutout.

Request: Please consider adding a quirk to keep Node 0x1f in D0 for the=20
CX20585 (Subsystem Id: 0x1b0a20af).

Thank you for your time.

Best regards,
Thomas

