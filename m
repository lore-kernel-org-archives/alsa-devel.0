Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236F9C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 31 Mar 2022 08:16:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2FFE18C3;
	Thu, 31 Mar 2022 10:15:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2FFE18C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648714606;
	bh=z8p5ZbMUPd777Gj4GRv2d1CHY2IjkrfFO/C5gpdysPA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A7xT+heo4WiP31tuLiqB4kRoZQQJe4o/7yGuY5BiPe1//XlYAaYoozA55UyYHwKFk
	 izbE/qeBqAicyspcA2rxJkQODxc0huy9iZe8sPYPhr6hxRgwKEtuWHxcTGikUOpKTp
	 LqkM1FDa+dMjMJOC3BlYOVbxuplXENfrgNtaMc/8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46675F80100;
	Thu, 31 Mar 2022 10:15:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 628ACF80227; Thu, 31 Mar 2022 10:15:55 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0EC0F80100
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2022 10:15:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0EC0F80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="J1HnsVIT"
Received: by mail-wr1-x42a.google.com with SMTP id j18so32546759wrd.6
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2022 01:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ce3XiUynrBovS1Dqjh/W2HbLqdCahz7xgN7KDMpYzcY=;
 b=J1HnsVITgr6QSTK4m6TnBMailz49y681Ypvo1Y88KWhdeniaXsBVQZa0K1Oj2eADIl
 nYByCdKr/pnmNrTP9i7v8jAhf7Bn31F6Tv7Qh7oXnM4q5zdstH6nJr2FRhFUMbrJSC1M
 Bjjsewh6zrKz7zZyhbmjhZRlLEPF9UPyD2kqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ce3XiUynrBovS1Dqjh/W2HbLqdCahz7xgN7KDMpYzcY=;
 b=E4aE47gwvAWa8AoXu1yV6Ltev5B9rROq1cj4QfvwVFutteYIRRLobj9sGcQfp0d0LD
 2QHKVRXRTC565h2+sB8Gdve0toeUCl+xBgEzA+M1xIwcD7IhrpmH1pq3BpeX7S26RLph
 SeptH+FMo6/3qvCkEj34/i14AHG6yKoq9HAIJdLLc9pEO8Asr3laNgs8EF9ki/j2fbx6
 WWFZABB6ZLsOax439PIkj/hCkXEp4CtD2hsiX10J/xC3XUzYuaLOJ2zmjHS9LjI0qgUv
 oQUbEuqgvrzWLmGYFkTDueLLzfKkbrV8TTmTY3jzQRDuiCLwNhqoURaEj0LYvpU96scA
 ybMg==
X-Gm-Message-State: AOAM533bbfk8RlyyZz3jWBDyoRMO9GCKOkJBZJ2Z3eS42Hmp4beN0/ca
 tfEss78bmcwgKzfKpnAKl4MCOqMyqdtUd8liqdegEg==
X-Google-Smtp-Source: ABdhPJxwK72eMVAlrWI9TufBptdUQt1Dm0cRvlerktWCd7Jibsvd0gmRTxIBjH+T20XY/zeapZypYCgga8qYMktqCn0=
X-Received: by 2002:a5d:64a5:0:b0:205:8e66:e9b1 with SMTP id
 m5-20020a5d64a5000000b002058e66e9b1mr3102248wrp.464.1648714550874; Thu, 31
 Mar 2022 01:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220330084519.3863856-1-judyhsiao@chromium.org>
 <YkRBo/1s6BgCRCvP@sirena.org.uk>
In-Reply-To: <YkRBo/1s6BgCRCvP@sirena.org.uk>
From: Judy Hsiao <judyhsiao@chromium.org>
Date: Thu, 31 Mar 2022 16:15:39 +0800
Message-ID: <CAJXt+b8MFjcQ1oY4oe2_ePUGPui7c4Oek3rqNgr8tvi9ywLhcw@mail.gmail.com>
Subject: Re: [v1] ASoC: qcom: Add driver support for ALC5682I-VS.
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: judyhsiao@google.com, cychiang@google.com, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org,
 swboyd@chromium.org, dianders@chromium.org, Takashi Iwai <tiwai@suse.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, yuhsuan@chromium.org
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

On Wed, Mar 30, 2022 at 7:40 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Mar 30, 2022 at 04:45:19PM +0800, Judy Hsiao wrote:
> > +     snd_soc_dai_set_fmt(codec_dai,
> > +                             SND_SOC_DAIFMT_CBS_CFS |
> > +                             SND_SOC_DAIFMT_NB_NF |
> > +                             SND_SOC_DAIFMT_I2S);
>
> Please use _CBC_CFS, and this can be set in the dai_link as data.
Done. Use _CBC_CFS.
As the original driver did not declare the dai_link structs
separately. Just leave as it is.
Thanks!
