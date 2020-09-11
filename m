Return-Path: <SRS0=2sca=CU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EC4C2D0E1
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:07:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B971121D81
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KKrq1HEk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Zj9C1l8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B971121D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 035311674;
	Fri, 11 Sep 2020 09:06:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 035311674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599808058;
	bh=3p8Hswo27x/2Inq2QFLOL1hL28WETaCQFGJoU5u2/VA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KKrq1HEkzw163DXarb/CqTBSlEFj/nauoM0pa6Dd5AQJCN59fzfE0IeIRr8urZgWC
	 /3RtW4Nye5CbDA9sjAGP754YJ+dthXrCZuDbPOwrWYTAY2MBtvD/pGQMiY5XQmv2Al
	 3s9ZnAbzqtSCTf+gmEJd1Zu892ucJ7aGxUdze8Pg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DF49AF80256;
	Fri, 11 Sep 2020 09:06:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37672F80274; Fri, 11 Sep 2020 09:06:05 +0200 (CEST)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43FDAF80100
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2020 09:05:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43FDAF80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="Zj9C1l8K"
Received: by mail-il1-x141.google.com with SMTP id x2so8145884ilm.0
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2020 00:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XjqzgjQOFRpWcDyxvZxk4QJoi3x7zBwCHCwHFZiUpHE=;
 b=Zj9C1l8KtRpl+As+fC2SodYHV3leGr8IKnqUrXtbIKaxuPg+jO46cUnNc8nVxX18SW
 mbEW+8P41/MJvM/E4u41uFzqENs/81i6qVqtPc1CTfNlU3EKI4I1TUEtnco1j69bnEZB
 wLRzlq0oAuyYLrpP3Z5qmaGoU/ISEgtJhEqpeGcisx9o3OBg19btgYSqmZJKzsuqIBqd
 Is69lQN28aGTCuDIiW2Zryc/kx6uTbqlcXQ9Homq6iIxjNcfkNX3gKaIihnTzR7UstAN
 2VmsxeVA/wm3GsAiYpgtNStNHtBtN5TvK8oY9/xl1uIVCpI92OXTTqJMUgchu/8p+4nA
 i2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XjqzgjQOFRpWcDyxvZxk4QJoi3x7zBwCHCwHFZiUpHE=;
 b=n+2A6IwMWAs1UwScqP52VDehrfkMHmY+KgztOOnObhmMZYp/S1O2C0xNtqrzngdZnv
 lFMB6nK9ABQqqt0Rv0tGKQ5JEXJ3uPsN67OAGp10IOblbcTPlj64fJiiYY2pRFew2MuS
 U0iLxWesKscTN/H0ZPb33TSfUHMUf2cQpZZL8NZY91nIEVmP71+YV7CYnIgBu2+MYbyX
 7jpOQVWkLalb2HTkvVFxweELoCypunfIU1+9ItlRr6XosXcg6pr1vKrKZYl2sKTtlKz5
 OMxJYykRPioEzdYmMOI2LZpJXvUgckyb1Bs4sqRzVexV2hZ78MKTObGRcrYPkxvXOU0a
 fHZA==
X-Gm-Message-State: AOAM530sIhA1yjBaKGUWVfNqBMs4a4WA31XvS+p0RDjnuake6IbXNZC5
 OYWigPMy9ErKFLuaujPfen3X0GAxKZWlY0UUmbRN4A==
X-Google-Smtp-Source: ABdhPJxx9W+H95xTgv9e14gbLyf1rs3mr+kr5EwsJPRKWUGmYYoAK21qecVtMoUC7yBc5BRWpykI7hnP1cxl9BbtPK4=
X-Received: by 2002:a92:217:: with SMTP id 23mr715365ilc.118.1599807952488;
 Fri, 11 Sep 2020 00:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200910052347.1790735-1-cychiang@chromium.org>
 <20200910052347.1790735-4-cychiang@chromium.org>
In-Reply-To: <20200910052347.1790735-4-cychiang@chromium.org>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Fri, 11 Sep 2020 15:05:41 +0800
Message-ID: <CA+Px+wVGaSfJxNGXX9LEw10k11vG=m9_bLpONA5w4-0O7XF0mQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] ASoC: qcom: sc7180: Add machine driver for sound
 card registration
To: Cheng-Yi Chiang <cychiang@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Taniya Das <tdas@codeaurora.org>,
 ALSA development <alsa-devel@alsa-project.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, Heiko Stuebner <heiko@sntech.de>,
 Takashi Iwai <tiwai@suse.com>, Rohit kumar <rohitkr@codeaurora.org>,
 Patrick Lai <plai@codeaurora.org>, Ajit Pandey <ajitp@codeaurora.org>,
 linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
 dgreid@chromium.org, devicetree@vger.kernel.org,
 Tzung-Bi Shih <tzungbi@chromium.org>, Stephan Gerhold <stephan@gerhold.net>,
 linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Douglas Anderson <dianders@chromium.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
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

On Thu, Sep 10, 2020 at 1:24 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> +struct sc7180_snd_data {
> +       u32 pri_mi2s_clk_count;
> +       struct snd_soc_jack hs_jack;
> +       struct device_node *hs_jack_of_node;
> +       struct snd_soc_jack hdmi_jack;
> +       struct device_node *hdmi_jack_of_node;
> +};
hs_jack_of_node and hdmi_jack_of_node are not using.  Remove them.

> +static int sc7180_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +       struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +
> +       switch (cpu_dai->id) {
> +       case MI2S_PRIMARY:
> +               return sc7180_headset_init(rtd);
> +       case MI2S_SECONDARY:
> +               return 0;
> +       case HDMI:
I guess this enumeration has not merged yet?  It doesn't sound like a
specific-enough naming.

> +static int sc7180_snd_platform_probe(struct platform_device *pdev)
> +{
> +       struct snd_soc_card *card = &sc7180_card;
> +       struct sc7180_snd_data *data;
> +       struct device *dev = &pdev->dev;
> +       int ret;
> +
> +       /* Allocate the private data */
> +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       card->dev = dev;
> +
> +       ret = qcom_snd_parse_of(card);
> +       if (ret) {
> +               dev_err(dev, "Error parsing OF data\n");
> +               return ret;
> +       }
> +
> +       snd_soc_card_set_drvdata(card, data);
To be neat, move this line immediately before or after "card->dev = dev;".
