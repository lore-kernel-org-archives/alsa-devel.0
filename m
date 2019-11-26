Return-Path: <SRS0=RV9o=ZS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090F3C432C3
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 21:21:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807BC2071E
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 21:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vUfiAzQE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxxC2gpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807BC2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C6A08173B;
	Tue, 26 Nov 2019 22:20:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C6A08173B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574803272;
	bh=RD9DLjPkDZ6yceJSkxG73snP03Gx4ShAj5u2JYkerR4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vUfiAzQE6ZckEZBFIekTB7J6EIzqoEb1ctdwr1izKrdpuTCQW4UNb1Bp/9b/zytgF
	 MJwqtJDMVwRj/zXCUa3iDMgmdb6tYTtM3OMnqctxXmtgQ7xUcKrNQviit0UMqTh5ki
	 3snYa/Reb17rN5Pcpb0wUZ7jfp2Mer+MaWMWyALE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F238F80149;
	Tue, 26 Nov 2019 22:20:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A798AF80159; Tue, 26 Nov 2019 22:20:17 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 201F2F800DD;
 Tue, 26 Nov 2019 22:20:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 201F2F800DD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="HxxC2gpL"
Received: by mail-wm1-x342.google.com with SMTP id l17so4842055wmh.0;
 Tue, 26 Nov 2019 13:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jJXteYvyCfVJ3ypolcMzDVFc1abAKWBFrdndIe0BEgs=;
 b=HxxC2gpLdgLS3oiXqGeszMxhBNNnAwoBA3VsWduTRKOUExvz55m/gMrFPQg4rW0Men
 /3CQ8m01yo3bq54n2C+lIPkrjiyby2nTLy9IugZxkBtgHsmVoHZvdQNwDiv3rJzZOeJQ
 JoofuRAEwRpmt2HS3xuTL9rde3324dLOpKXAmOffjS4hnI5rPJ6gpybX4oefkYN8lcgF
 7BcRJIi9J4abfRFjU+YrqTEjaCPGEgtIp9bCn3v4HfNeJ8m1tUkEJ96gI45cPPmFCUan
 aCAbxRkJ4bxHqiyr6224yx4onThk4i4g+uBrGk3gFdax2oeYau4yNDTSASdU88a7OfhZ
 twhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jJXteYvyCfVJ3ypolcMzDVFc1abAKWBFrdndIe0BEgs=;
 b=s7GyUfLlhN1mFa9+H6vqVo7x2TY9zMprpoGhq8MgBXsSNOu553akQ7pU9lj1/ouq6D
 9AyZi+JxIRm3BZzL/obeoaC18Nme3anyCB8SSqK1bTj/WkzOYZmbqFVoUqh1Xt78kaAo
 pYKIMUxxBp+/1ZdCuIkAkK8I/Ozdw3aPm0vxQ5R1uCh0jT77clkU40r7GsttPkcuCEa0
 KDix/WWjx7b/kQ28dPIsL/k8xwW5dxd57Og5AXZhd2Nzs+jaB8KIRZnSxbGv7ONxzUqw
 Y9QvL+3NMuYfMRM2x7BG2iojoFy1NEzDVnmGaOtF4/TIveKHaiZIbuL4X2DJYxYbf5Zm
 GdMA==
X-Gm-Message-State: APjAAAVWgfnnV8Wr08g5326zUJONgSFu1BBD4Rm/6oxNifBKZWqIak38
 95gCb5HCCy832NzXFuba6gHVoYiz88D+iMaCRsM=
X-Google-Smtp-Source: APXvYqx0AreVLrOj0YrKvYurHofenjrjsUA3nIIYswBsORykoN7y+VGnBL6eV9KZlC3rgJhXFX4cil0uj4csTGv5IUA=
X-Received: by 2002:a1c:2745:: with SMTP id n66mr936208wmn.171.1574803212854; 
 Tue, 26 Nov 2019 13:20:12 -0800 (PST)
