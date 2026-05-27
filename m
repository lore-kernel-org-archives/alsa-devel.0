Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C45CD5BD2
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2026 01:58:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36C8660255;
	Wed, 27 May 2026 03:57:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36C8660255
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779847089;
	bh=Bw8w5KkwlELSaVx8g19MsiGKBx5UDaGQZEma15jtp6Q=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=RyIOHWmTvieYfZ6vmmeJ+iFQJ3baGKJeo71EgpLxrcwCbViTeqY7KdKCWbq4XdRnO
	 PVJy/zyG5gbZMrWVkktSqZLyd34yDRjZU/FhfGoLwQMfb9MSh5/HZ4whtnyu4Kr6va
	 it0PM9DJsH61mxZp2cAshPCEoaeV8GdlWhZni/yU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 913F9F805F8; Wed, 27 May 2026 03:57:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F12EF805F4;
	Wed, 27 May 2026 03:57:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4356AF804FF; Wed, 27 May 2026 03:57:28 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E5FD8F800BD
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2026 03:57:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5FD8F800BD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b349752663bc00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/768@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/768@alsa-project.org>
Subject: ucm2: Qualcomm: fix device ids for surface pro 12in
Date: Wed, 27 May 2026 03:57:28 +0200 (CEST)
Message-ID-Hash: XOZF3I32KE2NAVKSIPC6FXV6IGR3P6XH
X-Message-ID-Hash: XOZF3I32KE2NAVKSIPC6FXV6IGR3P6XH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XOZF3I32KE2NAVKSIPC6FXV6IGR3P6XH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #768 was opened from harrisonvanderbyl:

Updated device ids to match updated device values in https://github.com/linux-msm/audioreach-topology/pull/32

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/768
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/768.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
