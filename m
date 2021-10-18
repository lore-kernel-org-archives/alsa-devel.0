Return-Path: <SRS0=JS7s=PG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D062CC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 12:44:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5A760F22
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 12:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA5A760F22
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE5601AA8;
	Mon, 18 Oct 2021 14:43:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE5601AA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634561075;
	bh=MMpXx4EvmjSnQ6FOaDXBc7/DAcngFQdNpwtSMukX8rg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rOM0X2foL7z4+YD9HOwH9fc3r8EDEhapOlxtoRS5051pN/0V9sOErsB9VSJJ8CVfv
	 qi8V9vZ8yS77uZ4LbwZ7Vg3K0HWOx8JO5RGZFrST1baYH8HdZge+2hjkU7TfWVWH5f
	 8zO4Tr1b17iwsAygw970us/imK8DTfs2HeEabwKg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4542CF80217;
	Mon, 18 Oct 2021 14:43:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 616C0F80224; Mon, 18 Oct 2021 14:43:43 +0200 (CEST)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C811F801DB
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 14:43:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C811F801DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="cNAdne7b"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="Rlhx4scR"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 60AA53200E31;
 Mon, 18 Oct 2021 08:43:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 18 Oct 2021 08:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm2; bh=VMvPUAeWdT5q9P36poNQ5jDABWB
 QkypGj4rnfryxjEY=; b=cNAdne7biKAQbRaa6PjlahE4Mr3tEtHOa1zpc5/UH88
 fmwU/JU3pCYhWVTROKQoAmZbl7LVIN1VClub39gP7coMWRDSwL/+pDamvnGDmhGJ
 QfYf4iCbuPYh5lzUq8FPnwm80MMIHA0ogGTpKNsqolfWYCfW1iaRqr86XIZVZzE8
 OBLpQeczsQjBhWE7JzTFns2t4fjE9MvnCxCHQHOoSaAAFYm+4AGRUlaI8plTEGwy
 nYUazr4E+1+ObxWD9RpdJRzEhfteUQko5x8STE1Qq9CYpYigMtmuytUbBmrbS6Fy
 lPTzNv3GsM2USxn1s4UUUZRIrEPkd1B/tpaZFcY2iJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=VMvPUA
 eWdT5q9P36poNQ5jDABWBQkypGj4rnfryxjEY=; b=Rlhx4scRfUDHJBbWL3U3Nd
 qz526dBCBBkuuM1h2OUNB/t+Rg3dx6LRLAfBtQ1OA9NIOT/Cn2/aT/8PpdGCuqEZ
 3cpQNaPHWLbzhaLRkHeHcLpkGuC7/2dlOU0eQK/NTRuwTAwVjHBUqvqt8F6IjgKD
 9bNNdA1253CEUSf8o01sP+jFd6VAIonNzdZf62hQ/lMm30MQobGup7tv+fNuGRHw
 VlESyLL/YeXRZZrAOIUDqvilaZWHp8QlKx5UcOEFM/HtdmXvzxYFmkJv0qN+qtgS
 drhqZrETKGagjOGXtuIYqqWNO1ywIXGHV8LBJXuXIU7CHWUbyNppfwKNxQ019qSw
 ==
X-ME-Sender: <xms:72ttYea9S9hgdUf-nrwkssTbOptOr9h0BLcOvbPzd4oopb4_GcwArQ>
 <xme:72ttYRab2vCd9hTSCguL_N681feeiXuAZcmfzDJ5kjJ6_OF0xoXSLIKOldlHacmg4
 MDvwOhWM5ggMSZeeq0>
X-ME-Received: <xmr:72ttYY8kEviL_Wusuel8hM57iXdNFUjjZx24OO-F8IkFxz9A3IGfeFs3hYyASLFPfRIhzhO8KwoFjJTlY8X6bneLw62ctEek9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvtddghedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
 hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
 hpqeenucggtffrrghtthgvrhhnpeelhfeugedvjefgjefgudekfedutedvtddutdeuieev
 tddtgeetjeekvdefgeefhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:72ttYQp3Sefv1AGxCmRP9JCwrY03LddODoxX3PIdNlPG9QnCTx8N-Q>
 <xmx:72ttYZpvtiAsrKqTq7PPkMTvZOBApEB24LEBnJPdsD1v6mA8X0vUkg>
 <xmx:72ttYeR80MRt3H249tOSAhPWEwDQ0W0Ng1wBeSN7x27nXWOm5wYoBA>
 <xmx:8GttYYSkA4GoIfHhjMKOMDSa5uQFU11CjUBKasjBw55Rvx8gqKcO5w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Oct 2021 08:43:26 -0400 (EDT)
Date: Mon, 18 Oct 2021 21:43:24 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: uapi: Fix a C++ style comment in asound.h
Message-ID: <YW1r7KL+I9XBiAlw@workstation>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20211018114035.18433-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018114035.18433-1-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
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

On Mon, Oct 18, 2021 at 01:40:35PM +0200, Takashi Iwai wrote:
> UAPI header should have no C++ style comment but only in the
> traditional C style comment, but there is still one place we used it
> mistakenly.  This patch corrects it.
> 
> Fixes: 542283566679 ("ALSA: ctl: remove unused macro for timestamping of elem_value")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  include/uapi/sound/asound.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
 
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

When adding code comment into UAPI, I'll take enough care of its style...

> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index 5859ca0a1439..5fbb79e30819 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -1002,7 +1002,7 @@ typedef int __bitwise snd_ctl_elem_iface_t;
>  #define SNDRV_CTL_ELEM_ACCESS_WRITE		(1<<1)
>  #define SNDRV_CTL_ELEM_ACCESS_READWRITE		(SNDRV_CTL_ELEM_ACCESS_READ|SNDRV_CTL_ELEM_ACCESS_WRITE)
>  #define SNDRV_CTL_ELEM_ACCESS_VOLATILE		(1<<2)	/* control value may be changed without a notification */
> -// (1 << 3) is unused.
> +/* (1 << 3) is unused. */
>  #define SNDRV_CTL_ELEM_ACCESS_TLV_READ		(1<<4)	/* TLV read is possible */
>  #define SNDRV_CTL_ELEM_ACCESS_TLV_WRITE		(1<<5)	/* TLV write is possible */
>  #define SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE	(SNDRV_CTL_ELEM_ACCESS_TLV_READ|SNDRV_CTL_ELEM_ACCESS_TLV_WRITE)
> -- 
> 2.26.2


Thanks

Takashi Sakamoto
