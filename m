Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6D8C4451C
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:41:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 224A160236;
	Sat, 18 Jul 2026 11:41:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 224A160236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784367706;
	bh=NOx5rRU/4S2NJ1ac7LwSUwiMQnwDCSWjXAaGgpElW2o=;
	h=Date:From:To:Cc:Subject:References:List-Id:List-Archive:List-Help:
	 List-Owner:List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ERWmsX/4DVv5WawfgsJKayzOsQaANfZfugw6hy4WPHCIbiHK6fsUnWqg4D2cDR3/q
	 88wbsk0ovG6LzGCvom6KdnlTEO4Zeh6LuoYGQEodu/b0EEo70Lg/uGEJcy3yvPgRS7
	 iGb6YY9X86yprqASRRCeHpgmXVg2gwsT3K0R4VXU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E91BF80686; Sat, 18 Jul 2026 11:40:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D3505F80685;
	Sat, 18 Jul 2026 11:40:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 05385F80526; Fri, 17 Jul 2026 05:18:14 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=182.22.18.197
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784258291;
	b=LVpF6bhHWL3EtU6JS0PzGVjQZBYixDqN5klBR08ZR0nk13Tn9tFW15GquuiXD6jEu4QY
	 /otrT7JzKpCtD6YGFxD52ktLfyZg8e6Dw50RJxzbFDcqu5/kLJskTfeg7i4K3mSdBp1Mz
	 HlhntoCNN4b1UU3iSDTe/mcSSAAxQJVam+nzhbMXIsWGbpVVpXELCBcDs6VMt2+vjiAKC
	 O9R2K+e4xDptvTh+NX/8yODDGyuDxCjl34QsrEMHydGav60GPOTOnxNnXjWszGYgvgdJD
	 WkbvkiOSlCkJZ4WI5QUWzLS+BqTrWAc+0UypDBmjimtGOIG5w8w8Y/gBHs8wD9RDj2g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784258291;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=NOx5rRU/4S2NJ1ac7LwSUwiMQnwDCSWjXAaGgpElW2o=;
	b=XWDi5kyRhAtB/j7LXT3jWmxxCVWWuInXVqfd+Qv6aXIW9wtQlolJMInT/pbRo4DVUEQS
	 V8zmOY49OR5U+F1g5/7Jzl3D2FCkaIk+dpp7MVtmVADWqD+KXkYOd/vPUCZyEzYoxe5HR
	 n8GinOHx4pzKn/G9VbvoEmoa09EV7u1iIq2xCtZ2JrCRWPOuP4P0GIx3eE8w2l7MbyXD3
	 jcFT6lQFjWoXL4xTvUGn1DQYVkWNrc20AGIwAoYKygVKQcsO58iVvFXehCVfL5y5mTCwI
	 fDwLvTOuT+uNtexXeqT2vHtcor1efvN3iDtTuygasxvOvPquOwtV9WI0UQVec7S3E7Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=yahoo.co.jp header.i=@yahoo.co.jp header.a=rsa-sha256
 header.s=yahoocojp-202506 header.b=aUmfrjqu;
	arc=none smtp.remote-ip=182.22.18.197
Received: from omggw0012-vm0.mail.otm.yahoo.co.jp
 (omggw0012-vm0.mail.otm.yahoo.co.jp [182.22.18.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5D33FF801F7
	for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2026 05:18:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D33FF801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=yahoo.co.jp header.i=@yahoo.co.jp header.a=rsa-sha256
 header.s=yahoocojp-202506 header.b=aUmfrjqu
X-YMail-OSG: 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
X-Sonic-MF: seiji_adachi@yahoo.co.jp
Received: from sonicgw.mail.gze.yahoo.co.jp by
 sonicconh6102.mail.ssk.ynwp.yahoo.co.jp with HTTP;
 Fri, 17 Jul 2026 03:18:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784258278;
	s=yahoocojp-202506; d=yahoo.co.jp;
	h=References:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date;
	bh=NOx5rRU/4S2NJ1ac7LwSUwiMQnwDCSWjXAaGgpElW2o=;
	b=aUmfrjquhaXKHBCptKSigPM/rHvbFUekoHqRbdSEQNNJhZMfAopWoW0nCz4nl6sA
	W7CB5yTwXkHJaK7xuIbdD7bRSXw0WDXL5FTYp2fbEn7qCvDc1dP1Hma2IpSOqGk5g1J
	L5HGDFa6VpdggLc0hH1VhASWKwfncCCM1gB/NMPw9f6LbeAWpT+oUp6zMD8xEXeQ9RT
	EJ+iFEd+c3K+MaQEzY/IUGty7GVhxSpjXSDZwszLY//67+uVbyfYlwtNbiSAdY+51LD
	PUSAtyNnRYcQRxHMW3xcpLjPyPvyJ2t1w1CAR/t2629sINoRle083g6WiWhjRSu3Wlw
	PfdpH9FyHg==
Received: by smtphe6002.mail.ssk.ynwp.yahoo.co.jp (YJ Hermes SMTP Server) with
 ESMTPA ID 70ce719faf41e88f207060056e2155be;
          Fri, 17 Jul 2026 12:18:02 +0900 (JST)
Date: Fri, 17 Jul 2026 11:17:58 +0800
From: Seiji Adachi <seiji_adachi@yahoo.co.jp>
To: alsa-devel@alsa-project.org
Cc: Seiji Adachi <seiji_adachi@yahoo.co.jp>
Subject: [PATCH] ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2 (21JN) to quirks
Message-ID: <almeAbvirJwQ5doF@adriana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
References: <almeAbvirJwQ5doF.ref@adriana>
X-MailFrom: seiji_adachi@yahoo.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 2SJIGPTP672WA5WJGUPPNA4ZE4HRHYLI
X-Message-ID-Hash: 2SJIGPTP672WA5WJGUPPNA4ZE4HRHYLI
X-Mailman-Approved-At: Sat, 18 Jul 2026 09:40:24 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2SJIGPTP672WA5WJGUPPNA4ZE4HRHYLI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

I have a Lenovo ThinkPad E16 Gen 2 (AMD Ryzen 7 7735HS) with machine type "21JN".
Currently, the internal digital microphone (DMIC) is not detected on Debian 13 (kernel 6.18).

Similar to the "21M5" model, this "21JN" model also requires a DMI quirk entry to enable the internal microphone.

Could you please add the "21JN" model to the quirk list in `sound/soc/amd/yc/acp6x-mach.c`?

DMI info:
- Vendor: LENOVO
- Product Name: 21JN

Thank you,

Seiji Adachi
