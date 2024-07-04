Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0272C31D97
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jul 2024 11:54:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E30A014DD;
	Thu,  4 Jul 2024 13:54:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E30A014DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720094084;
	bh=dTKC+tb0olG4VJCQydQ53dLPfOfet/UrZUBd+pMbJWY=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Dt2m9W+pHD/gG6qvvIBIS1fHuWoW+sDrOu/GMkrbkedyQobhP2HBPVy4WR3wyKqyA
	 UAdCoL7H9BhZhiJAB5wODZgDu4coII42SHq1QDV+2Tey5waf4/eUT0t7H0FFFwy4xX
	 oO9kiwumRb6juyKd/7O0PPEV+TAnv2m7fEA5eoQc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87CB7F805B3; Thu,  4 Jul 2024 13:54:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A6D7F805AD;
	Thu,  4 Jul 2024 13:54:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 05E6DF80272; Thu,  4 Jul 2024 13:54:08 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id F27A5F800F8
	for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2024 13:54:07 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [alsa-devel] unsupported variant of snd_hda_intel
From: hobefaj342@devncie.com
To: alsa-devel@alsa-project.org
Date: Thu, 04 Jul 2024 11:54:07 -0000
Message-ID: <172009404799.20.2114839556176931017@mailman-web.alsa-project.org>
In-Reply-To: <AANLkTik3nGq22b0t+f3NMn23CK7x5b+hLJpaW9rjhr0Q@mail.gmail.com>
References: <AANLkTik3nGq22b0t+f3NMn23CK7x5b+hLJpaW9rjhr0Q@mail.gmail.com>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: LPOBJQLH6CXMSB5ZTXM25QWYQBBHNU5Z
X-Message-ID-Hash: LPOBJQLH6CXMSB5ZTXM25QWYQBBHNU5Z
X-MailFrom: hobefaj342@devncie.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LPOBJQLH6CXMSB5ZTXM25QWYQBBHNU5Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Make their birthday shine with our sparkling selection of birthday cards! Whether you're celebrating a milestone or simply sending well wishes, our collection has the perfect card to add a touch of joy to their special day. Send a heartfelt message and make their birthday unforgettable!
Visit To https://sendwishonline.com/en/group-cards/happy-birthday-cards
