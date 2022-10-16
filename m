Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6ABC4332F
	for <alsa-devel@archiver.kernel.org>; Sun, 16 Oct 2022 01:38:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25F0F81C7;
	Sun, 16 Oct 2022 03:37:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25F0F81C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665884324;
	bh=ldy+pMFhORNFiFTTc0fDVzq4I3HXRofcJ11er0g7MLA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NN0XZWfnTk0kZMeFFTAsWpCb8O2uFoU+11Qfd4h5I7gAjhhbnMQyElgJXSz0Sp5fR
	 cGtVcrh7Frk9rjbFGm2+eB6b/2LNrz8ODzPEabqiAZedfdXLoc8B/lNDrxDzvY9LtR
	 GhutJPaf+pKoNqp7oWeaeszVcd7KMQGDcGnFW1HE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B28C4F80224;
	Sun, 16 Oct 2022 03:37:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F374BF80482; Sun, 16 Oct 2022 03:37:51 +0200 (CEST)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED13BF800C1
 for <alsa-devel@alsa-project.org>; Sun, 16 Oct 2022 03:37:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED13BF800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="Gyo1Xi3l"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="fuYJ+miz"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id E31AF3200786;
 Sat, 15 Oct 2022 21:37:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Sat, 15 Oct 2022 21:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=cc:cc:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1665884262; x=1665970662; bh=UF
 LjsWQ8Ayimtdzmcr4gAgW5OtjjMdavo5hWLZwmoEg=; b=Gyo1Xi3loSZUgNK8aC
 EnmGOmMx2sOb1Z+M0f75SnhaJX94STEYgkCAEQgte7BpUlZO3ekdlZHPI5AVQuG4
 FbsHrN2DyK2qnHgFjWuJ7dlM0BQOnjuGwJjV3CsSMxZ9TjukW/Y6kxxSUngJXKQo
 PXWlemVYJyazFD1czqIplmBZQX3+6kyjphX5B1q8iFhTJGVv/0sEMoXyZvD4dzY2
 IcibWvi54irGLPot2KvZe5GKzCcQ6unszXMrRFNBU1g+37+4mIKJYbfpvnZUe7pO
 3siPCO6oJ19LA6aX6ZZn+iMO3kOvVx2l5RA4z9SmvgU7KhNXorkWkEbJADdWLDNG
 QeDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1665884262; x=1665970662; bh=UFLjsWQ8Ayimtdzmcr4gAgW5Otjj
 Mdavo5hWLZwmoEg=; b=fuYJ+miz4AGBC8VgEAEfUYt9JUiC3HdrPHNb5J/RL+yj
 P3Ad7YwmqR5UqXV/QTzO+yashibeJVueIaC8DYqBp2xHGGBju8Pa1pLxFM7xbKFG
 bpt5qoEsGwImzM8dL+7pv7QfbMZMwfxIKFW0QipeKrb//pIULYHX9rlOZa5hCPDK
 A8on7dBGRDxjcZkULhBzkdDt8ivlqah/sA3LLMuNZ7zlsKD0cTklig2TBjfUYRpy
 pijN5sjpMAsg4+ZQ9o0G37jfi5D80D+u+yLCLFmnTyMXYAs+giCTUNzXBlg3jXki
 AX4FbHcrnYTEVK1N9SBWh+9rqeBZzUxRWSk1+iTe/g==
X-ME-Sender: <xms:ZmBLY-vayLefxR3RfT7lmp6SQSdO9pRs25I0F51-F7HkLYJwJt8kAA>
 <xme:ZmBLYzd0zpfYobd7vnDie_rp6xYj5_n9J3qSMpxdjkjuNLiXwnOeTaKpX0odx_bH8
 HCXZ7mrZC_IRCLITEs>
X-ME-Received: <xmr:ZmBLY5w9Zet8VOvBamE73QJje6_87cCjQ1T6fP4tt-9z_wzRHva6cGTwk5PY87kiIGx4TTB78obdYuyF-MCaI76kUMyCLm-pX49S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekhedggeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
 shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
 hjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeei
 ieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:ZmBLY5PPKIg0_WxhPo5VMSo0ABMQDfdTEWor1Kd3k928M0tMhO2Xjg>
 <xmx:ZmBLY-83prVI7vG7BC4LGDhCRTAIL9JayaHBKVdLIEXEzapTa7f_Dw>
 <xmx:ZmBLYxUnQQGH-f59uW7w6sOUhuF88kj8tUy946Djs7X8VibFkIZV-A>
 <xmx:ZmBLYwK0gOotl-N4tf3HzbvKMvRGu6GRiMwDcb66PDxsm2ylmoOTIg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Oct 2022 21:37:40 -0400 (EDT)
Date: Sun, 16 Oct 2022 10:37:39 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: George Hilliard <thirtythreeforty@gmail.com>
Subject: Re: [PATCH 1/2] sound: dice: Fix "Firestudio" typo
Message-ID: <Y0tgY3OYlykkXV0U@workstation>
Mail-Followup-To: George Hilliard <thirtythreeforty@gmail.com>,
 Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20221015233330.8679-1-thirtythreeforty@gmail.com>
 <20221015233330.8679-2-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221015233330.8679-2-thirtythreeforty@gmail.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>,
 linux-kernel@vger.kernel.org
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

On Sat, Oct 15, 2022 at 06:33:29PM -0500, George Hilliard wrote:
> No functionality change, just a small cleanup before adding the
> Firestudio Mobile.
> 
> Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
> ---
>  sound/firewire/dice/dice-presonus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
 
Acked-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/firewire/dice/dice-presonus.c b/sound/firewire/dice/dice-presonus.c
> index 967cc3119a64..c85178e64667 100644
> --- a/sound/firewire/dice/dice-presonus.c
> +++ b/sound/firewire/dice/dice-presonus.c
> @@ -11,7 +11,7 @@ struct dice_presonus_spec {
>  	bool has_midi;
>  };
>  
> -static const struct dice_presonus_spec dice_presonus_firesutio = {
> +static const struct dice_presonus_spec dice_presonus_firestudio = {
>  	.tx_pcm_chs = {{16, 16, 0}, {10, 2, 0} },
>  	.rx_pcm_chs = {{16, 16, 0}, {10, 2, 0} },
>  	.has_midi = true,
> @@ -23,7 +23,7 @@ int snd_dice_detect_presonus_formats(struct snd_dice *dice)
>  		u32 model_id;
>  		const struct dice_presonus_spec *spec;
>  	} *entry, entries[] = {
> -		{0x000008, &dice_presonus_firesutio},
> +		{0x000008, &dice_presonus_firestudio},
>  	};
>  	struct fw_csr_iterator it;
>  	int key, val, model_id;
> -- 
> 2.38.0
 

Thanks

Takashi Sakamoto
