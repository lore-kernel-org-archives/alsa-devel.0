Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB49D78311
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2024 12:36:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 031021947;
	Mon,  2 Dec 2024 13:36:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 031021947
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1733143007;
	bh=LeOX3I+AcsqcrHraUMzI7Le5xq2aTr1WdEXHilpQ7EM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OpMSRCI2q2zPqi8wLsPjDw4soHoz/FJQnNeH9AAPWrUNgV8f2cdolqC5PtH96EDOX
	 XRgIlDeM0Q+YeTo+OUQvyBypOZr6uyT5bEpy4pTRZ4uPH5Ju2/DKP9A19vge7EzIAt
	 Xd5mBVr4ntjBW0lp/qohKDF51NmFAnm1nneyY4nA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F0A5EF805BE; Mon,  2 Dec 2024 13:36:15 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 26CCBF805C1;
	Mon,  2 Dec 2024 13:36:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06D0FF80272; Mon,  2 Dec 2024 13:36:09 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id AB948F80073
	for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2024 13:36:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB948F80073
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1733142965877290249-webhooks-bot@alsa-project.org>
References: <1733142965877290249-webhooks-bot@alsa-project.org>
Subject: Unable to request ucm2 to load BootSequence controls defaults
Message-Id: <20241202123609.06D0FF80272@alsa1.perex.cz>
Date: Mon,  2 Dec 2024 13:36:09 +0100 (CET)
Message-ID-Hash: QNYEKOKG4PTO22DC33DAQPTTYNNUOTOE
X-Message-ID-Hash: QNYEKOKG4PTO22DC33DAQPTTYNNUOTOE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QNYEKOKG4PTO22DC33DAQPTTYNNUOTOE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #480 was opened from singalsu:

I'm stuck with my ucm2 patch to set by default control switches for SOF DRC and beamformer "on" when the controls appear for first time. I don't seem to be able to reset the controls for the SOF sound card to defaults.

There's a similar feature in https://github.com/alsa-project/alsa-ucm-conf/blob/62acef2efffdcb75a35f90d266bcad145b4eab35/ucm2/Intel/sof-hda-dsp/sof-hda-dsp.conf#L112 for "Dmic0 Capture Volume". But I haven't been able to see the volume to go to 70% in my tries to reset the configuration.

In Fedora 41 I've tried to remove /var/lib/alsa/asound.state and rename /usr/sbin/alsactl, reboot, and rename it back. But no success. The volume control remains in 100%. Similarly my tries to get DRC and TDFB enabled fail.

What is the right trick needed to trigger the BootSequence?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/480
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
