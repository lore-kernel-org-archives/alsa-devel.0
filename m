Return-Path: <SRS0=xcY/=3T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2530C33C9E
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 07:07:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C09C20702
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jan 2020 07:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="s/HaEiMA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Z22M/ikm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LtYiJ+eK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C09C20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C71E51664;
	Thu, 30 Jan 2020 08:07:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C71E51664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580368070;
	bh=90Rxe2lTuXe5HNesS3Ew64rD/CrCtjZJu4FEvQgv34k=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s/HaEiMAcAPUGDeKZk8PWG0x8+EUNFRtqX2PGqAhEEO2LgDIZtkXeR49QrYAjTl5R
	 g2OjjbNyN7VpIy+mJwCbdwNU2RwmkRwoMBtQoSePuMx679H5IIF5cWkAh7QnDSchpl
	 utcy8maeJkqHbAOYNJKBpYsvBuR2lR4V081KVvoE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E5F6F800F1;
	Thu, 30 Jan 2020 08:07:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D7A2F80150; Thu, 30 Jan 2020 08:06:57 +0100 (CET)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0673DF80123
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2020 08:06:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0673DF80123
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="Z22M/ikm"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="LtYiJ+eK"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 9BB8122006;
 Thu, 30 Jan 2020 02:06:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Thu, 30 Jan 2020 02:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm3; bh=V7DHPQWCr+QkVJn0dBGQPpxHj/J
 jf5BWQ5ZQzvHv2EI=; b=Z22M/ikmBOhowH8YQ8GSFzZy85l6rTZtz9B/OPlUkIc
 Yl22HDn+PzODJpaXNlc5yoEp7dS/w7ZyZbTevB4ihjL4uBEWUNdX19hKn8ZTrYr9
 pSAhLFC6E37QRboKj7J6z0skl5ruxl+iVNrCiLYIKXVukg0t9QLBNJ6W7bBI3s4l
 JDrvTiVVWkZXoXKoUvr5eLci26oM/NxNwm+L29AxqpbTo8hSqVtWeF3aDBscLvAO
 zBd90H4+gHx8PdOLLZeuKDnA4U7Flm7TW/2lMrvjYPxauxNUSkxk4tDHqmpml+Mk
 qraHX4mhYro5sIahFVnam2Y8l7rM8FKzV5LIm5PI+Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=V7DHPQ
 WCr+QkVJn0dBGQPpxHj/Jjf5BWQ5ZQzvHv2EI=; b=LtYiJ+eKZDpIpCYMMVtfHQ
 KXz8UdSw1qkHgcU2xBfCsTki6bP4+dhutFtLgTgWi9C1e8kI5gwqG/xFSaQS3gVZ
 Rm4hIZfN0J6An0wwvp8andne+HYZXK4UJruLH8a8Yf0dMqWV/AORPITOjzob5cvg
 /ASCJcovEEk96dZNNA+t3e4MNq+51BQ0yJp6YAXh9MOXXmFUpJpUqdNEsAnAFsF2
 J1xboUnbZNWZJ9aF8bRT4UR1Tnl7BU518fH3DC24h09O3BOc+CLlo7ISq68v5qis
 4t5qhbTfCvJEA3F4qx9VshWclbnFub92eoGeoCETJTuWQq/EYv8EmKBl+bBRQ8yg
 ==
X-ME-Sender: <xms:hoAyXsBHSN23wX_J--t_wdRT-ZJo6LjBaM-FpWVSHD6po69B4OMqNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfeejgddutddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfgrkhgr
 shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
 hjpheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudegrdefrdejgedr
 udeikeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:hoAyXoxFLmmDc_yXNSejKI0KA-uZOLtA79nyiYMVwuEJtxDXgM6vkQ>
 <xmx:hoAyXugQhN0MJQ3cHEkTCldZan-qSReIoUI8fr4EPx3KoWM24yfLeA>
 <xmx:hoAyXqbBitwNBCgZ3vNzDYUAx7qBzrVAEyPfQAdPTSS1X6IBy76rKQ>
 <xmx:h4AyXq89eOaegKPP-KQEQChnsU-Wndua-GeRUj4AuWhxVjeUkhrmQg>
Received: from workstation (ae074168.dynamic.ppp.asahi-net.or.jp [14.3.74.168])
 by mail.messagingengine.com (Postfix) with ESMTPA id EB32E3060A88;
 Thu, 30 Jan 2020 02:06:45 -0500 (EST)
Date: Thu, 30 Jan 2020 16:06:43 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20200130070642.GA7741@workstation>
Mail-Followup-To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 sylvain.bertrand@gmail.com, alsa-devel@alsa-project.org
References: <20200129232340.GA23769@freedom>
 <fffaf462-fd7a-6d09-e808-21d94f883365@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fffaf462-fd7a-6d09-e808-21d94f883365@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, sylvain.bertrand@gmail.com
Subject: Re: [alsa-devel] no period wakeup support
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, Jan 29, 2020 at 05:43:19PM -0600, Pierre-Louis Bossart wrote:
> > Nowadays, is this reasonable to consider disabling the period wakeup as default
> > instead of expecting period wakeup by default?
> 
> I'd say yes - it's been nearly 10 years since this capability was added, and
> it's quite common across HDaudio, Chrome, Android plaforms.
> 
> But considering this as a default doesn't mean it's available in 100% of the
> cases, you still you need to check that
> 
> a) the driver is capable of disabling the period wakeup
> b) the driver is capable of providing a precise position outside of period
> elapsed events (usually marked with the INFO_BATCH capability).
> 
> alsa-lib gives you the means to query both cases.
> 
> Note that you also have the case where you cannot disable interrupts but can
> still use timer-based solutions (e.g. for USB audio).

I suspect this advice.

In design of ALSA PCM core, runtime of PCM substream is configured for
the mode of no-period-wakeup just in a case that userspace application
requests it[1].

As long as developers take enough care of compatibility for existent
applications, it's better to support period wakeup for each IRQ as a
default, then support no-period-wakeup mode as an option.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/sound/core/pcm_native.c#n715

Regards

Takashi Sakamoto
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
