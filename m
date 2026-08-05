Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC764C55174
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:12:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B96E7601F9;
	Wed,  5 Aug 2026 07:12:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B96E7601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785906765;
	bh=kJsr4OENXIKX0OxLfE8PR1cQffiNRr4DgxaIO3Sahmk=;
	h=Subject:From:To:Cc:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=nydytTkXnzAkqQG9peOx2EU3WdVjuJSNNyhD0ahGU9+6iWQULBM/IW1YUYUpkk36z
	 GwIKo2e2A9uBaSSLhnVz8A/lqDWENNpclkTFJf1+UtFwGhPIYfIHtgSbzUt5QtF09q
	 gppXjuPTJNF6XtO4wGGrUM11q9NcdNqQr7WKejnc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0BA3CF805F1; Wed,  5 Aug 2026 07:12:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AAD2F80600;
	Wed,  5 Aug 2026 07:12:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69C0BF8027B; Wed,  5 Aug 2026 07:12:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785906718;
	b=RSKqRDPrtmPRpnVsheKPqvAayBHIDddrHOyfNJvtqKdPbwsrGF/GDGwwZOeZ/PVRJRZX
	 Oe9F6cMLOAQgWiwLdRwk4DYo9gUvxm3nYTzCoC0vY69BOYRT0/WVkrJgRw32twZBy/8sa
	 G2IvLAGcTmyLTu26fQz+n1wuFU1s4ijWIFtGdBLAssbrmXSGF1FDXvn+cLA60XUx9UmfU
	 HWRNYq+ozQZgifpXSsAZqvNmKeAD5HS5TaV+Yf58Q54b8nSboG9P5Ay+V9/GC90Cm82kP
	 vOBysoWbzUxID6hRfEIHZiJ61H9eW0hAC+o1EJ3Cw5lkqtTnZ4JOE7vmei4gwagNUCQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785906718;
	h=DKIM-Signature:Message-ID:Subject:From:To:Date:MIME-Version;
	bh=kJsr4OENXIKX0OxLfE8PR1cQffiNRr4DgxaIO3Sahmk=;
	b=OzOaQvUUXXKpltdaY/UTIx5EWcSMmimdZfIL6BW2PEkLAhncbyZ2+1ttNptSKLK/hzxP
	 S4blhF1Er7pj8OB6vkP7Z8DgFOEddAtZXoTgkB/mSzeTC9NlkKOa/4JDvStxtM3GgIh4K
	 Qo12NWX0X+G70JUnBHt3t7o7hUpaHvqqHsOx6vroNKVN8XpettBC/l1N9GNTxxdKgFp3T
	 0UvrPyJc2PDmehYcKxhDHsniyIIjzw0IPyO3D5+3priT0l5SP//UsglVCHiNrCCUvs72K
	 dqlpvDsogBWZXrJWiEdlGJCPihnCqK/kgGo1zpQbFpJistslDOP8EyO4zsQ+cyzo9+A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JXAah4zZ;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A0486F800AE
	for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2026 07:11:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0486F800AE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JXAah4zZ
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-848643382fcso619737b3a.1
        for <alsa-devel@alsa-project.org>;
 Tue, 04 Aug 2026 22:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785906715; x=1786511515;
 darn=alsa-project.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kJsr4OENXIKX0OxLfE8PR1cQffiNRr4DgxaIO3Sahmk=;
        b=JXAah4zZ0EOaCOebbyQbKytBrmjRZQSl8FWqPAGQDDBoLJ0r6kC+EBxsmaf+/jSUAa
         T9EeO+sHaPqdGp7GguN2Z/QD4FH5ngBs/I2JGM61KAiq5wqmpvbyfOqEMNpEl1o1FAy6
         CdBxM+3EE2+aLgFu3lMwo9QVVNJGrtoE8XCSSM3LMtlMTrR4fpOvo/K2lq6Wf2MLLPOR
         RN3xqyw1Hkx9zoXc4LIJBOGdJaTib0/pTFrsjfafFnW2AIbYburQpias6CGZ4NIv4gTm
         /ijYMYBx9LcmbjcLZT0EnkFF6dTxRq+6mXiiuZrp6Xhyn7pLLJJIhfOqgd+ChfThukVo
         yUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785906715; x=1786511515;
        h=mime-version:user-agent:content-transfer-encoding:content-type:date
         :cc:to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kJsr4OENXIKX0OxLfE8PR1cQffiNRr4DgxaIO3Sahmk=;
        b=PkNSeAaCO8ICE3iLrhf4VyB4dRZuZIM7IOLsqwZ6x/EI8z/w6yb1rOZRXe4Wafm1x7
         4Yj7ntFUaAooh7ad8RGk6JZYyQQfu5kUVsrobEEAb9tQmfTA4zQ/I7S+zc/WL/eX1kjv
         ailvjnODMuGGrgojocxZdBbzd9+8Vkr/MHIgSaFCiibYZSoYNKT9foxA8jkOPD/0CzlJ
         E+DfV/2845w7qCaH5kczuAcizltAINH4OS3UpDlbThprcxNzLjZPCeTHATZ434Y8ES5h
         O17E/rLyjXYMVKwegEqn8hTdTCHsj6FuDWqcGKgaZHBNvvv/GB9FFrA374gc+5QbBBnN
         FI8w==
