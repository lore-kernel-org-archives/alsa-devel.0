Return-Path: <SRS0=jkt5=7E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57784C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 08:11:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D323320812
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 08:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vatAoIdd";
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="0j5VXpgG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fKvywATN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D323320812
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29FFB1873;
	Fri, 22 May 2020 10:11:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29FFB1873
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590135115;
	bh=hPWa5eapB7RD7Tu9J3LNdMHf6hhCC/xBR/Jyh9jI7yo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vatAoIddBMyLiYfzbCNh6jfVEfya1tohE2jmKnANhicjHun5yZVbdm6iqySrtbpY+
	 btXt2RoOo5f7jVkzCK0lZZryQRULkaAXbI9Lc6/QijiEhHXD8qfEetpqYVZ6Y9H+Xa
	 s6Ao+st/90M9X2isegQw9Eq/YkzQkUn8AO0rx5HE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C44F1F801DA;
	Fri, 22 May 2020 10:11:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71FE2F801F9; Fri, 22 May 2020 10:11:02 +0200 (CEST)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com
 [64.147.123.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04B94F80121
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2020 10:10:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04B94F80121
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="0j5VXpgG"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="fKvywATN"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.west.internal (Postfix) with ESMTP id 79DECB26;
 Fri, 22 May 2020 04:10:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Fri, 22 May 2020 04:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=Wi95KCu2EEyD22g6RskRwb+g0sg
 CGAbgjklKXitHffU=; b=0j5VXpgGGAJyyX9Mrz2MO4SZBX7WnWfqaP3vTnWwKUq
 fLC80pXDxoelRr3F3L6zeBE2hrGC7guDjOpDtYbwsabrBJffJg/A9DzY56si0low
 XzKrcwyipj5VhlbLnWdD441u031xDdMzwZST4HSCloOjlfeJLHvOZNCIy9WC4qF7
 wrHqnAGE6TMlvS37QbMIJHKfPS0p1xiyu1YFi+CVeB85LXofAw3lkmLGSX8rxhOo
 tSvHejM2vieX5+aZySJGCzLjlz5HuEVWFaqdiTD0PZG0pzYPlGGLjRGnmkmYSIft
 wdI5g17EOet4cKtutMOGm2W8PLqo1FAhA+2Ypjuft/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Wi95KC
 u2EEyD22g6RskRwb+g0sgCGAbgjklKXitHffU=; b=fKvywATNAwRnE4YKjayH6M
 b1k2bxvg3+TYYyaueHGGYy9V877RG0ypbPJE433H8JniuLtOa1dyI8yiwMQwbHsS
 Y3OhuR/JkocaqZSoFWTN9XRsbO120Nsd5BMcemBub0WYZvtfg0nAURVRQJsguBC4
 bfwRgv3ntWo5UvbhaaYvFuGcH8EK3J+xjh55rxtu8a4WqvDLhvS7wvjzAULkQ7/x
 J9ngM5YIjrb40/5+S4oG/f5UtfMs6iqzvKnU2WX5wYS/hI9PLr/7wvXzVfBEVesr
 Fuu6vGO8ccVpHWNw10ll++YcRNcLU4m7bh+gAkwKD0XQyHh0TNu9BmFG51wzO+jQ
 ==
X-ME-Sender: <xms:ConHXjFTaYSkJLnqXmpPTAxypxaDa2IQq7GAuwFgzMaMBh8XQaXiIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddufecutefuodetggdotefrodftvfcurf
 hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertddttd
 dvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
 sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehueeuiefhveefhe
 ehudekfeffueevheelueduiefhffejieffieduffejieevffenucffohhmrghinheprghl
 shgrqdhprhhojhgvtghtrdhorhhgnecukfhppedukedtrddvfeehrdefrdehgeenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
 hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:ConHXgWOuHgFRv_xwa83-9dBoU9uAAElx1y337Jy02aZap1E6zNuTw>
 <xmx:ConHXlJOKXBiTf-rojnHa9RiiJLiOgCsaJgnu7jOXsudAyCQIwAr9w>
 <xmx:ConHXhFxb3LeFmrXx_DoFGYzw6eMXrDWcimYLAbaeUaqmWjcdmm4Kw>
 <xmx:C4nHXoCcfEGNhT88yfp1tvTEPqCv0wJ9XsfC1iYg2-AFCabzq6Fv_Q>
Received: from workstation (ad003054.dynamic.ppp.asahi-net.or.jp
 [180.235.3.54])
 by mail.messagingengine.com (Postfix) with ESMTPA id 80B2E3280065;
 Fri, 22 May 2020 04:10:49 -0400 (EDT)
Date: Fri, 22 May 2020 17:10:47 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: bomelp@gmail.com
Subject: Re: Dice firewire support
Message-ID: <20200522081047.GA105169@workstation>
Mail-Followup-To: bomelp@gmail.com, alsa-devel@alsa-project.org, mail@mel.vin
References: <276893435.728967.1590133905081.JavaMail.administrator@n7.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <276893435.728967.1590133905081.JavaMail.administrator@n7.nabble.com>
Cc: alsa-devel@alsa-project.org, mail@mel.vin
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

Hi Pascal,

On Fri, May 22, 2020 at 12:51:45AM -0700, bomelp@gmail.com wrote:
> Hi Takashi,
> 
> Sorry if i bother you about my mail.
> Actually, i try to enable a mytek  dsd-192 dac via its firewire port on a debian 4.9.12.
> I saw you worked on snd-dice module.Do you have a step-by-step documentation to help me do that ?
> 
> Best regards
> Pascal
> France

Although I don't test the device, Melvin Vermeeren added support for
Mytek Stereo 192 DSD-DAC in Linux kernel v4.18 firstly. It's not
available in your kernel.
https://www.alsa-project.org/pipermail/alsa-devel/2018-May/136194.html

If you can't work with the device just by loading snd-dice module in
recent Linux kernel, please contact to me or Melvin ;)


Regards

Takashi Sakamoto
