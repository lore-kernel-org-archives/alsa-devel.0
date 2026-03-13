Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4422106FD66
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2026 02:50:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AC49601E0;
	Fri, 13 Mar 2026 03:50:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AC49601E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773370247;
	bh=V6sGjm0OkFDgjscjjBf7OJ7zkUz97EFuBW9nEsKStk4=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Vw91R2pdrPzBoN3Za9HvWs1PXQcDWESb52Xg9Hw9NwHSsGd3sjoKGspk+URzGXyJv
	 nwZzZGHPTqSCLaCZKWn6z46Vgzx1sdcVZuU2Sj5VsVf0qRffmU+StQxlFunnNy7CvC
	 ymOv7HrzP4fAaurOPmSO4Z7SL3HZUyCJTguse3LM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9F835F805F5; Fri, 13 Mar 2026 03:50:14 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 58353F805F4;
	Fri, 13 Mar 2026 03:50:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA105F804B4; Fri, 13 Mar 2026 03:50:06 +0100 (CET)
Received: from mailman (unknown [10.254.200.5])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E70FF8015B
	for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2026 03:50:06 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [alsa-devel] Applied "ASoC: tlv320aic32x4: Model CODEC_CLKIN in
 CCF" to
 the asoc tree
From: single.giraffe.ctpl@hidingmail.com
To: alsa-devel@alsa-project.org
Date: Fri, 13 Mar 2026 02:50:06 -0000
Message-ID: <177337020653.20.11748886769988686523@mailman>
In-Reply-To: <20190325161140.A0E0111288F1@debutante.sirena.org.uk>
References: <20190325161140.A0E0111288F1@debutante.sirena.org.uk>
User-Agent: HyperKitty on http://mailman.alsa-project.org/
Message-ID-Hash: YMZ4UVW3YIK7JPVK2UCK7UFDIMBE7SLP
X-Message-ID-Hash: YMZ4UVW3YIK7JPVK2UCK7UFDIMBE7SLP
X-MailFrom: single.giraffe.ctpl@hidingmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YMZ4UVW3YIK7JPVK2UCK7UFDIMBE7SLP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

I learned then the value of small, digestible chunks. Oh, and remember to loop in the right people; communication is paramount. Slice Master skills are needed in every project, not only in the kitchen.
https://slicemasterfree.com
