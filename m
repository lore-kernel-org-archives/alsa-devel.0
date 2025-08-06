Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C36CC87FD1
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Aug 2025 08:37:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4133860291;
	Wed,  6 Aug 2025 10:36:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4133860291
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1754469422;
	bh=AU7f0/+Yw8xtvck2KANozaaC1B3QcbdUNGBXyFqvODo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=WdS3ujVbW9RfqNcpmkN4Hnjolp23qVTURSbN3ETLOY+1pBXSFl8XwoS24yBkSy3Xa
	 q/cxNRH1GJPfRI0oXGHmLC291wnN/O7JaX4gRznAXxfrb+ScbhEsXu/DM2/g9YJ+32
	 h4fHQ0JyvsIRMDtTSVXuCdQmDkTIgKdFEjJJpJDY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4DF24F805C1; Wed,  6 Aug 2025 10:36:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BFE03F805D4;
	Wed,  6 Aug 2025 10:36:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EDEF5F80423; Wed,  6 Aug 2025 10:35:53 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A43AF800F8
	for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2025 10:35:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A43AF800F8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <185920916744fb00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-utils/pr/306@alsa-project.org>
References: <alsa-project/alsa-utils/pr/306@alsa-project.org>
Subject: amixer: always use line buffering for (s)events
Date: Wed,  6 Aug 2025 10:35:53 +0200 (CEST)
Message-ID-Hash: SI6PTPQGPXJRCQPB27MENMUTHTCKI6EV
X-Message-ID-Hash: SI6PTPQGPXJRCQPB27MENMUTHTCKI6EV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SI6PTPQGPXJRCQPB27MENMUTHTCKI6EV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #306 was opened from elenril:

Line buffering is the obviously correct mode for (s)events, but block
buffering would typically be used when piping its output to another
program.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/306
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/306.patch
Repository URL: https://github.com/alsa-project/alsa-utils
