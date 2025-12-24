Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54C5E7545F
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Dec 2025 14:20:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1151601D5;
	Wed, 24 Dec 2025 15:20:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1151601D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1766586040;
	bh=+yWJG69saoKPveCMB2GlCgJxvAJ58CMwW2CVjdt6YhI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=I71o8RGMWRVhH9Cke4lkTYdwX/kp2Pm8GcVo5lWqA/Wz1PlSqy1EdhP+fEtPKknp/
	 JhutlACu/XJ/wP3j+JSDRAkReEND5zuxXqp0XjFy7sJEG6HpcWC5wfxbiNj32/Yq2E
	 QcykHYyQnH+puaYOQbvFJNQ4oaHqe8bXD+TegaPU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 66342F805DF; Wed, 24 Dec 2025 15:20:16 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 243F7F805E1;
	Wed, 24 Dec 2025 15:20:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D9ABF80236; Wed, 24 Dec 2025 15:19:22 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 812BBF80088
	for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2025 15:19:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 812BBF80088
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18842c8f2328e900-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/666@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/666@alsa-project.org>
Subject: USB-Audio: Add Focusrite Vocaster interfaces
Date: Wed, 24 Dec 2025 15:19:22 +0100 (CET)
Message-ID-Hash: 5NVIOXTCL4R65GHIFJCH5DZK4VFV44RG
X-Message-ID-Hash: 5NVIOXTCL4R65GHIFJCH5DZK4VFV44RG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5NVIOXTCL4R65GHIFJCH5DZK4VFV44RG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #666 was opened from geoffreybennett:

Add split configs for the Focusrite Vocaster One and Two interfaces.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/666
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/666.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
