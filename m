Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDCBCFD313
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Nov 2025 14:58:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76F8C601FA;
	Mon, 24 Nov 2025 15:58:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76F8C601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1763996307;
	bh=Kf57qKvOqnZleu3dOjGVSoEuDcabnbFUTfTW6fQ1nBQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=sa+B6YbMeMpYNsldI5WZUBZJ7gaqUnaA3Qkf9ioc6BP7KFuq3KmfxckPl8p6yl6jj
	 3adKsjPbS8JPCBfO7ZmR/40p6WCLH0V3V8BUDKYZDNsyRIBxh0drvy+S6WSuGJ/pxl
	 YYw8aVd0n7iqWCo5Wq6NzZ+9Dx+J+zGMDEACqD1o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 95999F805D2; Mon, 24 Nov 2025 15:57:53 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 55139F805C8;
	Mon, 24 Nov 2025 15:57:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4C43EF8026A; Mon, 24 Nov 2025 15:57:43 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id AF59EF800BF
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2025 15:57:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF59EF800BF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <187af940e8eafe00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-utils/pr/309@alsa-project.org>
References: <alsa-project/alsa-utils/pr/309@alsa-project.org>
Subject: configure: Allow systemd service installation without systemd.pc
Date: Mon, 24 Nov 2025 15:57:43 +0100 (CET)
Message-ID-Hash: EO7SZPVLYVQXURCVTG6WQOUAQC5DSN47
X-Message-ID-Hash: EO7SZPVLYVQXURCVTG6WQOUAQC5DSN47
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EO7SZPVLYVQXURCVTG6WQOUAQC5DSN47/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #309 was opened from fossdd:

If the systemdsystemunitdir got passed anyway as a variable, we don't need the systemd.pc dependency anymore and allow building without a systemd build-dependency.

Relevant in Alpine Linux, where we allowed systemd services to be (sub-)packaged (e.g. for downstreams like postmarketOS), but don't have systemd pacakged in Alpine itself, yet.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/309
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/309.patch
Repository URL: https://github.com/alsa-project/alsa-utils
