Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15B7C47073
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jan 2024 14:56:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65C10ECE;
	Sun,  7 Jan 2024 15:55:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65C10ECE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1704639359;
	bh=n2Vq4Bi2nT+hzizB3PD174/2lO+ONGMSy681qeppNzc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=g+S1ha3oXheugINg+KdW9cDiM5pPtRktEbhiB35LYDOMg3lMiZhBOItp9V0lpLRUd
	 eijof9joqxo56aze6z109qKzbcoaAsjNL+w6IsRimIDLJmQZ9mosf5LVVyx3iVE+Up
	 uTkIWrUM91QOlYMnMcJ4nFRRs0EFajZoJFe69lCY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CF21DF8057D; Sun,  7 Jan 2024 15:55:27 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E79E4F80564;
	Sun,  7 Jan 2024 15:55:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49340F80246; Sun,  7 Jan 2024 15:55:22 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 9890BF80086
	for <alsa-devel@alsa-project.org>; Sun,  7 Jan 2024 15:55:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9890BF80086
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1704639320234729528-webhooks-bot@alsa-project.org>
References: <1704639320234729528-webhooks-bot@alsa-project.org>
Subject: Add UCM for PinePhone Pro
Message-Id: <20240107145522.49340F80246@alsa1.perex.cz>
Date: Sun,  7 Jan 2024 15:55:22 +0100 (CET)
Message-ID-Hash: VXKST2XQNBX53CWGFHGJNLIAK5KNGBO7
X-Message-ID-Hash: VXKST2XQNBX53CWGFHGJNLIAK5KNGBO7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VXKST2XQNBX53CWGFHGJNLIAK5KNGBO7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #375 was opened from Daniel-Abrecht:

Merge PinePhonePro from https://gitlab.com/pine64-org/pine64-alsa-ucm branch master

Also, add conf.d/simple-card/PinePhonePro.conf symlink, and remove some stray spaces that got mixed in with the tabs.

Ideally, #374 should be merged first. This should work already on systems started without UEFI, as then there is no DMI, and the CardLongName should be set to CardName. However, for most installations, this probably won't be the case, and #374 will be needed for those. Fixes #125

Since I didn't write the UCM myself, I tried to preserve the history & authorship of the original work using a merge commit. Rebasing this properly without breaking the reference is a bit tricky, so I intend to do that myself after #374 is merged. Also I hope that's going to survive this pull request, but I haven't tried this before.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/375
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/375.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
