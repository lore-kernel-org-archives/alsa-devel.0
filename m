Return-Path: <SRS0=EuHN=OH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44675C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Sep 2021 11:51:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F2CF61212
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Sep 2021 11:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F2CF61212
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 68D0E1783;
	Fri, 17 Sep 2021 13:50:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 68D0E1783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631879474;
	bh=1fFmvv9JMvTmdccnoJQD8k8UDHzF8pw1awBj+jD0CLI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ilrb3gX9NVJC8QTmY2bqVweupMqWJZ1Xx3itwCAAwuyiPD6Yl0+wG1A0jfENqwyW6
	 UJoHJaWPVYzvJ2sRhXeRho0M5UdiVWm5mRU9pqw8JEHMgP/IHJRqZg84YPeEwKPfnO
	 wAwd+U0oDZzEWgIdCJLXwMMSfKjdJL8yYa8LKmyo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB6D5F80227;
	Fri, 17 Sep 2021 13:50:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C4D6F8027C; Fri, 17 Sep 2021 13:50:22 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F330F80152
 for <alsa-devel@alsa-project.org>; Fri, 17 Sep 2021 13:50:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F330F80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="iPgDO7Es"
Received: by mail-wr1-x42d.google.com with SMTP id g16so14719091wrb.3
 for <alsa-devel@alsa-project.org>; Fri, 17 Sep 2021 04:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zh4y3yYp5KK3lr75X4zbnPk1B/CwLrGMoLkLYmrR1gI=;
 b=iPgDO7EsA/atP+gM8ulA5dhg9BKm6GfVZi/cI93K8fPebyy5nLpZzPdFci+qmdNHcQ
 GCFflkJ+U5ux5aU5h9O6nHwMS1R0H+AduKuIFUTWZx1vFg+qsVBPBS2/0UDm7XVx60le
 IJ3YDbpWUsdQ8+xcharkL9a4NittPzRej54bYEqrXeR3+S8RAUQ/SwlFVJjb2KsbqBz5
 TZ7KhCVW7TxtkZQTi6qWev24khX0SbtAK7oQapdZ+Vb95fhIXTjObRDRb9rPlIjissod
 Fl0W3YpoL0B3vRXLhIJZjblztgKJFeX6irb/cy3wxkvL4lB/s73XFgrGXKuwI3p5JIq4
 9whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zh4y3yYp5KK3lr75X4zbnPk1B/CwLrGMoLkLYmrR1gI=;
 b=fmWgBD3v6kuBNhjn1e7EPN+rfyLygIMlH2KTGROPeiG2u04rEvaBzhJ4n0zSNS50IN
 XPWdJpiS1oIgdr/VwYREI5DefLuyBEwrxBbCoi1tx/HwkomPKv3NO1yvD4gG5VbCQocY
 FGCOqYUi0KOMuwzase1UvjKZJQ1Z4wVp0VDBmh6oXqr/9B40HMRXNX2Ni58cqOnl5kcg
 TmTROg0nrRkiKY7yJwUqvXdDTLDOrSZdY53ex2kbl3yNCIxMzlDdDskpgLN4jnP5pElE
 9A72LkT267iS7DdubCXHkIF8pP53SR4h1EiEet6CT9joW4XvsjG92xUJ5gl6jBVfANK+
 kiVw==
X-Gm-Message-State: AOAM531VXuYyziZeKe/OaCJRrrjPYQFoepPkWtTejvBoXuLdVu1Ml94s
 5DujRmn6ZMBaszHUjOY8M6xxEaHtvIUkywwcIX8=
X-Google-Smtp-Source: ABdhPJwJ9sdCFor0+VHLEPoXS/4JhRf09MVVcnOGywjnb+OfsOd3e4tKC3yjTVMN7tv6F8OP7Cyo+YNiV5bAYH3zdEU=
X-Received: by 2002:adf:d193:: with SMTP id v19mr11734422wrc.377.1631879412107; 
 Fri, 17 Sep 2021 04:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210916111646.367133-1-daniel.baluta@oss.nxp.com>
In-Reply-To: <20210916111646.367133-1-daniel.baluta@oss.nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 17 Sep 2021 14:49:59 +0300
Message-ID: <CAEnQRZDr0BK=kX2D5Cnr5kvGMj8wYfNzAU6xMDn2RoNsYM9S-Q@mail.gmail.com>
Subject: Re: [PATCH 00/12] Add support for on demand pipeline setup/destroy
To: Daniel Baluta <daniel.baluta@oss.nxp.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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

Hi Mark,

Will send v2 for this. I got informed that I forgot my S-o-b tag.


On Thu, Sep 16, 2021 at 2:18 PM Daniel Baluta <daniel.baluta@oss.nxp.com> wrote:
>
> From: Daniel Baluta <daniel.baluta@nxp.com>
>
> This patchseries implements the new feature to setup/teardown pipeline
> as needed when a PCM is open/closed.
>
> Review with SOF community at https://github.com/thesofproject/linux/pull/2794
>
> Ranjani Sridharan (12):
>   ASoC: topology: change the complete op in snd_soc_tplg_ops to return
>     int
>   ASoC: SOF: control: Add access field in struct snd_sof_control
>   ASoC: SOF: topology: Add new token for dynamic pipeline
>   ASoC: SOF: sof-audio: add helpers for widgets, kcontrols and dai
>     config set up
>   AsoC: dapm: export a couple of functions
>   ASoC: SOF: Add new fields to snd_sof_route
>   ASoC: SOF: restore kcontrols for widget during set up
>   ASoC: SOF: Don't set up widgets during topology parsing
>   ASoC: SOF: Introduce widget use_count
>   ASoC: SOF: Intel: hda: make sure DAI widget is set up before IPC
>   ASoC: SOF: Add support for dynamic pipelines
>   ASoC: SOF: topology: Add kernel parameter for topology verification
>
>  include/sound/soc-dpcm.h               |   1 +
>  include/sound/soc-topology.h           |   2 +-
>  include/uapi/sound/sof/tokens.h        |   1 +
>  sound/soc/intel/skylake/skl-topology.c |   6 +-
>  sound/soc/soc-dapm.c                   |   2 +
>  sound/soc/soc-pcm.c                    |   4 +-
>  sound/soc/soc-topology.c               |  10 +-
>  sound/soc/sof/intel/hda-dai.c          | 176 +++---
>  sound/soc/sof/intel/hda.c              | 177 ++++--
>  sound/soc/sof/intel/hda.h              |   5 +
>  sound/soc/sof/ipc.c                    |  22 +
>  sound/soc/sof/pcm.c                    |  58 +-
>  sound/soc/sof/pm.c                     |   4 +-
>  sound/soc/sof/sof-audio.c              | 709 +++++++++++++++++++------
>  sound/soc/sof/sof-audio.h              |  32 +-
>  sound/soc/sof/sof-priv.h               |   1 +
>  sound/soc/sof/topology.c               | 362 +++++--------
>  17 files changed, 1034 insertions(+), 538 deletions(-)
>
> --
> 2.27.0
>
