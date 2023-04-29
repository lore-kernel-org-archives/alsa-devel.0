Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD663C77B61
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Apr 2023 00:50:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DDB31573;
	Sat, 29 Apr 2023 02:49:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DDB31573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682729446;
	bh=vzTz8mocnqzLofHXvRLRcQEUrTguN4kZpcasT1NLlH4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=s90HSPQPTrS0rTysy6tRjpWWRqiWWbIoGDG/LHWyluEO4OioIpV0hITvS71eF4Ud3
	 8pHbJs8LwBAZ5V335Tn57xT2MdAIcznLgjJPgXiVrtCB+oFZKRsQj0uj2Sl3oBBkrd
	 NiH3lXkcU3OBOdRi4YpBdNPz1Juqwms7XOzVCD8c=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 16B10F800F8;
	Sat, 29 Apr 2023 02:49:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D782F8025E; Sat, 29 Apr 2023 02:49:27 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DA63F80137
	for <alsa-devel@alsa-project.org>; Sat, 29 Apr 2023 02:49:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DA63F80137
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1682729362026524782-webhooks-bot@alsa-project.org>
References: <1682729362026524782-webhooks-bot@alsa-project.org>
Subject: reduce `exec`s by four, and eliminate logic bug
Message-Id: <20230429004927.2D782F8025E@alsa1.perex.cz>
Date: Sat, 29 Apr 2023 02:49:27 +0200 (CEST)
Message-ID-Hash: RGRDDNT65JKRQRMGKT435YBHNGCOMNJW
X-Message-ID-Hash: RGRDDNT65JKRQRMGKT435YBHNGCOMNJW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RGRDDNT65JKRQRMGKT435YBHNGCOMNJW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #205 was opened from wileyhy:

Per `info uname,` `uname` always prints its data in the same order.  Also, "note that A && B || C is not if-then-else. C may run when A is true." https://www.shellcheck.net/wiki/SC2015 

  set -x; read -r KERNEL_VERSION < <(uname -v); smp=x; [[ "$KERNEL_VERSION" = *SMP* ]] && { smp=y; readonly smp; false;} || smp=n; set -

Request URL   : https://github.com/alsa-project/alsa-utils/pull/205
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/205.patch
Repository URL: https://github.com/alsa-project/alsa-utils
