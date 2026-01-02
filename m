Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB82FA373C
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Jan 2026 12:14:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23AE6601D5;
	Fri,  2 Jan 2026 13:14:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23AE6601D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1767356072;
	bh=oTZFXvm4SeykKOn+uHkur9ln2AuSOhSdCo6pL5c/hFA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=QFZdqnqRM/wnQ99a+MbRKUh5cDPm6otI/YuCcULYcIqjrdVJkzOMKrdCB87WbGN2j
	 j+Ei+C2Mbuz86+Oneq7a58nwqg1JcZDgtBRfVomeplxP5IIoNRR6Q43Ec9iL2/LbXa
	 RV/ODgoOdLvL+ef8tV9LW3V0WLQfnJUc725wv+qg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2773F805E4; Fri,  2 Jan 2026 13:13:48 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1009CF805E6;
	Fri,  2 Jan 2026 13:13:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D8C7F8032D; Fri,  2 Jan 2026 13:12:31 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 97566F80086
	for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2026 13:12:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97566F80086
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1886e8df29d02a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/671@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/671@alsa-project.org>
Subject: Remove outdated DisableSequence elements
Date: Fri,  2 Jan 2026 13:12:31 +0100 (CET)
Message-ID-Hash: F3CKOYHF5TJQQEX7BIUMVVCYP3A4T2VJ
X-Message-ID-Hash: F3CKOYHF5TJQQEX7BIUMVVCYP3A4T2VJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F3CKOYHF5TJQQEX7BIUMVVCYP3A4T2VJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #671 was opened from mstrozek:

cs42l43's 'Headset Microphone' and 'Microphone' devices were both used
to control mic mute LED in the past, but this was changed [1] to only
allow the built-in microphones to control the LED. Thus clean up the
DisableSequences to remove the switching off that is no longer needed.
Also, cs42l45 had those Sequences copied over from cs42l43, so remove 
them here as well.

[1]: https://github.com/alsa-project/alsa-ucm-conf/blob/master/ucm2/common/ctl/led.conf

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/671
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/671.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
