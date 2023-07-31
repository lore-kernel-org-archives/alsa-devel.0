Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B4EC001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 12:48:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB7711E3;
	Mon, 31 Jul 2023 14:47:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB7711E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690807726;
	bh=2U0iAIzuoeo/9rl5TJbmf+EXBpBOx9GO3dz6JYmd4RE=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=AWZjpETh5Vhky5Ba5axXh65gEmwNPNzqMtS8RLBWbpUTF6S85AJeURPUs3/+3MkHk
	 K/PZNQcE+QGj6IrsKlrcdG8MQdjjKUHnj0/Kl2Q2Wj+G/mvzuRq/YL44pcKH3xPdo2
	 aXFi0yLGlrc03R3yigugAv6gaSE0rELPaTE7pZFM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC395F801D5; Mon, 31 Jul 2023 14:47:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 91E8BF801D5;
	Mon, 31 Jul 2023 14:47:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0DE98F8016D; Mon, 31 Jul 2023 14:47:19 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 04D37F8015B
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 14:47:19 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/7] usb: Add USB MIDI 2.0 Gadget Function Driver
From: "Symbolic Debugger" <happy.debugging@gmail.com>
To: alsa-devel@alsa-project.org
Date: Mon, 31 Jul 2023 12:47:19 -0000
Message-ID: 
 <169080763901.22.11665243983550346032@mailman-web.alsa-project.org>
In-Reply-To: <20230725062206.9674-1-tiwai@suse.de>
References: <20230725062206.9674-1-tiwai@suse.de>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: F7UKATHQJ4JCG33OZ4ABOQG4J6BMW7LU
X-Message-ID-Hash: F7UKATHQJ4JCG33OZ4ABOQG4J6BMW7LU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FUYFT2E2YSGBV76IGMWAJ4XNHLNUWD75/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Thank you so very much for this gadget driver.  Is this expected to be merged into 6.5rc2 ?
