Return-Path: <SRS0=CIz3=4U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D09C3F2D1
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:15:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E5A2073D
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 16:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ASKGDnBj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRm2UbJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E5A2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5835F1660;
	Tue,  3 Mar 2020 17:15:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5835F1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583252156;
	bh=+iql/zkUqoRsxihlG2SiKyAvCHVyENPogrjW1qdx8pM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ASKGDnBj7DaUlEX2d78zWnGMLtN+DhT+fS4tlZRANKjroHTp6TCVcrSmZxahkdWXb
	 XNKKGLA5vKTEglCylOVQboM0TON5C94aeW5tP/FnaigE8XD3iVUf3p/JDTuJQIam9v
	 r+Gl2cRnwyek/+R5C+zsWDFJD35fjnjtKQbSJhcg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7AC2F80245;
	Tue,  3 Mar 2020 17:15:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A95AF8025F; Tue,  3 Mar 2020 17:15:04 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57C38F8011C
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2020 17:14:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57C38F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="iRm2UbJA"
Received: by mail-pg1-x543.google.com with SMTP id t24so1744234pgj.7
 for <alsa-devel@alsa-project.org>; Tue, 03 Mar 2020 08:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=W6bZJgA2B8yV92ToUdbhDnWn8Wf8SVbR4fdlo/S3zYg=;
 b=iRm2UbJAX2KPPtw/bXpNYbHTxPhnF9TrWTcUJhwMwBI16gSfrqYYcNgFsgFeeb3pjN
 sMlsweLT6FEy/aGSKQ/hPhiIRuNmFeEb1lAGPiOu+A9QKPb7Q+/kV9PzMwnZ2HfhhAKe
 YR3GUIsL80GB869gdjQ1UXmMYhuBzdqlzlYrFjg2IY8uaW37xHB8Y0KX6ssYmTkfVDIR
 AyQTx0V5o3Df/Eu/eh9rT6kNPFnBvJEHo3X3thcSXE0yY/cT9sAm3PusIP2MduOEGa1g
 rwGJ+lAkLZyW+SAwv/6Fj8dDlOsQpivJVxcE/mrDTzGXB8WzrX2iWc5NPGUuP0dGwBtP
 fy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=W6bZJgA2B8yV92ToUdbhDnWn8Wf8SVbR4fdlo/S3zYg=;
 b=YdiIwOXcivmzrULjGU23/5gViX4VxtBnOb8EZn1s1XfTd16QIMUbfW/2FKAPQL0Ggf
 kMdf9qHnJ5hkZ7ZUKzQbp1E43BiiJysHNeUhzvHLLN7csZ0E8e6ysYwIqxgJtxzk5Uic
 MPWaY9NHNUwVk110pWibF3aIP3GWeIR9/N5fE5+lchAkG3CKNIdh4U0NwbC9nB78nT4n
 87ijUQlIIllEop8Bu6M+SbqgKsmlfq4rAlAglWrdm5Frmgbr0fDHwFu0x0H33HPsC/As
 dbHSp9XQJ3XTET44srKvYc7yjgHaoe9iS+bfbRYFlISIRABtrD9I4QSeW7w4IVrE3EMb
 nZ3Q==
X-Gm-Message-State: ANhLgQ1zIeXgUJBt4XIZaYu2BGMT09USDPG3DRqet+JIXWsLhVH0lCy1
 rmgII8ns2Qq+P5y0lg0/O1s=
X-Google-Smtp-Source: ADFU+vugfk5YAPZd2rPmqKWvu0ze5swsKp4lwvB0qve9j0052KotJHbV2aNn8l27fjDnDSRKs1OPxg==
X-Received: by 2002:a63:d241:: with SMTP id t1mr4545801pgi.283.1583252084874; 
 Tue, 03 Mar 2020 08:14:44 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id q66sm23071256pgq.50.2020.03.03.08.14.43
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 03 Mar 2020 08:14:43 -0800 (PST)
Date: Tue, 3 Mar 2020 08:14:43 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ASoC: Fix SND_SOC_ALL_CODECS imply ac97 fallout
Message-ID: <20200303161443.GA23017@roeck-us.net>
References: <20200224112537.14483-1-geert@linux-m68k.org>
 <20200303143444.GA25683@roeck-us.net>
 <CAMuHMdWZxc5KjHaOhk5xdcjSn54i3ku7b1dW6tXhXbjku1eLww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWZxc5KjHaOhk5xdcjSn54i3ku7b1dW6tXhXbjku1eLww@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>
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

On Tue, Mar 03, 2020 at 03:56:25PM +0100, Geert Uytterhoeven wrote:
> Hi Günter
> 
> On Tue, Mar 3, 2020 at 3:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > On Mon, Feb 24, 2020 at 12:25:37PM +0100, Geert Uytterhoeven wrote:
> > > On i386 randconfig:
> > >
> > >     sound/soc/codecs/wm9705.o: In function `wm9705_soc_resume':
> > >     wm9705.c:(.text+0x128): undefined reference to `snd_ac97_reset'
> > >     sound/soc/codecs/wm9712.o: In function `wm9712_soc_resume':
> > >     wm9712.c:(.text+0x2d1): undefined reference to `snd_ac97_reset'
> > >     sound/soc/codecs/wm9713.o: In function `wm9713_soc_resume':
> > >     wm9713.c:(.text+0x820): undefined reference to `snd_ac97_reset'
> > >
> > > Fix this by adding the missing dependencies on SND_SOC_AC97_BUS.
> > >
> >
> > With this patch applied, arm:pxa_defconfig reports a variety of unmet
> > SND_SOC dependencies, and it fails to build.
> >
> > ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9713.ko] undefined!
> > ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9712.ko] undefined!
> > ERROR: "snd_ac97_reset" [sound/soc/codecs/snd-soc-wm9705.ko] undefined!
> >
> > Reverting this patch fixes the problem.
> 
> Should SND_PXA2XX_SOC_AC97 in sound/soc/pxa/Kconfig select
> SND_SOC_AC97_BUS instead of SND_SOC_AC97_BUS_NEW?
> The latter does not exist.
> 

Doing that results in:

sound/soc/pxa/Kconfig:24:error: recursive dependency detected!
sound/soc/pxa/Kconfig:24:	symbol SND_PXA2XX_SOC_AC97 is selected by SND_PXA2XX_SOC_TOSA
sound/soc/pxa/Kconfig:79:	symbol SND_PXA2XX_SOC_TOSA depends on AC97_BUS
sound/Kconfig:109:	symbol AC97_BUS is selected by SND_SOC_AC97_BUS
sound/soc/Kconfig:26:	symbol SND_SOC_AC97_BUS is selected by SND_PXA2XX_SOC_AC97

Guenter
