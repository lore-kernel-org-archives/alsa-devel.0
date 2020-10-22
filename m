Return-Path: <SRS0=uLsF=D5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141A1C4363A
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:20:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B67524248
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2020 10:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="E6ATMATp";
	dkim=pass (2048-bit key) header.d=kernelim-com.20150623.gappssmtp.com header.i=@kernelim-com.20150623.gappssmtp.com header.b="qmXYtRew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B67524248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelim.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7E6417B9;
	Thu, 22 Oct 2020 12:19:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7E6417B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603361996;
	bh=ggQxdcSQiRU2gFJXPfJiT/6ERgaiwlP5wrjqYNsEGmA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E6ATMATppNqlkngusmiaxWw3nz6+ZeB18YxmerNM4Af8DaLUvy/dhyb9KiaHTe1DI
	 z9BKWAr+H7sPGUCN8pfbOBXozTIxtN+QYYWIY3u6LwvipID1CVajUCbZ+nIbeog64u
	 klhr5YiLUepiW0uM0dV6TGkFIKcMiCKWQEgCTTCc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 43915F80247;
	Thu, 22 Oct 2020 12:19:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61924F804A9; Thu, 22 Oct 2020 12:19:04 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0739F80247
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2020 12:18:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0739F80247
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernelim-com.20150623.gappssmtp.com
 header.i=@kernelim-com.20150623.gappssmtp.com header.b="qmXYtRew"
Received: by mail-ej1-x633.google.com with SMTP id t25so1445665ejd.13
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2020 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernelim-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yakPHKy/egEYx2AxItGaazrPSO/c4HTeXHK298gKe1Y=;
 b=qmXYtRewJ323Tl64mM1QZ+oI//oYCY7ohAtfWsYnGm+/VfEkiiwhDz4RfyUoroq09A
 SZ/jqbxrRZbbUKfIMkP0IvpZUyTZ8ifnSfriEA0lQTIQ0FV9QsH+ITiRCiCWOeMULfvV
 hanE7EsR5ZthVa0flHddSmssniSFgrMF/Z/4WctEJ59jw8Vn8WiELVDG2jiww7be6F8Q
 M2VGhkKT5dD+135YZ46JLIW2KF+XOl3Gtz6I+WrJPmH+2KXajq4XRbrR+PZYHBmtmhsI
 PeLNJOFMDAqlo8X3+KPChUAqHEisLy4eZANQ0stPdMB1KYCCU2zpCcIZv+e+8d7ahCHa
 Vwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yakPHKy/egEYx2AxItGaazrPSO/c4HTeXHK298gKe1Y=;
 b=PNnOo4H902YCD125/WjcT942YIfBkmmqwVp9ZhbHPpcbqhG9MpBubB2H4Up22OlOSS
 /Hi1rS2LDDCXZyjx2YnbLpCboTyA7v4g6f5a9KjKLrXZOGSO7gEL6bu1S1pp/whxaLJQ
 HCWOzs0OhXzmZu1uZGA3BtUiHrRjdtzWWGVvQtcdgCObOG/3D6sNGQAfzG6dSUywSsU9
 3LaNWRVc0oGj7y9UnHpHyIln6g3zxLfwV+feZLtp5/3RI1mihYRapFiyHylXD4UXI8M0
 vYUzwbxDIi37DCGR2CDpW/W7d5vq4gBk5gDQzqxRYgzmp7D1AdDqGocRdEimHkcFbJOY
 UNLQ==
X-Gm-Message-State: AOAM533bi1T/POghRdq3q9u16okCcytnE1ELJifuwZu6ejlth24rqv51
 MXDXOFXpgOYmSdJmbHJNZUnN3A==
X-Google-Smtp-Source: ABdhPJz2SQOOUBedKtYDV/WV/hDD3wrO54mu1EYGU30jm2zXtTgv4K39lf8j1yUJE6/67hWmXrtodg==
X-Received: by 2002:a17:906:39ce:: with SMTP id
 i14mr1624682eje.170.1603361935793; 
 Thu, 22 Oct 2020 03:18:55 -0700 (PDT)
Received: from gmail.com ([77.124.42.64])
 by smtp.gmail.com with ESMTPSA id d7sm510674edu.46.2020.10.22.03.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 03:18:55 -0700 (PDT)
Date: Thu, 22 Oct 2020 13:18:52 +0300
From: Dan Aloni <dan@kernelim.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: on-board sound on ASUS TRX-40
Message-ID: <20201022101852.GA1095612@gmail.com>
References: <20201022081746.GA1118484@gmail.com> <s5hv9f2bp2c.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hv9f2bp2c.wl-tiwai@suse.de>
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

On Thu, Oct 22, 2020 at 11:14:03AM +0200, Takashi Iwai wrote:
> On Thu, 22 Oct 2020 10:17:46 +0200,
> Dan Aloni wrote:
> > 
> > Hi,
> > 
> > The on-board earphone jack does not seem to work on an ASUS TRX-40
> > board. Here's the alsa-info.sh output:
> > 
> > http://alsa-project.org/db/?f=7a94c1b1eec4b2e623c75770364ec43c33d6c95c
> > 
> > Tried coding up the patch below, but it _does not_ fix the problem. It
> > does shows the earphone as 'plugged' though. Verified that it's not an
> > hardware issue via Windows.
> > 
> > Please instruct on how to debug this further.
> 
> Did you try to add connector_map, too?

Yes, and it did not help. Anything else I can try?

-- 
Dan Aloni
