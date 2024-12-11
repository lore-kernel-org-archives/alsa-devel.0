Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B6CE7717F
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2024 02:50:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15F43211B;
	Wed, 11 Dec 2024 03:50:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15F43211B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1733885418;
	bh=YpmR0lFnp7VXxFOVFtwxTav81hrFKy8tA3EFg2dKfYc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=SPmsQjQFdv24e8ArBOTwcJsMfMU2EGZpKMyAnDOtotzAgJ8wQeUDCN1QQnMyR+Vhp
	 bKlF3kJV74OIhGfsV4heN/aevak4bWdqxTwc03nGgMLtqQfMQPqNpwwDttBpZehYjc
	 2+ta+wW5Igw7ZP6isBJt6akEJ0TqFXudvXfaESko=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 52A53F805C5; Wed, 11 Dec 2024 03:49:46 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A8DF9F805AC;
	Wed, 11 Dec 2024 03:49:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 680D6F80482; Wed, 11 Dec 2024 03:49:42 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id B938EF80087
	for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2024 03:49:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B938EF80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1733885379778549910-webhooks-bot@alsa-project.org>
References: <1733885379778549910-webhooks-bot@alsa-project.org>
Subject: rt722: add headset mic led control
Message-Id: <20241211024942.680D6F80482@alsa1.perex.cz>
Date: Wed, 11 Dec 2024 03:49:42 +0100 (CET)
Message-ID-Hash: VMXEXNJJNC62S2GETPNVZJAMCRIXCGSE
X-Message-ID-Hash: VMXEXNJJNC62S2GETPNVZJAMCRIXCGSE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VMXEXNJJNC62S2GETPNVZJAMCRIXCGSE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #487 was edited from shumingfan:

rt722: add headset mic led control

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/487
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/487.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
