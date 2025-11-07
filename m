Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F057CCFA05
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Nov 2025 13:08:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 102AC60201;
	Fri,  7 Nov 2025 14:07:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 102AC60201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1762520879;
	bh=9hwMSx7hM/2ddUF3QhDgU4kJuHZKjLOnhcyvB9H5Bfs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=T0/jjwx9v2z824aJ+vpwMa5ChXM6lCxt06jj41xvr6Vm1WFEXe7GMr/HZ+6T9lZtd
	 NVJn/iIoA6mWEPofAm07JnWbmqyBckgnMryXqaaUnNU6CYRWrWYDWz8CZtuN5wBldi
	 YdjH08e473ZUywUvlvopQIOk1NChZpRUUo1Dwznw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A992F805D5; Fri,  7 Nov 2025 14:07:22 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ACDB2F805D2;
	Fri,  7 Nov 2025 14:07:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B1E1F8055B; Fri,  7 Nov 2025 14:07:10 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5617FF80100
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2025 14:07:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5617FF80100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1875bb5a04050c00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/638@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/638@alsa-project.org>
Subject: ucm2: Qualcomm: add TUXEDO Elite 14 support
Date: Fri,  7 Nov 2025 14:07:10 +0100 (CET)
Message-ID-Hash: HEC6QCRC37YTZ2K52EZRJIHQR6AVULHA
X-Message-ID-Hash: HEC6QCRC37YTZ2K52EZRJIHQR6AVULHA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HEC6QCRC37YTZ2K52EZRJIHQR6AVULHA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #638 was opened from ektor5:

TUXEDO Elite 14 Gen1 (Snapdragon X Elite) supports:
	- 4 speakers
	- 2 dmics
	- Headset
	- DisplayPort (USB)
	- HDMI

Adding support to all above with this patchset.

Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/638
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/638.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
