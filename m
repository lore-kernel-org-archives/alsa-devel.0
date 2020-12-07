Return-Path: <SRS0=x+il=FL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B11DC433FE
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 23:22:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7B923A31
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 23:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7B923A31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A80716F0;
	Tue,  8 Dec 2020 00:21:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A80716F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607383326;
	bh=edbZ2+l1MblK0BZAl+T/FCWMuTNbLUVokY+QPVK2mX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gLPr87vf6gtyNx/KITfQ60JxueJj6LXVfQPAJtHH8n8TqJlIhFZXFpRRdAtakEzKb
	 MHzDuofWOPr+aXa9xOucfeT2bB1pqfvc8PXTLYhBAkeoJckQ012lH6RKesGfPagUc2
	 WupEHA9u5dO96VCagRxNnrr12wVDH7d48FUEhq0I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 838DCF801D8;
	Tue,  8 Dec 2020 00:21:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D12ABF8020D; Tue,  8 Dec 2020 00:21:13 +0100 (CET)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66B0BF8015B
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 00:21:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66B0BF8015B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Rcly/dyF"
Received: by mail-ot1-x341.google.com with SMTP id b62so14227061otc.5
 for <alsa-devel@alsa-project.org>; Mon, 07 Dec 2020 15:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=edbZ2+l1MblK0BZAl+T/FCWMuTNbLUVokY+QPVK2mX4=;
 b=Rcly/dyFCNQ4lyyFprCAU/lXdZFd+ySy9hRgc31aa5GMyT/jVNjPuPSHrKnm+aEotO
 sI2FffHUbXZtsPmxRyIVXXQrbpHh3N1DNt67TDAmNWFNVzbdT3I/umQvR5UAZ1kwAEDK
 F3awwK1PlHuovJWeoV1+uMp1n2uEI43X3cC9IQNV1Ul5uB8XI7L3WMjyvnJ8DfxOtl7i
 lmj8t/rykQcp8nB153WWKNt0ybBObvKsxdfx6ZZDmEliJYeJgodIsnTUkI1NBiQRu++b
 4mQulta309fUpSLGoCwj11YXKnOGf2HcF1FCM6W+0c5Kn3qw7KAjG5o+cZqkaMFQGW05
 6eRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=edbZ2+l1MblK0BZAl+T/FCWMuTNbLUVokY+QPVK2mX4=;
 b=C6ClFXTmCnmLoAsbHU+FCewbP+8visfh4C3k3/E3P0+Gd7GxxZwMcDDKA8jvaEzN5V
 wxpKalQQoGJikCscbR5RMwWanAbK2195lF/psT1UWHQipIPddDea/LCdaguwQgquLWmH
 kPTg9G1rAhUXzzVUnD5pvKUPzdLoCCV/OXjsoNrqf4hGqByBHafW/+aMtRIvUuYhJy1v
 T67SuvIFgqN9YAVQA9XHNsWfxDB5+sdOn0nwHKpsXHxtgSlNTAjx0tj9FRDJZl5SQE8a
 +tT5sGdMARY/HcWBWo6lAh1wKK/bSjQ9HQ3aArQWJtKq5st68YHc5ek8Rv/DgC2kYI6Y
 HWCA==
X-Gm-Message-State: AOAM530XpaI6EytLaeEyzo5YxP1KZe0w46DIQQ1J2NTZGxjQWmPOovnq
 JwzZ9Lyodawm5JuCKzrQDyqQs2O+Xp0GWM4Cw+M=
X-Google-Smtp-Source: ABdhPJz0LTQfzPn68GwM+TvRci1apQbH1YT2kFBQny+zO3s0aS+RV3wXHxfUQHKdy93d8dnZwcppok+nSnLdVnLAvlE=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id
 d27mr12629023ote.132.1607383264756; 
 Mon, 07 Dec 2020 15:21:04 -0800 (PST)
MIME-Version: 1.0
References: <20201207084616.411531-1-conmanx360@gmail.com>
 <s5hzh2q0z8o.wl-tiwai@suse.de>
In-Reply-To: <s5hzh2q0z8o.wl-tiwai@suse.de>
From: Connor McAdams <conmanx360@gmail.com>
Date: Mon, 7 Dec 2020 18:20:53 -0500
Message-ID: <CAM8Agx0c6xGh4M_j8GHtfZ1MjzyV1dmbh=EWfASL_SBYgR6UVw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ALSA: hda/ca0132 - Fix AE-5 rear headphone pincfg.
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>
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

Will do, thanks for the info.

On Mon, Dec 7, 2020 at 3:58 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 07 Dec 2020 09:46:13 +0100,
> Connor McAdams wrote:
> >
> > The Windows driver sets the pincfg for the AE-5's rear-headphone to
> > report as a microphone. This causes issues with Pulseaudio mistakenly
> > believing there is no headphone plugged in. In Linux, we should instead
> > set it to be a headphone.
> >
> > Signed-off-by: Connor McAdams <conmanx360@gmail.com>
>
> Those patches are relevant with your previous patches, right?
> If it's a fix for a specific commit, it'd be appreciated to have a
> "Fixes:" tag with the commit id and "Cc:" tag to stable in the patch.
>
>
> thanks,
>
> Takashi
