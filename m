Return-Path: <SRS0=Df35=DS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11B1C433E7
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Oct 2020 11:34:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6401F2225F
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Oct 2020 11:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="T58w0WUv";
	dkim=temperror (0-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="IpVVD/o9";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ceo6vjeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6401F2225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B31883A;
	Sun, 11 Oct 2020 13:33:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B31883A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602416039;
	bh=gq/gNsr2Ije0onBIHHiqD3efih4vSXfKob2kNT8DyIg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T58w0WUvtra9ooPg42wSOzxlSn7YHNHBLJB9RocTW71B9yd03khFMaxdCBuRwEysy
	 f9yuUlrkXC+w4RLU68HtvOeOp6UCJX+LhNQ3XImE1hHOrqnDPOuLLMnhxFt/VW0Qmj
	 9ZGF8xdCjVVZIn42w4tIYWTIW/OulYiqpcl3gvl0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE2D8F80148;
	Sun, 11 Oct 2020 13:33:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9F8B2F8016F; Sun, 11 Oct 2020 13:33:06 +0200 (CEST)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5DAEF80141
 for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2020 13:32:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5DAEF80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="IpVVD/o9"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="Ceo6vjeG"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 6916258C;
 Sun, 11 Oct 2020 07:32:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sun, 11 Oct 2020 07:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=+ebymQySiF7n21UOcFO9mizXixa
 NxwiZj2RVBB0uKW4=; b=IpVVD/o91q9rAPnu5miR6RQPgMLz4TobuQNkmO1/VxB
 0WAARCx1Qtvv8AvdqUB+Gtr2Kk+uXbGjvcUfTI5d9/xp23c5fiwhQ/63+X9v6X8T
 k8dNSXF4XllngQBL3Zock6eSJE5TUki34jFY0NhsstdArkAeeW36FbKtjhcbyVKq
 KUasJeAj9nXrco6fT6ntBZhJQe9eNOyyQk4eocvuxm3drKGpSvPZJdnTYcC4iIos
 NDMWm55NbgizmGeICFnd25FeDkJTFPgnb+egtVL4rPqT6/ooeRjLXvF/qYs4MS0F
 vXZ/2Ng3FhOXebraad8sHRv9iBDHcS/IeIbRCpWmmsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+ebymQ
 ySiF7n21UOcFO9mizXixaNxwiZj2RVBB0uKW4=; b=Ceo6vjeG1gvNM+jX+sY8eq
 fQdktd4m/Z125EdbtnQf2vVHxa/AE/xmMOvwbYTDFmdK7ixvCUQQIjWowVRDvidz
 AjpCivDnG4LUIhuMpC9aQiY9nRKbTpLPKFr+KxzZUjV85ChjJxa5ktASs7Lb97Hp
 oNVtABg7mWwsSLeHW4q1a9c2Il3LjtzZXiN5l9HiNxXJ4RrnV1daDFLw3m35G+oD
 o7mheeO7RerCyovBv3+hmuCa9i48CG5kjKdZPxn4pDC16t+Sh1y04s2C4cfVUWDt
 5OaT/XPyRpa9o4Mpl+HNf4CxOGk/NCNH2NMWDtHImeyjis+NWhgICAF4XQIfpUdw
 ==
X-ME-Sender: <xms:Y-2CX8wYszKA2GLZn5UN7zjMIFxWelt_9Wv-hrmJjRpWO5xs62Lz-g>
 <xme:Y-2CXwTzjorHYjaGzLbjH2JiL5NuoBDZBBAT6GFQjTT6CvapiDcx0U27IElAc3xId
 _TWv-yhogEzByMviNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheehgdegvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgrshhh
 ihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
 eqnecuggftrfgrthhtvghrnhepvdetfeevffeftdetuddtudegfeevleettdetiedujefh
 jefhkedvieeltdehuddunecuffhomhgrihhnpehlihhpiedrfhhrnecukfhppedugedrfe
 drieegrddvtdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
 rhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:Y-2CX-VoQ-RdDaC9yqqL_qSVhRNVEjpn0M0G83S9UwK8YoCjEwm1mg>
 <xmx:Y-2CX6jT8E6jo6lSYjRvKbQFKygIAD44SM9mg2QWz3TtZ-S3oIXutA>
 <xmx:Y-2CX-DS1gU5vd5TiJ_ApoDd_S_VU_pP_HcfGqYZhsDFCKQ3lqY5uA>
 <xmx:Zu2CX0BGa9yQUKuV0G0w6HonCm_ZMqJyWSa3fTfo9vFFLh2JrBiOTg>
Received: from workstation (ae064207.dynamic.ppp.asahi-net.or.jp [14.3.64.207])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6437A3064610;
 Sun, 11 Oct 2020 07:32:49 -0400 (EDT)
Date: Sun, 11 Oct 2020 20:32:47 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH 4/8] ALSA: fireworks: use semicolons rather than commas
 to separate statements
Message-ID: <20201011113247.GA333010@workstation>
Mail-Followup-To: Julia Lawall <Julia.Lawall@inria.fr>,
 Clemens Ladisch <clemens@ladisch.de>,
 Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
 Joe Perches <joe@perches.com>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-janitors@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <1602407979-29038-1-git-send-email-Julia.Lawall@inria.fr>
 <1602407979-29038-5-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602407979-29038-5-git-send-email-Julia.Lawall@inria.fr>
Cc: alsa-devel@alsa-project.org,
 Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
 Clemens Ladisch <clemens@ladisch.de>, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Joe Perches <joe@perches.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
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

On Sun, Oct 11, 2020 at 11:19:35AM +0200, Julia Lawall wrote:
> Replace commas with semicolons.  What is done is essentially described by
> the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):
> 
> // <smpl>
> @@ expression e1,e2; @@
> e1
> -,
> +;
> e2
> ... when any
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  sound/firewire/fireworks/fireworks_pcm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/firewire/fireworks/fireworks_pcm.c b/sound/firewire/fireworks/fireworks_pcm.c
> index 980580dfbb39..a0d5db1d8eb2 100644
> --- a/sound/firewire/fireworks/fireworks_pcm.c
> +++ b/sound/firewire/fireworks/fireworks_pcm.c
> @@ -148,7 +148,7 @@ pcm_init_hw_params(struct snd_efw *efw,
>  	}
>  
>  	/* limit rates */
> -	runtime->hw.rates = efw->supported_sampling_rate,
> +	runtime->hw.rates = efw->supported_sampling_rate;
>  	snd_pcm_limit_hw_rates(runtime);
>  
>  	limit_channels(&runtime->hw, pcm_channels);
 
Oops. It seems to be my typo added at the commit aa02bb6e6078
("ALSA: fireworks: Add PCM interface")...

Acked-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thanks

Takashi Sakamoto
