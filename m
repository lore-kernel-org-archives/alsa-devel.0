Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443B1EE49A3
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Aug 2023 01:32:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C16A827;
	Wed, 23 Aug 2023 03:31:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C16A827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692754338;
	bh=zS4lhaGjeJYUiH2eFXsRpV2UaojquykBTyr96pDIryI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fdftEVnT2VZCiNFusVNIOT3U1E80uA1OYo7lna7HGJCvLXTjiL2Fu4AGur/RlTgVE
	 Q9sKOjWJPYHo+9hmH2KyLqnZ3Wv1ROsS0TfE6/2ZOAUtnByxFHMyA8WyWKThxmsMq6
	 hHzrbySa4ANr4qeSF6nmrSbZKxKrHS9EIetf1He8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F84CF80536; Wed, 23 Aug 2023 03:30:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CDDCF8023B;
	Wed, 23 Aug 2023 03:30:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA409F8022B; Wed, 23 Aug 2023 03:30:55 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AB3AF80022
	for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2023 03:30:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4AB3AF80022
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1692754254284724474-webhooks-bot@alsa-project.org>
References: <1692754254284724474-webhooks-bot@alsa-project.org>
Subject: aplaymidi causes pa_stream_writeable_size() failed - connection
 terminated
Message-Id: <20230823013055.DA409F8022B@alsa1.perex.cz>
Date: Wed, 23 Aug 2023 03:30:55 +0200 (CEST)
Message-ID-Hash: JCD6JRF2NBMQ3PWI2B2QFJFLZ3CAMUBP
X-Message-ID-Hash: JCD6JRF2NBMQ3PWI2B2QFJFLZ3CAMUBP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JCD6JRF2NBMQ3PWI2B2QFJFLZ3CAMUBP/>
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
   Note: A Focusrite 18i20 Gen 1 audio interface is used  for audio playback and set in Pavucontrol as "pro Audio"
4. play a video with the "video" application.
5. run aplaymidi -l or palaymidi --version
6. Audio stops and soon after the error appears stopping the video.
Unplug the device  
Wait for about 30 seconds (this is important, sooner the error will appear)
Repeat steps 3 and 4 . The error won't occur.

![image](https://github.com/alsa-project/alsa-utils/assets/19564066/9bd6e993-be47-4715-8e6c-5f2a2242027c)

This is not unique to aplaymidi, other ALSA clients may also cause this error.  in almost all other applications there is no error, such a web browsers as playing videos in Youtube, the audio playback just stops.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/232
Repository URL: https://github.com/alsa-project/alsa-utils
