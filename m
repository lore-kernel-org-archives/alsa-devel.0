Return-Path: <SRS0=3BcS=MA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8882BC07E96
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jul 2021 09:01:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD49261C92
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jul 2021 09:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD49261C92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F50C15E2;
	Thu,  8 Jul 2021 11:00:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F50C15E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625734875;
	bh=htknzwNtS6hJ6LZsDMbKU8NzxzHLbVXPxVLpCNkgycs=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MjKD2954RJ5on7RQTuJUVYk6XgF0ktp/nIZPZMzJ6xHtmst914qqdCrWIntrIWSHU
	 kkoAbVUopryuLQHcXYPUT61slfwR+oCVOhFUk68yf6+DTyeRTx0/pg8+qK3Y9h1wHW
	 OvvX7tn6c1y/W8Zly8bi8ARswjFjPoa8HAIjrC5w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10950F80246;
	Thu,  8 Jul 2021 11:00:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11ABAF80249; Thu,  8 Jul 2021 11:00:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E99C0F8012A
 for <alsa-devel@alsa-project.org>; Thu,  8 Jul 2021 11:00:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E99C0F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="rH76wpsF"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="jJ5khGte"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2A0832017C;
 Thu,  8 Jul 2021 09:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625734811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zXBWX1J/SEQW1rLMlM4E1KFMEHbyBytq18w6+wHvhHE=;
 b=rH76wpsFPwPSCwy+j+WN+5Ylls3pePbrNr8gVu0eLbDdZ7BNfpcz0gTTl9jeO7a+7r4LHZ
 Mx74uy+IZmGQZUk/rvTE3KxyPmKiGRDhjo0fCgTbLPJriGWSsNHSIgsGLPpp+94b4D5rch
 /RMhO/TfvKJW5EzLaMoy8hArDXdf78Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625734811;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zXBWX1J/SEQW1rLMlM4E1KFMEHbyBytq18w6+wHvhHE=;
 b=jJ5khGtePHBx7PzxYRTZudOtCuVWq1fxcw+aW5ks5f23aPGMemVafe0SeIEcydk3qkCMdw
 RNrQuoekofssXNCg==
Received: from alsa1.suse.de (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 163AA2C1FE;
 Thu,  8 Jul 2021 09:00:11 +0000 (UTC)
Date: Thu, 08 Jul 2021 11:00:11 +0200
Message-ID: <s5h5yxl6uzo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: ALSA: intel8x0: div by zero in snd_intel8x0_update()
In-Reply-To: <CAMo8Bf+bGujLN7H5yBqy-AkPCN7LgfmGSiWEGdjW6ZWeFoXs9A@mail.gmail.com>
References: <YJ4yBmIV6RJCo42U@google.com> <s5hk0o18tio.wl-tiwai@suse.de>
 <YJ5cHdv6MVmAKD3b@google.com> <YKDYQfDf7GiMfGCN@google.com>
 <YKDYbaprE3K2QpCe@google.com> <s5hbl9b6mah.wl-tiwai@suse.de>
 <CAMo8BfKKMQkcsbOQaeEjq_FsJhdK=fn598dvh7YOcZshUSOH=g@mail.gmail.com>
 <s5ho8be8v3z.wl-tiwai@suse.de>
 <CAMo8Bf+FF8Ofq=FwoZZXp9vKiMaUZNAm+W=OJmu2j2XN6kLb-Q@mail.gmail.com>
 <s5hk0m26lfu.wl-tiwai@suse.de>
 <CAMo8BfLj+VLUbfUmHUSHOfc3PwbWd2w_xnaTZa9HyrcmvJCAkQ@mail.gmail.com>
 <s5hfswp6zx8.wl-tiwai@suse.de>
 <CAMo8Bf+bGujLN7H5yBqy-AkPCN7LgfmGSiWEGdjW6ZWeFoXs9A@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
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

On Thu, 08 Jul 2021 10:41:50 +0200,
Max Filippov wrote:
> 
> On Thu, Jul 8, 2021 at 12:13 AM Takashi Iwai <tiwai@suse.de> wrote:
> > On Wed, 07 Jul 2021 22:33:22 +0200,
> > Max Filippov wrote:
> > >
> > > On Wed, Jul 7, 2021 at 11:14 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > > On Wed, 07 Jul 2021 19:50:07 +0200, Max Filippov wrote:
> > > > > It didn't change anything in my case. My further observation is that
> > > > > the snd_intel8x0_update is called before the ichdev->prepared
> > > > > is set to one and as a result IRQ is apparently never cleared.
> > > >
> > > > So it's broken in anyway no matter whether
> > > > intel8x0_measure_ac97_clock() is called or not, right?
> > >
> > > The change that you suggested didn't eliminate the call to
> > > intel8x0_measure_ac97_clock, it's still called and an interrupt
> > > flood happens at the same place.
> >
> > Ah I see the point.  Then the fix would be a oneliner like below.
> >
> >
> > Takashi
> >
> > --- a/sound/pci/intel8x0.c
> > +++ b/sound/pci/intel8x0.c
> > @@ -694,7 +694,7 @@ static inline void snd_intel8x0_update(struct intel8x0 *chip, struct ichdev *ich
> >         int status, civ, i, step;
> >         int ack = 0;
> >
> > -       if (!ichdev->prepared || ichdev->suspended)
> > +       if (!(ichdev->prepared || ichdev->in_measurement) || ichdev->suspended)
> 
> There's no ichdev::in_measurement, but if replaced with
> chip->in_measurement it indeed fixes my issue.

One must compile the code before sending out :-<

> So with this change:
> Tested-by: Max Filippov <jcmvbkbc@gmail.com>

Great, thanks for quick testing, I'll prepare the fix patch now.


Takashi
