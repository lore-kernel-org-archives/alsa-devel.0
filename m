Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F3DCD5BD5
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2026 14:16:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF1F460251;
	Wed, 27 May 2026 16:16:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF1F460251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779891401;
	bh=cuDnAeolYGGRWC55WbtqEjOVdwEG+8TfQK2hl0Rap0I=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=MLSN4YOWeqLc7sSNYPk9vju7bzU4wFEhvRjI7VUk3kU5tnvpTDgdY31zAJsc/1tcs
	 UIozXtf1VfGypDD56ByhS5DZHGSSt3uOaofs+W5y6rExUVdrt0jCHzhgOhhCdJjzED
	 hOnWq06aeYTbQ/8dfeuO3qOy8234ZmXiV9h/6fSU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9B034F805E3; Wed, 27 May 2026 16:16:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E19EF805F3;
	Wed, 27 May 2026 16:16:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 00E67F804FF; Wed, 27 May 2026 16:15:57 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D913F80246
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2026 16:15:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D913F80246
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b371c1d50b7400-webhooks-bot@alsa-project.org>
In-Reply-To: <18b371c1d4ed3e00-webhooks-bot@alsa-project.org>
References: <18b371c1d4ed3e00-webhooks-bot@alsa-project.org>
Subject: Mute LED not working.
Date: Wed, 27 May 2026 16:15:57 +0200 (CEST)
Message-ID-Hash: IV7O3JSOAWJZ5RT2YABGWUJH2TFDXRNT
X-Message-ID-Hash: IV7O3JSOAWJZ5RT2YABGWUJH2TFDXRNT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IV7O3JSOAWJZ5RT2YABGWUJH2TFDXRNT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #769 was opened from Gropinou:

https://alsa-project.org/db/?f=a68feee728b669f547491855254add15fddad73e

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/769
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
