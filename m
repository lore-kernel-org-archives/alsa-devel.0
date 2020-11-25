Return-Path: <SRS0=zi5T=E7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E90CC56201
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 16:12:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411DD20BED
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Nov 2020 16:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XW1yNEV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411DD20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0DFEB173D;
	Wed, 25 Nov 2020 17:11:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0DFEB173D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606320722;
	bh=/C0ll5xcZ0CylqJR6ttle4L4NJYDwahvYC5vMDg722E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XW1yNEV+qz7267I081zkB138hUOLN424d8J1TSzy5ea7h4bo4yhKGPrpoGUDZT52r
	 ejgCrMrRf/IheDlc3YXRH5JQhudiRDWH2qe3sJGB6HQVor/BG/3nOyLCgir1WUfhRb
	 kMvIs82kLY4sKPEdE1AxUSYDkCuTDXufIpivIb80=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A14DAF8015A;
	Wed, 25 Nov 2020 17:11:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D242F80255; Wed, 25 Nov 2020 17:11:10 +0100 (CET)
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EFA8EF8015A
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2020 17:11:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFA8EF8015A
Received: by mail-oi1-f194.google.com with SMTP id h3so3364550oie.8
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2020 08:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/C0ll5xcZ0CylqJR6ttle4L4NJYDwahvYC5vMDg722E=;
 b=LrUJ9kN49g3iPvaslR8Q/fc4jJpFWRbpHplm5MiTVnREU3YHuK7Qxqa1L7O1MvOH+j
 rGXmEfiqBdlyWwlWnChpyX1Iv4VhhzTMRqS8x5ehp6vEQZelh3DF76fkw+m1WoaX16UI
 AENVyt4RVV8IivFfTL5l6DKysSMR5P3mlgRloGAEVaCvh68eTyE9BrD72+sexMzxbQ3e
 D+smI0zshlM2NmlaDUVMOFi0G0sZ41XiP7v8NohVpyv2aPcgqsSCoPjWIEEGLyVESxNN
 7ypThTtmBESlZfhGbBXEXHalVCDQK2qg+Wpz7cwNYFSnplNB9V/QMeIu7bbpyvBqN4gB
 YzaA==
X-Gm-Message-State: AOAM530EjYRcFkC7LgU3sIVh4XP9FE0DZSBF0U2mf8RJnjwnzaXQUhi6
 aIl6YqylSUEkz6aISDodZElGoxtdnRY6U8F3lXE=
X-Google-Smtp-Source: ABdhPJxEnZaTiOxRsndntYhtVYaLQDpHjvyFDqQNe1j0GKBKkRGfG14Z1pNWHLudF7qiLOyUCNeH3wiCCYwh2xHsmLw=
X-Received: by 2002:aca:5a42:: with SMTP id o63mr2638661oib.69.1606320661856; 
 Wed, 25 Nov 2020 08:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20201124095628.54373-1-andriy.shevchenko@linux.intel.com>
 <f33b4381ea3a4cf4b8e7f27676cd90ed@intel.com>
 <CAJZ5v0hxqydcoqTCDzR7O7Y4d71Qutx+k4sOmdvOY24f2-OWgg@mail.gmail.com>
 <20201125161028.GW4077@smile.fi.intel.com>
In-Reply-To: <20201125161028.GW4077@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Nov 2020 17:10:50 +0100
Message-ID: <CAJZ5v0huXtSDtQEmUHx4NmjJhFNOVUMktD_eJ06=fsmZB40ayw@mail.gmail.com>
Subject: Re: [PATCH v1] ASoC: Intel: catpt: Replace open coded variant of
 resource_intersection()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "Rojewski, Cezary" <cezary.rojewski@intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>
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

On Wed, Nov 25, 2020 at 5:09 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Nov 25, 2020 at 04:49:39PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 24, 2020 at 1:13 PM Rojewski, Cezary
> > <cezary.rojewski@intel.com> wrote:
>
> ...
>
> > Applied as 5.11 material, thanks!
>
> Thanks!
>
> There is one fix to the series [1]. But now I realized that I forgot to Cc
> linux-acpi@. Do you want me resend it?

Yes, please!
