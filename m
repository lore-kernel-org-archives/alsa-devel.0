Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CECCA0FFE
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:13:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63720601EC;
	Tue,  2 Sep 2025 12:13:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63720601EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1756808031;
	bh=tXG90RW+oXYa96MCp5cAXkyfLjtBPEQG4RRX5DWBbac=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=TN/b/xVPYMWvaYYAM9lyqQP0brOqbJ1Ra6YwuSCPC4CmGeYy2NzPluOT8u90bu8Q1
	 M4tJygqzPZqQ8KH6Qml5QIuRSiFzVm9cQ7tzfybRgxlEx0n7psBG4JCVuB7XAV2cBN
	 0eiF8GQjadmyo7sVxEeR24txjrVdRIw5jBNOzp2c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76B64F805C3; Tue,  2 Sep 2025 12:13:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B29DF805C7;
	Tue,  2 Sep 2025 12:13:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E345BF801F5; Tue,  2 Sep 2025 12:12:08 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 26828F801F5
	for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2025 12:12:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26828F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=l9OcGiwF
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-76e1fc69f86so4637753b3a.0
        for <alsa-devel@alsa-project.org>;
 Tue, 02 Sep 2025 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756807924; x=1757412724;
 darn=alsa-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tXG90RW+oXYa96MCp5cAXkyfLjtBPEQG4RRX5DWBbac=;
        b=l9OcGiwFpRG0+AOOR9FQVFQ2fgE24wA8e23URu2iGuTD2sHNEKbwuhUwS+kwyjE6gv
         YNsvf/ZEHsIbgWwkzKlzGLIC6Z2GQt6zUIYC6SvaD/dI51pxBZclgM1du3QfnEEBW4rs
         TLDE5eptDaulVNWI2/oYdcCYvzbpm4cBNHe9fx94TTLhWzaeLEVwuBGmiQ43hnpj26p6
         QMWoRv/Z1mrlOmTNHZBExtani9amTfhhSvR4nvO8E10oQgZWsicjLY0ZXL+bUbZvmIbi
         +8gDKHXDtG+wZ+a8NjWWWAAh1lYtxPaOPm6L0Td3lDuF+j2gZjx2YXsvb8GqqeryGtrV
         Akeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807924; x=1757412724;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXG90RW+oXYa96MCp5cAXkyfLjtBPEQG4RRX5DWBbac=;
        b=T7nQFbrgPRsPijzEEBBlRecHJKcSxBVbYkC1/auOr+3HsvUwex6r00NE/72pw5GsKA
         5rixU1mRxHFJ1vnfXRWyHNyjBJca84a65R7fdb16cMnQKIGt4gpGfF7F9rbl8/q2Kd4i
         6oowIsCAZiPaNyKlie9d89r4ZZqJF65+K6S5fJDeBSmPhdDlDa3EQArygAvjdvQT83IM
         VZJq6BxcyQY6alTbedvXSIfd+KipxZkkmCu4+WEFp6RxGMlHYGHrc4krdOR8FVVgdoiX
         gmZFE/Kx0xTphuoX+XxPqK3G/7M7ha5bANVd0VWvZp8SjMPyoSiTGTJtIM+EOnFb3nFR
         BUWQ==
X-Gm-Message-State: AOJu0YzSsx1wUXJ4K5VybZM8R1/TsIpJXpxFDbVxYyuGw5N7///qN5Xu
	kmxMv8+5qdxFg9U7BuWBc4SpAmjTxp1SjZRgU717TCOqEq+N5u4XVEAT8/z6nMfrJQOkTrs98Aj
	jUO7YfANh+in1fKEK7/pKaTEKorztCr+z8wZJSxvzgQ==
