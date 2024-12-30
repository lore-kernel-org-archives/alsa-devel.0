Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF6EE77188
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Dec 2024 05:24:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC4DA6052B;
	Mon, 30 Dec 2024 06:24:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC4DA6052B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1735536284;
	bh=/TJ4I9RWRNHCz/rua1VL3qN5SPfGMHh3BYVLidPeemY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=M5zpFwcnDjzRS7sWesluTVArqybYzUSFyVHQTzS1izRA7k/dzKgIF/Za55Y+yAp8x
	 ZIZfPVevf6lve5IJbtTaseTZFguim8hQnrGUYj6MqW73MoGoHAucIM3bODFUfzxFJF
	 ZGhN/zuhlWrHsbqWKld69ik+qspkcc3cNgLooQhI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73DCBF805C1; Mon, 30 Dec 2024 06:24:09 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AB3FF805C2;
	Mon, 30 Dec 2024 06:24:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 640F4F80508; Mon, 30 Dec 2024 06:23:59 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 61581F800FE
	for <alsa-devel@alsa-project.org>; Mon, 30 Dec 2024 06:23:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61581F800FE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1735536236746194363-webhooks-bot@alsa-project.org>
References: <1735536236746194363-webhooks-bot@alsa-project.org>
Subject: UCM2 macro breaks on updates for Motu 828
Message-Id: <20241230052359.640F4F80508@alsa1.perex.cz>
Date: Mon, 30 Dec 2024 06:23:59 +0100 (CET)
Message-ID-Hash: E7YBN6I5N65IGJLLQM5GZUGCJZ6CJ4TP
X-Message-ID-Hash: E7YBN6I5N65IGJLLQM5GZUGCJZ6CJ4TP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E7YBN6I5N65IGJLLQM5GZUGCJZ6CJ4TP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #493 was opened from beatboxa:

It appears that every time there is an update, my UCM profile breaks.
So that when I boot my machine, I have no sound (unless I manually map things in a pro audio application).  This appears to be due to an issue in the SplitPCM macro--specifically, some parsing.

Here is the thread describing the creation of the UCM profile I am using, including a patch that I had to apply in order to get things working: #416 

And specifically, here is the patch I apply in order to fix it: https://github.com/alsa-project/alsa-ucm-conf/commit/b68aa52acdd2763fedad5eec0f435fbf43e5ccc6

It involves adding a single hyphen character to the file:  ucm2/common/pcm/split.conf

Because it is a single character, I have been manually changing the file.

It's hard for me to follow that thread--but is this fixed and I am on older versions, or is this still an open item?  Or is there a way to automate this so that my audio doesn't break on every update?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/493
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
