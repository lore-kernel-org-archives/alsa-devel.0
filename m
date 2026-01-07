Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A30CF6BE2
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jan 2026 03:25:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E929601FD;
	Wed,  7 Jan 2026 04:24:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E929601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1767756299;
	bh=NVtSXh6Kc3PkfroqhAAz2+ZSwjy+1jsWsKQ7mem11rI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vV6dHSot8TiQ7VCzvseVLQD4JUbUGpRyG9GVuuFT8OHvyTtz6bDj3W33A4s9dc/23
	 gvl/f1KhQYRXEHwYFS5s+4nDnpFCdY5Aan7ZY9N8XCykEPIbka+wi8+zipcQlRlZ1W
	 z4qr+eKBHnZLtR3UwGJ0yakRJ9/wTveErtpS3Txc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57A3AF805DA; Wed,  7 Jan 2026 04:24:24 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 09C09F805D3;
	Wed,  7 Jan 2026 04:24:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C58E1F80448; Wed,  7 Jan 2026 04:23:08 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F681F80088
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2026 04:23:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3F681F80088
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <188854e1d7e40c00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/682@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/682@alsa-project.org>
Subject: ucm2: da7213: Add ADC switch in HeadphoneMic2 sequences
Date: Wed,  7 Jan 2026 04:23:08 +0100 (CET)
Message-ID-Hash: PTYHPZNB43DAASS3MWXDKXFH4RXLEKOY
X-Message-ID-Hash: PTYHPZNB43DAASS3MWXDKXFH4RXLEKOY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PTYHPZNB43DAASS3MWXDKXFH4RXLEKOY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #682 was opened from QTI-Quill:

Enable and disable the ADC switch in HeadphoneMic2EnableSeq.conf and HeadphoneMic2DisableSeq.conf to ensure headset microphone audio works properly on Talos EVK with DA7213 codec.

Without this change, the headset mic path remains muted and capture does not function.

Fixes: 5ccdd19 ("Qualcomm: qcs615: Add TALOS EVK HiFi config")

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/682
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/682.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
