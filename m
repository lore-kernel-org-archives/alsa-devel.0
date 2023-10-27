Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E75AC25B47
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Oct 2023 10:39:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 19F25AEA;
	Fri, 27 Oct 2023 12:38:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 19F25AEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698403186;
	bh=wI0mwt7sqTL8dmrGQBVp5uPpTi5gVqncM4ZFyn5JE0o=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=EiOzVbsxjcRF2DCP9Ygipjb84S8IWUGGOv4bjnDZAMZbvC9SItMv4TqGj4NII5ebx
	 sb1DBYcYgtqkOqo7Fuubf8IwL1EPAsyuWAE8q4UTg2W4KOmbweawYnO4YQGqU4QZOo
	 juqa/mf8OLROv0nfPgy4F1imr4KHIStyojQr+LD8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D7BEF80557; Fri, 27 Oct 2023 12:38:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 17E6DF8019B;
	Fri, 27 Oct 2023 12:38:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DE23DF8019B; Fri, 27 Oct 2023 12:38:20 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id D1079F8012B
	for <alsa-devel@alsa-project.org>; Fri, 27 Oct 2023 12:38:20 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [alsa-devel] echo-cancellation plugin advice?
From: f.antonini@tiesse.com
To: alsa-devel@alsa-project.org
Date: Fri, 27 Oct 2023 10:38:20 -0000
Message-ID: <169840310085.21.3458972256504699984@mailman-web.alsa-project.org>
In-Reply-To: <s5hsjfbneiu.wl%tiwai@suse.de>
References: <s5hsjfbneiu.wl%tiwai@suse.de>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: TXZQV55QSZDZNYGL4G3OFFAORIXJRQSJ
X-Message-ID-Hash: TXZQV55QSZDZNYGL4G3OFFAORIXJRQSJ
X-MailFrom: f.antonini@tiesse.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TXZQV55QSZDZNYGL4G3OFFAORIXJRQSJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Everyone

I arrived at this thread because I need to implement an acoustic echo canceller based on the Speex library. I think that the Speex plugin available under 'alsa-plugins' repository would be the best starting point, but I need to provide as input both the streams (input and output).
For what I understand the current implementation provides just one input (the audio stream coming from the MIC) and so it can't remove the echo of the playback audio. It works as a filter as explained before. Right?
Please can you suggest some hints provide both the recording source and the playback stream as one input to an ALSA plugin? Is it doable anyhow?

Thanks in advance for your help

Fabio Antonini
