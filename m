Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0A9D58CA3
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Mar 2026 21:32:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B26B601F7;
	Sun, 22 Mar 2026 22:32:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B26B601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774215162;
	bh=kifwpPfpLLdz5iArTxlV4suLcrHuQN67kLinWsiczcE=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=MkV4X5kCfNbcPfTdgCYV9FljkTyJwagjLNnddUe3NDOOKKlHlKVDkueAIb1ifDWPh
	 oVofuea7Qcu2LDmb1b2lAj6ohefNgqhD3Jdel8BCwJ/daT3NAGAPXHR/tKeXszA2rt
	 k7/if9x+nXZ7ugRzP7zB5tvI7XBnV+t/yU8pyjLE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BE542F805F6; Sun, 22 Mar 2026 22:32:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5844BF805F5;
	Sun, 22 Mar 2026 22:32:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C8E0F8047D; Sun, 22 Mar 2026 21:51:39 +0100 (CET)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D5A20F8014B
	for <alsa-devel@alsa-project.org>; Sun, 22 Mar 2026 21:51:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5A20F8014B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=Lse/tO+w
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-79800183233so42213907b3.1
        for <alsa-devel@alsa-project.org>;
 Sun, 22 Mar 2026 13:51:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774212693; cv=none;
        d=google.com; s=arc-20240605;
        b=Dx7t2tqOyqnrDwVTlafg0zDQL91Uug5pDhROCvGemtUU6r6zJXEdmCpGgPxsqR4Mr8
         y/bqkyGqVW+gg5v5slkxSQXa8NgUaWhDcphoKTXnUMSoYiEVvFYFbhTbQMHArRClCORN
         Se8rws1OBFEChFcgXy/SQlX4KMLEODf/O4Qxt7a6Z8S9jzrDrOznWts0ayN8qmloKI4Q
         ZADSaqECHW97rKPgt316kkakkkeLSXc7vh0jmDZBSNT+i3pjr7IW6B10wMKPNc13VE3v
         +bkovpq5roVOhRr8pkm9Hgzc8jUWzvM3tHhjGQzDnI1f/9US+gUN5uRhwq2yGv9G00qE
         I5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=kifwpPfpLLdz5iArTxlV4suLcrHuQN67kLinWsiczcE=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=Lzk+Kdxe8lM/E6j/Jx1q9bRJle/0RviBWw9eootiWwRfKhPIoAOL5C/zQ6Khc1S5TZ
         Q4gAfLpsfkfLvdueZiulHSASAMTVJkUWLVFv+nAQT77Y1Ntjdz32zrOFUJt/bdMWQkAo
         Jg7SfR4UxeGYThRGIBIUHR+3pfR+VWC9nYbsF/H8EXi0C3XCRqin69OriY8iBKtaHh/p
         F1VPpQAklCx9hPL0FJmeFeqgg7oMiQjM6JsQfkfQ25NhSn2haKF7I++4f/pWFpFYpG0m
         9raI2wchAe3wRlKsTnVzHXOL634kX/FJlk3EbvpbgLTD956VssuQvcS2eqELfezNS+J4
         B+Fw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774212693; x=1774817493;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kifwpPfpLLdz5iArTxlV4suLcrHuQN67kLinWsiczcE=;
        b=Lse/tO+wjlI3QKNItN0+xNOh5qiKxP8lO41jLkHIF6tk1c0yHx4UeVlkHnK5cFM9Zr
         uRdGWRFAA0JSRxPgwESfwbFeyGV20w/vN3zMhGQbdxAINVc6lL0bnwdLSg4BoV6e4cOQ
         I4/ptKPHVprwz6XotMg1E0R+gsgpczH9Tg17ulivIqF0npXX5RJEN6ZTdGFpS4hZDHK5
         9KYbmhUW6CO2/ASXIOMbFtfc1/Mu8yN0tdnnJu64LJcHw81YsFxnSDYmLe4mwUat2om3
         O3owek9NR2jzAaFiq3+fY2ZOn7DN3PRS8v5Q9thtqjeUyc2K0t82Kk3cYbnzf0qylYQ1
         oIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774212693; x=1774817493;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kifwpPfpLLdz5iArTxlV4suLcrHuQN67kLinWsiczcE=;
        b=GGDdlEHwN+hwmEOC35xgU9niO2IuJwEXBqM5CMN8CFT9rvqWdJ0jCzLe3dTrgEwkSH
         IiBucos1WnxQZEJ3U/Gev8KnSL/YfKWu6995nh9KC8qrkTAxPN7uzpSEo+HKfCAE7P1s
         bBXgkfF5rO0nBaYYKzUiN28TgCF4Sq7IgxcS5jgwMAZG1yF5l9GukMCCr2oSXb6bYemP
         bjKfemb3PR2DaQHxT6VFBTSRwDNoRvjG6gMRionflh/+oPHfaiKLyvYZW/tOMw10Sx4z
         sqNmKqFV5EjKYNnBKLDGzYJe2x7giI8CiG6+Z3YSSPmMXQ6Ug6h28QeeWjC9FwmOuoyy
         5CeA==