X-Gm-Message-State: AOJu0YwPpvfDW/7zRnpuRFJWedWCFYKFqhhGxYLd8cFL1glQoT5J+Rx0
	kctysJErpyPjQcEnZIow1AXGlWaoCKfQN5z5fnhhJtjdDdqPdlpsdDveaj9f7w==
X-Gm-Gg: AR+sD12tZGclIii466rcSOJ/ZKdW1O+XUxkgUPdT87/GDdm+g6bHuarbW3fz+RqkEaW
	NQ0hrtaxWZKOX7ZkS1TaAhiM8R22Oe3GoZ6BXi8JkT+C7MKMfaQ/ushhrJDCU2rkMsUHHkAuJlc
	NVxxupKNwVjfc9r6QmeaapNpi7cQXO0vWR39Xywpk0+5t+pKhuYnAwcg+w3gQtyiVZVxjuZqY7u
	qd1npYosmVmmW5qFNuc0aUGfGMeCJk4RMAJ9Yz0N0lE55dg7BOC3TJAqVleBBWDBuv3LdL1qaXc
	JeyYl0cyhyOJvirBwqpk6NGPLLFz/hy5NuSaTQVyaeu7r5Gy0Ig1b7XB6IO/g/pvSPFuhnJZUeO
	Fj9w2XNB/0XxSCxZnuHKQSV9zo6ompz8icnA5ykp9x1LJYMNIAwK6LOlSbasSfNpr7nG02OxgV7
	j31rhCOkHQ2KrjKP4LIslN2GHCSKMDGSsN+7eFfW3y/3SIytth4ZFE8M2oB+xLNQ==
X-Received: by 2002:a05:6a00:302a:b0:848:7443:f2de with SMTP id
 d2e1a72fcca58-84f2dff77cbmr4720199b3a.13.1785906714982;
        Tue, 04 Aug 2026 22:11:54 -0700 (PDT)
Received: from [10.10.0.107] ([103.185.193.249])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f2e2e3e29sm442055b3a.22.2026.08.04.22.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:11:54 -0700 (PDT)
Message-ID: <a96a0f35ee12b91d84b92521388bd7a032beab70.camel@gmail.com>
Subject: cs35l41-hda: PUP_DONE times out on ASUS UX3405CA (SSID 10431A63)
From: "luqeckr@gmail.com" <luqeckr@gmail.com>
To: alsa-devel@alsa-project.org
Cc: patches@opensource.cirrus.com
Date: Wed, 05 Aug 2026 13:11:51 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
Message-ID-Hash: I4IPX3732CMWYQBTFKUMEHI6OM6ANSK6
X-Message-ID-Hash: I4IPX3732CMWYQBTFKUMEHI6OM6ANSK6
X-MailFrom: luqeckr@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I4IPX3732CMWYQBTFKUMEHI6OM6ANSK6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

