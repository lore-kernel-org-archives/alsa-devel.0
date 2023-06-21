Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6550EB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 05:05:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6508582B;
	Wed, 21 Jun 2023 07:04:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6508582B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687323910;
	bh=gsE7TzsZMJaik6JWym0Tvl1jIcRIDPaCmtf25TcqzQY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=uEBuUkBeyiWBipRGjlHdIh4geGwfKf7wQGRBHONbe5t1nhhBEHND0e36mO5N5cwtd
	 VO7Xi1vf1rOmhGTFxBhs8IIZYoINWzjfk4TUJT/nnS9ackI1B85ROrVMPO3ygq6y+z
	 utfib6aNYIZKV/Xuns4poWtiZZsaECW22bTBRx08=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2710F80141; Wed, 21 Jun 2023 07:03:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 65BC1F80141;
	Wed, 21 Jun 2023 07:03:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C4674F80141; Wed, 21 Jun 2023 07:03:15 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 6984FF80124
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 07:03:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6984FF80124
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1687323787137549877-webhooks-bot@alsa-project.org>
References: <1687323787137549877-webhooks-bot@alsa-project.org>
Subject: Thinkpad Z16 Gen2 Mic mute LED not switching on when press F4
Message-Id: <20230621050315.C4674F80141@alsa1.perex.cz>
Date: Wed, 21 Jun 2023 07:03:15 +0200 (CEST)
Message-ID-Hash: MXOE54VIR5N7AZIVDQ7VWZBASQTNUCO3
X-Message-ID-Hash: MXOE54VIR5N7AZIVDQ7VWZBASQTNUCO3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MXOE54VIR5N7AZIVDQ7VWZBASQTNUCO3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #326 was opened from pma1:

The mic and sound output works fine.
alsamixer can switch on/off the F4/Mic-mute LED automatically.
But when press Fn+F4, the mic-mute led is not working.

/sys/class/sound/ctl-led/mic/card1# cat list
129

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/326
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
