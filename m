Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A98E94625
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Feb 2026 01:21:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 69AA160206;
	Tue, 10 Feb 2026 02:21:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 69AA160206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770686514;
	bh=DedcpN+Ps2jRqgDdYQay8idNQF6oPZYMH4L1fx55HGU=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=rBQ19xQPEHBdR1g2LtE+g4Uy/IoaF6DIVqTSOrIWhV8xkf9HYZ0/3j0GrNfs33JID
	 2xgyO0yGqpirwkwR5Iaf+vdM8JcbISZ3TA37oHz+WZm3i+RMHoGwMgK1T+QxsT6CPK
	 faYaJdxlDPFbuGgpavdwSmzRU8FVqiDEwFa+glao=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A6994F805EB; Tue, 10 Feb 2026 02:21:28 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A7F9F805E5;
	Tue, 10 Feb 2026 02:21:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0602AF801F7; Tue, 10 Feb 2026 02:21:07 +0100 (CET)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id E8A6CF80087
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2026 02:21:06 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: ucm2: sof-soundwire: fix a case MultiCodec1 string is in
 HeadsetCodec1
 string
From: haultalented@gmail.com
To: alsa-devel@alsa-project.org
Date: Tue, 10 Feb 2026 01:21:06 -0000
Message-ID: 
 <177068646694.22.14383787252090263678@mailman-web.alsa-project.org>
In-Reply-To: <187df4091567b900-webhooks-bot@alsa-project.org>
References: <187df4091567b900-webhooks-bot@alsa-project.org>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: 46F32AP2FHG5UV5Y5CISAATLG3TWH3C3
X-Message-ID-Hash: 46F32AP2FHG5UV5Y5CISAATLG3TWH3C3
X-MailFrom: haultalented@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EUQFNYMWIRQEHG6AMDK3XRFSFPKICKTM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Wow, this thread about the MultiCodec1 string in HeadsetCodec1 is really enlightening! I appreciate how detailed everyone is in discussing the implications of these fixes. I'm curious—how do you think this change might affect user experience with different headset models? Also, has there been any feedback from users since implementing these tweaks? It’s fascinating to see how these technical adjustments can lead to better sound quality! Thanks for sharing such valuable insights! https://fnaffree.io
