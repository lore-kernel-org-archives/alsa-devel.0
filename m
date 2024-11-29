Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA7CD6EC07
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Nov 2024 13:24:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 681F921B6;
	Fri, 29 Nov 2024 14:24:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 681F921B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732886656;
	bh=UlaS+n+NgV0bDNY0/7d38mPFHlRBSWVRbFdU//hWzI4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=mk/t2c5G6DNifD54yzqaaVfwpWXt87D3MAb+C8PH47/59HO2AfwnoR1+1T2utLGK7
	 TtbYnMcKz/zNJ9ceaDr18XSWmZqw+zOlu2qtbWcgvDb3jxjPo6sSc5bG0IMy8tXQH7
	 bmS9oyHSU+MjnaSsro02Db/A2I+md1P8xTRRLD2I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 847F0F805C5; Fri, 29 Nov 2024 14:23:44 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 180ABF805BD;
	Fri, 29 Nov 2024 14:23:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8A15F80236; Fri, 29 Nov 2024 14:23:39 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 47F36F80116
	for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2024 14:23:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47F36F80116
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732886617713476896-webhooks-bot@alsa-project.org>
References: <1732886617713476896-webhooks-bot@alsa-project.org>
Subject: amd-soundwire: add support for AMD generic legacy machine driver
Message-Id: <20241129132339.E8A15F80236@alsa1.perex.cz>
Date: Fri, 29 Nov 2024 14:23:39 +0100 (CET)
Message-ID-Hash: PMW42WFQCA6INGYJI6O2JZP362NDM5X2
X-Message-ID-Hash: PMW42WFQCA6INGYJI6O2JZP362NDM5X2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PMW42WFQCA6INGYJI6O2JZP362NDM5X2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #478 was opened from perexg:

The card components string is similar to Intel's SOF driver like, so we can  reuse sof-soundwire configuration and it is logical to reduce future maintenance, because the chips connected to soundwire bus are similar for multiple PCI bridges.

Example of the components string:

    Components : ' cfg-amp:1 hs:rt722 spk:rt722 mic:rt722'

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/478
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/478.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
