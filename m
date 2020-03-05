Return-Path: <SRS0=q21C=4W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6639CC3F2D2
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 21:02:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E66EB208C3
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 21:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AnnUtcPO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="I/QXXunR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66EB208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4529715F8;
	Thu,  5 Mar 2020 22:01:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4529715F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583442123;
	bh=VHeIp7Vf126zTQh+8yKcp+O0GCqPXKBZXNRRpBM9YEE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AnnUtcPOlUhcgix9TBvNUnwkGW7AcuRpiltRXeuTQBf4ACW3ie3eDE4hEjt3IAF1E
	 hrESW1llPyWKvpjjQC2WzQoAGp0csUUvdq8eL+Lc8VRiAv0EdeqO9XHdlqMLlqoxgm
	 X2dAvqtMnoXRJwFwi8yE8rUucZ2uMnnKgio7kOtw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4661F80245;
	Thu,  5 Mar 2020 22:01:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F976F8025F; Thu,  5 Mar 2020 22:01:04 +0100 (CET)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C297EF8012D
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2020 22:00:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C297EF8012D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="I/QXXunR"
Received: by mail-qt1-x841.google.com with SMTP id v22so132714qtp.10
 for <alsa-devel@alsa-project.org>; Thu, 05 Mar 2020 13:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rirrIqBp1YR7hjzgEMz3Rta06AiFV4BR0aGUnx3XIoE=;
 b=I/QXXunRVbFkGm/ZLRBPW3UsEw4H6o4hRmjQMTPkzGnV2vmi3JPOMeBD4CgS++3SeK
 cLFY8098wcd4R+PA/gxMvKOXe8Ch/CaldGDJCwyFc9tEz51/XIaOH8dQBtv43Q1VlRhG
 4OXwRQ8nNdnfOvsEvnyamZ46t2l1rYXoMJKxHv+/ilmczrkKPR1p9T4meSUfi4z8UciP
 szx0cTJbWHLmmV1SCOj1QGOsxthvh7S3oDFhNl47/R7/NaqbCweMx37J1FoWZBsQe2H2
 dnQwwIjmzrcDOzz05ZJzcGftWy0KbO7HvrhlbIKGdiB+IaqmsBuGY6zAiHygB4hp3fbB
 nTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rirrIqBp1YR7hjzgEMz3Rta06AiFV4BR0aGUnx3XIoE=;
 b=BAU85RA96cjcfpJWqVz/J3jt88heVkrRYq6wye0lhMu4FD3ksAfklkvnIOAwPwr2uf
 yUrCeewpEHVbTpDhh3lBJBfzGiwkIwm9JengpO0PGCP9GVfj3s/xJu7nrySfc+MGNJQn
 tRiTekjh6/+E9Y8hHv+Cgi/C7Rz+gTNieOtIBwqsE0Un4bzRTeMkoxMEmkpqJqcjBtV1
 O7r7vUqDCqxnoq+rWol+iUvfY6730MRKKdNg+FLcDqnFLCMQyKYnt6NakyjBVgykf96D
 T/zs/Jz4cE7xz7K35YX8OwikRK/AEzUW53TtRIOYwIJXkuAdcmAxcxWuibPfCvTH2qOZ
 u1ZA==
X-Gm-Message-State: ANhLgQ0gXytlTZ6aF/iL4PZWt5d2s7JTuLVluy9vaLmjHQy+zUnKwwNR
 5NtTRQikGjD6f4Xm6BDY5EyoSRAwIC8kGAlDWL3LJw==
X-Google-Smtp-Source: ADFU+vvXGIvyNEbhdAXOUMO6fV8hcppcasQNk9Y2u82llE9+NjxPBgupXTgs0hR3vvmt15kRRG1gWVbcMa3Cw/K3Xr4=
X-Received: by 2002:ac8:17ab:: with SMTP id o40mr92761qtj.308.1583442055471;
 Thu, 05 Mar 2020 13:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20200305130616.28658-1-pierre-louis.bossart@linux.intel.com>
 <20200305130616.28658-3-pierre-louis.bossart@linux.intel.com>
 <20200305133638.GE4046@sirena.org.uk>
 <13857c7b-f7d2-9be2-c1e1-a577a774773e@linux.intel.com>
 <20200305135908.GF4046@sirena.org.uk>
 <c1419cb1-c1d6-897d-05a4-48e57a3e15db@linux.intel.com>
 <20200305174324.GH4046@sirena.org.uk>
 <7c52ff6f-76ef-7c55-65e6-9c0437bb983a@linux.intel.com>
 <20200305183335.GK4046@sirena.org.uk> <20200305191059.GL4046@sirena.org.uk>
In-Reply-To: <20200305191059.GL4046@sirena.org.uk>
From: Curtis Malainey <cujomalainey@google.com>
Date: Thu, 5 Mar 2020 13:00:44 -0800
Message-ID: <CAOReqxhxZPvnRLssBgKKSHZ70Msj-eZwgNAu5ZmbLk+JWj8DNQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] ASoC: Intel: bdw-rt5677: fix module load/unload
 issues
To: Mark Brown <broonie@kernel.org>, Ben Zhang <benzh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

+Ben Zhang <benzh@google.com> who wrote the original driver for our 3.14
tree.

On Thu, Mar 5, 2020 at 11:12 AM Mark Brown <broonie@kernel.org> wrote:

> On Thu, Mar 05, 2020 at 06:33:35PM +0000, Mark Brown wrote:
> > On Thu, Mar 05, 2020 at 12:08:57PM -0600, Pierre-Louis Bossart wrote:
>
> > > b) do you have any objections if we remove this devm_ use without
> trying to
> > > dig further into the gpio management. This is a 2015 product that we
> use to
> > > verify the SOF driver on Broadwell, not an Intel-owned device.
>
> > The main thing I'm missing with this is a coherent explanation of the
> > problem and how the changes proposed fix it.
>
> Just to emphasize: the main concern here is that the issue is understood
> and that it's not just going to pop up again as soon as something
> changes.
>
