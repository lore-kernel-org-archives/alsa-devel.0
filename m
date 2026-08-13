Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A37C5AD5A
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2026 00:38:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FFD0601FF;
	Thu, 13 Aug 2026 02:37:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FFD0601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786581484;
	bh=eIEcFSeIqFefMxtfstcf0Jno6xfURaHEVB5tpCnjuN8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=i2ilqT+ezUkfuf5N2bL6q+q8KlpcJrd8u/VFRzmTk79sSxB6Z7mvv13zeeazogv66
	 a9gv1L8paGUaYVZ4GGai5hq6DWvj2m7GloivSEjWFBIOFJycsAeloInV1hxiceunMd
	 yP/jR0LO3AvS8puBB7KZVWFknX7ggAuNpyZHU0nM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5D23F805FB; Thu, 13 Aug 2026 02:37:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 704CDF805FF;
	Thu, 13 Aug 2026 02:37:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23AC0F80553; Thu, 13 Aug 2026 02:37:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786581444;
	b=QLKI/HRqomfsq0IrsFQqp5BTwG6wXENe5fzujv94lnm0gbxNWVtiev7j/sMZMBk2MDiH
	 J9Ai7gJySNOOXYQTCtXya/rtDihtXa6O8cfOvQMzzrNrgn/xqlzR9eYFTb6UOe9QMlEP7
	 yaAdUZBy4BSvlNYuC9mhoYHUEFN9vAzsB4DBv6Gx09eDbPkd8OpTrnyA1PzR3MA5iu3R6
	 Ylw6ZqI04NmzayQmbsV81vdVHmjyveMaF4/ln2A7gyZ6JKkeBoo+2oDKWhsxoCtJTnTSH
	 FdJb4EBxzFSwwlXsyroSNn2krtDj+SdQSfEXboAH5MtVgnRf637jLMqa2e31OjWvNdA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786581444;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=eIEcFSeIqFefMxtfstcf0Jno6xfURaHEVB5tpCnjuN8=;
	b=ecfps0bUt4C5jQ5HvoXAcgIsQrx7hAWm9mWCo07G01vj7Ctc5HEhNtee3aowr/PovZOx
	 AB0ZBdLkvVbsZrAuXS870U3IS1oNZyzDwl77RRvcPUKby5rUNFtXSmVDhTsm/oZu96+OL
	 tgoqM/tSZjPbMeaCPhvpFFtFjZODU3sPR8o+Y4W9JqrIz3M8uPPMUsil1X4nUi8vj/Jb4
	 BsF66R24UagsFmnG+eGB7ZR5egpJfgIWSPE6PyJbP8HU9dVUjPfnLcsiGQ9cDM4zWfLh+
	 +6CL8ZInwMvNckEqmUP0ZPALqvHoiB+6N0qKMmgrbTWCrJsb/UZmeIbVTwfCtFP8Cjw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 68546F8010B
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2026 02:37:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68546F8010B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cb365b37d56000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/831@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/831@alsa-project.org>
Subject: Add Blue Snowball UCM Mono Profile
Date: Thu, 13 Aug 2026 02:37:25 +0200 (CEST)
Message-ID-Hash: VKB32RPDSHCB56YJFNW5LB3OBL3R3RMV
X-Message-ID-Hash: VKB32RPDSHCB56YJFNW5LB3OBL3R3RMV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VKB32RPDSHCB56YJFNW5LB3OBL3R3RMV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #831 was opened from XirXes:

This forces the microphone to be detected as a mono input device correctly. This fixes a hardware crash caused by OBS attempting to access two PCM channels in low latency mode at launch. Without this the microphone works in stereo, when OBS isn't running.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/831
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/831.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
