Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA9BC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 16:57:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16B964F11
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 16:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16B964F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 582991655;
	Thu, 18 Mar 2021 17:56:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 582991655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616086667;
	bh=gCEirWoFZr21IJHyjb1zygjaeg6CizY6mqS9+y1XYKI=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EymVJkhB9Z1WCB8IDTM8x0Ub0Wfldtnx/BUtg6lRHx7RUUWXnudzQyA/kS2zw8rNO
	 PtMFHub9pC4pmKFarHJ8ziVn+3vqbp5y25P7qeQy7l78ueCOSjNgmm1o15NYTrlmUe
	 WgLa70yHEinmLQl7bGBpEsC65D/waOGa8Fvna0UI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DA5AAF80163;
	Thu, 18 Mar 2021 17:56:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A328F80165; Thu, 18 Mar 2021 17:56:56 +0100 (CET)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58969F800C8
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 17:56:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 58969F800C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="wzFkKmbw"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="PaUmzMUv"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id E9BEC1637;
 Thu, 18 Mar 2021 12:56:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 18 Mar 2021 12:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=y0Je8PhhfpB1uox2CDCvy/HHecC
 kGZ9VivRRmEggYvY=; b=wzFkKmbwiLecqSnPPnn2nI7bMM+oTckSEH2MXFNhVxE
 STEhMElGqMFL1+UvXsD+CwIdvZEpe7Md1wzeciAeUvJKu2zSmh4XzYJbFIjJNiIB
 KGRK2qa/8RgeOOo9TgCKtpM7Q2g3jk6ko7x+lEsNJmRxIIOGikQ2Y56X3+wT/7wF
 mRR3bA1jF7Oo51k3k3Z57xCA6zRlhxOFDukzBaF4IwXEUYvgpr18nia6+u7Jk0d+
 imN0kjSHrk/fxTYDBUNbeyUETL/t5BHUntW+zpr8gSReoD9Nk1faya9IaTAOJhRI
 xI1rXQN7udeeBTEtPpiRVBnpfACt1unLYcZsvQkz5Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=y0Je8P
 hhfpB1uox2CDCvy/HHecCkGZ9VivRRmEggYvY=; b=PaUmzMUvUzpryY9/Sf/m+x
 npjdJJgrje6/ZK+oBGOeCAoXGbqKrlidKjzLvxYE2d4naUYX6/GMj4IrAE12onAa
 rOJIyCM3aa3I09lHWw1OYepqZ+1d5vxmtRr4fCAjdUWqdM8WryGSWFGj5bxbX09k
 A60XcGLzL82P5MdrVI0ciUkk+qVyDdevn3gHdJba20jdyZGQ12vyxkVLWGntMSj2
 hJO1+92Mavq5lAneDIbSyz83XZCC2F1vxD0/qat868sVy6vegNXhn90y6CcYrfVZ
 XeUsf3ZOl0Q6ISLw/IdSZF6MJ3bXpXtrmcCzP8rW46Z6CTrrVQSQ3n89nnn6Vpeg
 ==
X-ME-Sender: <xms:RoZTYG8ADQ_1HGrD_5uepc44eXj0dlrCaUL2Nc9HCsughBrvaF4frQ>
 <xme:RoZTYGsFNwe9D3r3b3o-krWDery6BuJXSb5t5Otr1T0imjMyh_mP9gbL8HOdGhvGi
 kvw8zZ29B6vmC4qdT4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefiedgleeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
 dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnheplefhueegvd
 ejgfejgfdukeefudetvddtuddtueeivedttdegteejkedvfeegfefhnecukfhppedugedr
 fedrieehrddujeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:RoZTYMDIT0E3t1sl6eeGlVnwyHVeIkXHrvz_H8toyaDuklv2-QQOOg>
 <xmx:RoZTYOdlOFPRq35lAxAgLRtH3Oi1403G2czAW2d13hb7S5QP1MN47Q>
 <xmx:RoZTYLOxyJkFydPO3uxhfRqBdikOcUgQHt3-6LDQcU2iQ8a6rv7Jog>
 <xmx:R4ZTYB2nSRD5vdjVCF2cKY6zf2sy5kz_sQ8yP129xOp0Ix9q1U2s1Q>
Received: from workstation (ae065175.dynamic.ppp.asahi-net.or.jp [14.3.65.175])
 by mail.messagingengine.com (Postfix) with ESMTPA id 0B5B4240054;
 Thu, 18 Mar 2021 12:56:36 -0400 (EDT)
Date: Fri, 19 Mar 2021 01:56:34 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Jaroslav Kysela <perex@perex.cz>, tiwai@suse.de, tanjeff@cccmz.de,
 alsa-devel@alsa-project.org
Subject: Re: [alsa-lib][PATCH 0/6] add API of equality and comparison for a
 pair of control element IDs
Message-ID: <20210318165634.GA277809@workstation>
Mail-Followup-To: Jaroslav Kysela <perex@perex.cz>, tiwai@suse.de,
 tanjeff@cccmz.de, alsa-devel@alsa-project.org
References: <20210318103013.265264-1-o-takashi@sakamocchi.jp>
 <16eab1c6-03ef-fb06-9e5d-888de1cb63b4@perex.cz>
 <20210318163715.GA273829@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318163715.GA273829@workstation>
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

On Fri, Mar 19, 2021 at 01:37:15AM +0900, Takashi Sakamoto wrote:
> As I described, your old implementation is not acceptable just by renaming.
> Although the idea of inline definitions is itself preferable. I suspect whether
> inline definition for your comparison algorithm is really less overhead than
> function call.
> 
> Anyway I'll post revised version of patchset later.

Oops. These APIs have arguments with opaque pointers. In the case,
inline definition is not available since the layout of structure underlying
the pointer is not available for userspace applications. Thus the rest of
issue is whether to use 'tuple' or 'fields' in the name of new API.

In my opinion, 'fields' is generic expression and could give impression to
application developers that it includes numid field as well. On the other
hand, 'tuple' is weak expression somehow and the developers easily find
its meaning in alsa-lib documentation (see line 80). When considering about
helpfulness to developers, 'tuple' seems to be better than 'fields'.


Thanks

Takashi Sakamoto
