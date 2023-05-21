Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C22EC77B73
	for <alsa-devel@archiver.kernel.org>; Sun, 21 May 2023 15:44:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3823782B;
	Sun, 21 May 2023 17:43:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3823782B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684683866;
	bh=orwAOFoyOmL0zwUeB2UzfHr4YBq+mKsY7Stfk0tKLB4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vW2qzNr3QTm48kWWeXNxbMZPE0gE+sfRehp7GOK/svy1baSxXU/F+0HPuaCsyiFs+
	 8WO3lzzlNgEI8fagMHzkphekk3aGCbeL3hZ4I6RNLsfrV0DPEhtiL1xgJhZTWLLGmt
	 TausFn5WPyW/3vSeIO2spBjttEnZz6h3m6AQ3110=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 01F30F80086; Sun, 21 May 2023 17:43:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 785BDF80086;
	Sun, 21 May 2023 17:43:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80B25F8024E; Sun, 21 May 2023 17:41:56 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id BE298F8016A
	for <alsa-devel@alsa-project.org>; Sun, 21 May 2023 17:41:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE298F8016A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1684683709560790777-webhooks-bot@alsa-project.org>
References: <1684683709560790777-webhooks-bot@alsa-project.org>
Subject: Updated single and double quotes throughout
Message-Id: <20230521154156.80B25F8024E@alsa1.perex.cz>
Date: Sun, 21 May 2023 17:41:56 +0200 (CEST)
Message-ID-Hash: JIMRP5EWPZ2VRCVANUB274HOBROPG422
X-Message-ID-Hash: JIMRP5EWPZ2VRCVANUB274HOBROPG422
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JIMRP5EWPZ2VRCVANUB274HOBROPG422/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #215 was opened from wileyhy:

This commit:
- Added double quotes to common expansions; removed quotes from strings; 
- Changed REQUIRES to an indexed array and changed the corresponding for loop; 
- Added curly braces where feasibly necessary; 
- Removed a few unnecessary trailing semi-colons; 
- Put URL's in single quotes to prevent any possible expansions, except for within the sed command on line 988. 
- Some logic structures may depend on word splitting, on lines 641, 643, 654, and 667, so I left those as-is for this commit. 
- Double exclamation marks in double quotes allow history expansion which is usually disabled in non-interactive shells, so I left those as-is also.
- Single quoted instances of 'yes' as a parameter value, since it's also a command name, which in certain contexts could be executed.
- Removed quotes from instances of '$?' since it can only expand to an integer and cannot be unset.

Some additional issues for consideration of further efforts (credit: shellcheck):
- variables 'inp' on line 87 and 'KERNEL_RELEASE' on line 418 appear unused;
- https://pastebin.ca is offline

Request URL   : https://github.com/alsa-project/alsa-utils/pull/215
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/215.patch
Repository URL: https://github.com/alsa-project/alsa-utils
