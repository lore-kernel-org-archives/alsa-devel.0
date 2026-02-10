Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46BCE94625
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Feb 2026 01:22:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 85AAE601D9;
	Tue, 10 Feb 2026 02:22:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 85AAE601D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770686531;
	bh=CR8OAmmJ19gTgoyThFwDF415JPCJZzyTOySqrh92kL0=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=RBGnd0rZeWNGCA2NpJFbFzI3VH6wxB3smGCzZUQM/JzgnTl+9P80PaHt0SRoxHiYn
	 nSQhf58Kv8FuWtFieEbQn8WdAqtdj7mDtPZMM9zHBQka0dlcEi2Jw5UVoRz/s3KFUk
	 WzgOusLh94CB58XSBBzJ/UTP5xqvcSmkd65kZqz0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E3D3F8060D; Tue, 10 Feb 2026 02:21:44 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 05EF8F8060B;
	Tue, 10 Feb 2026 02:21:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27C77F805F8; Tue, 10 Feb 2026 02:21:36 +0100 (CET)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id CF728F805F6
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2026 02:21:35 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: ucm2: sof-soundwire: fix a case MultiCodec1 string is in
 HeadsetCodec1
 string
From: haultalented@gmail.com
To: alsa-devel@alsa-project.org
Date: Tue, 10 Feb 2026 01:21:35 -0000
Message-ID: 
 <177068649584.20.11653641541966137939@mailman-web.alsa-project.org>
In-Reply-To: <187df4091567b900-webhooks-bot@alsa-project.org>
References: <187df4091567b900-webhooks-bot@alsa-project.org>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: PWS7KKQM5UJ5HISIVKQTOPTMYNUVQEPJ
X-Message-ID-Hash: PWS7KKQM5UJ5HISIVKQTOPTMYNUVQEPJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EL4XWYLGFSQ25G7WJ3J35VZYY4T2FHNM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

I find the discussion about the MultiCodec1 and HeadsetCodec1 string interrelation quite compelling. Having recently worked on a project involving soundwire protocol implementations, I encountered similar issues with codec mappings that led to audio discrepancies. It's fascinating how these nuanced adjustments can significantly enhance audio fidelity in complex environments. Thank you for addressing this critical aspect; it’s insights like these that foster better collaboration within our development communities!
