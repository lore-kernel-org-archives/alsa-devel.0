Return-Path: <SRS0=H50z=GA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447CCC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 17:14:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66DF822472
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 17:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66DF822472
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A57BF1743;
	Mon, 28 Dec 2020 18:13:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A57BF1743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609175675;
	bh=/3z7UIp76l7ebmYoAGcG1Dz2sddZMRrfNthhsVGQCgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ecM1Rb9ZzvEMilWH94Wjb9kNJ1/wZ3M1l/k2tBnTeT4tmQGji43qLVGjFxQe689ur
	 0frPLC+95G/tG5cOvvqsf0+/MdZAZ4jlZmiakmpvA7wJ+/aT7bacYsQYr91AochFc6
	 XeHqyHMt/0qk6vhL2ehHhefi6wqmFqKLBL20VEQU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D891F80169;
	Mon, 28 Dec 2020 18:13:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 172A2F801F5; Mon, 28 Dec 2020 18:13:40 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F17F3F80169
 for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2020 18:13:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F17F3F80169
Received: from mail-oo1-f72.google.com ([209.85.161.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1ktw5L-0000I6-QC
 for alsa-devel@alsa-project.org; Mon, 28 Dec 2020 17:13:31 +0000
Received: by mail-oo1-f72.google.com with SMTP id a5so6061840oob.4
 for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2020 09:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3AREO2qVhTwtQVFWu5d92puZAYkGCodAaQymslEY8ZI=;
 b=ZLcFjGtVK3ih6daiaQbyEleA+lTW3MeHRP+gC21LztlKepdbLgYbnElE+yllIWNg5l
 JQfWo9Fvglh2DeSNWcJer/qyiasX/7/8XEFfQxuD4a+ZmAZI4RXk6ae4ETeoctLdr/ZG
 ZgNWvdqYx0IkpH57kGB1VIxnVvb0uUDhTz+v0s46ObLCxcNVXVsjB03J19vZV9+bC3N0
 O08acIrjy8amUNcSnQ72vxdu3Ciue1Z0WZ1sKjY44wWl8dL4X/rUnMalVxMlw7ku0Hca
 hqcKOKD5QGWzrE2F3TjvVCb4z6JxNwLE57DV5zjhqPi8bnHXe+gUJtLmeN/jXp4794Ug
 m/fQ==
X-Gm-Message-State: AOAM531zOmqxHu4c5QvIr8FAy/ZcBPkpwUc8tIwXuIjp9o4J5wjtdCoZ
 LWw9uZVgYf65BNvTyT9zf/CpYSWd7j7ZLdTN2ItR4JhsBjA1DxxkWDsQlLbknoENYNMht8+8etL
 I/X831ofN0XME8awFKLq18cN6B2S2LTZkbxULtty6MMb32iIniB+sNOg1
X-Received: by 2002:a9d:ea6:: with SMTP id 35mr6080592otj.188.1609175610750;
 Mon, 28 Dec 2020 09:13:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxJtyk21lN8oCPqZD3h/TV0OTLqyx6QSCXYVEQKeWNXngzpE6iT2U9TeSZxLS+1UCaeSSY2VtrdMoRXv9hJUQ=
X-Received: by 2002:a9d:ea6:: with SMTP id 35mr6080557otj.188.1609175610344;
 Mon, 28 Dec 2020 09:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20201225164727.103280-1-kai.heng.feng@canonical.com>
 <s5hft3tf1r2.wl-tiwai@suse.de>
In-Reply-To: <s5hft3tf1r2.wl-tiwai@suse.de>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 29 Dec 2020 01:13:17 +0800
Message-ID: <CAAd53p6jYWp3NdDmfAq76rcMkj26nrkFxmLjLa75CV30otWVig@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: Resume codec for system suspend if LED is
 controlled by codec
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, tiwai@suse.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
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

On Sat, Dec 26, 2020 at 3:46 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 25 Dec 2020 17:47:23 +0100,
> Kai-Heng Feng wrote:
> >
> > Laptop with codec controlled LEDs takes a very long time to suspend
> > after commit 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use
> > direct-complete optimization"):
> > [   90.065964] PM: suspend entry (s2idle)
> > [   90.067337] Filesystems sync: 0.001 seconds
> > [   90.185758] Freezing user space processes ... (elapsed 0.002 seconds) done.
> > [   90.188713] OOM killer disabled.
> > [   90.188714] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> > [   90.190024] printk: Suspending console(s) (use no_console_suspend to debug)
> > [   90.904912] intel_pch_thermal 0000:00:12.0: CPU-PCH is cool [49C], continue to suspend
> > [  321.262505] snd_hda_codec_realtek ehdaudio0D0: Unable to sync register 0x2b8000. -5
> > [  328.426919] snd_hda_codec_realtek ehdaudio0D0: Unable to sync register 0x2b8000. -5
> > [  329.490933] ACPI: EC: interrupt blocked
> >
> > That commit keeps codec suspended during the system suspend. This
> > doesn't play well with codec controlled mute and micmute LEDs, because
> > LED core will use codec registers to turn off those LEDs.
> >
> > Currently, all users of create_mute_led_cdev() use codec to control
> > LED, so unconditionally runtime resume those codecs before system
> > suspend to solve the problem.
> >
> > Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> A puzzling point is that it's applied only to the cases with the led
> cdev.  Or does it basically apply for the ASoC controller?
> That is, if you run with legacy HDA (snd-intel-dspcfg.dsp_driver=1),
> does the issue appear as well on those machines?

No, the issue doesn't happen with snd-intel-dspcfg.dsp_driver=1. It
only happens when SOF driver is in use.
My analysis was wrong, I will send a new patch to address the root cause.

Kai-Heng

>
>
> thanks,
>
> Takashi
>
> > ---
> >  include/sound/hda_codec.h   | 1 +
> >  sound/pci/hda/hda_codec.c   | 7 +++++++
> >  sound/pci/hda/hda_generic.c | 1 +
> >  3 files changed, 9 insertions(+)
> >
> > diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
> > index 2e8d51937acd..b01d76abe008 100644
> > --- a/include/sound/hda_codec.h
> > +++ b/include/sound/hda_codec.h
> > @@ -255,6 +255,7 @@ struct hda_codec {
> >       unsigned int relaxed_resume:1;  /* don't resume forcibly for jack */
> >       unsigned int forced_resume:1; /* forced resume for jack */
> >       unsigned int mst_no_extra_pcms:1; /* no backup PCMs for DP-MST */
> > +     unsigned int resume_for_sleep:1;  /* runtime resume for system sleep */
> >
> >  #ifdef CONFIG_PM
> >       unsigned long power_on_acct;
> > diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> > index 687216e74526..b890d9b4339e 100644
> > --- a/sound/pci/hda/hda_codec.c
> > +++ b/sound/pci/hda/hda_codec.c
> > @@ -2983,6 +2983,13 @@ static int hda_codec_runtime_resume(struct device *dev)
> >  #ifdef CONFIG_PM_SLEEP
> >  static int hda_codec_pm_prepare(struct device *dev)
> >  {
> > +     struct hda_codec *codec = dev_to_hda_codec(dev);
> > +
> > +     if (codec->resume_for_sleep) {
> > +             pm_runtime_resume(dev);
> > +             return 0;
> > +     }
> > +
> >       return pm_runtime_suspended(dev);
> >  }
> >
> > diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
> > index 8060cc86dfea..6d259d5bb5bb 100644
> > --- a/sound/pci/hda/hda_generic.c
> > +++ b/sound/pci/hda/hda_generic.c
> > @@ -3913,6 +3913,7 @@ static int create_mute_led_cdev(struct hda_codec *codec,
> >       cdev->brightness_set_blocking = callback;
> >       cdev->brightness = ledtrig_audio_get(micmute ? LED_AUDIO_MICMUTE : LED_AUDIO_MUTE);
> >       cdev->flags = LED_CORE_SUSPENDRESUME;
> > +     codec->resume_for_sleep = 1;
> >
> >       return devm_led_classdev_register(&codec->core.dev, cdev);
> >  }
> > --
> > 2.29.2
> >
