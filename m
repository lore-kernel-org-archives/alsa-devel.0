Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1D3EA8543
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Mar 2026 21:12:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C388E60251;
	Sun,  8 Mar 2026 22:11:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C388E60251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773004320;
	bh=X50B9gCuwjMgj6h8hKa2eg1CjaE9MmqAOXYUIrHX+gM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=gbJsP5iFw9m7LUDIvXnpD7yItBzRfvBYcaaXZpcm9kMJ8yVr4AKbHsx+EC6VRshbw
	 bmU0EY4awEAnkFEJ6g4S95o71QrZq1diIMH/dO0qXtM7lSaf33VR0iCBgPfGTQOqf2
	 WNXfeejaRnXJfQ1BFkCqsDbuwp/I68POEDCBe6vU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8523EF80557; Sun,  8 Mar 2026 22:11:27 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BF83F805F5;
	Sun,  8 Mar 2026 22:11:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 112ABF80557; Sun,  8 Mar 2026 22:11:19 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 57663F80087
	for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2026 22:11:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57663F80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189af9feb23d6100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/716@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/716@alsa-project.org>
Subject: sof-hda-dsp: add workaround for speaker LED on MSI laptops
Date: Sun,  8 Mar 2026 22:11:19 +0100 (CET)
Message-ID-Hash: 6VHXFJXGZVGONHU2JF6K5CBS44CVX4N7
X-Message-ID-Hash: 6VHXFJXGZVGONHU2JF6K5CBS44CVX4N7
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6VHXFJXGZVGONHU2JF6K5CBS44CVX4N7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #716 was edited from Fede2782:

Make speaker LED work out of the box once LEDs are made discoverable via msi-ec module

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/716
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/716.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
