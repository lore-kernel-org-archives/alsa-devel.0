Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B71D41D41
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2024 00:03:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 193AFF51;
	Tue, 12 Nov 2024 01:03:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 193AFF51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1731369829;
	bh=NWnVupaAr5xce8G06h0fF4KVcNjOyhngRKHPBgGMQRY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=tBdaAiiGe/Q+tWk/gh3+KpWnUBGUQbXaE/vtSTccuj41MuR6yqRDklQ7JyUlL2k7L
	 oGrnd1F+B4S9Yg/2hv+rZzubeVp5nDmjPgKYCd5DfdrcJNKsGizxSAuIVtdtwsa9uc
	 dgdRoifvwFVryLv65MXWPLwwX/osGvg5s2FNfmcQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B77CBF805E6; Tue, 12 Nov 2024 01:03:08 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CB2AF805D8;
	Tue, 12 Nov 2024 01:03:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 17D73F805C0; Tue, 12 Nov 2024 01:03:04 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 756F3F805BB
	for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2024 01:03:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 756F3F805BB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1731369782468131065-webhooks-bot@alsa-project.org>
References: <1731369782468131065-webhooks-bot@alsa-project.org>
Subject: ALC4082 - ASRock X870 Steel Legend
Message-Id: <20241112000304.17D73F805C0@alsa1.perex.cz>
Date: Tue, 12 Nov 2024 01:03:04 +0100 (CET)
Message-ID-Hash: 3CNLDJCFC5QG3ZJNPQTFYE4JBVSN5UOM
X-Message-ID-Hash: 3CNLDJCFC5QG3ZJNPQTFYE4JBVSN5UOM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3CNLDJCFC5QG3ZJNPQTFYE4JBVSN5UOM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #462 was edited from cybik:

Following up on https://github.com/alsa-project/alsa-ucm-conf/issues/334 | Relevant PR: https://github.com/alsa-project/alsa-ucm-conf/pull/461

The card "works", but there is one feature missing - though I hesitate to call it "critical": S/PDIF / TOSLINK support is incomplete.

While sound works "fine" (ish), it's limited to 2 channels.
* Plugging in another device (CM106-type, for example) gives out a plethora of configuration options (per the screenshot), though this also comes with having to select the right output
* The USB audio outs are output-specific, which is VERY welcome, but the S/PDIF out does not allow for any advanced selection like "Supported Codecs", and the HiFi 5.1 and 7.1 do not appear to enable any IEC958/AC3 support in the background

Is there something missing in the config files to allow for such support?

![image](https://github.com/user-attachments/assets/906ea829-0210-49a8-ba16-ad1b5b1285ae)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/462
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
