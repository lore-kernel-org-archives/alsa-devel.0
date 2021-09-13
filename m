Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEE3C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 21:44:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAFD60F4A
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 21:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEAFD60F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2E68178F;
	Mon, 13 Sep 2021 23:43:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2E68178F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631569474;
	bh=2AUfpURjFcGtHaYsGeixgaPIcT6nnM7qyKYPX8zES3Y=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dofvSMqGVm5h1BagdRPNnDHlwKAr5u0WGpxOq/5wOoYj7V8JPPfRQszZDGpCdx1va
	 d8HGxSxMZ3nTYZo9Gepm+Gg4ZdC2Yuy0SH4J1hGtahpBVPNTrcuOusfmDUmP79iSNJ
	 cboFhOidZiN/Ju5vYZU3/5Srr+OwFIE4lu7+t1FU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5BE7DF80227;
	Mon, 13 Sep 2021 23:43:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30841F8027C; Mon, 13 Sep 2021 23:43:42 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9EBF2F80128
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 23:43:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9EBF2F80128
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="VJ5kK3gn"
Received: by mail-wr1-x42f.google.com with SMTP id u15so10779040wru.6
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 14:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=OmKpkwcJ/YE9wWezjvSXq5deQ9qPVPHvzIJumJjTABo=;
 b=VJ5kK3gn4RfmIRlT7llJRz9GJuTGJVhpZHQG8Q9opCOZXKl6Vp2CZR/w7NeFB4sego
 1jY001DRuIAB5lEf+qUB8vrnKMiK5TRMRDHkorLyPwUi487CtgxBTByIDitg2zCllPxz
 XffGizxWw3C1Hwx6Iz1mbRdYR3Pq9/Qd8daxvijBKGGf0ikAN8AFu+WmF1E6vK227hBY
 IdC1a/thVUsbQf/DkNJJK72mcdoeE5JQOFz3eVIz+6Oj5UQjUSg7aBWFow9vZLvaovgr
 IxATxJCuz5Pk745ioCzmRIZKF8+DLqlmYlv7gRBhZ0mNl5p//sNnaaOr3053+S6YMPyY
 ZIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=OmKpkwcJ/YE9wWezjvSXq5deQ9qPVPHvzIJumJjTABo=;
 b=eF9dCnmCitOthJDX0M58fz+VWR55+2adg/BM19Va6kysVMtbTMUTcDhTiVGt2m4890
 ETpaXT/lyoB5IzYLhXP3wBihRvgskgjdrnw2CVJZN739CVsTXYBdOhpT5Wi5nSxMxRga
 7eDXpFC/mBWoho2jvwNoJPK6Nndoz4MkFg6oSzJzt95mtVx2DTukfgLl5xnH1onmvsgj
 K6FuLgihPfd1d7oHrz6jr5CRFk/PbXAOkBgEGGKlCtwTgrvBYOMnTIcqPyAl5lWSQluJ
 p4MNc2XzNtNvEYfqH+qSnLV5SmtPdKnxSgyG17pb9GWQhWMMf78knUbs+ycBTOrC33dk
 F3nQ==
X-Gm-Message-State: AOAM533nUG3Dppy3ep2qGgJNdrs4pfjxA8AqMVmIaMNzBwk76IZnWgoQ
 lMC72z7lnojXHZyyytKHtns=
X-Google-Smtp-Source: ABdhPJwhheyzgkqdjCX+sH1wHgX7BoKIO1IfHrtLv9BwRFZK7RXmIHgtkQwKelqGxZHg0IL4MOK0GA==
X-Received: by 2002:a05:6000:18c2:: with SMTP id
 w2mr14816879wrq.282.1631569408749; 
 Mon, 13 Sep 2021 14:43:28 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.16.219])
 by smtp.gmail.com with ESMTPSA id 129sm7833393wmz.26.2021.09.13.14.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 14:43:28 -0700 (PDT)
Message-ID: <e23f7de1dbb02def413d721a3bf5759100380937.camel@gmail.com>
Subject: Re: [PATCH v2 6/8] ASoC: cirrus: i2s: Prepare clock before using it
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Mark Brown <broonie@kernel.org>, Nikita Shubin <nikita.shubin@maquefel.me>
Date: Mon, 13 Sep 2021 23:43:27 +0200
In-Reply-To: <20210726165124.GJ4670@sirena.org.uk>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-7-nikita.shubin@maquefel.me>
 <20210726165124.GJ4670@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>
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

Hello Mark,

On Mon, 2021-07-26 at 17:51 +0100, Mark Brown wrote:
> On Mon, Jul 26, 2021 at 04:59:54PM +0300, Nikita Shubin wrote:
> > From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > 
> > Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
> > to Common Clock Framework, otherwise the following is visible:
> 
> Acked-by: Mark Brown <broonie@kernel.org>

would you take the patch to a tree of yours, please?

-- 
Alexander Sverdlin.


