Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3241EB64D7
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jun 2023 13:31:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B78D83E;
	Tue, 20 Jun 2023 15:30:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B78D83E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687267877;
	bh=t0CypdlXxfttsQ8W9NUs83+S7bZKUrmo44naGksTl0c=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GMldQJEeXYWP8xq32t5mPgPsmxuXZjZW9U/2eyEaXPe0bT0b0RB4oUpM0WuqZKnKb
	 TqmMndTd0T9BVc9dhBkARIHgkX8W5tRYashN1mzYE06HNW1JL+ebBB7InL8a7mJI3d
	 /tobU88gUJ1Dy0Rpkzz31NyIsw769SHeOR0MrbCM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC466F801D5; Tue, 20 Jun 2023 15:29:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9542BF80141;
	Tue, 20 Jun 2023 15:29:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53E5DF80141; Tue, 20 Jun 2023 15:29:50 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id E73B0F80130
	for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2023 15:29:49 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 00/37] ALSA: Add MIDI 2.0 support
From: "Symbolic Debugger" <happy.debugging@gmail.com>
To: alsa-devel@alsa-project.org
Date: Tue, 20 Jun 2023 13:29:49 -0000
Message-ID: <168726778987.22.3291129206408701069@mailman-web.alsa-project.org>
In-Reply-To: <87ilbl5evw.wl-tiwai@suse.de>
References: <87ilbl5evw.wl-tiwai@suse.de>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: UCBVEYB7AMHLGQBTOVYOINJ5YBSRX7D5
X-Message-ID-Hash: UCBVEYB7AMHLGQBTOVYOINJ5YBSRX7D5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UCBVEYB7AMHLGQBTOVYOINJ5YBSRX7D5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

All kernel 6.2 files build successfully ! P.S. I saw a reference to you on the NAMM  booth. :-) Thank you so much !
