Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBB9CA9EA0
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:01:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15EFE205ED
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LL4k0TvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EFE205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01F061670;
	Tue, 22 Oct 2019 21:00:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01F061670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571770859;
	bh=mUyaq4iJD2B0CIT/3r/hDn8SPPfNq+J5zh422OXOvfY=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LL4k0TvIia4Qho6+nm+jjC0ha08MeJy8sz+A0zkD6H23wceA8+RDTX41lt81V5Th0
	 DEvV/JlVyayA2EOz0eh/z3dUPS39ZKz3dYoW01SOwHKDxXZrtflXym/Ts+89ehlAqD
	 QcxzxLtEfPZ1M2rmsYbCRgeyiFR1OsUzpj58WF/U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 313CDF8026A;
	Tue, 22 Oct 2019 20:59:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EFFE4F80539; Tue, 22 Oct 2019 20:59:16 +0200 (CEST)
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D705F8026A;
 Tue, 22 Oct 2019 20:59:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D705F8026A
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
 by smtp1.de.adit-jv.com (Postfix) with ESMTP id 325EB3C057C;
 Tue, 22 Oct 2019 20:59:11 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
 by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PeenTeeOB236; Tue, 22 Oct 2019 20:59:05 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp1.de.adit-jv.com (Postfix) with ESMTPS id EF1133C009D;
 Tue, 22 Oct 2019 20:59:05 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Tue, 22 Oct 2019 20:59:05 +0200
Date: Tue, 22 Oct 2019 20:59:02 +0200
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Mark Brown <broonie@kernel.org>
Message-ID: <20191022185902.GA12906@vmlxhi-102.adit-jv.com>
References: <1550823803-32446-1-git-send-email-twischer@de.adit-jv.com>
 <20191022154904.GA17721@vmlxhi-102.adit-jv.com>
 <20191022163501.GK5554@sirena.co.uk>
 <20191022164607.GA20665@vmlxhi-102.adit-jv.com>
 <20191022165337.GX5554@sirena.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191022165337.GX5554@sirena.co.uk>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Cc: twischer@de.adit-jv.com, alsa-devel@alsa-project.org,
 patch@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 Eugeniu Rosca <roscaeugeniu@gmail.com>, Jiada Wang <jiada_wang@mentor.com>,
 linux-kernel@vger.kernel.org, tiwai@suse.com,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rsnd: dma: fix SSI9 4/5/6/7 busif
 dma address
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, Oct 22, 2019 at 05:53:37PM +0100, Mark Brown wrote:
> On Tue, Oct 22, 2019 at 06:46:07PM +0200, Eugeniu Rosca wrote:
> > On Tue, Oct 22, 2019 at 05:35:01PM +0100, Mark Brown wrote:
> > > On Tue, Oct 22, 2019 at 05:49:04PM +0200, Eugeniu Rosca wrote:
> 
> > > > It still applies cleanly to v5.4-rc4-18-g3b7c59a1950c.
> > > > Any chance to see it in vanilla?
> 
> > > Someone would need to resend it.  No idea what the issues are but I
> > > don't have it any more.
> 
> > How about downloading it from [1] by pressing on the "mbox" button and
> > applying it with "git am"? This will also include any
> > "*-by: Name <E-mail>" signatures found in the thread.
> 
> > If this doesn't match your workflow, I can resend it.
> 
> This doesn't match either my workflow or the kernel's workflow in
> general, please resend - that means that not only I but also other
> people on the list have the chance to see the patch and review it.

Resent as https://patchwork.kernel.org/patch/11205195/
("[RESEND] ASoC: rsnd: dma: fix SSI9 4/5/6/7 busif dma address")

-- 
Best Regards,
Eugeniu
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
