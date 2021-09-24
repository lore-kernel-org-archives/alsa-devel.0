Return-Path: <SRS0=QEGn=OO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CDBC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Sep 2021 07:43:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E213F60E9B
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Sep 2021 07:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E213F60E9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 911613E;
	Fri, 24 Sep 2021 09:42:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 911613E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632469410;
	bh=/45I+g2XTc7vz/LFEaBTheUe9CXkFtx8Uv+mrHE23h4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kjNN/UCRgr8Jw+UPsOP+d0C+p07hSiN60ThxstHKgKtLVj3POFDLnRX3kT0nASrrw
	 A5rQWoUJM2PQFphFCIwcLf9xTlbUtTd7DMAskoCqQ1BMOmz4hPK3Xjjakie+OChk/s
	 9aCPlZk+XtTTTunj6hqPOQBQiZgzpaj5/qj870XQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13767F8025D;
	Fri, 24 Sep 2021 09:42:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DEBEF802A0; Fri, 24 Sep 2021 09:42:37 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F21C0F800BC
 for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2021 09:42:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F21C0F800BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="lI4AkeDO"
Received: by mail-wr1-x429.google.com with SMTP id i24so8577504wrc.9
 for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2021 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BBAd8fkMceztBjAtolBY+N3vN1kqGZCk7vffXjVFyyw=;
 b=lI4AkeDOM+xZJOobC3Y+DWU/frUKH2+B93ekBGI50eraV0g9q691WSkzujuEP0nHqL
 5WTxxpIdsIcax7M0QAOXdhFIHs70HhDapuBbGGOcK2ddRxo7xWA2FfAPXrVpfZYUzzHz
 nAjiN5pgphtzYdNU93GJu8+w4kjHUCg2LVAHoWHH9SuboXixA3T/+BGoUF7WGZRXDsyG
 SVytETOVISme8eQwc9As1u31cbb2fOFIjshRPhz22cJKeYzyFZQfCgfOR5fQzgcpvzPp
 UdrWOLEflGAWeKzepSyEDYIpqBlMz4pblDZOs8xCfYDgXtVfC0nvReG97sAzAo88gUNk
 Uz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BBAd8fkMceztBjAtolBY+N3vN1kqGZCk7vffXjVFyyw=;
 b=YzHVrGHmfjAq1nhcfJiN/XfcTG1OW8TG972PkECBoFLR8yL4cj+vN9D/kg4bC+4een
 0nwzLfRVCT9T0Ln88GynlTYQP2tpa4MwvL4gLzcqXlOZXhxSSBr3ZLg21lIrc1LOio5K
 rCEsMbevl2QpJ43nyJmCLpkodyCrR5SUxi/l5dFlXDDRmf/sR6W0mY7CSnmK1vEOHGri
 tYyTSg7CEjQUXKHdrK17UCzVBINakzJM0nVzof0729pznj46JFLPzGFbSDybrxrN+B7P
 2uGd6EqUvYPS6KuJwLXm3iRMaNBJGAefwPsm24sQZarvXT/DztQvNqc7T01umwm3+lzp
 zI3A==
X-Gm-Message-State: AOAM532vTvWTbqvwQXDolseOyWAO88LQ0H6ueXEULat5s+t1HxcqE52P
 ikXn0j2bysewQk5sLFJM/dMQVV4vQ2+S+lPPPFE=
X-Google-Smtp-Source: ABdhPJxaXrfNpQGZX/DyzRVCa4s8UJYwiDGtNrK6e7v5FPo6xZ5cL9n0XnRxzQwfglrPgO3Xd5a81wQRulojrAK6zSY=
X-Received: by 2002:adf:e649:: with SMTP id b9mr9775010wrn.309.1632469346307; 
 Fri, 24 Sep 2021 00:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210917143659.401102-1-daniel.baluta@oss.nxp.com>
 <20210917143659.401102-11-daniel.baluta@oss.nxp.com>
 <203bf6cd-6407-f01d-52c3-e399d06cb3f6@linux.intel.com>
 <b90eff84-b56c-7764-a5bb-f1e07db57cc3@linux.intel.com>
 <ab4ea50f-9149-3468-ce2b-7cd421095b40@linux.intel.com>
In-Reply-To: <ab4ea50f-9149-3468-ce2b-7cd421095b40@linux.intel.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 24 Sep 2021 10:42:13 +0300
Message-ID: <CAEnQRZDmubE9aLG+7YtTeRTB2euqGpRh8FWqtgV5+h3H3M8JGA@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] ASoC: SOF: Intel: hda: make sure DAI widget is
 set up before IPC
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@oss.nxp.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
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

On Thu, Sep 23, 2021 at 4:04 PM P=C3=A9ter Ujfalusi
<peter.ujfalusi@linux.intel.com> wrote:
>
>
>
> On 23/09/2021 15:58, Pierre-Louis Bossart wrote:
> >
> >>> +static struct sof_ipc_dai_config *hda_dai_update_config(struct snd_s=
oc_dapm_widget *w,
> >>> +                                                   int channel)
> >>>  {
> >>> +   struct snd_sof_widget *swidget =3D w->dobj.private;
> >>>     struct sof_ipc_dai_config *config;
> >>>     struct snd_sof_dai *sof_dai;
> >>> -   struct sof_ipc_reply reply;
> >>> -   int ret =3D 0;
> >>>
> >>> -   list_for_each_entry(sof_dai, &hda_stream->sdev->dai_list, list) {
> >>> -           if (!sof_dai->cpu_dai_name)
> >>> -                   continue;
> >>> +   if (!swidget) {
> >>> +           dev_err(swidget->scomp->dev, "error: No private data for =
widget %s\n", w->name);
> >>
> >> NULL pointer dereference, just return NULL without the print. The call=
er
> >> is printing anyways.
> >
> > yes good catch, we need a v3 with the fixes suggested by Peter in
> > https://github.com/thesofproject/linux/pull/3171/ applied.
>
> Only the second patch in the PR is applicable for upstream, but it
> should be squashed in for v3.

Thanks Peter, will squash this in and send v3.
