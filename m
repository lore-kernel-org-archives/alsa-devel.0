Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0244EC77B7E
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Jun 2023 16:05:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7595D828;
	Thu,  1 Jun 2023 18:04:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7595D828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685635508;
	bh=47U77481J8R45xXOIvay+70BtesXIQ5aQ4HfME31dZw=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=AGkd8c6zyRc1EbO4WxyYlF2zHH76+IaltC9tIg8R3l82ehSHNnWjRSC6d9RrDQOeY
	 BvP7KA69X9oQyV62/MRIPR33IouOdVY6Po+TOduiDXBD1NqgcOgX2Oe4b4gY/CfXk6
	 9vJlJ9H7aWK7tgq7bX7971JQiTZ5K2lfpnQF466s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 94D35F805BE; Thu,  1 Jun 2023 18:02:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 23B9EF805AE;
	Thu,  1 Jun 2023 18:02:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0DE5F80249; Sat, 27 May 2023 21:28:34 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 328FDF8001F
	for <alsa-devel@alsa-project.org>; Sat, 27 May 2023 21:28:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 328FDF8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iGIh//w1
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 63E6360D33;
	Sat, 27 May 2023 19:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B184CC433D2;
	Sat, 27 May 2023 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685215699;
	bh=47U77481J8R45xXOIvay+70BtesXIQ5aQ4HfME31dZw=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=iGIh//w1R0aZbi6rkc8qZritYorqCU5chD0p5r/4uyFSRoECVlXCsdnhUcbLwdXDL
	 WGh67k0fcNYUJSVFII2t1HF1ZjwlynBKywpt5ghxPnBds+aW98VlaYih7JZgP5MmmV
	 zu3NLXtpLf5QxuCJohSIwJjuFhzUgp1WCb/E6QJ6Ftsi9yUTDfWUbqsjIw6WbXbPKq
	 cF2U9ZRt8Q6US9zOc8szJSdJbyaXAqLxQD9YFscLOlVB0rxj3wgmXRqLsb8m8NpBe5
	 RlAwVO6TK5IirXWpeeCuYcRGVdaovv7DRTK1RSf//ScqVCzDruiptudSp3ZR/9KwFA
	 f6cdSNdJN+92g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 8C086C4166F;
	Sat, 27 May 2023 19:28:19 +0000 (UTC)
Date: Sat, 27 May 2023 19:28:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From: "Kernel.org Bugbot" <bugbot@kernel.org>
To: bugs@lists.linux.dev, tiwai@suse.com, alsa-devel@alsa-project.org,
 perex@perex.cz
Message-ID: <20230527-b216392c2-2360e52d040f@bugzilla.kernel.org>
In-Reply-To: <20230331-b216392c1-7a8e13d80aac@bugzilla.kernel.org>
References: <20230331-b216392c1-7a8e13d80aac@bugzilla.kernel.org>
Subject: Re: Asus ROG Zephyrus GX701L sound problem
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: peebz 0.1
X-MailFrom: bugbot@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 4FESBZKRI5CWE57SCVJDLGVIKPXIHPYG
X-Message-ID-Hash: 4FESBZKRI5CWE57SCVJDLGVIKPXIHPYG
X-Mailman-Approved-At: Thu, 01 Jun 2023 16:02:26 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4FESBZKRI5CWE57SCVJDLGVIKPXIHPYG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

mpagano writes via Kernel.org Bugzilla:

(In reply to Ivan from comment #1)
> Any news?

There at least an acknowledgement of the growing problem and a statement that it's being worked on.

https://lore.kernel.org/lkml/1991650.PYKUYFuaPT@fedora/

View: https://bugzilla.kernel.org/show_bug.cgi?id=216392#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)

