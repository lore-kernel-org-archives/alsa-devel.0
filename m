Return-Path: <SRS0=1tVn=5J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34876C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 01:54:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC8EA20714
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 01:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mSrHdsGw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="iLXX3T4q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e7aPHb1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8EA20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9DD786F;
	Tue, 24 Mar 2020 02:53:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9DD786F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585014876;
	bh=KS4RS+RmLXTkK8iBNmlx1S9JODLxr81lLDoSp3prn1c=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mSrHdsGweBzaeIOBP9YxAoq37GQ7ueiT3Z1cs3kIZ+ygv9TjTvJ/kdiPqTePYfEiI
	 7qtM7nLodT/AWtWyEjYGtE7U5K+4tfyNWWJSd4J8G/Mig2PFew02aFnUxrkMfz0WZB
	 K3H/P1ds4mZwAhIEB1JqJNk/qTcDp/O/NjAjIYSo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70A11F80147;
	Tue, 24 Mar 2020 02:53:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EDB2AF80158; Tue, 24 Mar 2020 02:53:43 +0100 (CET)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E199FF800F6
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 02:53:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E199FF800F6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.b="iLXX3T4q"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="e7aPHb1Z"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 239D55C00E5;
 Mon, 23 Mar 2020 21:53:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Mon, 23 Mar 2020 21:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=s19KurUaRp9y9HFnm+TUdll9SE1
 Tn+bMf6OyXxL40jk=; b=iLXX3T4qeYH1O5Hom7A9oaol1oqS5gk6ANYSwA5TKoG
 lA6cPXXc4qdAZhG+dPBsgV+7EMG+kUgEGuA8Au0wqiauOsnl7Qi0GrUv3FrhiP1T
 dycXIgKnSxPMcfeCDrNAYlXH9atmz9W194I8xFnaJ0yoQNMUmPpbIn6Wjt30TEoU
 4L3GPdRHHprInK95UHlx1T8X722ZzJrsXG6V21Or9Lsdooz7S2HP1l18QaOuQKJy
 Fzaeu/6ly0gh9QsyEnx0lk4RUq4dJtB1FdzQEAOvmR5NU6VmmHiNn0GtKp3T4KnV
 S2l7Zqif78CF0FapvddulXpRsAA6pHNndelAceETvRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=s19Kur
 UaRp9y9HFnm+TUdll9SE1Tn+bMf6OyXxL40jk=; b=e7aPHb1Z3U7ZG6kyRhtO5i
 faQun6nXxUo9LPAGF9Y1mgt7YlG5Dgms+EosmCoFw87pL2OngrSrWxmD6d04theB
 omNL+qwWnFiDM649HDpvEq2YY101CPRXOWb63FZmL49/FQFrJYPh4pQjVCSKmRaR
 2hXBin9ZDFEjtfIxubq2/+PYNfe22ZsdD1KjOTXfm9AW2rSC+7lNLghjQn6Vet3h
 5BjVZYSjFtkJTdvjDzWaoqLrAAtQlcLZS68Dvd/K0A6ZIn1Dd44nudOth4QNdACp
 L6nj3h3XSEruJS/5i66z3rLf2sdhv2hlgyzdEMO86LNGyRU2WAoU5938keIjdEfA
 ==
X-ME-Sender: <xms:H2h5XvY9PC08Zge6d7ycukOeUgTu14h7QnggpWBFROR1N9LqnahG8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudegledgfeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepvfgrkhgr
 shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
 hjpheqnecukfhppedugedrfedrjeegrdduieeknecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthh
 hirdhjph
X-ME-Proxy: <xmx:H2h5Xhpulwl6kiz6sbq9HX-slTySyvdEGi-9ZAAyaA16xyejajhvzw>
 <xmx:H2h5XrbAJxfNpseTUQC_RTV2xkdLTJYKudTA0BqUERfjzAljFMflzQ>
 <xmx:H2h5XhQNOnmlLGGMT7G_pVQQNtknozpzjdBB_dT5_vUWbfvv1ZT46Q>
 <xmx:IGh5Xlh0V2mYi7oSC3V-QWc5JLRL2b5tBNg0VMZHw-v4nevasM20mQ>
Received: from workstation (ae074168.dynamic.ppp.asahi-net.or.jp [14.3.74.168])
 by mail.messagingengine.com (Postfix) with ESMTPA id 357BA30618C1;
 Mon, 23 Mar 2020 21:53:34 -0400 (EDT)
Date: Tue, 24 Mar 2020 10:53:31 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: core: sysfs: show components string
Message-ID: <20200324015331.GA3679@workstation>
Mail-Followup-To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 alsa-devel@alsa-project.org, tiwai@suse.de,
 broonie@kernel.org
References: <20200323193623.3587-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323193623.3587-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
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

On Mon, Mar 23, 2020 at 02:36:23PM -0500, Pierre-Louis Bossart wrote:
> Add attribute and show the components string. This is useful to see
> what is provided to userspace and e.g. used by UCM to understand the
> card configuration:
> 
> root@plb:~# more /sys/class/sound/card0/components
> HDA:8086280b,80860101,00100000 cfg-spk:2 hs:rt711 spk:rt1308 mic:rt715
> 
> Note that the style uses what's recommended by checkpatch.pl and is
> slightly different from other sysfs attributes.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/core/init.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
 
I have a concern about this patch in a point of userspace interface.

The 'component' field of 'struct snd_ctl_card_info' is just defined to
have strings with space-separated chunks, and its actual value is not
so fine-documented, thus it's largely different depending of developers
of each driver.

$ cat include/uapi/sound/asound.h
     ...
 941 struct snd_ctl_card_info {
         ...
 950     unsigned char components[128];  /* card components / fine identification, delimited with one space (AC97 etc..) */
 951 };

On the other hand, the node of sysfs is quite common in Linux because
it's tightly coupled to kernel objects. Let you see files under
'Documentation/ABI/'. We can find efforts to maintain sysfs node so
safe and stable. Due to this reason, it's better to take more care when
adding new node.

Would I request you the reason to add this node and the reason that
current ALSA control interface doesn't satisfy your requirement?

> diff --git a/sound/core/init.c b/sound/core/init.c
> index b02a99766351..decaf944a8ad 100644
> --- a/sound/core/init.c
> +++ b/sound/core/init.c
> @@ -695,9 +695,21 @@ card_number_show_attr(struct device *dev,
>  
>  static DEVICE_ATTR(number, 0444, card_number_show_attr, NULL);
>  
> +static ssize_t
> +components_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n", card->components);
> +}
> +
> +static DEVICE_ATTR_RO(components);
> +
>  static struct attribute *card_dev_attrs[] = {
>  	&dev_attr_id.attr,
>  	&dev_attr_number.attr,
> +	&dev_attr_components.attr,
>  	NULL
>  };
>  
> -- 
> 2.20.1
 

Regards

Takashi Sakamoto
