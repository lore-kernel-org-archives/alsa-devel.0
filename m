Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DD3F364A1
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 16:41:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DEF9B60204;
	Thu,  9 Apr 2026 18:41:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DEF9B60204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775752911;
	bh=5oW0lpX9Tva7w/71zByUGHXpqxtJ2cvhGc30p3MZ14I=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fUQixEd1mHJc44dnRp6thCM+RFqOe19DY/53uC8vMoOvGJcTvgUTEFVrPZ4RFjeBQ
	 JbSsl0huGCL3xw4kDYEU+RJYA8eWMI7HXPjk1ox8wgTGgfYH6u5VpMv+Y3wYZWF5Ma
	 31g8N1C0mySP3yaFZbSe+IvwuDDIPq5gVuCXl60o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 75403F805F0; Thu,  9 Apr 2026 18:41:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ED653F805F0;
	Thu,  9 Apr 2026 18:41:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C345CF8052D; Thu,  9 Apr 2026 18:41:03 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 259D1F8012B
	for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2026 18:41:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 259D1F8012B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a4bdd1644eb800-webhooks-bot@alsa-project.org>
In-Reply-To: <18a4bdd16443ac00-webhooks-bot@alsa-project.org>
References: <18a4bdd16443ac00-webhooks-bot@alsa-project.org>
Subject: Play "front center" instead of "front left" when only one channel is
 selected with speaker-test
Date: Thu,  9 Apr 2026 18:41:03 +0200 (CEST)
Message-ID-Hash: FGXZ54USYH7IZSSHKSWDAHP3D77ZOXNP
X-Message-ID-Hash: FGXZ54USYH7IZSSHKSWDAHP3D77ZOXNP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FGXZ54USYH7IZSSHKSWDAHP3D77ZOXNP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #326 was opened from Managor:

When running `speaker-test -t wav` I get audio "Front left" despite in the audio coming out of both of the speakers. Similarly --channels 3 should play "Front center" instead of "Rear left"

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/326
Repository URL: https://github.com/alsa-project/alsa-utils
