Return-Path: <SRS0=jYMw=PQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B34C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Oct 2021 15:24:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652FC610C8
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Oct 2021 15:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 652FC610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15CBC16E6;
	Thu, 28 Oct 2021 17:23:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15CBC16E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635434671;
	bh=ANEFYYSjA3bOF4gghQD5pDZp2J30g5S3NXwTqiJFRkw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LJ1AXULRagullCE8kfJyOYlA51gPbSYeg2PL/xeDOWWMrldaL6CSzmcHxD3OhZIMV
	 slRjuzonYn8tgcx8mZh7JiwbV/tKsOZl78racVOzNVyeoILhHWeRGsQuTLcghjUX7d
	 ZCv+LTxY4wmC8G7t3XXCNl02S9PY2aF8XAFKRDDA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 986A8F800D1;
	Thu, 28 Oct 2021 17:23:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 866BFF802C8; Thu, 28 Oct 2021 17:23:39 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E4D3F800D1
 for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2021 17:23:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E4D3F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="mE++Z0a0"
Received: by mail-qv1-xf36.google.com with SMTP id c9so3950933qvm.5
 for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2021 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mOVoYXRHI5sNBWLXNQNXSjOsNry4SjlW/GjCDgN+QZw=;
 b=mE++Z0a0PPlRUkk6R75IRCCUodjtsEUnnLfylnq63z4c5436WEDxvqrJgHpJtZn3K5
 jMGtw3eWXI7rdw2Fik8lCefKcMChJ//NjezCloryhA7LWjmilO25wDcdkaOlb9s2o4yC
 57N1H6KhjCqlVAu3AtGl3hWmAmfAVs9pr8Q/5dgBJtg1PPUaUOhO3GBPImLcGUSiiSno
 MlcWssjTT7oLHA4Gz8NEeumDYfdI6tSglF0rq+Na+i2Km7MEC5XiNa/LkKWCiaMXJAhL
 ipV/7y6recr65xFDRn1mlrj1cFLPjfiLlqDaFY9mQ/mKo/xx1HLFjTt7RhAvfnu9ywED
 NoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mOVoYXRHI5sNBWLXNQNXSjOsNry4SjlW/GjCDgN+QZw=;
 b=KS0bxafbU1po5yQ+K1/jOWDXJGRlbK4NIDbPLNN9oACCoDLXHksn4X3ah5KCp2j2lD
 u4ljAgWS/MGGgXIZF2tH3onQZFslm7kLzwToIx3OPcYj9r3BK/FYI0ZK+Mo8uiraQW9Y
 YFpwxQDrDoOqBuHzI/ZlGO6UCNDVPqAulmZQzDtdic6vpaQKxMLVKXLBjtS3LhXJpmBl
 OrvIWIEkyo/qSIP6gAnEUncA1Oc1nKW+Zixq5brlrjkR10X+B7VPJ0G3v6CZzxFYOrPg
 ipQY8qZidgDOcR8XKBGpjslsMr3qo3qr79SpYcJrzo2opsPe7MHat7jx990cgoyqDNeP
 7jgQ==
X-Gm-Message-State: AOAM533H8JAmmLxnIf6BkPSqZXQFB+4jEqGRIfHhya0otbqsCMbvlKCN
 ga+JqhRGNMfeGDZOv+KbE7Q=
X-Google-Smtp-Source: ABdhPJxZcqGt/AL0gMONY8/y92jwlGyjci7sYU0xuRmAp2TlTBvPQZI6R2lXM/zyqaYIZw/K2yuHcg==
X-Received: by 2002:a05:6214:4119:: with SMTP id
 kc25mr4650274qvb.65.1635434611069; 
 Thu, 28 Oct 2021 08:23:31 -0700 (PDT)
Received: from ubuntu-mate-laptop.localnet ([67.8.38.84])
 by smtp.gmail.com with ESMTPSA id u22sm1131685qta.23.2021.10.28.08.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Oct 2021 08:23:30 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: Mark Brown <broonie@kernel.org>, perex@perex.cz
Subject: Re: [PATCH RESEND] ASoC: fix unmet dependencies on GPIOLIB for
 SND_SOC_DMIC
Date: Thu, 28 Oct 2021 11:23:29 -0400
Message-ID: <51280965.5nCgCKSeW0@ubuntu-mate-laptop>
In-Reply-To: <YXqXdV0YC5BhEARB@sirena.org.uk>
References: <20211027184835.112916-1-julianbraha@gmail.com>
 <YXqXdV0YC5BhEARB@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: alsa-devel@alsa-project.org, fazilyildiran@gmail.co,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com, Vijendar.Mukunda@amd.com
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

On Thursday, October 28, 2021 8:28:37 AM EDT you wrote:
> On Wed, Oct 27, 2021 at 02:48:35PM -0400, Julian Braha wrote:
> > When SND_SOC_AMD_RENOIR_MACH or SND_SOC_AMD_RV_RT5682_MACH
> > are selected, and GPIOLIB is not selected, Kbuild gives
> > the following warnings, respectively:
> 
> I can't seem to find any indication that this has been sent before...
> 

Hi Mark,

When I previously submitted this patch, I did not send it to all relevant 
maintainers. Also the subject line was flawed.
Here's the original: 
https://lore.kernel.org/lkml/20210430143919.43362-1-julianbraha@gmail.com/

- Julian Braha


