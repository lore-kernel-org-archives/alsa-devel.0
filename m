Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8AAC5DF97
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:19:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E6BC60233;
	Wed, 26 Aug 2026 21:19:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E6BC60233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787771956;
	bh=K2ar9Hvjhl5W0xgfsLT/cuAk7/xlmib+o5SwRk77qD4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=pFpfnsC85PJAVw9cLnv+QF0Kcul/8gXc3DEZOjO1rV+ElKMki/zV51f8TifDWTB+4
	 ZEur5pivQd2Zsq77BytECsjW0yttScaSocOPdZMD4EQi5olgQDyphlei6KRxfUjgUG
	 iBelU/YzpDDnSq+jG6QWiSuq9ImKIeXqV8b+eDX0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A186BF805FB; Wed, 26 Aug 2026 21:18:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F836F80601;
	Wed, 26 Aug 2026 21:18:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59085F80525; Wed, 26 Aug 2026 21:18:30 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787771909;
	b=okgBKskd1X77mB/46TcOG/CdHghtVFEI6Z9BmFk1RCe6PCOkBcABvr2LD1cttWTxJU8t
	 IrlberCQP3dIlehQGiOHyrdjJkO59p1XdIUAYouu58IZyFCS2tG3yPOv8dKBFOwj83k4P
	 M6FfYQD9RlrutrJzhbsn5tw9Gr9nFTZieLCTqA+rs4hl32pdroz4CCaacrYs5ScSwJlr/
	 MKdg3yJGRfhhzXcSzcS/YamV9Srlm6EMiwjvJNGoNPKwpFUiUPOD343Fu2lkOd48L1GAD
	 23oxvXpKZWyvxEjDkcf1zQ37dCMIVWWhhLK9pktlJCHTV192Ww86Bhr97cZKxSDXGdA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787771909;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=K2ar9Hvjhl5W0xgfsLT/cuAk7/xlmib+o5SwRk77qD4=;
	b=Ek5gjFT1JxxqQjpBl3Zy1EEsU86brE7BFWgLiEKoKqVmAVTQYFj/G/wYBCbwwFLKk5Tr
	 b8P1M6ziA0dvYYktqpEzF93pbVzOH6r3J3L/p6NQ+8pS+Dx6D45Gt0JMyfBiW0+mllyKt
	 nDCBG8oZSdztnfxkzTvesLnNMMYOgBM+0x4IEyv/0hSBmueN1xY+cdJlKQrzakyXMKZw4
	 eQPIqmaeO5DSH2hrESvNHyOjkM2RI7p/CUKZP4LKrCxoTS7aXNaN0r0+AgnZZSVpZawOn
	 bPSmu+hLTDVdFi0O2rA1Xt4AFwQGnrX9mjjtT+g/FBre3lX5zzKlyqcyPtt4ce7iuxA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E54A6F802DB
	for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2026 21:18:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E54A6F802DB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cf7113e106ee00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/841@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/841@alsa-project.org>
Subject: ucm2: Qualcomm: sc8280xp: add DisplayPort devices on X13s
Date: Wed, 26 Aug 2026 21:18:30 +0200 (CEST)
Message-ID-Hash: FJBCGVHKHXYJ3TNECTIJ3IUX6YGCT2PD
X-Message-ID-Hash: FJBCGVHKHXYJ3TNECTIJ3IUX6YGCT2PD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FJBCGVHKHXYJ3TNECTIJ3IUX6YGCT2PD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #841 was opened from jglathe:

Model HDMI0/HDMI1 after the T14s HiFi layout: same MultiMedia1 frontend as Headphones, explicit RX_CODEC vs DISPLAY_PORT mixer sequences, and ConflictingDevice between Headphones and each DP sink.

Speakers stay on MultiMedia2 and are not part of that conflict, so the WSA path remains in the ACP profile across DP plug/unplug. JackControl is "DP0 Jack" / "DP1 Jack". No JackHWMute on playback; headset vs internal mic is priority-only (200 vs 100).

Compatible with the existing SC8280XP-LENOVO-X13S topology.

Assisted-by: Grok 4.5 (xAI)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/841
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/841.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
