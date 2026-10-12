Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F0BCA9ED1
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:55:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 225B0601FC;
	Mon, 12 Oct 2026 08:55:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 225B0601FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791788154;
	bh=aG68NNaOejwQHNDZoQyIcv1qq/8lTGbqoOJzWACH9Zo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ZZy8qHrhNuxS9I3Q/5Dl9Ait/+7qj+dze6RYshq2rluuJzBpcvRFT/mTtUdDrTw4t
	 DcNn1sM9nlw78YTOFj3Eq4Rlv08XnaWRFaO/2Zd4YaWI/SGC0VxotH1b/dou5+DeMk
	 yv616fzXE2kqxn9PJM+C72rplhmxIPedEenKFDFU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 167CDF805FF; Mon, 12 Oct 2026 08:55:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 29F63F805F5;
	Mon, 12 Oct 2026 08:55:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A291F80526; Mon, 12 Oct 2026 08:55:13 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791788111;
	b=pYkuUroVxP1hsS6/P/DIxEmjJiyvSaZB+I4OEiFntPBHL+Qg22C9w85oitrBPNhDOstF
	 0ZobH06EH0k6V8PAmL57HBP/gp3nkpSgpwoakbHw/i+yFwWgJsGzQd0oOfSnAmJGbOAEg
	 qV6C826ASWPWKMekFaaPbiVBLOts3cErS2f8JdEy3G9xnf7N05PTNval9T1+7HtvkeHzP
	 cMxiHZ8jF5L8IJNSl2f7mRJADQUHvUHSv1ILBmc9Z2N6NCI1aBEy4E3Y5m11FsrbHRNXl
	 YK+ITlSLrG2S0DZQhtGXHi9QxTgBqdXWJCYE5YqV13D5nvdZn8SXH+x4JsC0vyc6xzQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791788111;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=aG68NNaOejwQHNDZoQyIcv1qq/8lTGbqoOJzWACH9Zo=;
	b=UdQwbz4YZqZ8G2vkl4NbP0Pcq3xIyTQIbdH6XvJRWRaH0HV613hdXu7OxTp8h/U8bMsF
	 wrLayExK8q+3KiSJgMjz6gzZt4b4z9D2W1FuHxOKkzV2tG/V0XX2aCZPtddhJSi52YxTY
	 lc40h4LcndejKpmQLRshA2A5YyK3YNm15ET9oCdVqGAD/TVFpfezLzySgwmDN9lYXFcg8
	 Az+54hetcOdfeY4c7M7fLrR+b0uydN9dhTpagjNdO8i0iWK1pBxIhTmoOOugni4ykbHOC
	 MVI9QGDUTtyb7a02O8QBvVWZpzsgwYCqblWhpjDITQoIbE2IHDsUcO3zMxjWX4tZJ+Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 13FF5F80100
	for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2026 08:55:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13FF5F80100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18ddb5cad058cf00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/873@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/873@alsa-project.org>
Subject: ucm2: Qualcomm: add HP EliteBook G1q support
Date: Mon, 12 Oct 2026 08:55:13 +0200 (CEST)
Message-ID-Hash: OINRN5376MPYP7EEEF2ZRB6S7ETH77L4
X-Message-ID-Hash: OINRN5376MPYP7EEEF2ZRB6S7ETH77L4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OINRN5376MPYP7EEEF2ZRB6S7ETH77L4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #873 was opened from juergh:

The EliteBook series is just a higher-end version of the OmniBook and compatible. Confirmed working on a EliteBook 6 G1q.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/873
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/873.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