X-Gm-Message-State: AOJu0Yzt+7BlkbM1nZLEVZLBg3nP+FkEnRI3HTTHhc49qg8YGLOMkuxi
	dTken9vaR3si95OptJCzl2h4gdsCixICk3Q3QHkSjVVBszKaBqvw24h4MMMDUc+PsdupvY8cJEN
	GjxxDZgpEJm/IXK3XFG62d5lYpyZamb7cgqCL1XM=
X-Gm-Gg: ATEYQzx4Onxc1IMwJwF0kee8eumLzqrINRFYq+yQsvjLz+VvIk/nV/m4hw2/uclPxPI
	wPN82Z0Qak3vuBJyCaPNK7CyuR0Y3sYEbQBD+LHj4koWcSxRrz+yCfcyWyojeDHMA2DIfqyuH6p
	gmT5zpfaP94P0vJpMPwk/R4ZMPKK0L4rRJW+7b1u65cQOhLx5CKlCDvI33V6GBMnLiMTHkzG0fC
	64bnMRlbCZ1UGlcS1R/LkBYoiJWPzI5gh2kBWY1jAPgMH8KmApqdOV4erjVeGH+tBkTWG2+G04s
	S1wmxEfr7Ae4VA9ASLQz87EQyOzT2+/wMvgeI6DAaHve2AvfQ37Mrq9FJllPTsJg95vrW5nbYSk
	0g9GnnsfZWdqjmI+pC0jhMcYytUR0vANpEE+erE5qQz7N9GH0gSP4/vIIo6c=
X-Received: by 2002:a05:690c:6e83:b0:79a:8fa0:85fa with SMTP id
 00721157ae682-79a8fa08d16mr102050507b3.11.1774212693342; Sun, 22 Mar 2026
 13:51:33 -0700 (PDT)
MIME-Version: 1.0
From: Rob F <robfreundlich@gmail.com>
Date: Sun, 22 Mar 2026 15:51:22 -0500
X-Gm-Features: AaiRm5088G9tv2UFzcKrv0-Cy_77i1AleRoh3mvKeDY5x-VdzclYfcU04ousOlg
Message-ID: 
 <CADbP9YdthPAWizCaTy=5OnCKyAPNHWh8Lk_xjbJaapAGgnqVKA@mail.gmail.com>
Subject: [QUIRK REQUEST] Add Native DSD support for McIntosh HD USB Audio
 (2afd:0005)
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: robfreundlich@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: MTYPKKHUOBYP2XIJJ3DKZZUWWRRTSFLF
X-Message-ID-Hash: MTYPKKHUOBYP2XIJJ3DKZZUWWRRTSFLF
X-Mailman-Approved-At: Sun, 22 Mar 2026 21:31:57 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MTYPKKHUOBYP2XIJJ3DKZZUWWRRTSFLF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello ALSA maintainers,

I am requesting the addition of a Native DSD quirk for the McIntosh HD
USB Audio interface (found in the McIntosh DA1 Digital Audio Module).

The device currently functions perfectly for PCM and DSD-over-PCM
(DoP) up to DSD128, but is not recognized for Native DSD. On Windows
via the official McIntosh ASIO driver, the hardware supports Native
DSD up to DSD256.

On Linux kernel 6.12.75 (aarch64), the device is identified as follows:

lsusb output: Bus 001 Device 003: ID 2afd:0005 McIntosh McIntosh HD USB Audio

The current /proc/asound/card/stream0 output shows only PCM formats:

Playback: Status: Stop Interface 2 Altset 1 Format: S16_LE Channels: 2
Endpoint: 0x03 (3 OUT) (ASYNC) Rates: 32000, 44100, 48000, 88200,
96000, 176400, 192000, 352800, 384000 Interface 2 Altset 2 Format:
S24_3LE Channels: 2 Endpoint: 0x03 (3 OUT) (ASYNC) Rates: 32000,
44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000 Interface 2
Altset 3 Format: S32_LE Channels: 2 Endpoint: 0x03 (3 OUT) (ASYNC)
Rates: 32000, 44100, 48000, 88200, 96000, 176400, 192000, 352800,
384000

Could this device ID (2afd:0005) be added to the quirks.c whitelist to
enable Native DSD support? Please let me know if any further testing
or USB descriptors are required.

Best regards,

Rob Freundlich
