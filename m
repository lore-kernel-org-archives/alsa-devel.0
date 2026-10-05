Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD82CA5FCE
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2026 05:20:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04042601D5;
	Mon,  5 Oct 2026 07:20:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04042601D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791177643;
	bh=7Bed8DddmqOvKWTk+k+putGoxkBI10lWw5EcRRIHPvI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=EahfzoYNbO60lj7QTzut+kFFqLs1bI4TCub36Kl/YnlmFxfy2rADbP34Xpf3RVfQc
	 dptf301T/0c4mE4Ih+iApX3SXETxHngI6FZostPhHYt+EgxzK42onoDs3zelFlFRY8
	 ZXayzCzXm/Ab2tSmpIvRkqFqV/7Db6h/9+KBedaw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85ECEF80603; Mon,  5 Oct 2026 07:20:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EA956F80601;
	Mon,  5 Oct 2026 07:20:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9EAD3F80588; Mon,  5 Oct 2026 07:20:02 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791177601;
	b=V+CJs1XdpxD1bQbO56jZgt49g9cmRSJ6yV7mZ9h84tfG25N3ah3G22d3yx5sut3Dbb9c
	 Z+jl7a0eKs2s6DeeVMVUkh6/q44x0jvdTdrCOMy7y4SkX6r9qd7v+YNzyLHDA3laXFS3B
	 AP0sngqeB36HLnvts6vvR2ipoGQYVhzqwFgnFSKt/4iBVlfXDqnDMxUyzYOraqh566E5I
	 El4qYoDrWH7eSywdjdWXEJ+xwYRvfPJvMBFwa8IpY2JB3B8FdAqXnrseBRWU0cUV514pw
	 O2tADHXs5c/KDv7Orc+WKklxFe+6f/9pylXNPhVm3OXOGWTrM0lublOsSyHkZVVAeeA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791177601;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=7Bed8DddmqOvKWTk+k+putGoxkBI10lWw5EcRRIHPvI=;
	b=HC1id/oq5DhV7WdeAP+LEnD+1w1+6EDEMQhXnzWUqTw736VatTPeHZObSEQemw6/YtrW
	 ShaF1SfYH6cceE6Fu6U0frP9UAIRVHpw1Sh7z1jmy5cockopUK6o8gGA94TOnluO/r34s
	 srd9pywrwhIcWQxofdzZxX8d75Aptf1Oo3+VvbrVMbV3xgo+OaQb+6fgHirBmE2w2otyX
	 SBFwnQWWKgGt1vJI+0Xn6YDaZmy6YOunYYibHvgenIbw5icMMi0ZFWqq5pETAeSG3Z0oQ
	 ovmigK6920i4P+ty97kqgOHQoIATtSsndQ2jDzg4CA71JhTYaT/F/c0+bjFE+kXcuuw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id BD985F8007E
	for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2026 07:20:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD985F8007E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18db8a898567c200-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/791@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/791@alsa-project.org>
Subject: Qualcomm: qcs615/sa8775p/qcs8300: Add uboot TALOS EVK / Lemans EVK &
 Monaco HiFi config
Date: Mon,  5 Oct 2026 07:20:02 +0200 (CEST)
Message-ID-Hash: SUMY2MJPY2OLYVOQTCEMLOVC72DKLTBF
X-Message-ID-Hash: SUMY2MJPY2OLYVOQTCEMLOVC72DKLTBF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SUMY2MJPY2OLYVOQTCEMLOVC72DKLTBF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #791 was edited from kumarsingh-art:

Add UCM2 configs for uboot variant of the Qualcomm variant Talos/ Lemans & Monaco.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/791
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/791.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
