Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CAB606A31C
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=e43X1tqp
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AF6E60209;
	Wed, 11 Nov 2026 12:05:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AF6E60209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794395162;
	bh=tVfrf99530vTauGYkyqZln0zHUBt4SaNrwyRXcwHjJs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=e43X1tqpJCg8qI7fjr1lnMcureGoP/TtsieS6bVMhIcSPRjHuTks38IHt9X7Pkqcm
	 6VOeYM+dkQh069MOb8Gc6MGoWIYvBWDrg9wAbukay7BQOiAkMbt7vCwLNCFy1XtqRv
	 rT68zfqJkb3DNmQXJNvxc2RSb7LN9EgU5mfzPpQk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AADD9F805FC; Wed, 11 Nov 2026 12:05:26 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AAB3DF805FF;
	Wed, 11 Nov 2026 12:05:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3421F80537; Wed, 11 Nov 2026 12:05:19 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794395119;
	b=g9YZ3t8jS2VJ0M4qOD9GYWOSJuuF4PjkJu9iT1YoxMx26+ifcRvWarch5Xbtp8Sfcfk6
	 mTkv4hHa6fNsNU4aqXMZGq+AMupR2Cum6XygLWgXiJbCnZZ81H15X2XA5+lr49+ZUBGsu
	 0uSUDbQQm/5wFwLNjRdu0FcRymfjx5xRivWE1gVN40V9kA9qaoMVkpK9dDL2OZ96dcufz
	 +Y2FiblwXnxVQumXxSRTD84TK9zETZk2r64ds+/JXZjacIETxUNRnAMvNWl9emTQqSEAl
	 tBoSB5jRrMVrF79WCUWRImYLAisIpjjUUkGgdMxEJduKx++rfiH1F5qMQDdQ9mnWcEg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794395119;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=tVfrf99530vTauGYkyqZln0zHUBt4SaNrwyRXcwHjJs=;
	b=jIhK4KUQ6VgB689dPrNx9A3dsyOmJyDGeGq/3qR/5c24uYeW7sg/bCE/EjXR/LDq/3pw
	 +Jssp/4xSl38geI/t6WaLRaVWyLWhmV50/isF6w/l7JC3g1qBL6DL0f64Y2D7KvB5+fb2
	 hR0XXxWreCvSVPIrk2pVfHyJ4ALXmY7IMP1XHOdKMLh5PfPOvHiDVbCBII8DJnnr9efSk
	 Xqj1EnUK4AqXQqwyo0h0ML+aio77qEbQ0dSpl31Nyh1vJ3UMJsmxRX5JYs7csl6a/o+5b
	 UvZtlzgd/3jEPCBs+ffQqQiw3wEhwqjK6WLMyK4HCcY9EJVHRh5Nq7FAGkAU8sCYSGg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id DCD16F80020
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2026 12:05:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DCD16F80020
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e6f8da2606f100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/906@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/906@alsa-project.org>
Subject: ucm2: Qualcomm: Radxa Dragon Q6A: keep the headphone route when using
 HDMI
Date: Wed, 11 Nov 2026 12:05:19 +0100 (CET)
Message-ID-Hash: W5TJL7Y3D6FRPXGQBAU37PLNJ2RZI4B3
X-Message-ID-Hash: W5TJL7Y3D6FRPXGQBAU37PLNJ2RZI4B3
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W5TJL7Y3D6FRPXGQBAU37PLNJ2RZI4B3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #906 was opened from MarcHT91:

MultiMedia1 (hw:0) feeds the headphones and MultiMedia2 (hw:1) feeds
DisplayPort/HDMI. Each AudioReach back end accepts a single front end, so
connecting MultiMedia2 to RX_CODEC_DMA_RX_0 disconnects MultiMedia1.

The HiFi verb did exactly that ('RX_CODEC_DMA_RX_0 Audio Mixer
MultiMedia2' = 1), and the HDMI device then wrote 0 to the same control,
which on current kernels also clears the back end's link. After

  alsaucm -c hw:0 set _verb HiFi set _enadev HDMI

the headphones are disconnected, and a stream started on hw:0 never
advances (hw_ptr stays at 0):

  before: RX<-MM1=on   RX<-MM2=off  DP<-MM2=on
  after:  RX<-MM1=off  RX<-MM2=off  DP<-MM2=on

Keep each front end on its own back end: the verb clears the unused
routes and connects MultiMedia1 to the headphones, and the HDMI device
only switches 'DISPLAY_PORT_RX_0 Audio Mixer MultiMedia2'. The zero
writes come before the connections, so the order is also safe on kernels
where writing 0 to a route control drops whatever link the back end has
(fix sent to ASoC: "ASoC: qcom: audioreach: only disconnect the route a
mixer control owns").

Tested on a Radxa Dragon Q6A: verb only, verb + HDMI, verb + Headphones
+ HDMI, HDMI enable/disable: the headphone route stays connected in all
cases.

Fixes: 67628fb4871e ("ucm2: Qualcomm: add Radxa Dragon Q6A")

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/906
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/906.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
