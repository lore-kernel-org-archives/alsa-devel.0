Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DAFF8D753
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:55:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0146460204;
	Thu, 16 Apr 2026 16:55:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0146460204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776351334;
	bh=ceqdiEX5DQN7fz4ESlwdZHeIYd+6zUOPBj4fz7EQgxI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=hsHj2tUMkdruv7JODtqaLVlHqrWBHN7jIAsFaEQF3gWnjG8+fkVuxTUujYHE1BQKY
	 YqQE28jvjVdSduwFtC9bN2xvj1R/qnqLDIThX0MTnewWREj1L+tro0mx6/SOQIpbVD
	 kIG1/xnnoQIyFI2LpSURa9ch8IPhkPz17ApxEROk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EF2E5F805EE; Thu, 16 Apr 2026 16:54:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 58108F805F1;
	Thu, 16 Apr 2026 16:54:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A51FF8049C; Thu, 16 Apr 2026 16:54:51 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D592F80212
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2026 16:54:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D592F80212
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a6de15ec2f8d00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/746@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/746@alsa-project.org>
Subject: Update qcm6490-idp ucm2 conf
Date: Thu, 16 Apr 2026 16:54:51 +0200 (CEST)
Message-ID-Hash: 2KMCDN2QZHRYAG2VLADNEXKUXUPN3U4B
X-Message-ID-Hash: 2KMCDN2QZHRYAG2VLADNEXKUXUPN3U4B
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2KMCDN2QZHRYAG2VLADNEXKUXUPN3U4B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #746 was edited from mohsRafi:

Fix internal mic mute handling by selecting Mic1 to mute the internal mic when the headphone microphone is enabled.

Rename the ucm2 conf for Qualcomm qcm6490-idp. Removed snd-card tags from conf, as name did not
correctly match the actual sound card name.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/746
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/746.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
