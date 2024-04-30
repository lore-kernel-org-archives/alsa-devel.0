Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5A7C4345F
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Apr 2024 13:22:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F36D83E;
	Tue, 30 Apr 2024 15:22:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F36D83E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1714483358;
	bh=6Bm6qy1UnSvVLMdpsHowu3Vk1uMLw1Q8zMSlGaQQjdM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=jRpW6hlGrrlzC09ETycm9U6PtRhQv1zx6hIYmQiVWWDEzoLxpoA1v8X6BcdyUWNKZ
	 r4hJVRU9NKmp1PEBgmBqSclPKcQ5t7q9J1rXflbc+3+Ymsup9e7vj8dfklan1j8pVR
	 IN996Z9PrZN3TXBx1Y09WoMywgLHiC86afhUluZo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A76B8F805AB; Tue, 30 Apr 2024 15:22:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CD43F805A9;
	Tue, 30 Apr 2024 15:22:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40B6DF80266; Tue, 30 Apr 2024 15:21:54 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id F1770F8003A
	for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2024 15:21:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1770F8003A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1714483307461317539-webhooks-bot@alsa-project.org>
References: <1714483307461317539-webhooks-bot@alsa-project.org>
Subject: [DNM] common: pcm: hdmi/sof-hda-dsp/sof-soundwire: Syntax 7 dependent
 macro to generate the hdmi device sections
Message-Id: <20240430132154.40B6DF80266@alsa1.perex.cz>
Date: Tue, 30 Apr 2024 15:21:54 +0200 (CEST)
Message-ID-Hash: W34Y6QWDP2TSCIDTF4XBF2VTW2NQFW35
X-Message-ID-Hash: W34Y6QWDP2TSCIDTF4XBF2VTW2NQFW35
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W34Y6QWDP2TSCIDTF4XBF2VTW2NQFW35/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #413 was opened from ujfalusi:

Hi,

The PR will introduce a a generic `HdmiDevice` macro, which can replace duplicated conditions in sof UCM files and potentially used by other devices to generate the needed section for the hdmi PCM devices to allow passthrough.

The PR is marked as DNM and is in draft since the change depends on Syntax 7 support, which is only available in git version of alsa-lib, it is not a simple ask for a user (or developer) to use it and the change would break UCM for released alsa-lib.

@perexg, is this something that you were suggesting? I think the macro and it's definition is generic enough, I hope that it will be usable for non SOF setups.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/413
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/413.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
