Return-Path: <SRS0=okCM=C5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046B1C43465
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:46:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEF820575
	for <alsa-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="F7pxwaTB";
	dkim=temperror (0-bit key) header.d=sholland.org header.i=@sholland.org header.b="rAQrhhB5";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AbCyfx6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEF820575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E92A15F2;
	Sun, 20 Sep 2020 20:45:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E92A15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600627584;
	bh=bZ2EnYEWFewPiVyiZAM9DVj8IzBWpOvF/wsLvkqSxZM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F7pxwaTB+mNAoEzZA3x2bMRP15aoCU7/UbziKo76PMpttyJFdBjFM2M5XmP8tDFJ1
	 B506uLkUMwkEYGxfe9mbt3Of4D2HQ6Y/FQfhAE0Xt1Z+rtHOPiO4V1Pw11nmaisRXZ
	 XJonpsrh7awU2A/BCII/DL3uLjUq6qrtnTkikf2U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B68FF8010A;
	Sun, 20 Sep 2020 20:45:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9927AF80229; Sun, 20 Sep 2020 20:45:32 +0200 (CEST)
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E465F8010A
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2020 20:45:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E465F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="rAQrhhB5"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="AbCyfx6U"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 12AC9580195;
 Sun, 20 Sep 2020 14:45:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sun, 20 Sep 2020 14:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 subject:to:cc:references:from:message-id:date:mime-version
 :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=U
 ktx1VRTJlKt926xOC0fJTdMwvcW/tqqviFWzSCgYTM=; b=rAQrhhB5BY0ozfCkJ
 ULTtKfgOS3lObtqJesEa7hjgZauSluJH9jNbISNOMO3zbDec68JUb5gZBeBOpok5
 m+9OAWwbJ+jfiMXM8DdSxxpFbnDtZX7H5mBhFPCWOg3SPbUBGuLMVgXbLLWUqlSi
 4oUigGIyYSul7rZXoxrx2t1mmg50ixyI+VX5MBEnDo5++2Ew/1y65jFYb/sMkjGx
 4Re53tg45uWn7be/XhNg6csizZBb+cvXfZ330fbWNX+PfUjqALaJif1tcU3/C9Gs
 V8r7cadIatj9uJRQ6XUdmhXYJtUUj5QeYQbi8zwlkKUuLfMqpZ556n+0COra6Mz7
 /7tsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=Uktx1VRTJlKt926xOC0fJTdMwvcW/tqqviFWzSCgY
 TM=; b=AbCyfx6U/EbMMaPCWW1L77lTvD7DlIDa0Az2WEgvymv2ZaG96RfPHawTu
 WS4z/r/r19hSvIlclTboFKRiY6hy8R/0hUM9Z/T994jKm/GF5bAdfkQ4RVA+glbp
 vcsFZtxbEem/BAdBusZEoSGnQ7LMUllTlAYs9jLiCb1GtB/U3z8jgRVgkzExp7Hj
 uur7YrQhy0pnbBe1AyOBtC0HnfFauPD4WOC4kH5yJqNft38GQwX3rILolLrkdiij
 ON154Jscjw4AakZWff6WsEpBqomqgpy8QZnpj/QC/G7bf16t33PMokahpcZ/VI8Y
 3ydIJLbCGGub5YfsTxUmQ1yqp4nUQ==
X-ME-Sender: <xms:RqNnXwSI0Wrg8dfDYN4_sS3QU-0_62cUy31SVgAMDBEJwXLz2dZ5Zg>
 <xme:RqNnX9ydEN93faF_-710xV6VuUdqP6V1fJiAA4_uxVacTfwmox-_apY7Ef8Z3Kpfg
 7xtLWGKoBzc1FHO_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtgdduvdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepgfelkeduveejtdejhfeiledvhfeggeeiieeklefhfeefffffffeg
 udetteelieejnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
 nhgurdhorhhg
X-ME-Proxy: <xmx:R6NnX902Fy5EhF0jiUx3_Pl0HOoeA9_3WEGJyerJ-_8NP2iFAF6tfA>
 <xmx:R6NnX0BWzPk2KOx8Oh9NsQCn8idrKwokWSLrylMqMrQTCSRKu4jDOQ>
 <xmx:R6NnX5j9wTAF8rmwFN0dXZm0MetMKinuMIZyFkp0Z48pEnTnSMtfzQ>
 <xmx:SKNnXyZCTMzcRgmjMOOqgzJNPEPVkdOzn-SsTtg1jQcKIkNyZPwHpQ>
Received: from [192.168.50.169]
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 63E06328005A;
 Sun, 20 Sep 2020 14:45:26 -0400 (EDT)
Subject: Re: [PATCH v3 05/19] ASoc: sun4i-i2s: Add 20 and 24 bit support
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
References: <20200920180758.592217-1-peron.clem@gmail.com>
 <20200920180758.592217-6-peron.clem@gmail.com>
From: Samuel Holland <samuel@sholland.org>
Message-ID: <2d2799c5-62e8-8e64-c739-3d85b89c1178@sholland.org>
Date: Sun, 20 Sep 2020 13:45:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200920180758.592217-6-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org
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

On 9/20/20 1:07 PM, Clément Péron wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Extend the functionality of the driver to include support of 20 and
> 24 bits per sample.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
As I have mentioned before, if you want to support a 32-bit slot width on sun4i
variants (which patch 2 does via TDM and this patch does via PCM format), you
need to fix sun4i_i2s_get_wss() to return "3", not "4", for a 32-bit input.

Cheers,
Samuel