X-Gm-Gg: ASbGncsPIA45caVpwz7BXkMnU/okSNUhyuN/aJF7TTrc4uKGPHEuYZ41Q2mafZg8/zz
	P62tcbDUWOxnCl2gUpYolxvZrbreD01tfjwLlkIJ51C/bgtA2hdZCrUNqu1AjV+B+DWlQO2Eyo/
	zuXq/LpQGPJa0ytSJfQKILO4T4f00g03+pfbN4WuVRIdXP/M6y23X/t/pwrHamNm+8pW1yzUXlR
	E60tA==
X-Google-Smtp-Source: 
 AGHT+IGtKO/nLrd0pns0lHlz5h5syqpIEQ8b9I0sKfEF+jddMI80/OvPuR0GlVEiMsANKn6z6iE9VIxFIE9KtPrRn5k=
X-Received: by 2002:a05:6a20:7490:b0:240:792:e87a with SMTP id
 adf61e73a8af0-243d6dc18c0mr15167055637.3.1756807923427; Tue, 02 Sep 2025
 03:12:03 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0JrRg9C30L3QtdGG0L7Qsg==?=
 <zloy.technic@gmail.com>
Date: Tue, 2 Sep 2025 15:11:52 +0500
X-Gm-Features: Ac12FXykzJ7eqwiSWql148Wle7s72EJKmWQe63mL9Zo26C8BNNIshebOSsWtJFw
Message-ID: 
 <CAAnsHS64Pt9N2Ct3D6X=f6JytCiii9ntQ=MYqvweC=QaFpXPNw@mail.gmail.com>
Subject: 
 =?UTF-8?Q?=5BBUG=5D_ALSA_FireWire=3A_poll_timeout_causes_JACK_to_sto?=
	=?UTF-8?Q?p_=286=2E10_=E2=80=93_6=2E17=2Drc2=29?=
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: QPZBO7D7N2SC4ZK7P534B35FFK4NB6J6
X-Message-ID-Hash: QPZBO7D7N2SC4ZK7P534B35FFK4NB6J6
X-MailFrom: zloy.technic@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QPZBO7D7N2SC4ZK7P534B35FFK4NB6J6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

________________________________

Hello ALSA developers,

I would like to report a reproducible issue with snd-fireface on Linux
kernels 6.10 through 6.17-rc2.

________________________________

System Information

Kernel versions tested: 6.10 =E2=86=92 6.17-rc2

Audio interface: RME Fireface 800

Driver in use: snd-fireface

Audio server: JACK (tested with jackd and QJackCtl)

Distribution: Debian 12

Kernel config: ALSA FireWire drivers enabled, no FFADO in use

Chip 1394: Texas Instrumets

________________________________

Steps to Reproduce

Boot kernel 6.10 =E2=80=A6 6.17-rc2 with snd-fireface loaded.

Start JACK with ALSA backend, for example:

jackd -d alsa -d hw:Fireface -p 64 -n 3

Use the system normally =E2=80=94 during playback, recording, or even when
idle. The issue may occur at any time without apparent external cause.

Actual Behavior

After some idle time, ALSA stops responding and JACK prints:

ERROR: ALSA: poll time out, polled for ... usecs
ERROR: JackAudioDriver::ProcessAsync: read error, stopping...

JACK immediately terminates. The Fireface 800 does not recover until
JACK is restarted.

________________________________

Expected Behavior

The ALSA FireWire driver should maintain the stream and allow JACK to
continue running without manual restart, even when idle.

________________________________

Notes

With FFADO backend (jackd -d firewire), the same hardware works
reliably and does not exhibit this issue.

This suggests that the problem lies in the ALSA FireWire streaming
engine rather than the hardware itself.

The problem has been reproducible across all tested kernels (vanila,
rt, liquorix) from 6.10 through 6.17-rc2.

________________________________

Request

Could you please confirm if this issue is known?
Is there any ongoing work on the ALSA FireWire streaming engine
(snd-fireface) to address these poll timeout conditions?

I can provide additional logs (dmesg, journalctl) or test patches if needed=
.

Thank you,

Ilya Kuznetsov.
