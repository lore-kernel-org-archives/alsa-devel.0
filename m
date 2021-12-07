Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0890C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Dec 2021 08:16:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86217239A;
	Tue,  7 Dec 2021 09:15:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86217239A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638864985;
	bh=AzyUAEWATMIvCoDYu98AFpMGjzgMX6NNyOloO/w7Cjc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vEuesZgX4HIE6hZVbHgrOl0lVxL5lVFTFELSFCCrBGLaIcZ334uN9g1X0TFlFJ3JO
	 9fzBc7Y3k8ttpR+l/OFuTgD1ClarFE0eAKmI2vTxBL2Pn0jc9q4yV94rIEp2dENrQH
	 3LWq5lCJK09MNQKrs5Tg0Q5sIFwuNnlvNd6SjqX8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1ED6EF80259;
	Tue,  7 Dec 2021 09:15:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF084F8028D; Tue,  7 Dec 2021 09:15:32 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0B52F80253
 for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2021 09:15:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0B52F80253
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="O8SFw4q1"
Received: by mail-wm1-x32d.google.com with SMTP id
 n33-20020a05600c502100b0032fb900951eso1073045wmr.4
 for <alsa-devel@alsa-project.org>; Tue, 07 Dec 2021 00:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rOIlXsz0PGlaxQV5U7jqAgR4am707r4hcnOeW2eWLV8=;
 b=O8SFw4q1q5ubvaw3zVvh8753feNo1rPiMnkGhekMVUnsCFUaohyqvaZe68fvMGM8N8
 sZmBEpSiVbkdsKuPImwoM1u5FiZ+b+3/jl5Cd0KKSsu0dAAUUeqYVX6DyIrQHlcS2fms
 7J+rRho0iI5Mqzw7u+u11SgF0A/cbP3eBI5MwbYzydorih2gOxyIWaFLdlSVq4M2dIQx
 kdM/tlGiBGVBROrQ1X4OhBFx20/WgzcPgZJr+dTbXD6brOe0JaMKxU5CoJuSJde6YFaP
 yenPSry8I10ZwYJWXiRKF+2uhZuEtGMSxrM6BuGZ241OzmK6K4AK8C0JWM9tfaCYbfgc
 YQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rOIlXsz0PGlaxQV5U7jqAgR4am707r4hcnOeW2eWLV8=;
 b=dA20URYOA9wOAsb9dBi+fGMVcQahsp4mg3gY/eqfDyykMQtn5CfBDnmiKm/TGDakR/
 DVRRu6oOQbR9KOphgNMgelB1dP4Q8sv5qAhpfAElcKKyefKNmFNVd/WODWwzd7AOTgBF
 cNlHJ2Y63pbctxQ+0rRUqyTnQSIofz7ZRoN5y6pOyPvBfvkULZj/XWQuNb8f0dFjB95r
 FkLx7HgN1NasztDsb35bOUeVktdU983nozf2i2R0KVviOhbf98e4p5fIc/QkCImxRwIF
 YPmdFP23djEYBlm9FLDkz/yTIEKhY25OzHUSRt35i81FRvglBsPvnUFtMhSsITP4CKnR
 t1nw==
X-Gm-Message-State: AOAM532XmuMyyA0pkB9KH9IPvBKsn1wMcsdBEKa67Ucj10bOSlN5Lg33
 8FLSQOKTx5N4GpvjXjKcO30=
X-Google-Smtp-Source: ABdhPJy2X3TxTv34u8UaDIlSKuFZUwju+YHjlgxlUlnKm60GtggT+2vqZhY/Oj9PuKjuvpLCt4hQ/Q==
X-Received: by 2002:a05:600c:510d:: with SMTP id
 o13mr5051389wms.104.1638864926845; 
 Tue, 07 Dec 2021 00:15:26 -0800 (PST)
Received: from hamza-OptiPlex-7040 ([39.48.238.254])
 by smtp.gmail.com with ESMTPSA id r8sm16944910wrz.43.2021.12.07.00.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Dec 2021 00:15:26 -0800 (PST)
Date: Tue, 7 Dec 2021 13:15:22 +0500
From: Ameer Hamza <amhamza.mgc@gmail.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: test-component: fix null pointer dereference.
Message-ID: <20211207081522.GA9690@hamza-OptiPlex-7040>
References: <20211205204200.7852-1-amhamza.mgc@gmail.com>
 <TYCPR01MB55813B26BB2B3BB6D1E072F2D46C9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
 <20211206092937.GA5609@hamza-OptiPlex-7040>
 <TYCPR01MB5581998AD64AE249C7D86C26D46D9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB5581998AD64AE249C7D86C26D46D9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tiwai@suse.com" <tiwai@suse.com>, "broonie@kernel.org" <broonie@kernel.org>
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

On Mon, Dec 06, 2021 at 11:19:36PM +0000, Kuninori Morimoto wrote:
> 
> Hi Ameer
> 
> >> Probing this driver without adata is strange for me.
> >> How did probe this driver ??
> >
> > Thank you for your response. Unfortunately, I am not aware of
> > implementation details of this component. Coverity suggested that there
> > can be a potential NULL pointer access which seems logical to me. Do you
> > agree with coverity here?
> 
> I think no potential NULL pointer access, because this driver can't
> be called without of_id->data.
> But, potential NULL pointer check itself is good idea.
> It seems your patch was already accepted :)
Yes, indeed.

> I noticed that we can replace it to use of_device_get_match_data()
> 
> -	const struct of_device_id *of_id = of_match_device(test_of_match, &pdev->dev);
> -	const struct test_adata *adata = of_id->data;
> +	const struct test_adata *adata = of_device_get_match_data(&pdev->dev);
Thanks, that's a cleaner way. Can you advise how should proceed with
this since previous patch is already applied. Should I send a updated
version of patch, e.g., v2 or a new patch. 

> 
> Best regards
> ---
> Kuninori Morimoto
