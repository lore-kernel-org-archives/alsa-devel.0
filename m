Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F32EE49A3
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Aug 2023 01:28:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC33582C;
	Wed, 23 Aug 2023 03:28:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC33582C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692754137;
	bh=liP1P4OmGBdTqxlzN/iUk/CtAMAyLfCEa5rFUtQRMbo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=e1hC4HeQktPfXbFpXQmm4c4g1xRDN0AZCbuOBUNvpJi3ZN/xxs1ZlrR51Hth2R0+z
	 LjGgDwwv5ddp7OiXy6Wv3tiy/IWB17pA9dwKSh9+Yi+cyz0t4ldD8jZScLJgwuQhE0
	 Fk7kpvu0ckxPhD75DtIUGj4GrL13YF/XZxUSZtK4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B93EAF804DA; Wed, 23 Aug 2023 03:27:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 30B27F80158;
	Wed, 23 Aug 2023 03:27:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0AA6AF80158; Wed, 23 Aug 2023 03:27:35 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C638F800BF
	for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2023 03:27:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C638F800BF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1692754053066656113-webhooks-bot@alsa-project.org>
References: <1692754053066656113-webhooks-bot@alsa-project.org>
Subject: aplaymidi causes pa_stream_writeable_size() failed - connection
 terminated
Message-Id: <20230823012735.0AA6AF80158@alsa1.perex.cz>
Date: Wed, 23 Aug 2023 03:27:35 +0200 (CEST)
Message-ID-Hash: TRRXIMLEFDAXKBRGY6BE2MRY2WMYMGGK
X-Message-ID-Hash: TRRXIMLEFDAXKBRGY6BE2MRY2WMYMGGK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TRRXIMLEFDAXKBRGY6BE2MRY2WMYMGGK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #232 was edited from symdeb:

How to reproduce:
1. Plain Ubuntu 23.04 desktop but  with kernel 6.5rc7 and ALSA UMP &  sequencer enabled.
2. Insert a MIDI 2.0 UMP capable device  
   Note: (A Focusrite 18i20 Gen 1 audio interface is used  and set in Pavucontrol as "pro Audio")
4. play a video with the "video" application.
5. run aplaymidi -l or palaymidi --version
6. Error appears.
Unplug the device  
Wait for about 30 seconds (this is important, sooner the error will appear)
Repeat steps 3 and 4 . The error won't occur.

![image](https://github.com/alsa-project/alsa-utils/assets/19564066/9bd6e993-be47-4715-8e6c-5f2a2242027c)

This is not unique to aplaymidi, other ALSA clients may also cause this error.  in other applications such a web browsers  the audio playback just stops.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/232
Repository URL: https://github.com/alsa-project/alsa-utils
