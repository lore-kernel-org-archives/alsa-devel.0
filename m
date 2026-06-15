Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045F5CDB46B
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:44:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDD9460258;
	Mon, 22 Jun 2026 09:44:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDD9460258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782114281;
	bh=AUdimFTexxZwClYm/z6jwEfeqBrojqxOhlxN5l/yYBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=M3F64qRZX4Q3NlpPqJj0c3cZX30ncQWOZK7N/p4JEBVsbr8FKxZCE87MzbnTsHQZT
	 bqyUf+0/hks4PYqRuvceT1fn4WvPrqBT9WEI/YuOZ0O1oo1cOyLaUhdZXay4XNL2K9
	 N4+bUhi5Za7jkFIYEGr4Yjzf/gwIVwztTnGlyZSA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7D8FF8061B; Mon, 22 Jun 2026 09:43:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FE08F80610;
	Mon, 22 Jun 2026 09:43:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E05FBF8047D; Mon, 15 Jun 2026 08:07:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=202.108.3.212
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781503673;
	b=mEjMTrD011dYCNqAFk6EMzgYJTv+zn81iueBtfJFYI6VA2g4J4/vevtjOhP140Qgp4Zw
	 SPEk0WUCe/fPkTrulH0xazLTX8zFLWh3ZKJjgvDar8Bm1JY8cs/KwnzggGoyP2pDNksy0
	 EWCMItcs9dZxuEZq+Y6ZX4DtgU4nb5/bii7Zks/CjWdTpH7EYcc30SZZ3IuSqYJd5mHKi
	 U2kr1O8CMB1ogSE9cyuumDUCWAYmm72NxXLXgGgBVXrzuoYlxuHH3QBpno6S+th7Bsa7g
	 yRSx89P9Dqr9K+LD9ucz7nkZq8Yt8YqhVKsNPXYwrGIkLpFtvhLipzfSN2m71SFjpaA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781503673;
	h=From:To:Subject:Date:Message-Id;
	bh=AUdimFTexxZwClYm/z6jwEfeqBrojqxOhlxN5l/yYBo=;
	b=JMw1zlxOuKtMYZPQm5lxn+Y9HN0UmYJf7rccKpK12Vybd07+VBRqSMMHBkj3olxOxzGe
	 kcaqU573rFsjizjQZOLPSENAwDQ7OwXg5ULmXt/XIXcEF1KM8Vy+9ns+XxzlSHVxtV3XM
	 oNmHTitcj4saJE3VGd9v/jYg2JS/5vSang2KNz2NKd862LwdJNcIHqa4MAWwi3cyG9rEZ
	 l4U76PL2lbUqZTQ0IdotsCpwUNux7Tg2kSRx9bvO8sM1gVTBmJ6tcV6exV1i6PT8M45jf
	 crYIxoSH3L4ezsT9QIKRggOi1mMZxOst8Kovsgt3O2eFuOyYAukj+JEbDoE8jPZ/5Kg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=202.108.3.212
Received: from r3-212.sinamail.sina.com.cn (r3-212.sinamail.sina.com.cn
 [202.108.3.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3F50CF8010B
	for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2026 08:07:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F50CF8010B
Received: from unknown (HELO zy-virtual-machine.localdomain)([58.38.107.94])
	by sina.net (10.54.253.38) with ESMTP
	id 6A2F96B200002371; Mon, 15 Jun 2026 14:07:47 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 060A3B3A33EE4A8FBA7316C5896DBAAD
X-SMAIL-UIID: 060A3B3A33EE4A8FBA7316C5896DBAAD-20260615-140747
From: Zhang Yi <zhangyi@everest-semi.com>
To: krzk@kernel.org
Cc: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	tiwai@suse.com,
	zhangyi@everest-semi.com
Subject: RE: [PATCH 7/7] ASoC: dt-bindings: ES8389: Add members about HPF and
 clock
Date: Mon, 15 Jun 2026 14:07:44 +0800
Message-Id: <20260615060744.18775-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <fa710884-e66e-4ef8-bbbd-034eeef8ee62@kernel.org>
References: <fa710884-e66e-4ef8-bbbd-034eeef8ee62@kernel.org>
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: LJXPIJUX5H2PJNBBK6EBY372PPS5CURM
X-Message-ID-Hash: LJXPIJUX5H2PJNBBK6EBY372PPS5CURM
X-Mailman-Approved-At: Mon, 22 Jun 2026 07:43:14 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LJXPIJUX5H2PJNBBK6EBY372PPS5CURM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> >>> +    $ref: /schemas/types.yaml#/definitions/flag
> >>> +    description:
> >>> +      Indicates that SCLK is used as the internal clock.
> >>
> >> And what happens with mclk in such case? Is it still wired?
> > 
> > Yes, setting mclk-from-sclk does not affect the MCLK connection.
> 
> I am asking about wiring of the device. If MCLK is used from SCLK, but
> SCLK is used as the internal clock, then how can you still have MCLK
> connected?

If MCLK is derived from SCLK, whether the 'MCLK' pin on the device is
connected or not has no effect on operation.

> >>> +
> >>> +  everest,hpfl:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint8
> >>> +    description:
> >>> +      the HPF value of ADCL.
> >>
> >> Is HPF value in dB? If so, use proper unit suffix and proper units.
> > 
> > No, the values here correspond to the values in the registers.
> > The value is not in dB
> 
> What are the meanings of the register values?

The value of everest,hpfl is equal to the value of the corresponding register,
not the cutoff frequency of the HPF.
The code does not specify which register corresponds to which HPF cutoff frequency.
And we did not set the HPF to kcontrol because we do not want users to be able to control it
while the codec is running.

> >>> +        everest,hpfl = [0a];
> >>
> >> <0xa>? What did you want to say here?
> > 
> > I just wanted to give an example to show how to set the values of everest,hpfl to 0x0a.
> 
> So use syntax I asked.

OK

If you receive this email, please reply to me.
(I'm worried that the issue with not receiving emails might happen again.)
