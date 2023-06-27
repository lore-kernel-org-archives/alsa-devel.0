Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B1CEB64D9
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jun 2023 15:42:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA37D822;
	Tue, 27 Jun 2023 17:41:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA37D822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687880537;
	bh=bvU4VWDIXQSSKQTkMbj6ImZdeAa1dTdCLTUkYKQ1eno=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fHMIpY5GC28r4kAy/gDLx8orEs5x/KNY7suTF6jzwH3D3548J8LDdO6OQVYJCVsl2
	 JU+FpitAqO6fN96l8tmMhdtiIFNEA+F99CjWWqfe+UfAfmQ5fw/T5QWscny+nTgjHC
	 zLFGzw5o2/vuBQs/Rq52+lzaQuzbcS9gj4JEMkhY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 918A0F8027B; Tue, 27 Jun 2023 17:41:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 03628F800E3;
	Tue, 27 Jun 2023 17:41:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 569A5F80246; Tue, 27 Jun 2023 17:40:41 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 38C29F800E3
	for <alsa-devel@alsa-project.org>; Tue, 27 Jun 2023 17:40:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38C29F800E3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1687880434464995623-webhooks-bot@alsa-project.org>
References: <1687880434464995623-webhooks-bot@alsa-project.org>
Subject: Intel/sof-essx8336: Fix HiFi.conf
Message-Id: <20230627154041.569A5F80246@alsa1.perex.cz>
Date: Tue, 27 Jun 2023 17:40:41 +0200 (CEST)
Message-ID-Hash: EFEP2VNJGWF4SRXXJXQ2LCD3UGPFB6DQ
X-Message-ID-Hash: EFEP2VNJGWF4SRXXJXQ2LCD3UGPFB6DQ
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EFEP2VNJGWF4SRXXJXQ2LCD3UGPFB6DQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #328 was edited from xry111:

1. <del>Enable Left/Right Headphone Mixer Left/Right DAC Switch in BootSequence.  Despite they seem enabled in sof-essx8336.conf, if I don't add this I'll need to enable them with alsamixer.  I guess they are killed by disdevall.</del>
2. Switch Headphone on/off in Headphones enable/disable sequence.  This should be obvious.
3. "Headset Switch" is not recognized and triggers errors running "alsaucm -c hw:0 set _verb Hifi".  Change it to "Headset Mic Switch". And in the disable sequence we should turn it off, not on.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/328
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/328.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
