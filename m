Return-Path: <SRS0=T8Ko=BQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4692C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 17:48:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A304D206B2
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 17:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LtHzxFLj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="nPX227Of";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SmG6LEtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A304D206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7CC28820;
	Thu,  6 Aug 2020 19:47:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7CC28820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596736101;
	bh=rNdU3AEuPHFcs80mc8/ZeYYCwSlB5cZBxDsGd14ImZ4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LtHzxFLjXC+JHzE5tJVebB2LEZZ0v4J2cE60/AAEBeM8GcpT4T9xAUjSNg29ItPbr
	 eJrOoRNmxCYPxu2JK5sWtM8pq3eDkhCUcVwmvPkqSY+NRudP+L7T751iVTUlRsbVS8
	 L32Al6Pg+3y/JAseUbsGqLbAdfxc+W1DuaEt6CoI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EAA8F80159;
	Thu,  6 Aug 2020 19:47:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9B20F80159; Thu,  6 Aug 2020 19:47:29 +0200 (CEST)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0BB36F800B7;
 Thu,  6 Aug 2020 19:47:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BB36F800B7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="nPX227Of"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="SmG6LEtq"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id 64700CB6;
 Thu,  6 Aug 2020 13:47:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Thu, 06 Aug 2020 13:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=RKeMvIh3bkzwIN9Yu37V3LNYweb
 MbXPbmcdFlYZHI2M=; b=nPX227Ofu9MmI2/hCLTR9tXhxOaFmPlAEaq+TubvI5X
 QkQBayGo5/CIaUHkVUMDe1471X0LBts287/UYgqOWlIMTsI2NCoMvM5idZ8gePUV
 nw5cTAVjUYlZ3ZddJOXhytDi4ltT+wK4cnUbbXfd+lS/yoLIBAaa3oxBMxAGjRX2
 vqcP4RJngPvxCxfK90NwemQIIpdwAodZ3eY7Gr3Oel1mq9d3I+h1fgnH207ji3Gb
 HrLgKsjfr85QBOFoz6qIexscMdAszndopiR1BjbsbI+Y4BC+J6yzS5Uej570PlLY
 SQVg2LXDMap0y4XeUsS+oLFPRMh/OfPwigL1XI0Rcjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=RKeMvI
 h3bkzwIN9Yu37V3LNYwebMbXPbmcdFlYZHI2M=; b=SmG6LEtqSobTyn2PHXBg04
 sup6hTU32tFtHPxUm7lsEB3thwjJCqnal5Bd9NDci4d3+CMniYYLjISx5UZPzoDH
 vLK/bFmo0GSMJlDDLRVtUG02qvoBR8vi3AwvrTrE8ySC42qj5o+V2hABJIJKFfGX
 pcWlUIckSVr1fHt9EVZjfQYJeU/22RJ1Ex94nRbiLlq+/SzqJiS3DpOiqWEeLiHK
 mOpiinGOEmSdGz0arMK5zhUKdMZccXiUeUH7GskHctfzC+zAiRiLLDxbpgGwVHxV
 SKzbo9jlT5QwTqI8VWyjyGmu0LDF+RbRlM5ClY387U7UpfzAGOozsIJTWaMx7Yng
 ==
X-ME-Sender: <xms:H0IsXxIkN2PZxYrbYu2KdvegQUSecwD_r10dDy4U8M6gebWltqstgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedtgdduudelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
 hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
 hpqeenucggtffrrghtthgvrhhnpeelhfeugedvjefgjefgudekfedutedvtddutdeuieev
 tddtgeetjeekvdefgeefhfenucfkphepudektddrvdefhedrfedrheegnecuvehluhhsth
 gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihes
 shgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:H0IsX9KjcO3L5K1eE78c54AhSkrT5HywaP0LV8fQf7LUx66EsFzJxQ>
 <xmx:H0IsX5vEHGUBEXceWsWcOvbskw8fkLrUFK5YgFAEG90GhrvRKA9coQ>
 <xmx:H0IsXyZkqtPNKo8bgwuOenEG6oc_9JzaZJ_P5IR3qxMp5XujgDXY7w>
 <xmx:IEIsXxC6hb5Qbibm2jUjTCU_JAHigIJcuUn4b1KsYJn8rLxrmG4z8g>
Received: from workstation (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5EB673060067;
 Thu,  6 Aug 2020 13:47:10 -0400 (EDT)
Date: Fri, 7 Aug 2020 02:47:08 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
Subject: Re: [pulseaudio-discuss] Why doesn't mixer control (values) have
 some kind of locking mechanism? (mutex?)
Message-ID: <20200806174708.GA404054@workstation>
Mail-Followup-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>, 
 Tom Yan <tom.ty89@gmail.com>, alsa-devel@alsa-project.org,
 alsa-user@alsa-project.org
References: <CAGnHSEkpYqyZJjG587FSVUzYX2zV1tm83zj+uGjF4e24o4iAMA@mail.gmail.com>
 <20200806020601.GA6286@laptop>
 <61bf48f0-e63e-c762-c083-27a0bf371483@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61bf48f0-e63e-c762-c083-27a0bf371483@linux.intel.com>
Cc: alsa-devel@alsa-project.org, alsa-user@alsa-project.org,
 Tom Yan <tom.ty89@gmail.com>
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

Hi,

On Thu, Aug 06, 2020 at 10:30:36AM -0500, Pierre-Louis Bossart wrote:
> What I was trying to describe in my earlier answer is a different need to
> have an atomic update of *multiple* controls.
> 
> If e.g. a DSP or hardware engine exposes two separate filters for left and
> right channels, and the coefficients for those filters are modified with
> separate controls, it would be really nice to have the capability of writing
> these controls separately, but have a 'commit' mechanism so that these
> updated coefficients are used at the same time by the left and right
> filters.

For the pair of left and right filters, the simplest solution is to unify
the two control elements into single one, as you know. The array of
two values can be passed to your driver by single system call and
ALSA control core surely calls driver code under lock acquisition
against any operation for control element.

The other options are case-by-case. At least, you need to describe each
detail for better discussion.


Regards

Takashi Sakamoto
