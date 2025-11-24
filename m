Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC94ACFD313
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Nov 2025 02:29:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32D3F60211;
	Mon, 24 Nov 2025 03:29:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32D3F60211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1763951359;
	bh=HpB5XDG/nkKphjMISP3/oT1W85ipqgCV2IkQHkvzcJA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=lYl3dGGDmWA/rYCLSFsIQyhXvJBQIRymvw0cPS803pqXCXTUZMEDoE7yLLPukW4N9
	 gu5hi8kH0BxTeEzApudnTRdJg0ISUR6Eo1j9GsfEr6HBIIeHMumQDcsTygJ0FPaeeJ
	 o3KKtfngcCAr/b0lRvvsimS7JR4qYesf0qkeXjak=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3FF6FF805C6; Mon, 24 Nov 2025 03:28:43 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DBED8F805CA;
	Mon, 24 Nov 2025 03:28:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C4B4F8026A; Mon, 24 Nov 2025 03:27:42 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 09A05F8003C
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2025 03:27:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09A05F8003C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187ad051b79c4a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/649@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/649@alsa-project.org>
Subject: rt713: add mic led support
Date: Mon, 24 Nov 2025 03:27:42 +0100 (CET)
Message-ID-Hash: BXOJZCD4ILLVTXEDOGI624PE3ZCZKGEM
X-Message-ID-Hash: BXOJZCD4ILLVTXEDOGI624PE3ZCZKGEM
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BXOJZCD4ILLVTXEDOGI624PE3ZCZKGEM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #649 was opened from shumingfan:

rt713: add mic led support

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/649
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/649.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
