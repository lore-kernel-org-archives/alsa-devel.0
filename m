Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943DFC25B47
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Oct 2023 20:17:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0153CAE8;
	Fri, 27 Oct 2023 22:16:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0153CAE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698437818;
	bh=5BGmWDst9Aoz+OtA4E1y82rnWz81p6RC+QHyEhre5hI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=h/4HKnN8IrKid5qT34rGVKxWZ+X6SLgwWBOV948XLsectC1mlOLoLgp2fM9fHNRgn
	 lvauSdWN5ri50VsEkhcDUgs2ds3uMQzm4ud5ZNWmOAuYmJnNLsJp6sKm9mg0HE9Ut3
	 noobQ6cAHt7Luf7iHagGeGo3FOBJ091bDMpbv1f4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B12CF8028D; Fri, 27 Oct 2023 22:16:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 21E0CF80165;
	Fri, 27 Oct 2023 22:16:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36CA1F80165; Fri, 27 Oct 2023 22:16:02 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 41BDCF8012B
	for <alsa-devel@alsa-project.org>; Fri, 27 Oct 2023 22:15:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41BDCF8012B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1698437759059802771-webhooks-bot@alsa-project.org>
References: <1698437759059802771-webhooks-bot@alsa-project.org>
Subject: aplay: improve xrun logs
Message-Id: <20231027201602.36CA1F80165@alsa1.perex.cz>
Date: Fri, 27 Oct 2023 22:16:02 +0200 (CEST)
Message-ID-Hash: 7QRTFUCCMUILBL44RZNQYITGSYQRK3RU
X-Message-ID-Hash: 7QRTFUCCMUILBL44RZNQYITGSYQRK3RU
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7QRTFUCCMUILBL44RZNQYITGSYQRK3RU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #242 was opened from plbossart:

Add a pcm_status on xrun and a non-zero timestamp.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/242
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/242.patch
Repository URL: https://github.com/alsa-project/alsa-utils
