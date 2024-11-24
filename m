Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F69E668AD
	for <alsa-devel@archiver.kernel.org>; Sun, 24 Nov 2024 13:09:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E4D691;
	Sun, 24 Nov 2024 14:09:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E4D691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732453796;
	bh=p2/1e2z0F8CnGprSKxZZcvNvM36bhonvfwh73WbPJ90=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=mM/lVpuZxm2+FHm2WhJbF7aFFFpiMBB/Fr2ZcRmBfN1Nl1x+VfQCCkwM16NaJKgMG
	 nk+14BR4wdFqJ1rwRu8WNZGTScoaipP8UlrE1GOB+NpPH7szrLGh+2eBQDgw5cPuaf
	 HH5QtNwZNxirbEKPhSzCsf9tDysgEvsZl9uk6lA8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F2ABF805B1; Sun, 24 Nov 2024 14:09:24 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A164F805AF;
	Sun, 24 Nov 2024 14:09:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA6F5F80496; Sun, 24 Nov 2024 14:09:16 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 132B0F80073
	for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2024 14:09:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 132B0F80073
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732453753013833523-webhooks-bot@alsa-project.org>
References: <1732453753013833523-webhooks-bot@alsa-project.org>
Subject: No sound and alsactl init errors after updating to 1.12.13
Message-Id: <20241124130916.BA6F5F80496@alsa1.perex.cz>
Date: Sun, 24 Nov 2024 14:09:16 +0100 (CET)
Message-ID-Hash: OMEXXVOPEP46DSQFXHNVR7PNLYR4HWVN
X-Message-ID-Hash: OMEXXVOPEP46DSQFXHNVR7PNLYR4HWVN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OMEXXVOPEP46DSQFXHNVR7PNLYR4HWVN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #283 was opened from wastlnd:

I think I have kind of a regression after updating to the latest version. I have this error at startup:
```
Found hardware: "acp" "" "" "" ""
Hardware is initialized using a generic method
```
And I have no sound at all. I have tried to apply the latest commit fixing the udev rule, but it didn't work. Downgrading to 1.2.12 fixes the issue.
I am running an Arch based distro on AMD Ryzen 7 5825U CPU with Radeon graphics. My soundcard is Realtek and I have an AMD microphone array.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/283
Repository URL: https://github.com/alsa-project/alsa-utils
