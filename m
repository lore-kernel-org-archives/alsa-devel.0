Return-Path: <SRS0=nhcg=4A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32EAC2BA83
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 10:17:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426F1217F4
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 10:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DOJF468A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426F1217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F465167E;
	Wed, 12 Feb 2020 11:17:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F465167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581502671;
	bh=XdwQOfUCRwP9O5h4c/qvob1QIdqTZzjEop09vf0ANpI=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DOJF468AYy05rYlKaqwUO++zA1kWGfE6EbFO75eeKAN0I87PQdj53sc/Fnl6QD+Ou
	 jWwGQjanOgXBeddBdupK+FYKfbEfu0r7a+W1gBynGal49IzhEvwKVhnxAH3sj7Wz/X
	 bURDiptZHjtWUD6Zg5Rwng7VClayrnJZCLiXcaRE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F9ECF8019B;
	Wed, 12 Feb 2020 11:16:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AEC21F8020B; Wed, 12 Feb 2020 11:16:43 +0100 (CET)
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D144FF800E7
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2020 11:16:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D144FF800E7
Received: by mail-ot1-f66.google.com with SMTP id j16so1388500otl.1
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2020 02:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BSd7L1WcqmA7Rn1t/qtLYAH7L9DL0l8H2ANtY/V6cDc=;
 b=M+cwjQcu9D/1zFT/rHHz8qyUi6PdJfwZ/sv+LE8y24QTKNpCf35fMf+kc9WPojgUUn
 oS6tfwoWPeFQDE2jHIGW9gYo5cxe9Pj0SIzJ9vGGfMy/fPXFt0EWdj5IOVBvZkysTOBe
 dcZFR/O0PEKs8ZM1YHoUnyh5HND7gnuU9jgR/bCi8AhyaVsNkw4+nsjHSSwd37YSTxHa
 5jTicybzVfdeqIN5zHShB686VZ2l0Nm+hFwjzdFAp/LY3QsZsVopnp1rkmd+k3ggzlUH
 hI1jxNwfDkPsY0yJSCFX1qJvPSGp7FXcBaSczImJt3dHy4VZRnBSxWZu+B6yt0gLq97j
 ZykQ==
X-Gm-Message-State: APjAAAX7G+m3EjkJTf7WXASElDM40xkmFJW39s6tTuV6xZBV7HmCu59/
 Jg4pVNyQWXE2cmHRM60d7S9UAv9l3h/xRhsiIyQ=
X-Google-Smtp-Source: APXvYqyfmunP1o2BTpeb9JU1HjP2UYYEVp4pQeJQcvu4Jqvu9FNFexZwM5K2BHzwypUIBN4OQGyWST7sYQ52txz7keM=
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr8759446otn.262.1581502598886; 
 Wed, 12 Feb 2020 02:16:38 -0800 (PST)
MIME-Version: 1.0
References: <1654227.8mz0SueHsU@kreacher> <197693303.hiACyxC3Vm@kreacher>
 <20200212100810.GA4028@sirena.org.uk>
In-Reply-To: <20200212100810.GA4028@sirena.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Feb 2020 11:16:27 +0100
Message-ID: <CAJZ5v0i8DsjQkf_4ezOYMrvB47ZuxsgNmTbHQB-JEK8bMHUpPg@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Linux PM <linux-pm@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Takashi Iwai <tiwai@suse.com>, Amit Kucheria <amit.kucheria@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH 24/28] sound: Call cpu_latency_qos_*()
	instead of pm_qos_*()
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

On Wed, Feb 12, 2020 at 11:08 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Feb 12, 2020 at 12:34:15AM +0100, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Call cpu_latency_qos_add/update/remove_request() and
> > cpu_latency_qos_request_active() instead of
> > pm_qos_add/update/remove_request() and pm_qos_request_active(),
> > respectively, because the latter are going to be dropped.
>
> What's the story with dependencies here, I only have this patch and not
> the cover letter?

The cover letter is here:

https://lore.kernel.org/linux-pm/CAJZ5v0h1z2p66J5KB3P0RjPkLE-DfDbcfhG_OrnDG_weir7HMA@mail.gmail.com/T/#m92ce7ffd743083e89e45c0a98da8c0140e44c70b

Generally speaking, this patch depends on the previous patches in the series.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
