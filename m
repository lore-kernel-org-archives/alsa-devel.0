Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A326C6FD1D
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Mar 2023 08:41:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 367341F6;
	Tue, 21 Mar 2023 09:40:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 367341F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679388106;
	bh=rxuGKv2YcjFLtsBtnVhbCaKDkGJ/hHLI0wgKkHAFxVo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=eLklm6Gb3r4Um0XVklh8dHsY1A+AkxYQa9ktVvmuWrumv48Gt4LfE21fU85A5Ddhu
	 AHCGXVx3Gn+7EtsFJdZNBzAZlvnoUX/9U1fOSzbqjwLH0qD51L7KVRHcxwxHYbvy0P
	 bJfRoxwhtVW/URhghZ5ctdzz503OOaN3JsiMrGHU=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DB0FF8027B;
	Tue, 21 Mar 2023 09:40:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 64DEDF80105; Tue, 21 Mar 2023 09:40:10 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 8FD45F80105
	for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2023 09:40:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FD45F80105
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - reopened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1679388002632436514-webhooks-bot@alsa-project.org>
References: <1679388002632436514-webhooks-bot@alsa-project.org>
Subject: ALC4080 - ASRock X670E Taichi
Message-Id: <20230321084010.64DEDF80105@alsa1.perex.cz>
Date: Tue, 21 Mar 2023 09:40:10 +0100 (CET)
Message-ID-Hash: 4CVVPTKKSNAIOG4HWYJQJCHQC6YFEAV4
X-Message-ID-Hash: 4CVVPTKKSNAIOG4HWYJQJCHQC6YFEAV4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4CVVPTKKSNAIOG4HWYJQJCHQC6YFEAV4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #229 was reopened from hendrikb-101:

This board's ALC4082 seems to be sitting here:
`26ce:0a06 Generic USB Audio`

After trying out the latest UCM configuration I also tried adding this to my USB-Audio.conf:
`# 26ce:0a06 ASRock X670E Taichi`
`Regex "USB((26ce:0a06)|(0414:a00e)|(0b05:(1996|1a(16|2[07])))|(0db0:(005a|151f|1feb|419c|82c7|a073|a47c|b202)))"`

but no dice (still recognized as "Generic USB Audio" and ports don't work). Sound works in Windows 11 and manually playing a sound like that works:
`aplay -D plughw:Audio,1 /usr/share/sounds/alsa/Front_Left.wav    ` 

Is there anything else different on this board besides the device's id?!

This is my [alsa-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/9771968/alsa-info.txt).

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/229
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
