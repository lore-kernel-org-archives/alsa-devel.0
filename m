From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [PATCH 1/3] add API to allow disabling period
	interrupts
Date: Mon, 17 May 2010 08:59:21 -0500
Message-ID: <AANLkTinVgkyhnxekM02j88FrFb7tJrqYqnXkH5F6XaAB@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<4BDABDDD.4050502@ladisch.de>
	<w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>
	<s5hsk5uq4u4.wl%tiwai@suse.de>
	<AANLkTiljN2IuWnI1g3BsVux33VcnMeCAwBZl7kexDPvU@mail.gmail.com>
	<AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>
	<4BF1086F.9070900@ladisch.de> <4BF108E9.5020705@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B71D24665
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 15:59:23 +0200 (CEST)
Received: by iwn1 with SMTP id 1so374263iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 17 May 2010 06:59:21 -0700 (PDT)
In-Reply-To: <4BF108E9.5020705@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Looks good. Using the .info field is probably better than adding a new
one as I did. One correction though:

> + =A0 =A0 =A0 runtime->no_period_irq =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !!(params->flags & SNDRV_PC=
M_HW_PARAMS_NO_PERIOD_IRQ);

An additional test is needed here so that the capabilities of the
hardware are double-checked

if (params->info & SNDRV_PCM_INFO_NO_PERIOD_IRQ)
     runtime->no_period_irq =3D !!(params->flags &
SNDRV_PCM_HW_PARAMS_NO_PERIOD_IRQ);
else
    runtime->no_period_irq =3D 0;
