Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA1ED2502F
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Jan 2026 15:07:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBDEB6021E;
	Sun, 11 Jan 2026 16:07:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBDEB6021E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1768144039;
	bh=3ElNodeN8lzT0+KlY48upsjBy+fdk/fNc9mSldsSfuA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OW58F+CnC7svRRZjjWaRcLq0+W06AYY0NDxbb1kr4PBxfvCMeggmlwAQjjV3NKnWf
	 AXoaeSUGdYLLNej7Qh3WH0PDYyA3C9o9ccspxTsmyZttP6jVXGXi8c4vYyNevAgBFb
	 nQEHrA2Oe/DXlZ0LFAUhjVEkJVRs19MjYQCROesk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1E41AF805FA; Sun, 11 Jan 2026 16:06:38 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B90C8F805F5;
	Sun, 11 Jan 2026 16:06:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 17117F80149; Sun, 11 Jan 2026 16:04:38 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A029BF80100
	for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2026 16:04:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A029BF80100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1889b57cdcae3c00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/684@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/684@alsa-project.org>
Subject: USB-Audio: Add support for UR24C firmware version channel
 differences, fix UR22C
Date: Sun, 11 Jan 2026 16:04:38 +0100 (CET)
Message-ID-Hash: TRSKQDK65JQNS5YMDWMGQTDIRQFCVWXO
X-Message-ID-Hash: TRSKQDK65JQNS5YMDWMGQTDIRQFCVWXO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TRSKQDK65JQNS5YMDWMGQTDIRQFCVWXO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #684 was edited from jwlademann:

Steinberg UR24C has a similar change to the number of capture channels for version 3 firmware that UR22C has. During implementation I found an issue with the condition used for UR22C which I fixed also.

See: https://github.com/alsa-project/alsa-ucm-conf/pull/554 and https://github.com/alsa-project/alsa-ucm-conf/issues/547

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/684
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/684.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
