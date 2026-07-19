Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3643FC4450A
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jul 2026 00:16:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34563601EF;
	Sun, 19 Jul 2026 02:16:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34563601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784420207;
	bh=ymfkLiawsgVLaYvh5T1oHPpcwYPkW5/Oolht/1FXLb4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=o3PUzt6sF/24Sjdqd9LkC3vy9fgimIJsIa9HGyQnrQBs63hFKggymqBfnbN70lyeG
	 YRIhaGQ6PTvQ2JVjAl9586ZjzKDnvSpkXeFT7Utx8XUaFNZHoYcioMTroeBVbzqyH1
	 dDtVs98TiGL/CK9HqE6IZq6t/OOn+naO7rJeIaJQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5188EF805FC; Sun, 19 Jul 2026 02:16:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 18D4CF80601;
	Sun, 19 Jul 2026 02:16:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 886B7F80551; Sun, 19 Jul 2026 02:16:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784420161;
	b=Xgv7GFwGrb04PEt65wJRYRcyZvCDlHh9D9cwc/S7AObW/df9njqZs490GGntycFYgnJ4
	 JeRlpSbdq+KSdXtjF8oMaVFiboO8U8wmkBuc5reltw4wQn0GLMwuFTR66yG3epTSRTAJO
	 H+qocnuOd3AnTtdjANUsjwWUGxCgFktv68S569zUpdMxQaL4BssP9cFTe9siKPu1FpMby
	 cttisySHeiJll9JiCseL9Ab9QxzQI2+aa7+mSJUgaoUWHfC+KUrdcBTu0+ZYRlU4dvt4H
	 onLF+gPvgirIPwr9QidsFWgPY1XkcQYR/wUeBZbTVdZ8ghKIE5rpkDAJUlIvkM2BxuA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784420161;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=ymfkLiawsgVLaYvh5T1oHPpcwYPkW5/Oolht/1FXLb4=;
	b=JLPsctCm7Z8VgV1gkhcifChweJB7beV2GuOsakpYWQ3/Eh7uyHLixMqLfWhx0MOEtBUv
	 HtRKZF9uEU5D0jPbCu5mb5rWAhOn4vBwf5lIE+byzVzjJ75kMhv1gv7yinzP58m37Tahv
	 9TzPuvqSVId69cB1Zvx6PgWAx8KB9sF6xwMi4AdI5h8SJVho8yFBCBr7ffTE0Uf3EdS3z
	 gWCc/A63KILa1aSAYf7/pIONLPuAACpWGi23FJSRUs1sCIPvYu/WQLymC3s0+iYf670Sw
	 RCuf5FWqIjLZf8Hv9234SamiFUkJC4ilDHXYCByTb/6WjxJNv5d095QChE4QKWgwWgA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 11D23F80246
	for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2026 02:15:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11D23F80246
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c388ae63774d00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/814@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/814@alsa-project.org>
Subject: ucm2: MediaTek: Add SOF UCM for mt8186 mt6366 rt1019 rt5682s
Date: Sun, 19 Jul 2026 02:16:01 +0200 (CEST)
Message-ID-Hash: OCJJB7H4HDCDOIVCMXN7RZR3ARY3HZSC
X-Message-ID-Hash: OCJJB7H4HDCDOIVCMXN7RZR3ARY3HZSC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OCJJB7H4HDCDOIVCMXN7RZR3ARY3HZSC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #814 was edited from dangowrt:

Add a UCM profile for the SOF variant of the MediaTek MT8186 (Kompanio 520) sound card `sof-mt8186_rt1019_rt5682s`, as found on Corsola-family Chromebooks (e.g. google,steelix).

The card exposes:
- RT1019 amplifier -> speaker (SOF_DL2 -> I2S3)
- RT5682S codec -> headset jack: headphones (SOF_DL1 -> I2S1) and headset mic
  (SOF_UL2 -> I2S0)
- MT6366 built-in digital microphone (SOF_UL1)

RT5682S DAC/ADC routing follows the existing mt8195 mt6359-rt1019-rt5682 profile (same codec), with board specifics:
- MT6366 internal DMIC needs one-wire mode (`Mt6366 Dmic Mode Switch`)
- headset-mic capture (SOF_UL2 -> I2S0) needs the AFE `UL2_CH1/CH2 I2S0_CH1/CH2 Switch` interconnect
- a moderate analog capture gain for the headset mic

Tested on google,steelix (Debian, PipeWire): speaker, headphones, headset mic and built-in mic all validated end-to-end; jack detection works.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/814
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/814.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
