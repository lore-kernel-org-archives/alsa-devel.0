Return-Path: <SRS0=u2Q7=AV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3C6C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:37:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F3920725
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="q919ymZb";
	dkim=pass (1024-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net header.b="YRhSlHpO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mi+eGrOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F3920725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arunraghavan.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3B2B86F;
	Fri, 10 Jul 2020 17:36:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3B2B86F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594395432;
	bh=tc5ZlBKjCaJMsvln1SNRNUvNtpPbIuOnTMZRcWW9AU4=;
	h=In-Reply-To:References:Date:From:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q919ymZbNoULrGWjTEFbfyZiDYKfo3NoMS2Roquzv5Nu+uji7+jT7NF4C/LgfW++m
	 nhaMlk+GKZPKFc4gCnywEuApqgyoCcVAjWQbweE+f/TvU8Bsd9YgRSs8nxGaQrSB9x
	 0zXP7Aq9U5DTYxfVUnpqhRkU2Ev0d9zgmxm68Jyk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3670EF80150;
	Fri, 10 Jul 2020 17:36:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41042F8015A; Fri, 10 Jul 2020 17:36:20 +0200 (CEST)
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com
 [64.147.123.17])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BCA6BF8011C
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2020 17:36:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BCA6BF8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=arunraghavan.net header.i=@arunraghavan.net
 header.b="YRhSlHpO"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="Mi+eGrOz"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailnew.west.internal (Postfix) with ESMTP id EDC12544;
 Fri, 10 Jul 2020 11:36:10 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute2.internal (MEProxy); Fri, 10 Jul 2020 11:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 arunraghavan.net; h=mime-version:message-id:in-reply-to
 :references:date:from:to:subject:content-type; s=mesmtp; bh=kTiv
 N/pL7IV/vtUxlciNN6TAuLNtB0cSai0354+kSOU=; b=YRhSlHpOCyoCZ+iJFvc+
 iVtumLY6KkL9ZfFQpdCG0Lbv/V7MAYp3JEFSGE1Kuc7okotuvdwFuO/7ieezL/io
 w5JinhqFaoycsEJfJVDGUJFPgknF9EhHvBEuR+3CqLxskHUZ1LqQkLFeSbxmZec3
 t5ilaIptafw2lDeJ+0bC9Dg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=kTivN/
 pL7IV/vtUxlciNN6TAuLNtB0cSai0354+kSOU=; b=Mi+eGrOzQW2mjm0EBMP4x/
 +IhOMp2Odmgce0duVT0KC4HxEFCVM7a28D9uX9b8wX29rJd63VwGpa9uC1vNObT6
 ucWvOA2tgNTwMgVeMoRh7fY8yXkKQDA8Il+XxTlmakj+FcE5WaQkHPONq+mP410P
 cRHEO+h/0rnSJ+rK6ygCknIRRBfGutmR+uEMEVAL/tCAC+VX4zWq04Dp9RyyvMGj
 mRizQfEZc7HZKigvTMq5lFCg+h0dsIf9uYoHA+LrJLNpKES1JtRcIljDVh51qCoz
 xLxb/MnhHX3pmCsnnvPAkmbsws6cAP1vUWKfMOL9zO0BrICHXALPDThQvzJJnk3w
 ==
X-ME-Sender: <xms:6YoIXwRt_kbB527UVVMGqef2SSgmt1LbFcHmNxboipbD1-y4Hcko_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrvddugdelhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehruhhn
 ucftrghghhgrvhgrnhdfuceorghruhhnsegrrhhunhhrrghghhgrvhgrnhdrnhgvtheqne
 cuggftrfgrthhtvghrnhephffgtddvvdevleetffffjeegleefgeehuedvveeihfdvuefh
 udfhiedtheeuffefnecuffhomhgrihhnpegrlhhsrgdqphhrohhjvggtthdrohhrghenuc
 evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhunhes
 rghruhhnrhgrghhhrghvrghnrdhnvght
X-ME-Proxy: <xmx:6ooIX9we7A9sAfCi21OcM3z96zrgI4XS2OwufAJfL1F8be8lWA23Xw>
 <xmx:6ooIX90jcx0K1wlAdAS7y2gKp_7hvfkKTe4tOAzwOS738Vc3Ub2i6g>
 <xmx:6ooIX0A_3vbYx7sgX3oLoIbPkrPrCyc8L_r2oowl0pETzavVpDULsQ>
 <xmx:6ooIX0v0ZfaopDUABef1zxu00vuRwDQ3I3exLiA2hK77ZDj1UWxzc9tBKNw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id DEFB066007F; Fri, 10 Jul 2020 11:36:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-613-g8a73ad6-fm-20200709.001-g8a73ad6e
Mime-Version: 1.0
Message-Id: <0fb11c79-98ec-4060-aaf4-efbdef306a00@www.fastmail.com>
In-Reply-To: <a1dfd3f5-812b-48e1-976a-613a2e4f837e@www.fastmail.com>
References: <a1dfd3f5-812b-48e1-976a-613a2e4f837e@www.fastmail.com>
Date: Fri, 10 Jul 2020 11:35:49 -0400
From: "Arun Raghavan" <arun@arunraghavan.net>
To: alsa-devel@alsa-project.org,
 "PulseAudio Discussion" <pulseaudio-discuss@lists.freedesktop.org>
Subject: Re: Weird jack detection on ASRock B450M Pro4
Content-Type: text/plain
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

On Fri, 10 Jul 2020, at 11:31 AM, Arun Raghavan wrote:
> Hi folks,
> I ran into some weird behaviour on this motherboard. First, alsa-info 
> is here: 
> http://alsa-project.org/db/?f=f48105f391d848b34b3779f27369130ca024f417
> 
> The weird behaviour is that the HDA card is picked up fine, but jack 
> detection is broken on boot. However, this gets "fixed" after you run 
> alsa-info. The before/after codec info is at:

Quick note, the same behviour is seen on unplug/replug on that port as well (i.e. unplug is detected, but replug is not until alsa-info is run again).

-- Arun
