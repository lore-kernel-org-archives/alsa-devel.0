Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0DAF46113
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:39:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4F20601FA;
	Mon, 23 Mar 2026 14:39:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4F20601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774273151;
	bh=tnVX1BRdd+Y4RAkbNrKFDWnvOLOF4PotLEUzQtYjl+U=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=NTesa11Th1HQfvWr2OyWlmB8hQuh+KfLAiqVF1QeNmI0SIUI+Z6oo5r8Oylnh0icB
	 mvL7oIMFNF1z+bg6+q2ZpN6Vb6RzK3OEBaKvXO1DKPCVsM9+hD0ULlRDGtdOZWjIYx
	 s2fqfNveYOmMluiwysoV3KBIw7wEgbeMQv7nIKeo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 206ACF805F6; Mon, 23 Mar 2026 14:38:37 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A259BF805F0;
	Mon, 23 Mar 2026 14:38:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E771F80496; Mon, 23 Mar 2026 14:38:28 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id BEBF3F800FE
	for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2026 14:38:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BEBF3F800FE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189f7bfd55fcb400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/732@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/732@alsa-project.org>
Subject: ucm2: sof-soundwire: add ACP DMIC configuration
Date: Mon, 23 Mar 2026 14:38:28 +0100 (CET)
Message-ID-Hash: QJ2AHZP4VPH4STYUDDE3OGDA6QVSAZU7
X-Message-ID-Hash: QJ2AHZP4VPH4STYUDDE3OGDA6QVSAZU7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QJ2AHZP4VPH4STYUDDE3OGDA6QVSAZU7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #732 was edited from ChaitanyaKrishna001:

Add acp-dmic.conf to the sof-soundwire configuration tree to enable the ACP digital microphone (DMIC) endpoint for AMD SoundWire platforms.

Signed-off-by: Chaitanya Krishna.J <chj@amd.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/732
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/732.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
