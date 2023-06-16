Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD85EB64D7
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jun 2023 12:23:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E801782B;
	Fri, 16 Jun 2023 14:23:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E801782B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686918238;
	bh=a4h3OVKjXJwnzri7CZ4hcdGpjqC4XEyFrpTXp5HCFZk=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=IePdki9rKSHy1yA5SCPricD6wUrf8beNcPUOF+chLVQyLFO8rEDhCTfATd8Rn3xWl
	 Ui+54gRA5qmNtraKyjsMEEUylKBethA5+EtT2F76i8ohsuiYMnFqkXNgUsgT0NJWtq
	 ZBLtLksWOpkGvjTyY2D7PYey9i/IkjsJ2r5aWFu0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B27AFF8052E; Fri, 16 Jun 2023 14:23:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D756F80149;
	Fri, 16 Jun 2023 14:23:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8635F80149; Fri, 16 Jun 2023 14:23:02 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id D041BF800BA
	for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2023 14:23:02 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 00/37] ALSA: Add MIDI 2.0 support
From: "Symbolic Debugger" <happy.debugging@gmail.com>
To: alsa-devel@alsa-project.org
Date: Fri, 16 Jun 2023 12:23:02 -0000
Message-ID: 
 <168691818283.22.13707495755989096624@mailman-web.alsa-project.org>
In-Reply-To: 
 <168682914833.20.10859690398442251462@mailman-web.alsa-project.org>
References: 
 <168682914833.20.10859690398442251462@mailman-web.alsa-project.org>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: LSVYP2OPN6JR7ZDLEELDUC6N2P54NPYX
X-Message-ID-Hash: LSVYP2OPN6JR7ZDLEELDUC6N2P54NPYX
X-MailFrom: happy.debugging@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VZMJAITR2DMQXBQ5EPD2AOZJCQMN7BNQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Well never mind... Finally ! 

uname -a
Linux Ubuntu 6.4.0-rc6-next-20230615 #3 SMP PREEMPT_DYNAMIC Fri Jun 16 17:48:44 CST 2023 x86_64 x86_64 x86_64 GNU/Linux
