Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5E3CA9EC0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:36:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDDB221783
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ldfHqS6/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU1Ig+FC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDDB221783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE3CE1FDD;
	Mon, 28 Oct 2019 17:35:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE3CE1FDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572280573;
	bh=Rb/MkpvIGi/hwahkQfxBSBB5CVkueyiywU+673wAtsY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ldfHqS6/4okqGh3BfLkiONehYNm46c/WZSPO/cGHx+GOceBtz1sxhIkFG3ls0Rorl
	 A16opkn+NFgh133uD4p4aUjpXYvqmh4Iz9kOcEV0UBz9UvjXkddhCfZLWr7UzIKBZB
	 4vvGjAfCdY7vlYynJgMZ8RilpO8NpscyzZcCDj6Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C2BCF802BD;
	Mon, 28 Oct 2019 17:35:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 117E2F80361; Mon, 28 Oct 2019 17:35:20 +0100 (CET)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2DB12F80145
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 17:35:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DB12F80145
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="aU1Ig+FC"
Received: by mail-il1-x143.google.com with SMTP id h5so5473057ilh.11
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2019 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=21j/dEL0woCR7rVyFBJA5jrlm9GOTcbrkftyZXegyKo=;
 b=aU1Ig+FCiz7v2IaiVq8NhUuGtv0bCBMp3YsGpTDegyuWP+LJPtteTZlzwPwajX8jCv
 NRz4cASxes89dYC6sB0CbiJxU/1CaUWgP7M34Cky4H6G6hxoEdT4OV4YIrB4r4FgHBmg
 5mQ15GrEag5lIB+QOYnvkJWdLW053YG6Ivi4+z853DDikUjFGGKLm4OPisECfiH+my7Z
 gN2OD5tu8Hd5h8meTBFNmA2I3Ykf7ci8D8kC6KC95b/1meOlz3l8pWGmww+XIK+vVvrQ
 UybrDCU6sLgBPJ485nRSyr3ZVTP69vtt89S4QiUmL3yOSOe/2T2//dKXaeedoG5hjdPq
 nHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=21j/dEL0woCR7rVyFBJA5jrlm9GOTcbrkftyZXegyKo=;
 b=iuYQxKTYh/l+D6QpDL/16k92ky/8FrhU0BhqihhrQAwLpTk2VoykPfMosZZooWnBRg
 eVIEUW7/9QpTjCdx3gPPdO6HudVcOf4HaGuz+kd8moiZnoPjWD84FnGGIvCMcb/bhEYX
 H2eh0i7X+x0Wi59O1dkHlrpFQYuqEf1BlYoznPYROmDh7bR+48o3I1E1dkn5KUiWUQ4f
 Sep3rDoU6xiROA1AFDzyvTW+BbCJjinX7kcDJXx2MEjvimPPRqtJGkGp+1L7BOyFlsQA
 LJq94HxPY6fCPYALRPHV0zMbyNVTniMNumVChHoJqZ2lIxdNhCF1EWkwN/Pyf4KSWc0M
 OOZQ==
X-Gm-Message-State: APjAAAWJUyNpEz5vi1qDUY8qjsNgQIRxluTJq86w6JTC5n3NlmEBD8Zu
 n4TdgPKnVyyjOhGnpC/Y7uIEB6UDQcy+KwrN94Q=
X-Google-Smtp-Source: APXvYqxZHTQgUs3vZ4EyKxk1J2VBxbW1V/6qsk4AKLh6jW/960J5msDNOgE9rFT9PBlWL6y2v0qTQSUQ5QvAY+3DS7Q=
X-Received: by 2002:a92:d94a:: with SMTP id l10mr17910669ilq.227.1572280515345; 
 Mon, 28 Oct 2019 09:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191027215330.12729-1-navid.emamdoost@gmail.com>
 <fb4fa7f3-fefb-e2d0-da4d-842396a7c251@linux.intel.com>
In-Reply-To: <fb4fa7f3-fefb-e2d0-da4d-842396a7c251@linux.intel.com>
From: Navid Emamdoost <navid.emamdoost@gmail.com>
Date: Mon, 28 Oct 2019 11:35:04 -0500
Message-ID: <CAEkB2ETrEu6SxBC+OfPNe_DqNn-=4c9p=1d9Cz5XR3NbbcD2OQ@mail.gmail.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pan Xiuli <xiuli.pan@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Kangjie Lu <kjlu@umn.edu>, Liam Girdwood <lgirdwood@gmail.com>,
 Slawomir Blauciak <slawomir.blauciak@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Stephen McCamant <smccaman@umn.edu>, LKML <linux-kernel@vger.kernel.org>,
 Navid Emamdoost <emamd001@umn.edu>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: ipc: Fix memory leak in
	sof_set_get_large_ctrl_data
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

On Sun, Oct 27, 2019 at 9:15 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 10/27/19 4:53 PM, Navid Emamdoost wrote:
> > In the implementation of sof_set_get_large_ctrl_data() there is a memory
> > leak in case an error. Release partdata if sof_get_ctrl_copy_params()
> > fails.
> >
> > Fixes: 54d198d5019d ("ASoC: SOF: Propagate sof_get_ctrl_copy_params() error properly")
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>
> May I ask which tool you used to find those issues, looks like we have a
> gap here?

We are developing a research tool to find such cases. Not sure what
gap you are referring to, but we statically track the allocation and
look for an appropriate release/assignment of the pointer.


>
> > ---
> >   sound/soc/sof/ipc.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
> > index b2f359d2f7e5..086eeeab8679 100644
> > --- a/sound/soc/sof/ipc.c
> > +++ b/sound/soc/sof/ipc.c
> > @@ -572,8 +572,10 @@ static int sof_set_get_large_ctrl_data(struct snd_sof_dev *sdev,
> >       else
> >               err = sof_get_ctrl_copy_params(cdata->type, partdata, cdata,
> >                                              sparams);
> > -     if (err < 0)
> > +     if (err < 0) {
> > +             kfree(partdata);
> >               return err;
> > +     }
> >
> >       msg_bytes = sparams->msg_bytes;
> >       pl_size = sparams->pl_size;
> >



--
Navid.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
