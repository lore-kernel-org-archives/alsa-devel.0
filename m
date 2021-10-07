Return-Path: <SRS0=Vpzd=O3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5B7C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 07:08:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C94661130
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 07:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C94661130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFE01166E;
	Thu,  7 Oct 2021 09:07:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFE01166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633590503;
	bh=+8HtTa/XW2jm2lOpHEo8noJAF6j1LkfZQbiw92FUKmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FPT5Zit5zizI8xBGhPLqugmNs4RulARbQVLPWm8mbk0e8ICU1ST8nU6TB24KThGuH
	 Q2+RV35kSdKt7+uHN9q6281bMzGb0u8hgNYdlCDwaeTt7IqdG5Db9CXjiFveLlYe3e
	 e+ItD9X7OBvRNLT3gbp7ZJBDi9lNZbTZLpTaNSmk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57F58F80259;
	Thu,  7 Oct 2021 09:07:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A49D8F8027D; Thu,  7 Oct 2021 09:07:30 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 475C1F800F0
 for <alsa-devel@alsa-project.org>; Thu,  7 Oct 2021 09:07:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 475C1F800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="kkEwdCfb"
Received: by mail-ed1-x52d.google.com with SMTP id l7so19470779edq.3
 for <alsa-devel@alsa-project.org>; Thu, 07 Oct 2021 00:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lpotU76vDdSm2eyI0wHhAXO0FhpuVMiLp6edMsQuB/8=;
 b=kkEwdCfbTMghfRCVfLPPLp6Ro4F1GGM3fceeohiUVlRN4EvoS4bUU9ZEXdgNEcYSPQ
 GqAsnu/9pLxoqx9/4XrtPZGMjLaG1cTG8SI+wqFhLWPUg6ltkKAg9Egsk/1tu02ev+bT
 vB6yL1wCtirUM6SrADyGQJjRQwGgvaD8saIxAOpJFTm4GwRmOnBdRjCgGkI0jbVT/LYA
 DUEdSsEUFz7oc2mT9zolDrRgEKm6+j9Ja6Q+6sGMF9C2+4cAf7FTDWoPhM0nQGcFplDi
 362TcgNl4Uqr7APsGnhAdmCoDYqiagqQkjVOg0ajKvBiitYSGIHuQi8kOx9/LsUGVRer
 REdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lpotU76vDdSm2eyI0wHhAXO0FhpuVMiLp6edMsQuB/8=;
 b=8KdwQAJsj4lnY5XtrbUrIGRFC3T6/wEWb6AqJFXT3sPypwmbvfLWW0meJbLEp/N0RK
 I97T6ytSFZdP1qQpvOoi8PSHuW5W/xQ6K7hrsk/y2n9lI60NaCfsUvSWL3qtaOKZW+Zj
 FOLyuRRZumVpaDQZqur5Wo7JqtFMsU47VMgETU5nUndFnmC27+AyJuZlAvBlFI4w9U7A
 V8/OOqVpf4tGrHj5ccRkxb5i8EUp+xyqypq7Wfu3BpCIxZ/b3ivwP6gT0prKiohdGNU9
 biegKUwPufElbohng/DJ4co2+VLW1gOHCCwy8ppRZCMGCL7fGTTTycLFMu8mETDfn60k
 NSVQ==
X-Gm-Message-State: AOAM5303Wf23RsqpfarOHuxTmTuNbn9O8bAolRqj6weMbifHtdccx6hV
 fO+see1Xc95sJiAIzrg91z5TRiBZFTSLtVBAdQ4=
X-Google-Smtp-Source: ABdhPJzPiN2EYEiuKmeFZCvmZzjTLeaum6RWXkWNbQ1qvZhfFyAItuboJf5DUkY/AeLRN5wZXWuWQUVdU1fvcd/tiwk=
X-Received: by 2002:a17:906:5a47:: with SMTP id
 my7mr3576173ejc.128.1633590442300; 
 Thu, 07 Oct 2021 00:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633572679.git.atafalla@dnyon.com>
 <5004d52da527bf1dd9e5b17e20b2ce50a0b57b5a.1633572679.git.atafalla@dnyon.com>
 <4682758.31r3eYUQgx@alexpc>
In-Reply-To: <4682758.31r3eYUQgx@alexpc>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 7 Oct 2021 10:06:46 +0300
Message-ID: <CAHp75VdbZmGeCq8A1E3AJU4T39xPUhomzrQqZNaDj8Zi0x9WrA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: sound: max98927: Add reset-gpios
 optional property
To: Alejandro Tafalla <atafalla@dnyon.com>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree <devicetree@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
 <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 " <~postmarketos/upstreaming@lists.sr.ht>,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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

On Thu, Oct 7, 2021 at 5:45 AM Alejandro Tafalla <atafalla@dnyon.com> wrote:
> On 7/10/21 4:38 Alejandro Tafalla wrote:
> > Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> > ---
> >  Documentation/devicetree/bindings/sound/max9892x.txt | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Sorry, I forgot to add:  Acked-by: Rob Herring <robh@kernel.org>

And commit messages?


-- 
With Best Regards,
Andy Shevchenko
