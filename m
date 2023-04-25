Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735C3C77B61
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Apr 2023 02:25:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D15AC1028;
	Tue, 25 Apr 2023 04:24:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D15AC1028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682389499;
	bh=Jyi1/JV5McqXGHI9E3S4DmkDYWfkrqZ0q1lria9OWQ0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Uq8B6tHuBTi9JJNafwbcoCLKtR0ORcQ/UD0GF7cYU2o3Zir4IDjWuy3+48nYa/gaK
	 8DEKDXwIz8LUsk9DgG90eHnQ5QDhzedkyLZpuaIHHqqPmGM6GU9CTIjS0ClIqsNa8n
	 80MgegOFWJ99GwcIRZCp6CyVEhDyVTHRqWK1ib8M=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EFD8F80236;
	Tue, 25 Apr 2023 04:23:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEF70F80236; Tue, 25 Apr 2023 04:23:40 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FB59F800F8
	for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2023 04:23:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FB59F800F8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1682389414848679781-webhooks-bot@alsa-project.org>
References: <1682389414848679781-webhooks-bot@alsa-project.org>
Subject: Fix gigabyte z690i aorus ultra ALC-4080
Message-Id: <20230425022340.EEF70F80236@alsa1.perex.cz>
Date: Tue, 25 Apr 2023 04:23:40 +0200 (CEST)
Message-ID-Hash: AXH56NSJLUPH2MJZJS2SGO6P73BPZZDZ
X-Message-ID-Hash: AXH56NSJLUPH2MJZJS2SGO6P73BPZZDZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AXH56NSJLUPH2MJZJS2SGO6P73BPZZDZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #307 was opened from jameson-reed:

Currently the board is not matched by the regex.
Once matched the config still isn't valid.
I've got it stable with the following changes, disabling spdif and line1 and updating Mic1PCM value.

The front headphone and microphone jacks are working now, as is the rear audio out. That does leave 1 jack on the back I haven't had any luck with.

There is no spdif on the board.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/307
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/307.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
