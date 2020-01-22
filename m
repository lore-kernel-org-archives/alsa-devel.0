Return-Path: <SRS0=vsGj=3L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C814C32771
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 23:05:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B0421835
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 23:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TN8E8JYB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="coez5CmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B0421835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A2F91660;
	Thu, 23 Jan 2020 00:04:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A2F91660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579734316;
	bh=GaSLB5bRKVpbbBrDH+p1bOlL5YG3Uxv4gipDyWVSeeQ=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TN8E8JYBYUnl2l43pnw8c/PkDy4bYQWm0oBeAXOvnQYIeBcKVmdsWX16j22788euH
	 bdj7FBClbLPYrUx3rYN4sXe6wPUKwc4gAjSTjse8r6qMgXwN/lFuCtdvBUGDB7rrww
	 7Y35L3aMGjlACD8lUgtFTTziuoE56cq82TcKYw60=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A45EF801D8;
	Thu, 23 Jan 2020 00:04:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBD2CF8020C; Thu, 23 Jan 2020 00:04:23 +0100 (CET)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59446F800E7
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2020 00:04:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59446F800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="coez5CmQ"
Received: by mail-io1-xd41.google.com with SMTP id d15so1060138iog.3
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 15:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Rx5dSGGDU3a4klMudAzkmYdVYzSQF0u8+Kn1SdwmCAs=;
 b=coez5CmQuTDa896qBVyNQD6pM43uZR9yk2I73PsKlcphQ7J1dMz9eVNFtvJMOJsY59
 es5SHT8H65VDVU3eFYwQJ0xMAFA6cK5oXGyoS+WX3I5sh5KEsyodRIDevDCmkN6POS70
 onX7aBk54OOmkQz7PObRFnowBq9nePDONJUMTAjxyMZ18WkKO1qdso4uKO1amI3Z0siN
 1bo0HqMCx8R4OWVffILOdn7OqZHrRFkSVbV4QPQR6XbKJARqykKRxxLz2sfPZ99+t9G9
 NtzFgFfRgHkFdjXu3bFO5h2ATF7pEHntV7Gj/zX1l7rCW1fSXTQ6TAUVqUmggsinop7x
 q5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rx5dSGGDU3a4klMudAzkmYdVYzSQF0u8+Kn1SdwmCAs=;
 b=S/75f4jBQXJ8fGjvDCz+4f6M1XSDiL+5eWeva9JSsKJozcSJuF/S23g7HpgbR4Rw41
 WQBTJb9lhPMi5zd67uKacrCRq8533EwkCH4dsP78I996Go/MGkCRazVIuYR0MPhwcLmR
 cpK59rPYaz+8+F4PMj/4j8ZEn+yGfw18rxCpavfcJIBrl01GnrZQXBGCPmyzwhICgotW
 ksMD1on1LbXw7gBcdR2EOwUOSMMbXAp2me2vjI2FqT1XbsyVUk8INEgKUiKon/ZlY8vi
 0MQz5DxOW8oeS8baVvwn3AdYKyQwubU265b0+H+vrOdBuqgleV3unj3xZQfZOmmpcWXi
 8KYQ==
X-Gm-Message-State: APjAAAU+INagLfc8UsiPmoh3nrnoPqqb9VkU8g8WfmfaiG7oS9wYvTsY
 D3s0l6l7bJY4W1zPM5NSDZSDiIF3SJU5Czol9GNY7Q==
X-Google-Smtp-Source: APXvYqyCc1oyieRlhVAWv+A8r4772Q+mpJP7SG4WVvRtV8qim7esVX1GV/4AVn6ukIV1tBtAb8V3dMJCZWIP5u/bF8g=
X-Received: by 2002:a5e:da42:: with SMTP id o2mr8574654iop.125.1579734258486; 
 Wed, 22 Jan 2020 15:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20200122181254.22801-1-cezary.rojewski@intel.com>
 <0c4a19c3-f1e3-7b76-be42-e4902645955b@linux.intel.com>
 <CAFQqKeVi8OBNc0ON+ogFBv07fYV25G3oK9Hsnydfg-sTwYZx5A@mail.gmail.com>
 <b6809ad7-10dd-2afd-6d46-953d0e59c249@linux.intel.com>
In-Reply-To: <b6809ad7-10dd-2afd-6d46-953d0e59c249@linux.intel.com>
From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Date: Wed, 22 Jan 2020 15:04:07 -0800
Message-ID: <CAFQqKeW=hOztSvomDPz-Ge9JHhuMk2Lr9ugLTNwXPFE3sKWKzA@mail.gmail.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>, tiwai@suse.com,
 Liam Girdwood <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: skl_hda_dsp_common: Fix
 global-out-of-bounds bug
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

On Wed, Jan 22, 2020 at 2:50 PM Pierre-Louis Bossart <
pierre-louis.bossart@linux.intel.com> wrote:

>
> >> Kai and Ranjani, do you think this impacts SOF as well? Or does our BE
> >> override somehow suppresses the problem?
> >>
> > Hi Pierre/Cezary,
> >
> > SOF does have the same problem too but I thought we're allowed to have
> dai
> > links without platform component? An alternative to adding the platform
> > component would be to do something like below.
> >
> > Thanks,
> > Ranjani
> > diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c
> > b/sound/soc/intel/boards/skl_hda_dsp_generic.c
> > index 11eaee9ae41f..dacf8014b870 100644
> > --- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
> > +++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
> > @@ -112,6 +112,7 @@ static char hda_soc_components[30];
> >
> >   static int skl_hda_fill_card_info(struct snd_soc_acpi_mach_params
> > *mach_params)
> >   {
> > +       struct snd_soc_dai_link_component *platform;
> >          struct snd_soc_card *card = &hda_soc_card;
> >          struct snd_soc_dai_link *dai_link;
> >          u32 codec_count, codec_mask;
> > @@ -148,7 +149,8 @@ static int skl_hda_fill_card_info(struct
> > snd_soc_acpi_mach_params *mach_params)
> >          card->num_dapm_routes = num_route;
> >
> >          for_each_card_prelinks(card, i, dai_link)
> > -               dai_link->platforms->name = mach_params->platform;
> > +               for_each_link_platforms(dai_link, i, platform)
> > +                       platform->name = mach_params->platform;
>
> we already do this indirectly with:
>
> skl_hda_add_dai_link(struct snd_soc_card *card, struct snd_soc_dai_link
> *link)
> {
>         link->platforms->name = ctx->platform_name; <<<
>
> I suspect the issue is that the plaforms part is not allocated. The
> 8-byte out of bounds is not a string, it looks like a pointer stored in
> the wrong location.
>
skl_hda_fill_card_info() would be called before skl_hda_add_dai_link(). But
yes, it should be fixed here as well or as suggested in the patch, we
should set the platform component to prevent this error.

Thanks,
Ranjani
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
