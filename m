Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4121C77B73
	for <alsa-devel@archiver.kernel.org>; Sat,  6 May 2023 18:39:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C37517EA;
	Sat,  6 May 2023 20:38:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C37517EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683398359;
	bh=jmOmvlciVS9lLXw7W9YMfwOZGMztdo5ZzbPV416XytE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=HmbhyaQUC4/R7Sq2OJpT+/OkjGwOBaF/kG+RzExO61h9T2ftul8jJg6xGHF3TCdxv
	 oiiyPO8cVnu5Da8GYdEoIAJJ4IicaOZ3tf0izIMVtmYSlwPLPqtpyNG7WS7gjzBxCb
	 us9YqpII01oeG9rWPeaVl7DB5Pm1MrJJNXE1y4DQ=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E2E4EF8052D;
	Sat,  6 May 2023 20:38:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 45F83F8052D; Sat,  6 May 2023 20:37:59 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 35EB0F80087
	for <alsa-devel@alsa-project.org>; Sat,  6 May 2023 20:37:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35EB0F80087
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1683398269587543726-webhooks-bot@alsa-project.org>
References: <1683398269587543726-webhooks-bot@alsa-project.org>
Subject: MSI MAG B650M Mortar Wifi Spdif input & output are reversed
Message-Id: <20230506183759.45F83F8052D@alsa1.perex.cz>
Date: Sat,  6 May 2023 20:37:59 +0200 (CEST)
Message-ID-Hash: OGBYVHRT2ALEUYTNBCDWU3MIKTSPYV47
X-Message-ID-Hash: OGBYVHRT2ALEUYTNBCDWU3MIKTSPYV47
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OGBYVHRT2ALEUYTNBCDWU3MIKTSPYV47/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #311 was opened from RenEH01:

Hi, I have a MSI MAG B650M Mortar Wifi. I have installed this UCM conf files which provided no sound. I further installed pauvcontrol and I found changing the USB Audio device under Configuration to Pro Audio and changing the output device under Output Devices to USB Audio Pro 2 allowed for sound. 

When I select Digital Stereo (IEC958) Output under configuration I get no sound.

When I select Digital Stereo Duplex Duplex under configuration I get no sound, but there is sound under Input Devices. I believe this is reversed. I do not think this board has spdif input functionality at all. 

A side effect of using Pro Audio 2 for output is that none of my multi channel tracks are downsampled for 2.0. I'm guessing this will be resolved if the above isssue is resolved. Would that be correct?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/311
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
