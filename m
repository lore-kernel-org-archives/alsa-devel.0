Return-Path: <SRS0=OCx8=ZZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8EEC432C3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 17:28:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6295A2073B
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 17:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TnIBp2YJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="PubAOo3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6295A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A751984A;
	Tue,  3 Dec 2019 18:27:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A751984A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575394123;
	bh=36eFGqfp8RV2zX2HX3Dn83dqvncWjCVXF5eJJEzl/Mg=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TnIBp2YJM4SInylVtfU0WvLke1QHq+Qk02nA3bE+vUh6dvgzzlIivUudVP7ISljb5
	 3+3SHSXJmxAN8Wf0b/k5kX7rivNMNBKXiqTkaEMvw31d9KkB/Hag0DJEUiQ44lnzih
	 ZDDnoWScBYQmXd8MzMhUdIYovPluR4K1NpijCi14=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3EC39F800ED;
	Tue,  3 Dec 2019 18:27:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE337F80227; Tue,  3 Dec 2019 18:27:51 +0100 (CET)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D44E4F800ED
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2019 18:27:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D44E4F800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="PubAOo3f"
Received: by mail-qk1-x742.google.com with SMTP id c124so4266360qkg.0
 for <alsa-devel@alsa-project.org>; Tue, 03 Dec 2019 09:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ic9BT3PQ2lubnEvSUJwsX7SEe9neTzIhpVv0e1r53nk=;
 b=PubAOo3fnjJDHh5rbzzotnvnsO3a7fjxITGnJfAVOTjrI8PwKTSCX5Mn8ccqJYS4Yr
 icnGlAYW4UytP2Yk4t6GAs0uUy18Beef2u40NXsyD5vyJD0O9D0pyN1ZWdKgoIwezfe6
 vkK36ltnfmAQFeLiv6DAjt2rtVRFbbDZm6YQHBsQC6/MVBZYmerPuDQ6hECi7xMLn2bM
 rLvm3Ke/BBq+l2uweuHlb3uAS6l922d8EduHmipF8iMdwZL2GfY1uWWXCPgXpRPMxjF8
 mLNdyWBFg+8h9MTKHKggaNweW10zU7EOCd6P0Cp1N1Cj1t+5acRNs83Y1jqIBZCUXgN1
 BmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ic9BT3PQ2lubnEvSUJwsX7SEe9neTzIhpVv0e1r53nk=;
 b=ZsDZFUIGBP1HZS2byudvJ/GEM/fmNC0dtY5EkVrXWJR2LJAi2BMtj3TQsZaEhYW0Lo
 wsSU1q2rmf8tb269blrJpAXnSDjFc/bUGKRaFdrGm41XPCENJE+PutKNj6keokLhgIdW
 iOa7LkrTXounIAQQ4b+Ka9CsRZFmLmwwSg0d0ooZC9cGJSuWd+Jn3T77mUTDSHgaf3zE
 TaktRNPIgC0tvJT9+s6BY3jRpPiLz9+hkImHMCxkCJZubykshwPlg2ZNa5bIVYpUOX1c
 c/tGi37h2epY4/ZHU6ubPvVwky8vRnFKPmQ1fARz9lrT5JzKrTrOpCdVeiIpb7IpbdfY
 H8QQ==
X-Gm-Message-State: APjAAAUSy9jKoMON6IiRZqHCby0Jum0hlBPfv3kGqmATeHQakAJK2QzK
 siEBYfVcKg4TzcSpgktaUii5Z3tQjp4khUQ6sK2aXg==
X-Google-Smtp-Source: APXvYqwWdnZwpiQedBXAnkcHDzzZfGV6Qe75WYPG4VkLEvYJDKMk57ubV6Ty9q+UUGOK5mSg2aCsL8JlDJIT3o9dHoo=
X-Received: by 2002:a37:61c6:: with SMTP id v189mr6087315qkb.158.1575394066409; 
 Tue, 03 Dec 2019 09:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20191202224752.52039-1-cujomalainey@chromium.org>
 <s5h7e3dhpow.wl-tiwai@suse.de>
In-Reply-To: <s5h7e3dhpow.wl-tiwai@suse.de>
From: Curtis Malainey <cujomalainey@google.com>
Date: Tue, 3 Dec 2019 09:27:35 -0800
Message-ID: <CAOReqxg10zyMqcvK+oJFBocYKgcbFguxr+sJtk5Fg4YE9-d3tQ@mail.gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Curtis Malainey <cujomalainey@chromium.org>,
 Mark Brown <broonie@kernel.org>,
 ALSA development <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: core: Init pcm runtime work early to
	avoid warnings
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

