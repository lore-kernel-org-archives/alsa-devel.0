Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4F6EA795B
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:05:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59672601F7;
	Thu,  5 Feb 2026 04:05:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59672601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770260732;
	bh=XEU4HkBDJPzD/yAYwt6DUmSndMn/EmVnf+nMiz4FGno=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=QV//D05gmbNeznA4VXRrMTWnjHlgesSAzAIDXeoP8bVudfVjW7lJU6zq9r0RASXZD
	 CKZkOMz6vzyfo1ZqjR57pSY7qFr+Zdf8lRqMAMWPaTaVXccYQmgz5EOYgIN1CrtyhB
	 TQoSE4BuHOpKAcczXeuoiH2qXCf8RTOLEnpEDBsU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1D7DDF805EC; Thu,  5 Feb 2026 04:04:56 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A58FCF805E7;
	Thu,  5 Feb 2026 04:04:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54BB4F804FB; Thu,  5 Feb 2026 04:04:46 +0100 (CET)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 47B03F8010B
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2026 04:04:46 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [GIT PULL] ASoC fixes for v6.19-rc3
From: raw.parakeet.ivtr@protectsmail.net
To: alsa-devel@alsa-project.org
Date: Thu, 05 Feb 2026 03:04:46 -0000
Message-ID: <177026068629.20.8639230894155820519@mailman-web.alsa-project.org>
In-Reply-To: <20251231124837.C972C1AC5681@finisterre.sirena.org.uk>
References: <20251231124837.C972C1AC5681@finisterre.sirena.org.uk>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: IY2567WDUJ3ZH67QNTFHLQXTAKJGPKUS
X-Message-ID-Hash: IY2567WDUJ3ZH67QNTFHLQXTAKJGPKUS
X-MailFrom: raw.parakeet.ivtr@protectsmail.net
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IY2567WDUJ3ZH67QNTFHLQXTAKJGPKUS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This commit addresses minor driver fixes and naming adjustments within the ASoC subsystem. It seems like navigating these changes requires precision, much like playing Slope Game. A small misstep and you're off course! Keep your focus sharp as you fetch the updates up to https://slopegamefree.com/
