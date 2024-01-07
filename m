Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FFFC47074
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jan 2024 19:43:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2479585D;
	Sun,  7 Jan 2024 20:43:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2479585D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1704656602;
	bh=UCl6r2vcNH48280ZfVif1BSntAnhScPDpzxg8RwKlMQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=hRxbT2qM7tllRVop7E/uwrvNdvuGRvT18SF9a3+YFD4ZUeXYX8EdIJAs8xy/BPMQV
	 5QDc4kp40mMBOmTqlQKVSyGcfwXZzuBcSzA0qI3Wv6Qe+aKkyUQgaeGNuCk5s46hj2
	 N14LIk5i7b4kHMKMa0T0wamx9l6OqPY9LtZuq7x4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B146FF80588; Sun,  7 Jan 2024 20:42:39 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 29190F80589;
	Sun,  7 Jan 2024 20:42:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 82DD9F80246; Sun,  7 Jan 2024 20:42:34 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id D0DA4F800F5
	for <alsa-devel@alsa-project.org>; Sun,  7 Jan 2024 20:42:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0DA4F800F5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1704656551892743587-webhooks-bot@alsa-project.org>
References: <1704656551892743587-webhooks-bot@alsa-project.org>
Subject: aplaymidi: Set event completely for tempo event
Message-Id: <20240107194234.82DD9F80246@alsa1.perex.cz>
Date: Sun,  7 Jan 2024 20:42:34 +0100 (CET)
Message-ID-Hash: ZKM73GE44USXMIO24QDTERVZAY6HMG5F
X-Message-ID-Hash: ZKM73GE44USXMIO24QDTERVZAY6HMG5F
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZKM73GE44USXMIO24QDTERVZAY6HMG5F/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #253 was opened from jkl1337:

After UMP support was added in b399fb8 ev.type setting was inadvertently dropped in the code path handling tempo meta event. This is causing tempo meta events to not be handled at all. Moreover, snd_seq_ev_set_fixed is also missing so MIDI files with variable events such as SYSEX before the tempo meta event usually are causing a segfault.

Fixes https://github.com/alsa-project/alsa-utils/issues/241

Request URL   : https://github.com/alsa-project/alsa-utils/pull/253
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/253.patch
Repository URL: https://github.com/alsa-project/alsa-utils
