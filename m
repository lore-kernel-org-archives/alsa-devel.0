Return-Path: <SRS0=Jhnj=L7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC8AC07E95
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 12:27:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4D061C9A
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 12:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4D061C9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F7AF827;
	Wed,  7 Jul 2021 14:26:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F7AF827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625660837;
	bh=rAfs36psQLRHu/YN00KN2Ikb6bEAoIBnVauWpJ+tkys=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lNzupw9x6Dl9Oc4swL/LTvwie7dWIQ4KCPKsWMBSKcaIQyTSGoIW9SBAvgsWik6Ur
	 9gHTQCCxMn6hI9emqwZnfmzVYhsCPgZ41kGkT10hnDwOy3KRwRj7rwRqm9QlTUwwpQ
	 4kDXwcbhPncQMjFyU3id7HMCGgwEKjrkakJr0LT8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DA44EF8012A;
	Wed,  7 Jul 2021 14:26:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00F1FF80224; Wed,  7 Jul 2021 14:26:25 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9CF7CF8012A
 for <alsa-devel@alsa-project.org>; Wed,  7 Jul 2021 14:26:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CF7CF8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="YN87qPS0"
Received: by mail-lj1-x236.google.com with SMTP id p24so2481864ljj.1
 for <alsa-devel@alsa-project.org>; Wed, 07 Jul 2021 05:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=xBbhKVMcRKP7IhEubejquc8vBu7KzNJEOw/BevSGbY8=;
 b=YN87qPS0pzLUyvk7DSoVbYduhgb99x/HC2fqZASSbKmj4qRmQGgsHtGtYcVNNgsGfN
 XFHCj6eR/kHfTQRSitOXokdmWtJN9112BHJw+GlAzhNUWJ7JN3UWUPazmDkk6A18cvwf
 X0xVG6vCJE3jt36o7a9NrpgK1I7lyswuLYXsLzX358CHJSYB6B1n6wukVmD836ubWTN5
 UsRH1+uGuQ9E9kVkINYWoKi8xNeAq3+GnQIbAPo59bUrORnU7RhuBsKdgDPRaAs228em
 uPjxy/neXmEv/nzMJ3OwzNLzdD9Vi91Cfc0l1qTat7pYdQhV0I1xlkA5c+fYoqutJFxI
 N/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=xBbhKVMcRKP7IhEubejquc8vBu7KzNJEOw/BevSGbY8=;
 b=c89+6hNBUkMG+rdpdFXdk3fY9Ytn6ZB40bKKQg9VRDdSNV11bHazcR69sFUT4wvBrn
 jXtaoPOjc0BuS3HGjl4gOG21m4TK7ITw7IlC16w7s2+mJUsPcNnBX2JU2Y5R4+zXFl7E
 +uXELFeeYeEJCQwCnfPw5sOlJw+cw9nRjqQX8TEimVMzMp19KhJl8/STEdI1fgLk9xB8
 cgqoZvBU96Yb8iDdSSku1SNhli4QK+h9pnUU2pLbCv7GX99j8wX+jeZJq4EnO2WxZKVK
 cQBGySznypSK+LskHumsafSCmtrHD9/lWeXkcTzkgGiroym82aBwbXivbiPjs84T28na
 Snrw==
X-Gm-Message-State: AOAM5338wmz0sKZA6wzt+BvS29pp0tbyEOYJi/X51AkBSjoQCFCeTQNd
 evYd1G6N2P9F8GrZ/vQ1WpLX8W8S4Ti9/eNrHZr0SEeq2JGy2A==
X-Google-Smtp-Source: ABdhPJwwUpcWfLr381OG4ZbZJVdLwpzoZb4sZ/SyISlyAUBF39xnukeGROeB5GpfjJ6tnpa8KkX5Xd4ZjdLPRBXiZyw=
X-Received: by 2002:a2e:a22d:: with SMTP id i13mr10987888ljm.140.1625660781659; 
 Wed, 07 Jul 2021 05:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAEk1YH4Jd0a8vfZxORVu7qg+Zsc-K+pR187ezNq8QhJBPW4gpw@mail.gmail.com>
In-Reply-To: <CAEk1YH4Jd0a8vfZxORVu7qg+Zsc-K+pR187ezNq8QhJBPW4gpw@mail.gmail.com>
From: Damjan Georgievski <gdamjan@gmail.com>
Date: Wed, 7 Jul 2021 14:26:10 +0200
Message-ID: <CAEk1YH7vzOKyCOYr_=GdHYaWi_2--6JP5SPV21G6Z+R3uppEmg@mail.gmail.com>
Subject: Re: Audio out on DisplayPort but not HDMI, on AMD Ryzen APU/Vega
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
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

> I have a desktop computer with an AMD Ryzen 5 4650G PRO APU (CPU + on-die GPU).
> The motherboard (MSI Mortar B550m wifi / bios 1.6). has one
> displayport and one HDMI outputs.
> The displayport is connected to my Lenovo P27 monitor, and the HDMI to
> my Samsung TV.

not sure if the driver in sound/soc/amd/renoir/ should be enabled for
the 4650G PRO too, but on my computer it has
a different PCI vendor and ID than in that code. Mine has 1002:1637
(vendor ATI) while the driver is for 1022:15E2
(which does not exist on this computer).

sudo lspci -d 1002:1637 -v
30:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device 1637
       Subsystem: Micro-Star International Co., Ltd. [MSI] Device ec94
       Flags: fast devsel, IRQ 94, IOMMU group 4
       Memory at fcb88000 (32-bit, non-prefetchable) [size=16K]
       Capabilities: [48] Vendor Specific Information: Len=08 <?>
       Capabilities: [50] Power Management version 3
       Capabilities: [64] Express Legacy Endpoint, MSI 00
       Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
       Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
       Kernel modules: snd_hda_intel




-- 
damjan
