Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F25FEA80C
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2026 05:58:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8AA7601F9;
	Wed, 25 Mar 2026 06:58:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8AA7601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774418294;
	bh=IdzFla7b0qynZkVjsEURDrX5D0v5QBqq/177uRxWL28=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GWzIn/1QDMJ6MEsgrcD1ztCaYueiEbaA4SKIhO3OaiRXsItki5VQqwc/rMNm2QIKp
	 G1uFkHPFAN7YDG4JrvkLV22nj5ZbK6xcvghxEo3sPaKLdEDRCN6wfE0Ey9XxPIx8eQ
	 siTVdekTSR7uP9TZAv00auRPjrg+eQ78ES1tH2sg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76FE9F805F6; Wed, 25 Mar 2026 06:57:39 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D87A6F805EA;
	Wed, 25 Mar 2026 06:57:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A9D35F8059F; Wed, 25 Mar 2026 06:57:28 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id ADFD5F800E2
	for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2026 06:57:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ADFD5F800E2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189ffffe5c493600-webhooks-bot@alsa-project.org>
In-Reply-To: <189ffffe5c112a00-webhooks-bot@alsa-project.org>
References: <189ffffe5c112a00-webhooks-bot@alsa-project.org>
Subject: Certain Audio routed from headphones to microphone (Minifuse 1)
Date: Wed, 25 Mar 2026 06:57:28 +0100 (CET)
Message-ID-Hash: NJFXMPCTS3PGUQY5KNJW3V3GNMGGQEUZ
X-Message-ID-Hash: NJFXMPCTS3PGUQY5KNJW3V3GNMGGQEUZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NJFXMPCTS3PGUQY5KNJW3V3GNMGGQEUZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #733 was opened from AnomalousHendo:

Hi, I only recently started having a problem with my audio, and do not really know what has changed, being somewhat new to linux.
Currently, most of my problems and procedures to amend this can be found on this reddit thread here.

https://www.reddit.com/r/linuxmint/comments/1s25sy5/a_recent_update_messed_with_audio_drivers_and_i/

I apologize if this is the wrong local to ask this to... I'm new, and on the more foolish side with technology

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/733
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
