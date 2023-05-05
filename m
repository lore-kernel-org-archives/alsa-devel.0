Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D201C77B75
	for <alsa-devel@archiver.kernel.org>; Fri,  5 May 2023 10:44:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44B232C5B;
	Fri,  5 May 2023 12:43:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44B232C5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683283462;
	bh=lplHaKa0BrhHkdJWzvIm2c0q65+ElO9YHb3IoNwE+4I=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RNOzWZ9jQZK+6Ev3I4Vdc6vf7plXQqRtoTUad6udM84fnyj1p3fvV2eNVyJePsd23
	 HjFCLPwFrQPpHR9rBKdms9k2hOhYrCnV78L+VCfIQ7yrIzhDi+/Fc6PuhdA5jWcVip
	 sYitrGhf7HvJdG5YZA/OIGlMAXHTgPzHDna06pVU=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FCC1F80087;
	Fri,  5 May 2023 12:43:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 202F6F8052D; Fri,  5 May 2023 12:43:03 +0200 (CEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E932DF80087
	for <alsa-devel@alsa-project.org>; Fri,  5 May 2023 12:42:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E932DF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256
 header.s=fm3 header.b=Bz7cz1oU;
	dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm3 header.b=RqXJnCqZ
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 6CB9D5C030C;
	Fri,  5 May 2023 06:42:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 05 May 2023 06:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1683283371; x=1683369771; bh=RC
	TWVk0KOAVQ/MkChme+8/6o8h9CkRTO4hkaOFGb8H8=; b=Bz7cz1oUuN9Ila0jCg
	gsP4cAo3R88v0BuIlQw1Iuc/Jj6Cj7ZXE9Fshdcm/j3oLmC4sr5jhqeNzc9p244X
	W0eLkFo/G1Z/ZC1YyMBGKM2xwor/lJ6H8k9vcz6KMSOTVXZLOjR00Wknyf7QcCl4
	t5gzw0uAid9TThPkEfNxHiS7M76D6UYONrLWramwxBm68cGMXuUfPCtxj4lFJo0t
	KbQ0QmzgnPxYW8n/mHyNyGdoCl/aruEtt4cKDmlmmmHtaJ1cjCqlraTijs710Tqr
	Sgje05/RuvhRmmMjF4kqoX5QtwiucfxcpnBsylSWqUQ0CQtGD11Pp9I/aNTFn8sM
	l4EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1683283371; x=1683369771; bh=RCTWVk0KOAVQ/
	MkChme+8/6o8h9CkRTO4hkaOFGb8H8=; b=RqXJnCqZQliMjqwLuDeWV6/a8f/8w
	Ex08I0VVzwluGBAFMlMOsi04uS+XzUJB8SVqq4e1sNrsKX7sDjPKNHn2EQG1Eq9w
	Es9fyZgT+upuxBCRw/feo+jcDAgeeSEZGJik2zalGiOKJTG2OIvVedodQl0F2hyX
	yMGoHCwfnfFK3d6G5FZRWMTCD8PKSjz4vN69ycV6YrkDkEmiAIPJXsIlVIZZ78t/
	D2nIYuUANhFurxcvLdV3MMts9Jz3LDeaIXkg2oLIFObfoPY2IjlU0m74402AUcPR
	Fz2LeYE8LsBr6BJeQyAQP+H6H15fWfe/AVu0IM2T7gpL5nxc44wmnX7Gg==
X-ME-Sender: <xms:q91UZEtqwzQfHlBVK8mMUtYYGXFHothsncvoO6cgnAUdoole3iQJTA>
    <xme:q91UZBfAzVecWUB6Rspa9NELo2WaOtSeOhB5qNbzwcivY0AUXwfBfwWrtPrVtAoeg
    Zbm_5Oe4BxegA>
X-ME-Received: 
 <xmr:q91UZPzLwzvzEplPrtZlnBrpRDOJLLVFBJQ7pMqO9iSW1VMWy76AOfOKqHpS>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvhedrfeefvddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:q91UZHOu1TTFc2_K8TvRiOMUtur5kvxN65ASjKvMFVXWiKq57x26Nw>
    <xmx:q91UZE9d_kEYgYuEIa7CD_-TKyzu6wMDuBp6W-Nl0sczL7KMf1edgw>
    <xmx:q91UZPVQ3ai0cckISVAcXEuDgeCcTwI4Hqo5bsVXEkqSVA_ETw6-fA>
    <xmx:q91UZAuGKvyPNXUwWWOc0qPH82LmGpPhyNoID6R9ibALztDQ9XNsVQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 06:42:49 -0400 (EDT)
Date: Fri, 5 May 2023 19:42:44 +0900
From: Greg KH <greg@kroah.com>
To: yixuanjiang <yixuanjiang@google.com>
Subject: Re: [PATCH] ASoC: soc-pcm: Fix and cleanup DPCM locking
Message-ID: <2023050534-errant-crusher-0379@gregkh>
References: <20230504092142.4190069-1-yixuanjiang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504092142.4190069-1-yixuanjiang@google.com>
Message-ID-Hash: DDW7Q3U3MD6YLJDPTON6XUTGEREP2HNH
X-Message-ID-Hash: DDW7Q3U3MD6YLJDPTON6XUTGEREP2HNH
X-MailFrom: greg@kroah.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, stable@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DDW7Q3U3MD6YLJDPTON6XUTGEREP2HNH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, May 04, 2023 at 05:21:42PM +0800, yixuanjiang wrote:
> From: Takashi Iwai <tiwai@suse.de>
> 
> The existing locking for DPCM has several issues
> a) a confusing mix of card->mutex and card->pcm_mutex.
> b) a dpcm_lock spinlock added inconsistently and on paths that could
> be recursively taken. The use of irqsave/irqrestore was also overkill.
> 
> The suggested model is:
> 
> 1) The pcm_mutex is the top-most protection of BE links in the FE. The
> pcm_mutex is applied always on either the top PCM callbacks or the
> external call from DAPM, not taken in the internal functions.
> 
> 2) the FE stream lock is taken in higher levels before invoking
> dpcm_be_dai_trigger()
> 
> 3) when adding and deleting a BE, both the pcm_mutex and FE stream
> lock are taken.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> [clarification of commit message by plbossart]
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Link: https://lore.kernel.org/r/20211207173745.15850-4-pierre-louis.bossart@linux.intel.com
> Cc: stable@vger.kernel.org # 5.15.x
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  include/sound/soc.h  |   2 -
>  sound/soc/soc-core.c |   1 -
>  sound/soc/soc-pcm.c  | 229 ++++++++++++++++++++++++++++---------------
>  3 files changed, 152 insertions(+), 80 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
