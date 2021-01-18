Return-Path: <SRS0=Aiaa=GV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEF6C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 17:28:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CB322CA1
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 17:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CB322CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9AC461842;
	Mon, 18 Jan 2021 18:27:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9AC461842
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610990895;
	bh=MUNjxMEV0ic18SVDfKWNJHh/+Asw34YN0a7BcHo4aZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OtO0CZVUNby1UmRIeXTsT3b3apW3DHFN0+bAS5mSa3of/PSn4M/SjepLFCvCX5X4m
	 3CRxM4hngR5Ide7dB6ebthweRD8o86TBdyHMuFIF2EbhsH04nLWId5kwWYSlfqjWcy
	 G1zSfLe7TYPT9MSWZFeSjpCiTyUgx2hSE/6xeyHs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B2C6F80166;
	Mon, 18 Jan 2021 18:27:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5954AF80137; Mon, 18 Jan 2021 18:27:23 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5AD90F80137
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 18:27:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AD90F80137
Received: from mail-lf1-f71.google.com ([209.85.167.71])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1l1YJA-00033B-4X
 for alsa-devel@alsa-project.org; Mon, 18 Jan 2021 17:27:16 +0000
Received: by mail-lf1-f71.google.com with SMTP id 198so6874387lfj.19
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 09:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y+F3xum/Kfc0s4a7NIXADFe5DKglu0DQNppY8qILCAo=;
 b=QTA1Z1y4Z7jCXHFjzGi2AjTmAlxMfJ6eJaTFYi7Gt3KuStsuaa6AS/ty/rEsc8WWZ3
 86ObC1nPIkQ5NlJKTN/5jntXS5A3LlOy6ZniYXV0YsAOwhEQSuLf+xpu61oaVJAwOfNj
 fl3DuMLnf9DrJdhM6biQkfRxHbkI2chVwV/ZoReuP1j0Kd6bBJP8tBVFM5G7WsM7GFca
 bslnZT1MKl7FxhADSQFYVpmIca+V9vvt+QtXC84AvJeOQFWGgjQTZhQjkJVDz/7VEPnl
 n0ktEmJNJVjZ9cFYVnmaHLhXPR7r8nfHrqcVjcc20xmz70g1mYlzNu/0MjY/MjnQdj5i
 UuRg==
X-Gm-Message-State: AOAM532vfaQwZQ2Ogl27n7ri4Bu1MBsylMwWaRDU74xjHkyoHHXMWelt
 Cv47paaZxX8hDZ37Js51npKo/wcm8dNvLwZVDGZ6QrjZo6gj6WNFvU1CgO+nHU/BNbSBncOiF7W
 n8PAr7BB/5MMe5sN0Y6pn7TQ/enNkfTmHp80ZPzypkjzWuS7QJog5mrn7
X-Received: by 2002:ac2:561b:: with SMTP id v27mr68206lfd.425.1610990835602;
 Mon, 18 Jan 2021 09:27:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYmaz7Mag/kez3M93Cx3y078QCv8AQVETwR/huIC1MYo4C13IX0QrWoS1GnvkepFD5e7x9Ed3noF1EGli4q+w=
X-Received: by 2002:ac2:561b:: with SMTP id v27mr68191lfd.425.1610990835325;
 Mon, 18 Jan 2021 09:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20210118130937.164650-1-kai.heng.feng@canonical.com>
 <s5hzh16idnj.wl-tiwai@suse.de>
In-Reply-To: <s5hzh16idnj.wl-tiwai@suse.de>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 19 Jan 2021 01:27:03 +0800
Message-ID: <CAAd53p7ipG7wnRjYmhm0P0Tm893QDfN+TjzeFkTf23CL_0220w@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: Balance runtime/system PM if direct-complete
 is disabled
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Harsha Priya <harshapriya.n@intel.com>,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 "Kenneth R . Crudup" <kenny@panix.com>
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

On Mon, Jan 18, 2021 at 9:21 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 18 Jan 2021 14:09:36 +0100,
> Kai-Heng Feng wrote:
> >
> > HDA controller can't be runtime-suspended after commit 215a22ed31a1
> > ("ALSA: hda: Refactor codjc PM to use direct-complete optimization"),
> > which enables direct-complete for HDA codec.
> >
> > The HDA codec driver didn't expect direct-complete will be disabled
> > after it returns a positive value from prepare() callback. However,
> > there are some places that PM core can disable direct-complete. For
> > instance, system hibernation or when codec has subordinates like LEDs.
>
> Hmm.  This sounds rather like the approach using the direct-complete
> isn't well suited for the purpose? The increasing number of
> regression reports worries me.

Direct-complete works fine on HDA controller but so far not so on HDA codec.
I think the main reason is that the codec doesn't have the middle
layer to handle the detail, while HDA controller has PCI bus to deal
with them.

>
> > So if a device is prepared for direct-complete but PM core still calls
> > codec's suspend or freeze callback, resume the device to keep PM
> > operations balanced.
>
> I find the ping-pong of the resume/suspend there a bit odd.  It's no
> refcount management but it invokes the real resume there, which is
> involved with lots of operations.

Yes. I'll find a better approach to address this.

>
> Can we rather skip the hda_codec_suspend() call instead (while
> changing dev->power.power_state)?

Maybe we can revert the most of the commit, and just leave
hda_codec_pm_complete(), which is the most relevant part of the patch.
Let me test a bit and send a new patch. Let me know if you don't like
this approach.

A question a bit unrelated to the discussion - how does
snd_hdac_power_up_pm() work for concurrent resume?
It can work for recursive call, but what if there are concurrent
resume request, but pm_runtime_get_sync() is still running?
The second call may access the codec which hasn't completed resume.

Kai-Heng

>
>
> thanks,
>
> Takashi
>
> > Reported-by: Kenneth R. Crudup <kenny@panix.com>
> > Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  sound/pci/hda/hda_codec.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> > index 687216e74526..0afbced979df 100644
> > --- a/sound/pci/hda/hda_codec.c
> > +++ b/sound/pci/hda/hda_codec.c
> > @@ -2997,6 +2997,9 @@ static void hda_codec_pm_complete(struct device *dev)
> >
> >  static int hda_codec_pm_suspend(struct device *dev)
> >  {
> > +     if (pm_runtime_status_suspended(dev))
> > +             pm_runtime_resume(dev);
> > +
> >       dev->power.power_state = PMSG_SUSPEND;
> >       return hda_codec_suspend(dev);
> >  }
> > @@ -3009,6 +3012,9 @@ static int hda_codec_pm_resume(struct device *dev)
> >
> >  static int hda_codec_pm_freeze(struct device *dev)
> >  {
> > +     if (pm_runtime_status_suspended(dev))
> > +             pm_runtime_resume(dev);
> > +
> >       dev->power.power_state = PMSG_FREEZE;
> >       return hda_codec_suspend(dev);
> >  }
> > --
> > 2.29.2
> >
