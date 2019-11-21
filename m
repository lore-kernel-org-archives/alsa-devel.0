Return-Path: <SRS0=ShlF=ZN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94B8C432C0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 02:46:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D70F2075A
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Nov 2019 02:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PtrVBNp1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="isB5I4xn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D70F2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E7FF1723;
	Thu, 21 Nov 2019 03:45:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E7FF1723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574304366;
	bh=Up44b8malT0DQvm2rGhzTgIW4LlbeCf95FAlB1d6LOk=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PtrVBNp1LcJZ619u06oEYyerkM2+Ua5roy9c9pW4/Z2WAAjHaBVEndhOx+rKN3tex
	 c1eWT3XdJ4XyxaIXYoYqaDF2vnTV1O31na90jZdKsp6uxjIlhunUIMLkgvpsQ0tFbv
	 dgOmgrZL/owEtdPNN8irD5ukoR4Hf6pAk/+iWM7Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B031F80145;
	Thu, 21 Nov 2019 03:45:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A1A4F80146; Thu, 21 Nov 2019 03:45:14 +0100 (CET)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C198FF800EF
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2019 03:45:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C198FF800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="isB5I4xn"
Received: by mail-io1-xd42.google.com with SMTP id 1so1636997iou.4
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 18:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DSWP3Wi9A1FrBhlpFzV+gqZ8sFxv+BMZv+4RglG1dto=;
 b=isB5I4xnjK1rVz/KGPHrLEwqBt9arFTAlVr7XFKL3IgirBStKeRsM8EsnLqulIKF0v
 iEUJENLNBm/FSS4H1BkXDlqlqf11mAJqU3IYYncZUj/lXQsO6KRg2bntnm2ZFUnZjSAO
 lwcJNbVbt5RbuGBoXI7W8kKjkC6dvVCN0KKyyeBDxnsMbtS4xmZyQqTAFktLB39oqhiV
 WWz72PoHDdzOxn2CQrA4sepy0M4Se/JoWHrzbuLkmfiDSFJTBqlyxRWhvE1nhKtMY3XA
 7h2BlkYnS9eIraqlHn3MWtqwRqh4ciZeza8fxMhyxvZ62k7tuxUPUqjHFGfHsMtuwGiM
 EwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DSWP3Wi9A1FrBhlpFzV+gqZ8sFxv+BMZv+4RglG1dto=;
 b=pLtfMwPYpF8CABFbqdufvIsfvW+34S0diZ3H8sa2Kb8Le1b/gmIfHUtIauNjlNQcsP
 2opggNbdwlyN6A/cgyNmjm39UXTAJaGTZqcHrOSgzEXZSJ1ftTTOlIK020DnoUe3awAj
 xek110vjSeI9+JELUtGhm8+MZ2mOcq/1hXXz/aMlyTHf1rn+V5ZImzfeZsHK2RZQNlpG
 cMqi3GXYFzS3hN75xBc4Lk38Q2PuY0aflh0vRceM5UL7Bvpq2bfr4yVCNLAMt9vn7BAa
 iOIEX5BwFHHYPwZbNf5ARmhV/QxC8IRJ078lzwsGCcKOHjcfNKwTX36MMG2hlTo5icft
 1FCw==
X-Gm-Message-State: APjAAAU8cHg9oP1EIq1q6+LvsAcl/CVReXvlHYORJJIB7mFjmd4wo3JX
 seI3Mq4HVOn4sAmNcH29UlkTOxjACGNEUAgi1/wZ5w==
X-Google-Smtp-Source: APXvYqx0kVwv0RuHuKTp6ES8mfWN4raIF1BYZ63DIr2eBpQ4RSkm4w5AM4f5rhbyb/KwVczKEpX/ytAn53QUVX2kogc=
X-Received: by 2002:a02:7f93:: with SMTP id r141mr6192201jac.68.1574304309521; 
 Wed, 20 Nov 2019 18:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20191120060844.224607-1-tzungbi@google.com>
 <20191120060844.224607-3-tzungbi@google.com>
 <20191120171609.GB5705@sirena.org.uk>
In-Reply-To: <20191120171609.GB5705@sirena.org.uk>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Thu, 21 Nov 2019 10:44:58 +0800
Message-ID: <CA+Px+wVntoeBwgSqhcbJ59uAyJ7DB4i5a1q7tZX34TS1HyjjZA@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Dylan Reid <dgreid@google.com>, Jimmy Cheng-Yi Chiang <cychiang@google.com>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: max98090: save and restore SHDN
 when changing sensitive registers
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

On Thu, Nov 21, 2019 at 1:16 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Nov 20, 2019 at 02:08:44PM +0800, Tzung-Bi Shih wrote:
> > According to the datasheet, there are some registers can only be changed
> > when SHDN is 0.  Chaning these settings during SHDN = 1 can compromise
> > device stability and performance specifications.

Oh, and got a typo.  s/Chaning/Changing/

> This doesn't apply against current code, please check and resend.

I guess so, as mentioned in the cover letter, the series should apply
after https://mailman.alsa-project.org/pipermail/alsa-devel/2019-November/158850.html
Will resend this patch after that.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
