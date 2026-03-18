Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3395B10775FC
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:48:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 619C9601F3;
	Wed, 18 Mar 2026 18:48:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 619C9601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773856131;
	bh=9gSqWvv/RCWcLjFC+UR53MzuWOp9LLhbWi9DWyIech0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=C7plyw3Z/OsBLe9cTVaFlYDUVpJ1NPUEB4fgRa650ybxqnemcaFqt5iHBjhtaGeqL
	 II+d6gh8pOAVhQrP4e8TndFdk6mWxDK+Q9vZHyMREQP1xX5Xo2WOvq2b1J8dxkI5Wm
	 nknqPn7opkHO9I5Ef4zfLHFsQu9Kva6s47aS8R4E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8406F805F7; Wed, 18 Mar 2026 18:48:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EB706F805F4;
	Wed, 18 Mar 2026 18:48:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1740F80553; Wed, 18 Mar 2026 18:48:06 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 583FAF8024C
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2026 18:48:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 583FAF8024C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189e00b50bd42900-webhooks-bot@alsa-project.org>
In-Reply-To: <189e00b50baf5900-webhooks-bot@alsa-project.org>
References: <189e00b50baf5900-webhooks-bot@alsa-project.org>
Subject: Lenovo T14s G7 AMD audio issues
Date: Wed, 18 Mar 2026 18:48:06 +0100 (CET)
Message-ID-Hash: HZ2YZNA2PVSXVM5DFCUHZ5AKUEA6CPZX
X-Message-ID-Hash: HZ2YZNA2PVSXVM5DFCUHZ5AKUEA6CPZX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HZ2YZNA2PVSXVM5DFCUHZ5AKUEA6CPZX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #726 was opened from mrhpearson:

We're working on Linux enablement for the Lenovo T14s G7 AMD and having issues with getting the microphone working.

AMD engineers recommended having a ticket upstream for better collaboration - there are some issues with ACP PDM controller and volume support capabilities that need discussion.

alsa-info content:  http://alsa-project.org/db/?f=9082b76bc281046ae2b719cf89123fc174862864

I'll let the AMD folk know this has been created so they can explain the technical details of the issue more effectively

Thanks
Mark

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/726
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
