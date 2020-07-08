Return-Path: <SRS0=mEIa=AU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5534BC433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:26:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E1620720
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tkBNmxf6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io5qErML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E1620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F8871660;
	Thu,  9 Jul 2020 16:25:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F8871660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594304796;
	bh=0cL23bUd7WWvjO/NXxMnsulm74ljQLVfiATOvoDpZTg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tkBNmxf6+UVoMMpLiqnhRFKOsm/HCliYnGCmTxf4IU1iq7CCAhGuXBTIcIFZ9xWfT
	 fizTLOUkFAX5zM6xhDBXayebiQT+B8oK+SjRy5ngFTr2NDOUTGcdA1DFlV6JItPh+p
	 uDRFQf00JKBzn8Vu28GCt3F80n8gLP893ncWIS8s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26368F802E0;
	Thu,  9 Jul 2020 16:22:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24DC7F8015A; Wed,  8 Jul 2020 18:25:37 +0200 (CEST)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 112DFF8011F
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 18:25:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 112DFF8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Io5qErML"
Received: by mail-io1-xd41.google.com with SMTP id i4so47592127iov.11
 for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2020 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qm7dRGKiw730Olt/HrMoQtUDcOhKGV8ocadFpWr81/8=;
 b=Io5qErMLbMbVUzcefcxDZalWfIpcbCDBgDBWRVrfAlslRqv0R64heqxyS5WRKVFok/
 4OC4zCEItBIyfFAlJeWHT46MprDWBQirbCccoZmmMs8Kxx82ZXvFmd9drdKldx75+HBX
 eMRGg/30/MdZDeZ9SwCiVcqgLrTPcWe7YPwOu7mfQegdrRb8jgzctAey9ZrgqvQUWBDy
 w+hNho5vob4jKVosMUjdkKVpLIeh2Y4aClltUvYx4jPHt5qfMQPWL0KtThC5FbRPO/UH
 CAvteNYptrOVLISamof/F98K4bkx7hdDth+6FehOEPNDFBVq74HwhLYSzw8PKgEZRozr
 inkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qm7dRGKiw730Olt/HrMoQtUDcOhKGV8ocadFpWr81/8=;
 b=VRwWqZhYsL51+4GjJfFFUNb4Gty3SuZ095R2lNf7al/PHWQ2hN/7sgUXIhBicVft0i
 eVUNF8l1P+dUQrnQJFIsmCQ6Qt/zDprmr4ZhVQuI09luuR6B2ECR6cZLgpF5YjUFtOUw
 hVQSH1V1tP3/luoIog+qt8GaWaVYuYTguapRuoNIPSJZDoLQN90MqMwY1X1nvfZRYd9v
 I1avFwP+Dq+mDmMHFlNzlNP4f5SXZ8vrOrwdkbNGAVs3yDKLCeQUlxi0VWVNyajkTIum
 elmPQfsbdNRvwIEnSd0tkVXCL5GKsH9+y8tdpQFF+nn2Y7YrvPGmdut9cg1myPkQiber
 3edQ==
X-Gm-Message-State: AOAM533Zbrp7baRdCVWJe7PnHHM8o+7Q3cJ8dhctih9Sb9YbiBkI+YWf
 iGfrJanraL69FKPWeAXiOZiM21WQAmsKr2iXdgk=
X-Google-Smtp-Source: ABdhPJy9ugkrSjfoUQs4eKC+m15bKrIwUQQPcvu6crqwqa4FwNicCuT6XCmHMyCDZpjj3IC6o1VYsOmmDonCD73oVLU=
X-Received: by 2002:a02:8816:: with SMTP id r22mr67915541jai.128.1594225525434; 
 Wed, 08 Jul 2020 09:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200702081709.10159-1-doomsheart@gmail.com>
 <s5hsge3d1wh.wl-tiwai@suse.de>
In-Reply-To: <s5hsge3d1wh.wl-tiwai@suse.de>
From: Junar Wohn <doomsheart@gmail.com>
Date: Thu, 9 Jul 2020 01:25:14 +0900
Message-ID: <CAHcbMh3FWqfZPU7TE6oOEpiTyyHD+Jom3FKDzBh2-khqBNTkDQ@mail.gmail.com>
Subject: Re: [PATCH] Fixed no headphone sound bug on laptop Samsung Notebook
 Pen S, by using exsisting patch Linus' tree as commit 14425f1f521f (ALSA:
 hda/realtek: Add quirk for Samsung Notebook). This laptop uses same ALC298
 but different subsystem id 0x144dc812. So I add SND_PCI_QUIRK at
 sound/pci/hda/patch_realtek.c
To: Takashi Iwai <tiwai@suse.de>
X-Mailman-Approved-At: Thu, 09 Jul 2020 16:22:25 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, tiwai@suse.com
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

Thanks for your feedback.
It's really helpful to me.
I'll revise email and send you again soon.

2020=EB=85=84 7=EC=9B=94 7=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 8:01, Ta=
kashi Iwai <tiwai@suse.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> On Thu, 02 Jul 2020 10:17:09 +0200,
> Joonho Wohn wrote:
> >
> > ---
> >  sound/pci/hda/patch_realtek.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/sound/pci/hda/patch_realtek.c
> b/sound/pci/hda/patch_realtek.c
> > index 737ef82a75fd..ebedc6093642 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -7528,6 +7528,7 @@ static const struct snd_pci_quirk
> alc269_fixup_tbl[] =3D {
> >       SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen
> (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
> >       SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro
> (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
> >       SND_PCI_QUIRK(0x144d, 0xc740, "Samsung Ativ book 8 (NP870Z5G)",
> ALC269_FIXUP_ATIV_BOOK_8),
> > +     SND_PCI_QUIRK(0x144d, 0xc812, "Samsung Notebook Pen S
> (NT950SBE-X58)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
> >       SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807",
> ALC283_FIXUP_HEADSET_MIC),
> >       SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120",
> ALC283_FIXUP_HEADSET_MIC),
> >       SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)",
> ALC283_FIXUP_HEADSET_MIC),
>
> Thanks for the patch.
>
> The code change itself looks OK, but the patch has to be provided in a
> formal way described in Documentation/process/submitting-patches.rst.
>
> That is,
> - Move the description about your change into the mail body, not in
>   the mail subject; keep the mail subject concise
> - Don't forget to give your Signed-off-by line, which is a legal
>   requirement
>
> Once after fixing those, please resubmit the patch.
>
>
> thanks,
>
> Takashi
>
