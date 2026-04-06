Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23E6EF4EDF
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2026 13:04:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42F266016F;
	Mon,  6 Apr 2026 15:03:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42F266016F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775480642;
	bh=q4CeR7vNs2IbawTBlJO9jJ7eXJkTFypEfNw66vx6Ouc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=M7MCiJwIRvlm8WalCUvdAcTmuGsqDWFBN9+PzTpeYQe7oDb5u40CLGEHbNG484+Um
	 vLx2vHF7uKETgIJRAEVnJisBoipqJ9mFwy2QdfEkgjnL8VooFobZfGvnxFNI95qCsy
	 jTBvchDaQsWfpkw/90Ab2JjnvXsDUcPr2usE/+10=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E770F805E8; Mon,  6 Apr 2026 15:03:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D704F805F2;
	Mon,  6 Apr 2026 15:03:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E29AF8049C; Mon,  6 Apr 2026 15:03:18 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id DC304F80169
	for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2026 15:03:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC304F80169
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a3c631f3597500-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/738@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/738@alsa-project.org>
Subject: ucm2: sof-soundwire: cs42l43: support UAJ-less configuration
Date: Mon,  6 Apr 2026 15:03:18 +0200 (CEST)
Message-ID-Hash: B3G5HPMSMXO3DSTGEX234ZWFBBH7E2MW
X-Message-ID-Hash: B3G5HPMSMXO3DSTGEX234ZWFBBH7E2MW
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B3G5HPMSMXO3DSTGEX234ZWFBBH7E2MW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #738 was opened from mstrozek:

In some cases cs42l43/cs42l43b devices can be set up without UAJ. In this case, guard the ConflictingDevices behind a check for a cs42l43's headset's presence so the UCM can still load even if the headset is missing.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/738
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/738.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