Both CS35L41 amps driving the internal speakers on an ASUS Zenbook 14
UX3405CA fail every power-up with:

=C2=A0 cs35l41-hda spi0-CSC3551:00-cs35l41-hda.0: Failed waiting for
CS35L41_PUP_DONE_MASK: -110
=C2=A0 cs35l41-hda spi0-CSC3551:00-cs35l41-hda.1: Failed waiting for
CS35L41_PUP_DONE_MASK: -110

The internal speakers are completely silent. HDMI and Bluetooth are
unaffected.

Reading the amp registers during a failing playback shows that PUP_DONE
*does* eventually assert - the amps are not faulting, they are just
slower to bring up external boost than the 100 ms the driver allows.
Details and evidence below.


ROOT CAUSE EVIDENCE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Registers captured during a failing playback. Playback started, the
PUP_DONE timeout was logged at 11:15:26, registers were read at
11:15:28:

=C2=A0 Register=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 amp .0 (L)=C2=A0=C2=A0 amp .1 (R)
=C2=A0 --------------------=C2=A0 -----------=C2=A0 -----------
=C2=A0 PWR_CTRL1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 00000001=C2=A0=C2=A0=C2=A0=C2=A0 00000001
=C2=A0 IRQ1_STATUS1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
1400001=C2=A0=C2=A0=C2=A0=C2=A0 01400000
=C2=A0 IRQ1_RAW_STATUS1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 41406001=C2=A0=C2=A0=
=C2=A0=C2=A0 40406000
=C2=A0 IRQ1_MASK1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 7ffd7e3f=C2=A0=C2=A0=C2=A0=C2=A0 7ffd7e3f
=C2=A0 GPIO_STATUS1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=
0000001=C2=A0=C2=A0=C2=A0=C2=A0 00000000
=C2=A0 GPIO_PAD_CONTROL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 02010000=C2=A0=C2=A0=
=C2=A0=C2=A0 02000000
=C2=A0 AMP_GAIN_CTRL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 000002=
73=C2=A0=C2=A0=C2=A0=C2=A0 00000273
=C2=A0 AMP_ERR_VOL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 00000000=C2=A0=C2=A0=C2=A0=C2=A0 00000000
=C2=A0 VPBR_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 00000000=C2=A0=C2=A0=C2=A0=C2=A0 00000000
=C2=A0 VBBR_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 00000000=C2=A0=C2=A0=C2=A0=C2=A0 00000000
=C2=A0 PROTECT_REL_ERR_IGN=C2=A0=C2=A0 00000000=C2=A0=C2=A0=C2=A0=C2=A0 000=
00000

IRQ1_STATUS1 has bit 24 set on both amps, and CS35L41_PUP_DONE_MASK is
0x01000000 - bit 24. Power-up completed.

That can only be a late assertion. In the CS35L41_EXT_BOOST branch of
cs35l41_global_enable() the failure path returns without clearing the
status; only the success path clears it:

