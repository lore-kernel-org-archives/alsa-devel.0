Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4031AC3DA64
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Aug 2024 03:27:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC7D239C4;
	Mon,  5 Aug 2024 05:26:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC7D239C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722828409;
	bh=+/7Yy5kPv6UUS9K5b6SrXlz/gc/OSr96+uXiEnrkeJE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=uw/WGXlnBuW7XODO++RsiUBJoFO/JitXdLKrPQzjtwLb/9bAj5PagTmtY3bUY2WWg
	 DARrGHikdM8CrIhOYb7K11IyT2wJhymY7w5KXxqOkV6S3YhqcAFUZ0F3CRdJpUhgPw
	 WMYJTIXuyC/DYERemB6tDuECfCirC5NdP3lvpQ0s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5EE2DF8049C; Mon,  5 Aug 2024 05:26:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D38C1F805A1;
	Mon,  5 Aug 2024 05:26:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67161F80448; Mon,  5 Aug 2024 05:04:05 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CEFCF800E3
	for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2024 05:00:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4CEFCF800E3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1722826848964968920-webhooks-bot@alsa-project.org>
References: <1722826848964968920-webhooks-bot@alsa-project.org>
Subject: ucm2: sof-soundwire: add rt712 VA device
Message-Id: <20240805030405.67161F80448@alsa1.perex.cz>
Date: Mon,  5 Aug 2024 05:04:05 +0200 (CEST)
Message-ID-Hash: KFAPDDSMDLQI6EIMMALRKF7R4UV7RXIO
X-Message-ID-Hash: KFAPDDSMDLQI6EIMMALRKF7R4UV7RXIO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KFAPDDSMDLQI6EIMMALRKF7R4UV7RXIO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #435 was opened from shumingfan:

Add support headphone/headset mic/speaker/dmic for rt712 VA

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/435
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/435.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