On Mon, Dec 2, 2019 at 10:46 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 02 Dec 2019 23:47:52 +0100,
> Curtis Malainey wrote:
> >
> > There are cases where we fail before we reach soc_new_pcm which would
> > init the workqueue. When we fail we attempt to flush the queue which
> > generates warnings from the workqueue subsystem when we have not inited
> > the queue. Solution is to use a proxy function to get around this issue.
> >
> > Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> > Cc: Takashi Iwai <tiwai@suse.de>
> > ---
> >  include/sound/soc.h  |  1 +
> >  sound/soc/soc-core.c | 10 ++++++++++
> >  sound/soc/soc-pcm.c  | 11 ++++-------
> >  3 files changed, 15 insertions(+), 7 deletions(-)
>
> Forgot the change in soc-compress.c?
>
>
> thanks,
>
> Takashi
>
Thanks for spotting that, I'll send v2, I won't be able to test the
compress path as we have no platforms setup for that.
>
> >
> > diff --git a/include/sound/soc.h b/include/sound/soc.h
> > index c28a1ed5e8df9..2628967998264 100644
> > --- a/include/sound/soc.h
> > +++ b/include/sound/soc.h
> > @@ -1150,6 +1150,7 @@ struct snd_soc_pcm_runtime {
> >       unsigned int num_codecs;
> >
> >       struct delayed_work delayed_work;
> > +     void (*close_delayed_work_func)(struct snd_soc_pcm_runtime *rtd);
> >  #ifdef CONFIG_DEBUG_FS
> >       struct dentry *debugfs_dpcm_root;
> >  #endif
> > diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> > index 062653ab03a37..0e2e628302f1d 100644
> > --- a/sound/soc/soc-core.c
> > +++ b/sound/soc/soc-core.c
> > @@ -435,6 +435,15 @@ static void soc_free_pcm_runtime(struct snd_soc_pcm_runtime *rtd)
> >       device_unregister(rtd->dev);
> >  }
> >
> > +static void close_delayed_work(struct work_struct *work) {
> > +     struct snd_soc_pcm_runtime *rtd =
> > +                     container_of(work, struct snd_soc_pcm_runtime,
> > +                                  delayed_work.work);
> > +
> > +     if (rtd->close_delayed_work_func)
> > +             rtd->close_delayed_work_func(rtd);
> > +}
> > +
> >  static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
> >       struct snd_soc_card *card, struct snd_soc_dai_link *dai_link)
> >  {
> > @@ -470,6 +479,7 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
> >
> >       rtd->dev = dev;
> >       dev_set_drvdata(dev, rtd);
> > +     INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
> >
> >       /*
> >        * for rtd->codec_dais
> > diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> > index 01eb8700c3de5..b78f6ff2b1d3f 100644
> > --- a/sound/soc/soc-pcm.c
> > +++ b/sound/soc/soc-pcm.c
> > @@ -637,10 +637,8 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
> >   * This is to ensure there are no pops or clicks in between any music tracks
> >   * due to DAPM power cycling.
> >   */
> > -static void close_delayed_work(struct work_struct *work)
> > +static void close_delayed_work(struct snd_soc_pcm_runtime *rtd)
> >  {
> > -     struct snd_soc_pcm_runtime *rtd =
> > -                     container_of(work, struct snd_soc_pcm_runtime, delayed_work.work);
> >       struct snd_soc_dai *codec_dai = rtd->codec_dais[0];
> >
> >       mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
> > @@ -660,7 +658,7 @@ static void close_delayed_work(struct work_struct *work)
> >       mutex_unlock(&rtd->card->pcm_mutex);
> >  }
> >
> > -static void codec2codec_close_delayed_work(struct work_struct *work)
> > +static void codec2codec_close_delayed_work(struct snd_soc_pcm_runtime *rtd)
> >  {
> >       /*
> >        * Currently nothing to do for c2c links
> > @@ -2974,10 +2972,9 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
> >
> >       /* DAPM dai link stream work */
> >       if (rtd->dai_link->params)
> > -             INIT_DELAYED_WORK(&rtd->delayed_work,
> > -                               codec2codec_close_delayed_work);
> > +             rtd->close_delayed_work_func = codec2codec_close_delayed_work;
> >       else
> > -             INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
> > +             rtd->close_delayed_work_func = close_delayed_work;
> >
> >       pcm->nonatomic = rtd->dai_link->nonatomic;
> >       rtd->pcm = pcm;
> > --
> > 2.24.0.393.g34dc348eaf-goog
> >
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