=C2=A0=C2=A0=C2=A0 ret =3D regmap_read_poll_timeout(regmap, CS35L41_IRQ1_ST=
ATUS1,
int_status,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int_status & CS35L41=
_PUP_DONE_MASK,
1000, 100000);
=C2=A0=C2=A0=C2=A0 if (ret) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(=
dev, "Failed waiting for CS35L41_PUP_DONE_MASK:
%d\n", ret);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cs35l41_=
test_key_lock(dev, regmap);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return r=
et;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* <-- status not cleared */
=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0 regmap_write(regmap, CS35L41_IRQ1_STATUS1, CS35L41_PUP_D=
ONE_MASK);

Every attempt on this machine takes the failure path, so nothing ever
clears bit 24. The only way it can be set is for the amp to have
asserted PUP_DONE some time after the 100 ms poll expired.

No fault bit is set - not bit 6 (BST_OVP_ERR), 7 (BST_DCM_UVP_ERR), 8
(BST_SHORT_ERR), 15 (TEMP_WARN), 17 (TEMP_ERR) or 31 (AMP_SHORT_ERR).
PWR_CTRL1 =3D 1 confirms GLOBAL_EN is set, and GPIO_STATUS1 =3D 1 on amp .0
confirms the VSPK switch is actually being driven.

I should be clear that this is an inference from the code path that
never clears the bit, not a direct observation of the bit changing. I
could not time the assertion: because the failure path never clears it,
it cannot be re-armed without rebooting for a clean baseline.


NO FAULT INTERRUPT HAS EVER FIRED
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Consistent with the above, the amps have never raised an interrupt.
Setup is correct on both sides: all 12 handlers (6 per amp) are
registered, cs35l41_configure_interrupt() does not emit its "IRQ Config
Failed" warning, and IRQ1_MASK1 =3D 0x7ffd7e3f leaves all six fault
interrupts unmasked at the chip. The parent GPIO interrupt is
level-triggered on hwirq 207.

Yet every counter is zero after hours of uptime:

=C2=A0 177:=C2=A0 0 ... 0=C2=A0 intel-gpio=C2=A0 207=C2=A0 cs35l41 IRQ1 Con=
troller, cs35l41 IRQ1
Controller
=C2=A0 197:=C2=A0 0 ... 0=C2=A0 cs35l41 IRQ1 Controller=C2=A0=C2=A0=C2=A0 0=
=C2=A0 Boost Overvoltage Error
=C2=A0 198:=C2=A0 0 ... 0=C2=A0 cs35l41 IRQ1 Controller=C2=A0=C2=A0=C2=A0 1=
=C2=A0 Boost Undervoltage Error
=C2=A0 199:=C2=A0 0 ... 0=C2=A0 cs35l41 IRQ1 Controller=C2=A0=C2=A0=C2=A0 2=
=C2=A0 Boost Inductor Short
Error
=C2=A0 200:=C2=A0 0 ... 0=C2=A0 cs35l41 IRQ1 Controller=C2=A0=C2=A0=C2=A0 3=
=C2=A0 Temperature Warning
=C2=A0 201:=C2=A0 0 ... 0=C2=A0 cs35l41 IRQ1 Controller=C2=A0=C2=A0=C2=A0 4=
=C2=A0 Temperature Error
=C2=A0 202:=C2=A0 0 ... 0=C2=A0 cs35l41 IRQ1 Controller=C2=A0=C2=A0=C2=A0 5=
=C2=A0 Amp Short
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (identical block for=
 the second amp, 203-208)

I initially read this as a misrouted interrupt line. I no longer think
so - the register evidence says the part simply does not consider
itself
faulted, so there is nothing for it to report.


HARDWARE
=3D=3D=3D=3D=3D=3D=3D=3D

=C2=A0 Machine:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASUS Zenboo=
k 14 UX3405CA (DMI board UX3405CA)
=C2=A0 BIOS:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 UX3405CA.314, 11/20/2025 (latest from ASUS)
=C2=A0 SoC:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Intel Core Ultra 200H
=C2=A0 HDA codec:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Realtek ALC294
=C2=A0 Amps:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 2x Cirrus Logic CS35L41 (35a40) Revision B2, on SPI
=C2=A0 SSID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 10431A63
=C2=A0 ALSA components: HDA:8086281d,80860101,00100000
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HDA:10ec0294,10431a63,00100004
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cfg-dmics:2 iec61937-pcm:5,4,3


SOFTWARE
=3D=3D=3D=3D=3D=3D=3D=3D

=C2=A0 Distribution:=C2=A0=C2=A0=C2=A0 Fedora 44
=C2=A0 Kernel:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7.1.5-=
201.fc44.x86_64
=C2=A0 linux-firmware:=C2=A0 20260622-1.fc44
=C2=A0 alsa-lib:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.2.16.1
=C2=A0 PipeWire:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.6.8 / WirePlum=
ber 0.5.14
=C2=A0 Driver stack:=C2=A0=C2=A0=C2=A0 snd_soc_skl_hda_dsp (SOF) + cs35l41-=
hda over SPI

Earlier 7.1.x kernels showed a milder symptom (see HISTORY); I cannot
confirm whether the PUP_DONE error was present there.


REPRODUCES ON A CLEAN COLD BOOT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Firmware loads correctly and both amps bind, then power-up fails two
seconds later:

=C2=A0 10:48:46=C2=A0 ...hda.0: Calibration applied: R0=3D10390
=C2=A0 10:48:46=C2=A0 ...hda.0: Firmware Loaded - Type: spk-prot, Gain: 19
=C2=A0 10:48:46=C2=A0 ...hda.0: CS35L41 Bound - SSID: 10431A63, BST: 1, VSP=
K: 1,
CH: L, FW EN: 1, SPKID: 1
=C2=A0 10:48:46=C2=A0 ...hda.1: Calibration applied: R0=3D10440
=C2=A0 10:48:46=C2=A0 ...hda.1: Firmware Loaded - Type: spk-prot, Gain: 19
=C2=A0 10:48:46=C2=A0 ...hda.1: CS35L41 Bound - SSID: 10431A63, BST: 1, VSP=
K: 0,
CH: R, FW EN: 1, SPKID: 1
=C2=A0 10:48:47=C2=A0 ...hda.0: Failed waiting for CS35L41_PUP_DONE_MASK: -=
110
=C2=A0 10:48:47=C2=A0 ...hda.1: Failed waiting for CS35L41_PUP_DONE_MASK: -=
110

Fully reproducible and permanent from boot. On an earlier boot the
first
failure came 11 s after boot and the only suspend/resume cycle happened
four hours later, so suspend is not the trigger.


BEHAVIOUR WITH THE DSP FIRMWARE ABSENT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

At one point the amps ended up running with no DSP firmware (see the
secondary bug below). In that state the behaviour changed
informatively:

=C2=A0 - PUP_DONE no longer timed out at all, across ~20 minutes of repeate=
d
=C2=A0=C2=A0=C2=A0 playback.
=C2=A0 - The speakers did produce sound, for roughly the first 4 seconds.
=C2=A0 - After that they went silent and stayed silent, with playback still
=C2=A0=C2=A0=C2=A0 running and no kernel message of any kind.
=C2=A0 - Reproduced deliberately with six 2-second pink-noise bursts, 1 s
=C2=A0=C2=A0=C2=A0 apart, at 100% volume: only the first two were audible.

"Forced Mute Status" was polled every 2 s across a 20 s playback and
stayed off on both amps.


PLATFORM _DSD IS COMPLETE AND CORRECTLY APPLIED
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I dumped and decompiled the platform ACPI to check whether the _DSD was
at fault. It is not. Device (SPK1) in SSDT17 declares:

=C2=A0=C2=A0=C2=A0 Name (_HID, "CSC3551")
=C2=A0=C2=A0=C2=A0 Name (_SUB, "10431A63")

=C2=A0=C2=A0=C2=A0 Name (_DSD, Package (0x02)
=C2=A0=C2=A0=C2=A0 {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ToUUID ("daffd814-6eba-4d8c-8a91=
-bc9bbf4aa301"),
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Package (0x06)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Package =
(0x02) { "cirrus,dev-index",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Pack=
age (0x02)
{ Zero, One } },
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Package =
(0x02) { "reset-gpios",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Package (0x08)
{ ^SPK1, , One, Zero, Zero,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0 ^SPK1, , One, Zero, Zero } },
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Package =
(0x02) { "cirrus,speaker-position", Package (0x02)
{ Zero, One } },
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Package =
(0x02) { "cirrus,boost-type",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Package (=
0x02)
{ One, One } },
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Package =
(0x02) { "cirrus,gpio1-func",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Package (=
0x02)
{ One, Zero } },
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Package =
(0x02) { "cirrus,gpio2-func",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Package (=
0x02)
{ 0x02, 0x02 } }
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
=C2=A0=C2=A0=C2=A0 })

Every value matches the driver's bind messages and the chip registers:

=C2=A0 Property=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Value=C2=A0=C2=A0=C2=A0 Meaning=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
Confirmed by
=C2=A0 -----------------------=C2=A0 -------=C2=A0 ------------------------=
-------=C2=A0 --
--------------------
=C2=A0 cirrus,boost-type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {1, 1}=
=C2=A0=C2=A0 CS35L41_EXT_BOOST=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
BST: 1 in bind log
=C2=A0 cirrus,gpio1-func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {1, 0}=
=C2=A0=C2=A0 CS35L41_GPIO1_GPIO / HIZ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
VSPK: 1 / VSPK: 0
=C2=A0 cirrus,gpio2-func=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {2, 2}=
=C2=A0=C2=A0 CS35L41_GPIO2_INT_OPEN_DRAIN=C2=A0=C2=A0=C2=A0=C2=A0
IRQ registered, level
=C2=A0 cirrus,speaker-position=C2=A0 {0, 1}=C2=A0=C2=A0 Left / Right=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
CH: L / CH: R
=C2=A0 reset-gpios=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 idx 1=C2=A0=C2=A0=C2=A0 shared reset=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
"Reset line busy..."

GPIO_PAD_CONTROL reads 0x02010000 on amp .0 (GP2 =3D 2, GP1 =3D 1) and
0x02000000 on amp .1 (GP2 =3D 2, GP1 =3D 0), exactly as declared.

So unlike 103C89C6 and 103C8B63 - where cs35l41_hda_property.c carries
comments about ACPI declaring the wrong boost type - there is no
evident
mis-declaration here to override.


NOTE ON THE DRIVER PROPERTY TABLE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

In sound/hda/codecs/side-codecs/cs35l41_hda_property.c (formerly
sound/pci/hda/), the entry is:

=C2=A0=C2=A0=C2=A0 { "CSC3551", "10431A63", missing_speaker_id_gpio2 },

identical in v7.0, v7.1 and master. Of the 40 ASUS 1043* SSIDs in that
file, 10431A63 is the only one not handled by generic_dsd_config, and
the only one with no cs35l41_config_table entry.

There is no cirrus,speaker-id-gpios in the platform _DSD, which is
presumably why the quirk exists - it supplies one from GPIO resource
index 2. Decoding the raw _CRS gives five GPIO resources:

=C2=A0 idx 0=C2=A0 GpioIo=C2=A0=C2=A0 pin 72
=C2=A0 idx 1=C2=A0 GpioIo=C2=A0=C2=A0 pin 208=C2=A0=C2=A0 reset line refere=
nced by reset-gpios
=C2=A0 idx 2=C2=A0 GpioIo=C2=A0=C2=A0 pin 206=C2=A0=C2=A0 claimed by the qu=
irk as speaker-id
=C2=A0 idx 3=C2=A0 GpioIo=C2=A0=C2=A0 pin 207
=C2=A0 idx 4=C2=A0 GpioInt=C2=A0 pin 207=C2=A0=C2=A0 level-triggered; match=
es intel-gpio 207

Pin 207 appears twice, as a GpioIo at index 3 and as the GpioInt at
index 4. I cannot verify from here whether index 2 is the correct
speaker-id resource on the CA variant; given the quirk appears to have
been authored for the closely related UX3405MA, that may be worth
confirming.

Also worth noting: "Using extra _DSD properties, bypassing _DSD in
ACPI"
is printed whenever cs35l41_add_dsd_properties() succeeds, but on the
missing_speaker_id_gpio2 path the platform _DSD is still parsed by
cs35l41_hda_parse_acpi(). The message overstates what happened and
initially misled my own diagnosis.


HISTORY
=3D=3D=3D=3D=3D=3D=3D

This machine previously showed a milder form of the same problem:
playback cut out for a fraction of a second roughly every 1 s, and a
reboot restored clean audio for a while. No kernel error was logged at
all then. If the cause is a marginal boost ramp against a fixed 100 ms
bound, that earlier intermittent behaviour fits: sometimes boost made
the deadline, sometimes not. It has since degraded to failing every
time.


RULED OUT
=3D=3D=3D=3D=3D=3D=3D=3D=3D

None of these changed the behaviour:

=C2=A0 - CPU governor (powersave -> performance)
=C2=A0 - snd_hda_intel power_save =3D 0
=C2=A0 - PipeWire quantum locked to 1024/2048
=C2=A0 - WirePlumber node suspension disabled
=C2=A0 - PipeWire RT scheduling (verified: SCHED_RR prio 60 via rtkit)
=C2=A0 - SMI storms (0 per turbostat)
=C2=A0 - Scheduler latency (no gaps > 30 ms over 15 s)
=C2=A0 - CS35L41 runtime PM (forced power/control=3Don on both SPI devices)
=C2=A0 - BIOS and linux-firmware both at latest available versions

Mixer state during failure is correct throughout: ALSA Master 100% on,
Speaker 90% on, SOF Pre/Post Mixer Analog 100% at 0.00 dB, PipeWire
sink
routed to Speaker and unmuted.


SUGGESTED DIRECTION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The 100 ms bound in cs35l41_global_enable() looks too short for this
platform's external boost. A longer timeout, or a per-platform bound,
would likely fix this machine.

If you can supply a debug patch that timestamps the assertion - or
simply raises the timeout so I can report whether audio returns - I am
glad to build and test it. I can also read back further registers or
provide any other debug output on request.


SECONDARY BUG: FIRMWARE LOOKUP FAILS AFTER A PCI REBIND
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Probably unrelated, but found along the way. Unbinding and rebinding
the
audio controller:

=C2=A0 echo 0000:00:1f.3 > /sys/bus/pci/drivers/sof-audio-pci-intel-
mtl/unbind
=C2=A0 echo 0000:00:1f.3 > /sys/bus/pci/drivers/sof-audio-pci-intel-mtl/bin=
d

rebuilds the sound card successfully, but the amps then cannot find
their firmware:

=C2=A0 cs35l41-hda ...hda.0: Falling back to default firmware.
=C2=A0 cs35l41-hda ...hda.0: Unable to find firmware and tuning
=C2=A0 cs35l41-hda ...hda.0: Cannot Initialize Firmware. Error: -2

With firmware_loader dynamic debug enabled, the requested names are:

=C2=A0 fw-cirrus/cs35l41--spk-prot-10431a63-spkid1-r0.wmfw
=C2=A0 fw-cirrus/cs35l41--spk-prot-10431a63-r0.wmfw
=C2=A0 fw-cirrus/cs35l41--spk-prot-10431a63-spkid1.wmfw
=C2=A0 fw-cirrus/cs35l41--spk-prot-10431a63.wmfw
=C2=A0 fw-cirrus/cs35l41--spk-prot.wmfw

Note the doubled hyphen. SSID (10431a63), speaker id (spkid1) and amp
name (r0) are all still correct - what is missing is dsp_name, i.e.
cs35l41->cs_dsp.name, which should be dsp1. It is empty after the
rebind, so cs35l41_request_firmware_file() builds cs35l41--spk-prot-...
instead of cs35l41-dsp1-spk-prot-..., and every candidate misses,
including the generic fallback (cirrus/cs35l41-dsp1-spk-prot.wmfw.xz is
present on disk).

A runtime reload via the "L0/R0 DSP1 Firmware Load" ALSA controls fails
the same way, so the amps cannot recover their firmware without a
reboot.

Separately, unbinding the HDA codec alone:

=C2=A0 echo ehdaudio0D0 >
/sys/bus/hdaudio/drivers/snd_hda_codec_alc269/unbind

tears down the entire SOF card, and the subsequent bind fails with
"No such device".


Happy to provide the full regmap dumps, the decompiled SSDT, or
anything
else useful.

Thanks,
Luqman
