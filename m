Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C138EEB64DC
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Jul 2023 03:59:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 346F31FC;
	Thu, 20 Jul 2023 05:58:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 346F31FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689825550;
	bh=mdNBTldOL6PUT/vtG6xIcJox7GE/RMcRUn6r63lC/K4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=W16b1eTata9kVT/v19LZcM1KT2dnGey4Oj+CuCvZ3ClP+geobpxHL7vt+h9q724Y0
	 0tU5pdwxURFXUCwWrEJsYGIPItF8ER7m7byGGKAu7xE8cOTTU3ttnAzzbU41UkENic
	 7PmdyK+Gmu3KbDyFZjA2gnU0Uta2oiH9DbUB/hv4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2534EF80494; Thu, 20 Jul 2023 05:57:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4945BF8047D;
	Thu, 20 Jul 2023 05:57:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1E77F8047D; Thu, 20 Jul 2023 05:52:08 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id E42E0F80153
	for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2023 05:51:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E42E0F80153
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1689825115049217224-webhooks-bot@alsa-project.org>
References: <1689825115049217224-webhooks-bot@alsa-project.org>
Subject: Broken microphone switch on mtk-rt5650
Message-Id: <20230720035208.D1E77F8047D@alsa1.perex.cz>
Date: Thu, 20 Jul 2023 05:52:08 +0200 (CEST)
Message-ID-Hash: 4EIQIIS75X2FUXXRHZ55377NZPJKXIN4
X-Message-ID-Hash: 4EIQIIS75X2FUXXRHZ55377NZPJKXIN4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4EIQIIS75X2FUXXRHZ55377NZPJKXIN4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #336 was opened from jenneron:

The problem is that both headphones and mic use `JackControl "Headset Jack"` When there are headphones without mic connected it switches to external mic which is not present.

In kernel there appears to be only one switch https://github.com/torvalds/linux/blob/3c8b5861850c734add65233e538d4a8c2dff95d9/sound/soc/mediatek/mt8173/mt8173-rt5650.c#L130-L135 responsible for handling both headphone and microphone. So, how is userspace supposed to distinguish connection of headset and headphones without mic?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/336
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
