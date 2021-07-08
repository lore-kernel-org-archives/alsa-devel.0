Return-Path: <SRS0=3BcS=MA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73098C07E96
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jul 2021 12:30:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B7C613B2
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jul 2021 12:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B7C613B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30775820;
	Thu,  8 Jul 2021 14:29:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30775820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625747404;
	bh=XEEu6wvzUz+GtwYORf+IsZTvJv6sIgrGjgGRUQMSfw4=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZW8xEJgsNgafCJcBEEaayQ0BnNhajnD610SDAVJ+mXPRIFiRD50LbseEPSJEW16Ew
	 Cs6J0FcFvRz/DUfFd6ubBCAaE+arnFWQS1YC50fAKHauxhtG8t+HvDlsKpYfijVINu
	 WAITbRrdIi9Ipv3JQeYZREou79KLnvJrld303OA8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3846DF80246;
	Thu,  8 Jul 2021 14:29:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87998F80249; Thu,  8 Jul 2021 14:28:59 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4257CF80143
 for <alsa-devel@alsa-project.org>; Thu,  8 Jul 2021 14:28:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4257CF80143
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="g3p6IdQu"
Received: by mail-lf1-x136.google.com with SMTP id u18so5291155lfl.2
 for <alsa-devel@alsa-project.org>; Thu, 08 Jul 2021 05:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=NQAuXMFmObdMnWXeSRrLFvLFh0QiDBqCUxmLFElViTA=;
 b=g3p6IdQuvFlFm42dmZppDBVWrpw9cl6Ib4L7X+YnRl9lKN7bB3uCLgi8prp3RJbsXX
 4if13S9N79kl3noIuJtMbWX/+b94eNehyhH4fSpd5vFB91jltuP3wqsKfaXKTyOBsVuR
 COFkLLiArdEQJEuUG/wQyZvLAdot18La/IIwKxb6DoX+h5eOAA68tu0hpUQPvKcDLts5
 IJfEhsEvf/hk3P/gi25WpJ148FVML3ftznlOcpNXglEVXN0lVmwWbP7hS9bV36PEb93N
 BK5+7BKrKAQ3HcRgVeSCNy3YtBLY9U9lenlPBtjsoQqrJ/Khn4zY7igC995vb3ZTdmZG
 rKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=NQAuXMFmObdMnWXeSRrLFvLFh0QiDBqCUxmLFElViTA=;
 b=WMvHRUr7NXXFKbwOe42iLE+teuCp+R50GOS1QIQzhEYWNAA7m7u/x2UM5ZtCUq+Bzk
 yUSOWlwd5zGgLYPbQ05vNZCyQBVqlHVHCBPOfQp3FH6mKuZbZ9QGO5n9URa9ePrdcUA4
 ITyUgrcn+OO3U316BoAkcgTTLMLGYLNqxrDETKW2h5gLmstUO38s6VtFdgS7442kTqTI
 rTiKB89hn0IpuFaDANZ7yet13AGdEvA8A0F9Q8SNaer5VHa/LBpPbsmFBG5LXInyrfqD
 0FTUSWEgS9OELS9CMxtRD0Pj4t+pdEXCKCA+C1JGIAAabXgr0IRoEGDv4PywVpyZ5apR
 IMqA==
X-Gm-Message-State: AOAM530mtWDkfsoHBPwFML/GvsxkJdyWgMmYxQwR7BfCxa4Gq7zmYdzz
 PDFTtrJmjFWfAqZOEoX9b85+yL7F/zqgdXfsI2OJS1dweg//Dw==
X-Google-Smtp-Source: ABdhPJzDdGvbGRG+R8cIW/+GLjgQOusPTI7f/8hHJ23dei0VWnInE2jyPxKJ3edP2D7R8Xcs7Otof5+Zijb1GzB0q4o=
X-Received: by 2002:a2e:2407:: with SMTP id k7mr11017030ljk.473.1625747321959; 
 Thu, 08 Jul 2021 05:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAEk1YH4Jd0a8vfZxORVu7qg+Zsc-K+pR187ezNq8QhJBPW4gpw@mail.gmail.com>
 <s5hlf6h594o.wl-tiwai@suse.de>
In-Reply-To: <s5hlf6h594o.wl-tiwai@suse.de>
From: Damjan Georgievski <gdamjan@gmail.com>
Date: Thu, 8 Jul 2021 14:28:30 +0200
Message-ID: <CAEk1YH6geicHz0DWjpP=M_pEw7Ytu3jZYzPJL8VtkGZBCT10uQ@mail.gmail.com>
Subject: Re: Audio out on DisplayPort but not HDMI, on AMD Ryzen APU/Vega
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

(re-sent to the mail list)

On Thu, 8 Jul 2021 at 13:37, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 02 Jul 2021 15:27:30 +0200,
> Damjan Georgievski wrote:
> >
> > I have a desktop computer with an AMD Ryzen 5 4650G PRO APU (CPU + on-d=
ie GPU).
> > The motherboard (MSI Mortar B550m wifi / bios 1.6). has one
> > displayport and one HDMI outputs.
> > The displayport is connected to my Lenovo P27 monitor, and the HDMI to
> > my Samsung TV.
> >
> > When I choose the GPU as an audio out, I only get audio on the 3.5"
> > headphones jack of the Lenovo monitor, while I would like to get the
> > audio on the Samsung TV over HDMI.
> > I can't find a way to switch the different outputs (neither over
> > pipewire or just using native alsa).
> >
> > pavucontrol configuration https://i.imgur.com/9nbVtNz.png
> > alsamixer -c0 only has only one option to mute s/pdif, which mutes the
> > output on the displayport -> Lenovo -> 3.5" jack.
> >
> >
> > $ aplay -l
> > **** List of PLAYBACK Hardware Devices ****
> > card 1: Generic [HD-Audio Generic], device 3: HDMI 0 [HDMI 0]
> >  Subdevices: 1/1
> >  Subdevice #0: subdevice #0
> > card 2: Generic_1 [HD-Audio Generic], device 0: ALCS1200A Analog
> > [ALCS1200A Analog]
> >  Subdevices: 1/1
> >  Subdevice #0: subdevice #0
> > card 2: Generic_1 [HD-Audio Generic], device 1: ALCS1200A Digital
> > [ALCS1200A Digital]
> >  Subdevices: 1/1
> >  Subdevice #0: subdevice #0
> >
> > Am I correct that card 1 here ^ should have at least two devices?
>
> It could have more entries, depending on the configuration.
> I suppose you enabled CONFIG_SND_HDA_CODEC_HDMI properly?

yes - CONFIG_SND_HDA_CODEC_HDMI=3Dm is enabled.
I've been using the  Arch distro kernel, which has that enabled; but
also with self-compiled 5.13.0 from
stable, with the same distro config; and with 5.14-git (77d34a468)
with the same config.
All have the same behaviour.

Should this hardware be supported with the
sound/soc/amd/renoir/rn-pci-acp3x.c driver (instead of snd_hda_intel)?
=E2=80=A6 since it is a Renoir desktop APU.

> Please give alsa-info.sh output for more detailed analysis.


http://alsa-project.org/db/?f=3D00b31f3f0e6c58b56c73f98aec7c6b5ccaff700e



Thanks for looking into this.



--=20
damjan
