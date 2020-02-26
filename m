Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E79DC4BA12
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:33:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9AC20838
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EDvA7j8V";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo8zTNll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9AC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04327166D;
	Wed, 26 Feb 2020 13:32:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04327166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582720379;
	bh=dTko1tilxS3S8vj7bQGj7xrjWq8TTL6aDTriVVNz9Cg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EDvA7j8V6gjowRlQmPaH0jU+apw76ZN4XuIIvvc6cfL/Cpgp1mHySQ5v4CYxwbAzL
	 l0bAQg6k9z0G20jb66b5fjvQ9r+Ies7Ni3ILdHDaez5sZzBhcY6yLhSR7RJcvtd9WE
	 qktNWqrkt7K+mDSEMEJowaS6vggILafS7KjvsHsY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 826F4F8014D;
	Wed, 26 Feb 2020 13:32:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB9F6F8014E; Wed, 26 Feb 2020 13:32:05 +0100 (CET)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D12EF800E8
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 13:32:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D12EF800E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Vo8zTNll"
Received: by mail-qk1-x743.google.com with SMTP id m2so767621qka.7
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 04:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0MRsXhRp3E6rh2+qvZmIeFVHR93AAhtRNYB0tmbFEVY=;
 b=Vo8zTNllfC4o6nND7kLPoDV7V03+PGLD04JqV7MNWSx0oObQWxHlaEfGIBrdyHaRvJ
 ww2vSmC4bRv8i6hcU8VBeY2YhfMDKdaS6MfQUPq1T7fZxrXW5NTcxlG8C521XtoJJQOx
 AlBGmyqtGt3YFgb2TnObOZnHZNWjm9XEp7X9sF25doQduHp62/V02ifg2v+zkJGjLGie
 X240XCgFRjloBM3RFAwEtFylPsHPRhwNYVxOXI3L4Uz4qTKOe116ebQmBoaKfuWsL/+e
 cjoSbJV9c9LPLH4pAIgZn619ZEH4FQ8oRR3Ud3Vo+NF1ywIf8ZBsAIOqEb9XriCWX05L
 N/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0MRsXhRp3E6rh2+qvZmIeFVHR93AAhtRNYB0tmbFEVY=;
 b=eqeGWtA0YHXOMCDUS0p/XW0b5mIgBE7GWwSFH6EHD+eQz8ChjlgNzjuSLCAbhf11/C
 CoLLSxuP0+dhJyW5W5vo6Z6w5+c7gSgFXsVmvk5HVe+ZXlhXFbIpVyHhEQwomsQ744n0
 B0wRMJD9ZawpO2p8cdkEDoVFtJEx3S4CkpXyrhDR6DmOqziiDJTCCWssVDjsZ0o086ZR
 wVPv8nkx3ZRO8ps1+LTFXHiriK7494G8sobAYvXMZpn6N+QOZ4v8jWQp9vC0Au7zEPCI
 Ff/rPaTFbW9iQyA6KlueXIXUjZx+ASi+U50sNhwAA9bWi7iNAvmYpJfWnh3SNRatGgeJ
 Qtww==
X-Gm-Message-State: APjAAAXsk6loG9kjwVv9GmIcSQ4+3PFDTtJmYUbrLdG9xvymFzNCFddL
 o1lcWf0jnIommPDMYQroGu7F9RwGvcEAYj/VCfg=
X-Google-Smtp-Source: APXvYqzT0QOBpKRKbC4kcg/YNxuLy3cnTrGuXc9LH9ek2oNBn/hVko38x0Hlgj0xhIw5szgawcSuZNLgT142188LFQs=
X-Received: by 2002:a37:a8c3:: with SMTP id r186mr5306087qke.37.1582720319288; 
 Wed, 26 Feb 2020 04:31:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582007379.git.shengjiu.wang@nxp.com>
 <a02af544c73914fe3a5ab2f35eb237ef68ee29e7.1582007379.git.shengjiu.wang@nxp.com>
 <20200219203706.GA25618@bogus>
In-Reply-To: <20200219203706.GA25618@bogus>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 26 Feb 2020 20:31:48 +0800
Message-ID: <CAA+D8AMrHHZ3U66z+jroZqLK8pnn7xF0A9MCzxAqdqDfUHxf2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ASoC: dt-bindings: fsl_easrc: Add document for
 EASRC
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
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

Hi

On Thu, Feb 20, 2020 at 4:38 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Feb 18, 2020 at 02:39:36PM +0800, Shengjiu Wang wrote:
> > EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
> > IP module found on i.MX8MN.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../devicetree/bindings/sound/fsl,easrc.txt   | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.txt
>
> Bindings are now in DT schema format. See
> Documentation/devicetree/writing-schema.rst.
>
Thanks, will switch to .yaml format.

best regards
wang shengjiu
