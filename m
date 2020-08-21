Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EEAC433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:04:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985BF2078D
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SUfVDqUg";
	dkim=pass (2048-bit key) header.d=superlative.org header.i=@superlative.org header.b="J+JItTlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985BF2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=superlative.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5271114E;
	Fri, 21 Aug 2020 14:03:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5271114E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598011477;
	bh=PG5ptCpNTSWQo4tv2+ei6JOTCoVH4AsIIpLu3Ak880Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SUfVDqUg6SZcnX1XdFBdAywsDy4OqFISIPzluV2WlAcihu0/nmVdNWOX3ADGPRKMo
	 1li0rs0t3KzIbuRrc4EYcp/nedjaR4IAdPHC8G2BvPA7irrU+V99ZOuW2yiEBeImHi
	 DB+SusF+UWqCcpo2ImsX8mmY3LsAky94dfmoceuQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70BBDF80216;
	Fri, 21 Aug 2020 14:03:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39053F800D3; Fri, 21 Aug 2020 14:03:44 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 511F1F800D3
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 14:03:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 511F1F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=superlative.org header.i=@superlative.org
 header.b="J+JItTlP"
Received: by mail-wm1-x32e.google.com with SMTP id t2so1349619wma.0
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 05:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=superlative.org; s=google;
 h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p48NazErvhXBSdYpUlvISqTMlZJT39nGGGYPAsW05Y8=;
 b=J+JItTlPxkd8PGUzEzDb+iSatRgqlFbWcWmqbJKZGj5oAfyDQWTt2GQnpnmA25sLoo
 XTJljeDCbD57Sq/8tymAMFkUrOwkn9jqvYZ73X5z/ZpvGFaBgP/UGTxhz4IdC8dBSuqb
 D7JcwBY37rtw0yXd9sgEhLPRMJDZButEDi7G8o3HO95l4Nyo/H0rd3Zl61SV4IIiXUTK
 kPfC0UfMPAf032NVUA+Pml0ujuaLS2U0EsPadbVcAXPyrVrEODeNOfm2kSqLg2Y6DjSF
 2Zb5thpLJMNQ1sEEOPMmgHc4BV6z/VHIC4JtITECyofc26wuM6B6PWMZaRP8qDrIWprA
 sjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=p48NazErvhXBSdYpUlvISqTMlZJT39nGGGYPAsW05Y8=;
 b=Q8Xg+T6uTo5dN8TYFcQSnyl8G+yOJ03Uuf7N/Djf/2RzwFtAw9tN7ZXVK9+ej4CoDi
 BFmxnIZEKF/XdujUSvB/NV4TJcph+SBbpwSPu4aFPVp2SCTKtyhnlCI9PR92yY7vsaZD
 7qpYUEZTy5goOb40NvPTBfP0bV/MNjgNFMW7A/7RIpTYAH7FNw/22mzjm3O9dI9CqMxs
 DEjQrp75xx3Q2HAWkDtoqkiA5NjfeP3D+d1YNKDx5SU9HFWgEJkVHb7O65/zjKNFJIbH
 i/zkSwLhrpA2qsAuhed28593qujSuDs/qnWASgl4hmzGfNrbZFkZqpGGnL1oAatjmnIh
 Qnpw==
X-Gm-Message-State: AOAM53283eWqvTMhQI18BMjq9SLB9xqmEh80RCPxcNhJDSXwYTZiwclm
 uXm7RRiMtpv0ljBAtkVeQ3US38xuHmYULedw
X-Google-Smtp-Source: ABdhPJz1WdpesdXI3Zf3He85rrZsNEOrGv+l3CF2FeaQCK3Yebl6xj2HTifoSOvjnvuE9SF5teWLiw==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr2995311wmj.90.1598011412074;
 Fri, 21 Aug 2020 05:03:32 -0700 (PDT)
Received: from kamdesktop.localnet ([2001:8b0:be0a:29af::201])
 by smtp.gmail.com with ESMTPSA id f6sm5986050wme.32.2020.08.21.05.03.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Aug 2020 05:03:31 -0700 (PDT)
From: "Keith A. Milner" <maillist@superlative.org>
To: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Attempting to understand odd snd-usb-audio code and
 behavior
Date: Fri, 21 Aug 2020 13:03:30 +0100
Message-ID: <1812050.cYJzfEYQ9C@kamdesktop>
User-Agent: KMail/5.2.3 (Linux/4.15.0-112-generic; KDE/5.36.0; x86_64; ; )
In-Reply-To: <20200405021415.0e7c3f44@rosh>
References: <20200405021415.0e7c3f44@rosh>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: Ilya Dikariev <dik_again@mail.ru>
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

On Sunday, 5 April 2020 02:14:15 BST Ilya Dikariev wrote:
> Hey Keith!
> 
> I'm working with Roland R-26, and have pretty same problem here.
> Was you able to solve yours?
> 

Hi Ilya,
No, sorry. I also didn't have time to follow up on this. I get the feeling 
there's a lot of Roland/Boss devices out there with this problem, and that 
fixing one of them will fix them all.

Regards,

Keith


