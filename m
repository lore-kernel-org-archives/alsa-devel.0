Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAABEE49A0
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Aug 2023 21:13:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F055E839;
	Mon, 21 Aug 2023 23:12:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F055E839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692652384;
	bh=m4z+v6dbwQ9Phv4FVkMuIIpC8Co8nzNQAPcl/2nmNsY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=HQI+ujNzsIb4BB6vtH1y3f88U0nMjnevrDVEJGWEtu00uP9JMRKk3fNhZ4KXUynlM
	 uQwvkbVg4IQGqVaIVrG+uJHw0EsDVQWXrVW8iWjXeiVrrASk7dSH+Y6zIbP0wKRum8
	 aCxnUYHvyebgwEjJ1x5vzPcLMEDKcc5hYbBw6ikc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BB589F80536; Mon, 21 Aug 2023 23:11:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6770BF80199;
	Mon, 21 Aug 2023 23:11:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 825A6F80199; Mon, 21 Aug 2023 23:11:41 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 3456EF800BF
	for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2023 23:11:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3456EF800BF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1692652294032554388-webhooks-bot@alsa-project.org>
References: <1692652294032554388-webhooks-bot@alsa-project.org>
Subject: Add a config for the Allen & Heath Zedi 10 mixer.
Message-Id: <20230821211141.825A6F80199@alsa1.perex.cz>
Date: Mon, 21 Aug 2023 23:11:41 +0200 (CEST)
Message-ID-Hash: X4TZHT4E7E52724YZ2F7RLJHLH3DQJNO
X-Message-ID-Hash: X4TZHT4E7E52724YZ2F7RLJHLH3DQJNO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X4TZHT4E7E52724YZ2F7RLJHLH3DQJNO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #341 was opened from pololevu:

[alsa-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/12402535/alsa-info.txt)
The mixer has an embedded 4x4 USB interface, this config surfaces the mixer channels as 4 mono inputs, 2 stereo inputs and 2 stereo outputs. Config based on the Behringer Flow8 config.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/341
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/341.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
