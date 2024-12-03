Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2F6E64AA3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:39:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77235F54;
	Tue,  3 Dec 2024 14:39:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77235F54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1733233181;
	bh=E72FRzm+G4f7H71DgxMT7FBl2wUV4mQztPcy4EkUg+4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=pQHKPpw3Wb2mvn06UxpW8TV97VuflE40XfsdUbotvjXoFD/WPLb8GqZFXC9yKaVwj
	 4dUJJAgHDUQ67KcEzX7seGX/gEmz4p0YJY5iamxnfKWakoVduvTmlBc/xYN6SDO5wR
	 Azs8TlXH9Z6UR41mbmBPd2p722PmKLpIO55yhSrY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12A2DF805C5; Tue,  3 Dec 2024 14:39:07 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 564F9F805AC;
	Tue,  3 Dec 2024 14:39:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69759F80272; Tue,  3 Dec 2024 14:38:57 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 2BBB2F80073
	for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2024 14:38:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2BBB2F80073
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1733233129608801603-webhooks-bot@alsa-project.org>
References: <1733233129608801603-webhooks-bot@alsa-project.org>
Subject: UCM2: Intel: sof-hda-dsp: Enable Dmic0 DRC and TDFB pre-processing
Message-Id: <20241203133857.69759F80272@alsa1.perex.cz>
Date: Tue,  3 Dec 2024 14:38:57 +0100 (CET)
Message-ID-Hash: SOBU3P5G6Y2DMJ3B7IPNEW3VJKTF3S72
X-Message-ID-Hash: SOBU3P5G6Y2DMJ3B7IPNEW3VJKTF3S72
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SOBU3P5G6Y2DMJ3B7IPNEW3VJKTF3S72/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #481 was opened from singalsu:

This patch adds enable of the microphone capture pre-processing features as BootSequence inital values if the controls for them are available. If the user later switches these off, they will remain off.

The DRC is dynamic range control that boosts the capture level, and the TDFB (time-domain fixed beamformer) improves capture signa-to-noise ratio for set beam angle direction. The used 0 degrees angle is defined as angle towards notebook computer user.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/481
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/481.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
