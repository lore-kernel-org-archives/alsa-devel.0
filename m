Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AC0F4198B
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:33:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0645260204;
	Wed, 15 Apr 2026 13:32:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0645260204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776252778;
	bh=iOg2CGdID0WNKEWPOz/5GgdORIFtLYNnAUevlubOiik=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ATTqkeZOGRx7nk8qnsakZqUEepAqLJl/Iei+vhXnC9+sJccsNE6y+EPznPx9MgqU2
	 taudWCTW7RIYN4oIxJwRAFaHyJKVbmwSm0QnlQ1MAh21m2Qpl/KoUpPBkBNFS/FwZq
	 nlLk94DG6vLdL+ozto7KAArqftS82WwgBhz9A4Bo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2DEE2F805F0; Wed, 15 Apr 2026 13:32:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E1F90F805EF;
	Wed, 15 Apr 2026 13:32:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0AB73F80217; Wed, 15 Apr 2026 13:32:17 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 83D36F800EE
	for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2026 13:32:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83D36F800EE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a684739717e400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/746@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/746@alsa-project.org>
Subject: Update qcm6490-idp ucm2 conf
Date: Wed, 15 Apr 2026 13:32:17 +0200 (CEST)
Message-ID-Hash: W6D4ZL6YBSSYWIYHKPM5XOJCK7E7VLAO
X-Message-ID-Hash: W6D4ZL6YBSSYWIYHKPM5XOJCK7E7VLAO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W6D4ZL6YBSSYWIYHKPM5XOJCK7E7VLAO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #746 was opened from mohsRafi:

Set PlaybackChannels explicitly for Speaker and Headphones to ensure correct
stereo playback configuration and also fix internal mic mute handling by selecting
Mic1 to mute the internal mic when the headphone microphone is enabled.

Rename the ucm2 conf for Qualcomm qcm6490-idp. Removed snd-card tags from conf, as name did not
correctly match the actual sound card name.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/746
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/746.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
