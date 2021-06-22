Return-Path: <SRS0=bL7i=LQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1750C2B9F4
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 16:12:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF81C610C7
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 16:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF81C610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A8519F6;
	Tue, 22 Jun 2021 18:11:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A8519F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624378320;
	bh=eoXQ/HLOPJ1ZL6ifYqtHv17VK7GiLIVM06x2osYKz6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZnTft/NqWwD4ao8XeWxnRVXkdszBwDsvkXYgjuYD+x42+FUYtfAZibTP76ZZYRf8Y
	 pUnPc7VtGE8/52l1fE57+fI7m7e64SwI5SJqvl8NWBqUr6inq8MQu82J/Ufh0ooeEu
	 Q7Z6KMGv3TUMyse0CLBaig1KF0eDM+PmeMu+La4I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BBB63F8025F;
	Tue, 22 Jun 2021 18:11:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66EA6F80268; Tue, 22 Jun 2021 18:11:08 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 140F5F800E1
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 18:11:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 140F5F800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="JoWO76bS"
Received: by mail-ej1-x634.google.com with SMTP id bu12so2125922ejb.0
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 09:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vUaa49+IpptNOMLBet5loWbWxua8vz3pz9+hJM0DysA=;
 b=JoWO76bSpdLeQy5raImQZVy8kWIlBu223s0LgU66ck+jTTwwNklVp9QexxIMkCOWnd
 zvYlt55snx4xFt5fFueb8Vor4fraGnMaFhbg6eT4Xif+PZPct8BBxwAGi1Wf8XYUTV8z
 +bSYQeHCU97YONUY2McqcSAiC+lEmyuxvtPg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vUaa49+IpptNOMLBet5loWbWxua8vz3pz9+hJM0DysA=;
 b=kAPGP31QZgjjrskjoB2IC5hdhHzVKzbKP86hi04O9FG1327yMIlvOycIWGGsPK9wE3
 /o/DYuhK2TJbKWRfkummgA8pI8o/+8B2PcfPdT1etBDwlUrCbd4+VBNlVR4wZeTSIABr
 5jHHtb3Ww7QBu1qp9OSLnfV+rFtjmyBL87s2Ph2LAeH2IyFjQAeWbzUgzsgXWvsIQvUz
 yKNvJXoblE9PET2fGOimiJ/80ghDEUHHjnbEaVrhpxLp675HK2ovW3LpXs6VR1I1yu7R
 Zb9sdC+fBQw6am4UaCeCqZFAdGIxldpuyz3PS3eAOqa3l1OdlboU6AIYQ8dn6ZJabhfJ
 Oddw==
X-Gm-Message-State: AOAM530GsBzXBVcfU9ui/+sTfXKRJBo8nWwwcxKrNsK7HoWbYhVMV6QQ
 /8pSqhf9FhVExk3jkYpcJ+7tiw4wX7GyQ00xKoeO9w==
X-Google-Smtp-Source: ABdhPJyRoaQ6qHQfdem8pZzXTW1Ky+LtLjfwVmIzRD47hgaShM+PfsaM9EDnomrcW5hRGbdsO5lon4HAy7wpYxgvQV4=
X-Received: by 2002:a17:906:8041:: with SMTP id
 x1mr4713697ejw.81.1624378263922; 
 Tue, 22 Jun 2021 09:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210621074152.306362-1-judyhsiao@chromium.org>
 <20210621114546.GD4094@sirena.org.uk>
In-Reply-To: <20210621114546.GD4094@sirena.org.uk>
From: Judy Hsiao <judyhsiao@chromium.org>
Date: Wed, 23 Jun 2021 00:10:53 +0800
Message-ID: <CAJXt+b-eRLKORqPOX1cJM3xzEyJhdeuj+w9-btpZSmy7v4U6Sw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: snd-soc-dummy: add Device Tree support
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: devicetree@vger.kernel.org, Judy Hsiao <judyhsiao@google.com>,
 Tzung-Bi Shih <tzungbi@chromium.org>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org,
 Stephen Boyd <swboyd@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Dylan Reid <dgreid@chromium.org>, linux-arm-kernel@lists.infradead.org
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

On Mon, Jun 21, 2021 at 7:46 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jun 21, 2021 at 03:41:52PM +0800, Judy Hsiao wrote:
>
> > Support for loading the snd-soc-dummy via DeviceTree.
> > This is useful to create dummy codec devices where we need to have some
> > DAI links without a real Codec.
>
> Why would it be useful to create DAI links to a dummy device that has
> no properties?  If you've got a device with no software control it's
> still going to have some limits on things like what formats and sample
> rates it can accept so you should describe that in DT.

Thanks for your review comment.
This patch is used to support multi-channel where we want one codec to
control the only GPIO shared by 4 amps.
(Please refer to
:https://patchwork.kernel.org/project/alsa-devel/patch/20210526154704.11495=
7-1-judyhsiao@chromium.org/)

In snd_soc_runtime_calc_hw(), by creating dummy codecs that share a
DAI link with a real codec:
  1. The min/ max channel of  CPU DAI will be directly adopted.
  2. The formats and sample rates of the DAI link will be determined
by the real codec unless the real codec supports the rate
      and format that do not intersect with the rate and format of
snd-soc-dummy.
That is the reason why we don=E2=80=99t specify the format and sample rates=
 of
the dummy codec with the real codec determining the properties .

Does reposting a new patch with  a more clear commit message to
describe the use case sound good to you?
>
> Please try to keep the CC lists for patches you are submitting relevant
> to the patch, people get a lot of mail and reviews for irrelevant
> patches add to the noise.
Sorry about that. I have adjusted the CC lists.
