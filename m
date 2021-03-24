Return-Path: <SRS0=3oXn=IW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0AAC433C1
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 12:45:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F97261A06
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 12:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F97261A06
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EA4D1674;
	Wed, 24 Mar 2021 13:44:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EA4D1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616589934;
	bh=5sM55q/YiX1hdVBpHxGsUwHOYyqpDM1nFH8/32QNCsw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JfxAWdoTicW6lqfd/eVm2UzGyxRMEcguRC6Iq/Z9VBWssfRVB9vN7N3M9CCWTnHXB
	 rf1juTjHmuL2Bq2NNICB41TUuxXjL4g1ypgvJ6/r6RzPKEV2NXvKsaoLzDymGKt57V
	 cjfMjJBe0FP/y9YpMzdgqDAGzcTv9DMtyaiA8Jao=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 917FAF80156;
	Wed, 24 Mar 2021 13:44:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54AFAF8016B; Wed, 24 Mar 2021 13:44:42 +0100 (CET)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 423C1F800FF
 for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2021 13:44:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 423C1F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="bTFwhokl"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="rOz+RDae"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id B1EFF5C00D6;
 Wed, 24 Mar 2021 08:44:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 24 Mar 2021 08:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=q0xtl7tkfwT1I18k4zKzC6kbycs
 x8R40wWGAEzP+vwU=; b=bTFwhokl7/75MJHwtvFo1247KZUKTUU/ZEwwHYy2A9Z
 lBPHPb/nR+ziAWHQyBWQGJXVBVw9kFtT1/Pl81F6cR8e58yqsh5PfGyeQ01qkaz8
 vW8duEBgMiSi52y0/Dnpxy521N4YKoDArrkSOI7DXw+Ro1Ci5qf5yoQ+1TGYC7MT
 hDUKLPCDG2uCiwbAliIHSZWSwWpt+bd2ujRDkGPsfNrqW2ZDKKpQCaj6Yz4x8qUu
 g6qFYME7awXylUzcQn20FN8R++MJIKt0LPcoR3Egb6AJu1nOg3o8X/BTrTwQ9JIs
 kbAC+SVmZQsWeB+wSJ1CIim/RkYi9cI6NoxzA8xNg+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=q0xtl7
 tkfwT1I18k4zKzC6kbycsx8R40wWGAEzP+vwU=; b=rOz+RDaeXbOonmgOLErYwF
 ApFH6sAiyH8huVtjntw/7rysfUBZPTap4KwGQzheVITGRXkPnXZwGUkfzzvU8QVg
 CRPGgJlkLHqD0IDDSIoUo2bDcQtuHLxTegTOSEbw4srm0en1ko2E+X/O/qg7w+XB
 Y5gDyOVrojQRxeIkurFh88lCAsuVIgl5mpjuFPcAHU9nfIUXCynBstTW/o3hiOsi
 in4Y7Z38LvQLs66km0eD6/tiH0RASslb4TitS9aaFGPQukybcZ7/Jd/qiE4qwZ81
 pXdGfnsSzsuSOhqpbEJUuVJPAMl+eRo1QOcX2qwXNKgD7EJHvXb38xm7uxGZKwKA
 ==
X-ME-Sender: <xms:MjRbYKq0FTQXvh0zUn5pIQgP_RrhHFuQQSBGnU6KwKpgSbtU3eklJg>
 <xme:MjRbYIrEPO7mNB_hWrF-r8xVBLhzV8Ygq-YL2bvCauNe4YjbHVGoBk9Q0gunPCFwi
 gjG8XISR7Trm6g57SU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegkedggeefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
 dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
 shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepjeegieefue
 evueefieeggeejledvgfejgeffjefgvdekleehgfdtfeetjeelkeejnecuffhomhgrihhn
 pehkvghrnhgvlhdrohhrghenucfkphepudegrdefrdeihedrudejheenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehs
 rghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:MjRbYPMCDNsZVUVcCreT9GaAmpjBBQmzvzBLtqGpJVtbmo_D_M8cqQ>
 <xmx:MjRbYJ7_qsXB-PDWNLU5Xayqs46DZhlrPxT6ZMutY8v8u6ceeefjDA>
 <xmx:MjRbYJ6OYrE1FOIzwW3dL-16lIGYzr1r0kfS9ceb6maYbHo6FgE2Mw>
 <xmx:MzRbYLQg-96BFb-C7itJ0oH_9h9vsMKHbnIYBc2EaG1OgL6VcK-W6Q>
Received: from workstation (ae065175.dynamic.ppp.asahi-net.or.jp [14.3.65.175])
 by mail.messagingengine.com (Postfix) with ESMTPA id 909621080057;
 Wed, 24 Mar 2021 08:44:33 -0400 (EDT)
Date: Wed, 24 Mar 2021 21:44:30 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: David Henningsson <coding@diwic.se>
Subject: Re: [PATCH v2] sound: rawmidi: Add framing mode
Message-ID: <20210324124430.GA3711@workstation>
Mail-Followup-To: David Henningsson <coding@diwic.se>,
 alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz
References: <20210324054253.34642-1-coding@diwic.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324054253.34642-1-coding@diwic.se>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
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

On Wed, Mar 24, 2021 at 06:42:53AM +0100, David Henningsson wrote:
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index 535a7229e1d9..f33076755025 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -736,12 +736,28 @@ struct snd_rawmidi_info {
>  	unsigned char reserved[64];	/* reserved for future use */
>  };
>  
> +enum {
> +	SNDRV_RAWMIDI_FRAMING_NONE = 0,
> +	SNDRV_RAWMIDI_FRAMING_TSTAMP_MONOTONIC_RAW,
> +	SNDRV_RAWMIDI_FRAMING_LAST = SNDRV_RAWMIDI_FRAMING_TSTAMP_MONOTONIC_RAW,
> +};

In C language specification, enumeration is for value of int storage. In
my opinion, int type should be used for the framing member, perhaps.

(I think you can easily understand my insistent since you're Rust
programmer.)

I note that in UAPI of Linux kernel, we have some macros to represent
system clocks; e.g. CLOCK_REALTIME, CLOCK_MONOTONIC:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/time.h#n46

We can use the series of macro, instead of defining the specific
enumerations. However I have one concern that the 'None' value cannot be
zero in the case since CLOCK_REALTIME is zero. This is a bit inconvenient
since we need initializer function in both of kernel space and user
space...

For the idea to record system timestamp when drivers call helper
function to put MIDI message bytes into intermediate buffer in
hardware/software IRQ context, I have some concerns and I'll post
another message to thread, later.


Regards

Takashi Sakamoto
