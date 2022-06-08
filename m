Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E63C43334
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jun 2022 18:44:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DA3C1B26;
	Wed,  8 Jun 2022 20:43:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DA3C1B26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654713839;
	bh=OwrRkjAndIN1eGR4geSs0u9bzVeTXjr5YvYeH+47FDg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hF7jUWy2t1LIuymTWHFvhB07J/dbEypv2K8Nmo8aC1quQl4RP3OJ6Itqyu+Ywm6ym
	 Ap+qseb8ELR1eBXbH1b8aYpwP2V9KiJg4B8luRgsVB9MhmdGvk05pLMypnTqM0F//5
	 vAZaRELmOdyGHj1KJanZmUE7k6i6zg7DxFMggO0s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1977AF800C7;
	Wed,  8 Jun 2022 20:43:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C53A9F8024C; Wed,  8 Jun 2022 20:43:07 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E4631F800C7
 for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2022 20:43:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4631F800C7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1654713784042361021-webhooks-bot@alsa-project.org>
References: <1654713784042361021-webhooks-bot@alsa-project.org>
Subject: no input from razer headset microphone when using RAZER BASE STATION
 V2 CHROMA
Message-Id: <20220608184307.C53A9F8024C@alsa1.perex.cz>
Date: Wed,  8 Jun 2022 20:43:07 +0200 (CEST)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-lib issue #236 was opened from fiercebrake:

Greetings everyone!

So I currently have a razer "blacksharck v2 pro" headset that i connect to a razer "base station v2 chroma"

The razer base station is properly detected/listed by (arch) linux.

Problem is though the card and mic are detected and listed, the mic has no actual input at all.

For the mic to start showing/taking any input I need to manually unplug and replug the headset from the base station.

The jack in the base station is a 4-pin 3.5mm (TRRS) jack

This article/fix below seems to 
 alleviate the problem, say 50% of the times. So I am wondering if there is anything else I can do via ALSA to completely fix the problem
 
 "https://wiki.archlinux.org/title/Advanced_Linux_Sound_Architecture#Correctly_detect_microphone_plugged_in_a_4-pin_3.5mm_(TRRS)_jack"

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/236
Repository URL: https://github.com/alsa-project/alsa-lib