MIME-Version: 1.0
References: <CAEnQRZBsmz17JGdxT_bB_tDHsmWskdXCW47R5wf5dhEw=Jpu-g@mail.gmail.com>
 <6a508a6f957b13a2ccb71c1c91316a272fb38b3a.camel@linux.intel.com>
In-Reply-To: <6a508a6f957b13a2ccb71c1c91316a272fb38b3a.camel@linux.intel.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 26 Nov 2019 23:20:01 +0200
Message-ID: <CAEnQRZCia2s-UxoqO4mYuS=4PEY_2Cjsq9prKfmmOAwguV1DEA@mail.gmail.com>
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "Sridharan,
 Ranjani" <ranjani.sridharan@intel.com>, sof@nxp.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 sound-open-firmware@alsa-project.org
Subject: Re: [alsa-devel] Converting a non BE to BE inside soc_check_tplg_fes
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

Hi Liam,

I continued with the investigation and found really interesting
things. See below:

On Tue, Nov 26, 2019 at 5:32 PM Liam Girdwood
<liam.r.girdwood@linux.intel.com> wrote:
>
> On Mon, 2019-11-25 at 18:45 +0200, Daniel Baluta wrote:
> > Hi all,
> >
> > I am trying how a non-BE link is converted to a BE link
> > inside soc_check_tplg_fes.
> >
> > soc_check_tplg_fes
> > => for all components that have ignore_machine setup to card name
> >      => dai_link->platforms->name = component->name;
> >      => dai_link->no_pcm = 1;
> >
> > But the thing is that the link is a true non-DPCM link, than fields
> > like dpcm_playback/dpcm_capture are not set and playback/record
> > substreams are no created.
>
> These fields should be being populated by topology since they are
> runtime configuration on a non DPCM PCM device.
>
> >
> > The question is: is this supposed to be working with non-DPCM links?
>
> Yes, it "should do" and did when I last tested - there were some non
> DPCM Intel machine drivers that needed to work (grep -L no_pcm
> sound/soc/intel/boards/*.c), but I am not as up to date as other on the
> SOF driver core now. So if it's not working, it could be a regression
> (as these non DPCM boards are not used now IIRC).

Did you somehow tested it between March 27 and April 19. I think
in this window span it should have worked.

The history is like this:

commit 45f8cb57da0d7a9ead4b39d7f5def333a5b0c08b
Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date:   Tue Mar 27 14:30:40 2018 +0100

    ASoC: core: Allow topology to override machine driver FE DAI link config.


This patch introduced the overriding FE capability. This patch
contains something like this;

+                       /* convert non BE into BE */
+                       dai_link->no_pcm = 1;
+                       dai_link->dpcm_playback = 1;
+                       dai_link->dpcm_capture = 1;

then the patch got reverted by:

commit 291bfb928863d496e25c785e132a8fbfb32341a8
Author: Mark Brown <broonie@kernel.org>
Date:   Thu Apr 19 12:14:10 2018 +0100

    ASoC: topology: Revert recent changes while boot errors are investigated

and then when it got reinstantiated with:

commit a655de808cbde6c58b3298e704d786b53f59fb5d
Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date:   Mon Jul 2 16:59:54 2018 +0100

    ASoC: core: Allow topology to override machine driver FE DAI link config.

it does have some changes one of them is that
dpcm_playback/dpcm_capture are no longer
set.

+                       /* convert non BE into BE */
+                       dai_link->no_pcm = 1;

Do you remember what was the root cause that caused the crash?

I would like to re-add the following lines:

+                       dai_link->dpcm_playback = 1;
+                       dai_link->dpcm_capture = 1;

With these two lines added back the non-DPCM link works well for me.

Thanks a lot for your help.

Can someone at Intel test following machine drivers for SOF:

sound/soc/intel/boards/byt-max98090.c
sound/soc/intel/boards/byt-rt5640.c

I would expect them not to work for SOF case.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
