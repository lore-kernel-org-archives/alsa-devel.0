Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBBAEB64DC
	for <alsa-devel@archiver.kernel.org>; Sat,  1 Jul 2023 17:17:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 599E0839;
	Sat,  1 Jul 2023 19:16:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 599E0839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688231832;
	bh=83G22JY+rL6aVn6kOwO6RfuGIZXCqNjyJTDF1es8KpI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ajaLyju80D73QYKdqEpBMHvt5uxJAu+WcXfvFqpzGNEdLZtAYA0cTK36ObwoLmdab
	 ARdIlZE+V6WnrylfX0QQaawTBWVTFCvSBzNAmAv5tgqLjj6vCbMThO3JqiSwQbxwhQ
	 jsUhB2Kj3Fs4KMOfvstSzZaBW/IOwA4F5LfNzAR0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14F55F80212; Sat,  1 Jul 2023 19:15:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E665F80212;
	Sat,  1 Jul 2023 19:15:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B15AFF80246; Sat,  1 Jul 2023 19:15:52 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 9195BF80093
	for <alsa-devel@alsa-project.org>; Sat,  1 Jul 2023 19:15:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9195BF80093
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1688231744662647247-webhooks-bot@alsa-project.org>
References: <1688231744662647247-webhooks-bot@alsa-project.org>
Subject: ucm: mark internal functions static
Message-Id: <20230701171552.B15AFF80246@alsa1.perex.cz>
Date: Sat,  1 Jul 2023 19:15:52 +0200 (CEST)
Message-ID-Hash: K75GXKYH43BFJA7BN5MXBL7TS4CAWFKY
X-Message-ID-Hash: K75GXKYH43BFJA7BN5MXBL7TS4CAWFKY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K75GXKYH43BFJA7BN5MXBL7TS4CAWFKY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #335 was opened from neobrain:

I've ran into build issues in a project that links against both libalsa and libxkbcommon, which both export a function called `parse_string`. Changing internal function to internal linkage (`static`) prevents this kind of problem.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/335
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/335.patch
Repository URL: https://github.com/alsa-project/alsa-lib
