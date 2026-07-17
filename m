Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB2DC4451B
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:42:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 81E0C6025F;
	Sat, 18 Jul 2026 11:41:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 81E0C6025F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784367725;
	bh=7AGhV14rm2f256BwBUsGZIQV7V8qNd71LUoJFxdXZ4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=f91RP1rZ7tT9U8fi6Qp5PfApIJySqS42cAcrkHekelZSJ8RcaZMpMsnEfaLUdcrC+
	 Q3fN2AS7uRUsHmYJ3rBSRR7J3u1aWGWDR0fH6eejMMS5MnCxaYv6vdH3hTnzXudczo
	 9l7LDKRGRFVbf62gzBrAR9RBpVU/NUc6fUO5rwcg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 817B7F806A5; Sat, 18 Jul 2026 11:40:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B47EFF806A5;
	Sat, 18 Jul 2026 11:40:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 34A9AF80526; Fri, 17 Jul 2026 08:22:46 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=182.22.18.10
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784269365;
	b=D/7Cd+Bxjq0VS171Ju3TZP6HSjKeWgsbTXvt8HiTcphig+NfConZ9DXPLbCWAd3SZH3v
	 SSkMIHPJLY9cjote94CF3meuJqMNeWTva5ibDbo2FVT6/eucxisHZXgGo0E1F6B6e3xAX
	 SDamLBusjAxVfQQ/+l+yDn7t+2EmjqunPfdEGHSbKm903RmaZFzJUIWpho/VRWlRw3xwX
	 6PUClndzjjhZj/ffRpnwL434grLiWVQZQhJi99ddhJt0b9tym0Y3SVMMWSzkKfo8IhjRS
	 ncJG8itV+FTBpk/+8Wo+yZVk99qrealrRgiPW+hjL9cdWKPdai6dDqajdVy5V4nD5IQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784269365;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=7AGhV14rm2f256BwBUsGZIQV7V8qNd71LUoJFxdXZ4Y=;
	b=QJt5WMr7OMMmQRppkcU5zs+kMUgJ+qIqItr2ZrRFFGwuypbwgxtoomakW0PsiTcfPMu8
	 CeylCX2+ik7k4JdifYNta1u1xyI3Qik2rk3nXd//XjskjOVTuGL4V53QjaG28IxzTk6NW
	 FBRwB2DhOoDp1F3mdASmCpIMn1YpqeSk05/XUMUQOxu7ZpBDCPQPUbJnaq6qmuxgVJOS0
	 o4MGS15wCGQcjwCaznToG339soV/ATF1XHXAD+m+eC+FO4BbJxMh7oZkq9jYWdL1Rhjng
	 93HwvazpLuTXShyT1w8rydDGn+bYwco3vEMTfQeAd4csR/9wB5eyOM94/4l/+MSS8Jw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=yahoo.co.jp header.i=@yahoo.co.jp header.a=rsa-sha256
 header.s=yahoocojp-202506 header.b=UOK15Yf7;
	arc=none smtp.remote-ip=182.22.18.10
Received: from omggw0003.mail.otm.yahoo.co.jp (omggw0003.mail.otm.yahoo.co.jp
 [182.22.18.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3D8D2F801F7
	for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2026 08:22:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D8D2F801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=yahoo.co.jp header.i=@yahoo.co.jp header.a=rsa-sha256
 header.s=yahoocojp-202506 header.b=UOK15Yf7
X-YMail-OSG: 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
X-Sonic-MF: seiji_adachi@yahoo.co.jp
Received: from sonicgw.mail.gze.yahoo.co.jp by
 sonicconh6102.mail.ssk.ynwp.yahoo.co.jp with HTTP;
 Fri, 17 Jul 2026 06:22:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784269347;
	s=yahoocojp-202506; d=yahoo.co.jp;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=lEDPHU/mD3ENYmCnvhUs4h9nl5s1w6A2lq1N+cJOstU=;
	b=UOK15Yf72NpLC8KAJqpvCBG/OdxaB7CAdCCgfu26Rm/DWsRLLF//kU7nKER0H6Ra
	EoeOihlaYxfGQlu7l/Up0qBm8cWpfrd6I+r3IrMVCQzgMvhJDMfcSvJQ65/bqRjUpCF
	IaC6w7EptbW0BaxFC9bAq2u+iXevN1FB2dkuLpbC19q0GcIfSPxTvdxBUSXd+MyMvZb
	PP7LMedeOXd+h5/aTBHQvrve4Sqer5qQlyvBkdkuc3wEcXQNwafvv9uNTdsg4nb1+iD
	RFjCWOkKviVXlHUTsnW4czr3NzJORUTk6+bYamDQXxGuYoSW0ciNLlixEmoblJGlSLA
	uXDCQyJjMQ==
Received: by smtphe6008.mail.ssk.ynwp.yahoo.co.jp (YJ Hermes SMTP Server) with
 ESMTPA ID 94dbaeacd1957ba93fc6154ed2d71751;
          Fri, 17 Jul 2026 15:22:35 +0900 (JST)
Date: Fri, 17 Jul 2026 14:22:27 +0800
From: Seiji Adachi <seiji_adachi@yahoo.co.jp>
To: alsa-devel@alsa-project.org
Cc: Seiji Adachi <seiji_adachi@yahoo.co.jp>
Subject: Re: [PATCH] ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2 (21JN) to
 quirks
Message-ID: <alnKI3bPaZUc6uwB@adriana>
References: <almeAbvirJwQ5doF.ref@adriana>
 <almeAbvirJwQ5doF@adriana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <almeAbvirJwQ5doF@adriana>
X-MailFrom: seiji_adachi@yahoo.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: KPUS7M6O332RIASF6YPZU2RKCRSDPFFL
X-Message-ID-Hash: KPUS7M6O332RIASF6YPZU2RKCRSDPFFL
X-Mailman-Approved-At: Sat, 18 Jul 2026 09:40:24 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KPUS7M6O332RIASF6YPZU2RKCRSDPFFL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

An update on this: I have just upgraded my system kernel to the latest available version, 7.0.13. 

However, the internal digital microphone (DMIC) is still not detected (`arecord -l` shows the same result as before). 

So the quirk entry for "21JN" is definitely still needed in the latest kernel version.

Best regards,

Seiji

On Fri, Jul 17, 2026 at 11:17:58AM +0800, Seiji Adachi wrote:
> Hi,
> 
> I have a Lenovo ThinkPad E16 Gen 2 (AMD Ryzen 7 7735HS) with machine type "21JN".
> Currently, the internal digital microphone (DMIC) is not detected on Debian 13 (kernel 6.18).
> 
> Similar to the "21M5" model, this "21JN" model also requires a DMI quirk entry to enable the internal microphone.
> 
> Could you please add the "21JN" model to the quirk list in `sound/soc/amd/yc/acp6x-mach.c`?
> 
> DMI info:
> - Vendor: LENOVO
> - Product Name: 21JN
> 
> Thank you,
> 
> Seiji Adachi
