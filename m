Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56940CA600D
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Oct 2026 17:23:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2239860200;
	Thu,  8 Oct 2026 19:23:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2239860200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791480227;
	bh=nSydQOVqzY7SmtE3PA9Qcc9FavCI1VyVUSekqfzjyl0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=VvkMNULztV32pg3sRrhpIomVk744VoFP/MWZK3393zvACD+QHYmeQiwi9Er5UnwHo
	 LoVGHt9LfYSlEKfwvN3IG1M1xebtr3GYjkicDIeH+s7rKbIWXLvsrGu+UU5O/iebTD
	 TOYHviCpgPzK29NFBIZ2jx+PadGrFpsc9K73+tGU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8ED40F805F2; Thu,  8 Oct 2026 19:23:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 207BAF80602;
	Thu,  8 Oct 2026 19:23:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ECABFF80571; Thu,  8 Oct 2026 19:23:06 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791480186;
	b=JHcV0cTvrNhppwHnv0Gls430kOJ5OAfauGvu3CTTyW1B01nmaxqoPG48L3Bf6o23EtNG
	 XacxSmxoSOuc8Sfv35Car8At2hZN1kOlH3/9LrVfP/boWMjuUhPiOo4bxlmAol3Y1BVHG
	 v4cIj/FBzPNVlOMoXmy4rKD9Yjk8NDiXmYsjFyc7q9WrxSoW6QAI7CZCdVL06IJjblWCm
	 XLOzSzQ2jkS+YeiouX6QjInsZjFVnEdZ+pEi2V1hlT5UIskCUP21Zl4MVzMaayt1uBwGK
	 mRsUgzcJagt5nFAA0kEudjed7qQZJjcFthGBOSUGOEVmSXKXOJPqhKtQI5wF6qfXkLw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791480186;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=nSydQOVqzY7SmtE3PA9Qcc9FavCI1VyVUSekqfzjyl0=;
	b=fBpDDHkPQfAlnEUIUHH8JavCVlRqJz6mDo4G6W+6gPKUUzASmrqe1d2NPNZwDL99XH2a
	 0HL4S9NLPUlGSWBsV2ckTHwjeVibVXn3fDBIfM85gRiNaqaMLdHQ/MY3FxifE0ASPmxwv
	 0gLdx03Ey4bFv731dLB2o1OC8jzH9buB2JJdt2sCiy3X+Rw+//z4JKmw9hZQ3vEggvnwt
	 9roDnJn+KLlWrnu+3EBDckajovz2u+eQgcR8TEPS0RR8TWSh5IVX0sB2cAm6/N2Hi6Y76
	 M1LwLhf+JS0GMChRTi3nj2uDiWT/dR8bzdXNYXiV7IGhYAgqBplpiQzFE5LZSNqzFYA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C150F8007E
	for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2026 19:23:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C150F8007E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18dc9dbc857add00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/869@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/869@alsa-project.org>
Subject: sof-soundwire: add ES9356 device files
Date: Thu,  8 Oct 2026 19:23:06 +0200 (CEST)
Message-ID-Hash: NPGKHVEEVMLBI2WXMDCKFXV2J7Y2HEJO
X-Message-ID-Hash: NPGKHVEEVMLBI2WXMDCKFXV2J7Y2HEJO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NPGKHVEEVMLBI2WXMDCKFXV2J7Y2HEJO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #869 was opened from kannoy2024:

Boards using the Everest Semiconductor ES9356 SDCA codec (for example the MECHREVO WUJIE 14SAH with AMD ACP6.3) report the component string

    cfg-amp:1 hs:es9356 mic:es9356-dmic spk:es9356-spk spk:es9356

so sof-soundwire resolves the device files to es9356-spk, es9356-dmic and es9356. Those files do not exist, UCM loading fails, and WirePlumber falls back to the "stereo-fallback" profile, which only exposes the first PCM of the card (device 0, the headset output). Desktop audio is silent even though the kernel side works.

Add the three device files, using the PCM layout of these boards: device 0 headset playback, device 1 headset capture, device 2 speaker playback, device 4 internal DMIC capture.

Tested on a MECHREVO WUJIE 14SAH (Ryzen 7 H 255, ACP6.3 rev 63, ES9356 on SoundWire link 0) with mainline 7.2.9: with these files Speaker, Headphones, Internal Microphone and Headset Mic all appear in PipeWire and playback plus recording work.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=222092
Link: https://lore.kernel.org/linux-sound/20261007193038.2473068-1-mario.limonciello@amd.com/
Link: https://lore.kernel.org/linux-sound/179145019931.16888.9682263186729943710@gmail.com/

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/869
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/869.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
