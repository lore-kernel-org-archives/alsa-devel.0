Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF879C54E58
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Mar 2024 12:05:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4CCABE66;
	Mon, 11 Mar 2024 13:05:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4CCABE66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710158744;
	bh=Gs4eOaBeZihauGIMzfgQE25y75IeTknPpAxi3WO/A10=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fpyAlGSj9aYqc5ef+h8JMGMgGmZOber43f9jEwtAkioalhpTBj8aPUeGxuYSNK145
	 LWkTiDdbplWLoFTn6Z2rLuR8lCPQ2F+gfPydKxZg2J8KDfk+MglECsiMpHu5JE8KwQ
	 8L4z0hYKh6wrLB3O+I5Zp4xZHjE+Bqom0ezX30rU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A31C9F8057B; Mon, 11 Mar 2024 13:05:12 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C3DBF8057A;
	Mon, 11 Mar 2024 13:05:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1BFFDF8028D; Mon, 11 Mar 2024 13:05:07 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C993F80088
	for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2024 13:05:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C993F80088
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - reopened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1710158703036945581-webhooks-bot@alsa-project.org>
References: <1710158703036945581-webhooks-bot@alsa-project.org>
Subject: Strange trigger_htstamp after snd_pcm_drop
Message-Id: <20240311120507.1BFFDF8028D@alsa1.perex.cz>
Date: Mon, 11 Mar 2024 13:05:07 +0100 (CET)
Message-ID-Hash: PGNSKSOZ4UBMT7EJQ2GI473ODBZLLZV4
X-Message-ID-Hash: PGNSKSOZ4UBMT7EJQ2GI473ODBZLLZV4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PGNSKSOZ4UBMT7EJQ2GI473ODBZLLZV4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #387 was reopened from z-s-e:

I have conceptually the following situation (actual code can be found [here](https://gitlab.com/z-s-e/alpe/-/blob/main/src/alpe_alsa.cpp?ref_type=heads#L590)):
```
// sound is currently playing
snd_pcm_status(pcm, pcm_status);
snd_pcm_status_get_htstamp(pcm_status, &ts1);
snd_pcm_drop(pcm);
snd_pcm_status(pcm, pcm_status);
snd_pcm_status_get_trigger_htstamp(status, &ts2);
```
On my hardware I get a `ts2` timestamp that is earlier than `ts1`.  From my understanding that should be impossible, as `ts2` should contain the timestamp of when the drop happened, which should obviously be after `ts1`. Is that a bug or do I misunderstand the meaning of those timestamps?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/387
Repository URL: https://github.com/alsa-project/alsa-lib
