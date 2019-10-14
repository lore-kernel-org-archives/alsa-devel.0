Return-Path: <SRS0=QzCZ=YH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2301FECE587
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:35:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 190942089C
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Q9VLjopU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="D2cc9wrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190942089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D4208844;
	Mon, 14 Oct 2019 14:34:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D4208844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571056516;
	bh=kT0sifmZcnTasEsaV2FlbNuKFpHZET1B82VHF94XcvE=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q9VLjopUNZyOeaQ8fF7PqKXw7ck+XKSTmCS/wKwiWbNL3OfagSetpTD19C/ejV2o3
	 ZnmBOZSG2k6xn5L3rCZ31UfNWkCky/sc81mf+SzXABqejQYaDM4/PdG6ZTXbcDn2s5
	 gABIdmdAlfXVX/TB4Y75OnDc63y/Djm/qeoooffc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14F9CF80322;
	Mon, 14 Oct 2019 14:34:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ADA0AF80362; Mon, 14 Oct 2019 14:34:23 +0200 (CEST)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A8D1F80212
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2019 14:34:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A8D1F80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="D2cc9wrH"
Received: by mail-oi1-x244.google.com with SMTP id k20so13588339oih.3
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2019 05:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8iLjshTXGmcUkjH1jEkadZShwPFBLspbffes+yRjZgY=;
 b=D2cc9wrHifvrfvQCRkPEFLOEnC9L7yarowrEwRrhChFpDWaZmJDbx3+iNUpPrNLJES
 It0SY7S1izs74cNZTCgkSRLgkwNsBwRjqEPpGEI60islljgaW0z9GqoCP+GH5g/uLIQd
 cfgRe+CJvQPB82W5jsrZ+2lgRsYVqjNMFZd0AEnbD17NIhudcjM2jwtPnVh81YaKzuNw
 QT3kwwSQkSxrELJYN+Y+nHwatzawh14/cJA43PRC5xNJwmDMw5evatBVTXXgtiAaMwzl
 Akr5Nsz6F500RnshJGPen8WHOdx5skVBzJzHuPWV0vqXpf1/hTrd3naAbdmx+wLiHIZf
 h8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8iLjshTXGmcUkjH1jEkadZShwPFBLspbffes+yRjZgY=;
 b=rPPuCS5xfA1KpJzeUt+8wPbFYQR4GfIM9zG29lTKqwQN64hfYSSO2DOVC31tJZs8GO
 5Ksd5FAGL5ppO3LYE4adzsu9RyPSIB3g5lqrsMwJRwn1nICXachX/fa/5kJN9YjK0cfM
 P+0Nv93A6E3x050l9P71cBWee2DqHOuTiBDpUohymd0tTUwMLGX7uiMZaNGX0+mqdmKV
 FN9CDLquZ2kjlsaKR/EVU3sf/U1PCYRetuyCm9OroCrTAmTVnq6Wd1PPNeVmTuuyoO9A
 nqOflFYFAIUA8S1ZU0Jdj7ET/1x5djajbai2mLD12KXnC8ZTbvR8fbpwcoO9DMqU4SmM
 apAg==
X-Gm-Message-State: APjAAAUD+dHFzX1nbJPhSlyqeJL6qUI8EzR3+Mo2maOgns6tbhhe+HMp
 hB02mei6OP+ClnGwvxWRbWcgh7is5QWj9EK0aoJIdw==
X-Google-Smtp-Source: APXvYqynDK6URPYcg8UEy4tlUHS7DSTW0ic6uunNazq6QOzQY21CpX4H9Rxs2YzjthRV3K0epyXM8/Tnwh8fQZOe0GY=
X-Received: by 2002:a05:6808:4c3:: with SMTP id
 a3mr24505140oie.82.1571056457681; 
 Mon, 14 Oct 2019 05:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191014102022.236013-1-tzungbi@google.com>
In-Reply-To: <20191014102022.236013-1-tzungbi@google.com>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Mon, 14 Oct 2019 20:34:06 +0800
Message-ID: <CA+Px+wXt0Y95t3qzdxWaP94w+Jnr30sRUHfa97FymPvG25Y6qA@mail.gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Gwendal Grignou <gwendal@google.com>, devicetree@vger.kernel.org,
 ALSA development <alsa-devel@alsa-project.org>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>,
 Nicolas Boichat <drinkcat@google.com>, robh+dt@kernel.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Benson Leung <bleung@google.com>, Dylan Reid <dgreid@google.com>
Subject: Re: [alsa-devel] [PATCH v3 00/10] ASoC: mediatek:
 mt8183-mt6358-ts3a227-max98357: support WoV
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

On Mon, Oct 14, 2019 at 6:20 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> This series makes mt6358, cros_ec_codec, and mt8183-mt6358-ts3a227-max98357
> support WoV (wake on voice).
>
> The first 3 commits are some cleanups and refactors.  It looks like
> breaking the existing interface.  But please be noticed that, the
> cros_ec_codec has not used by any real device yet.  The refactor is
> very necessary to keep the style consistent and for easier to further
> extend and maintain.
>   platform/chrome: cros_ec: remove unused EC feature
>   ASoC: cros_ec_codec: refactor I2S RX
>   ASoC: cros_ec_codec: extract DMIC EC command from I2S RX
>
> The 4th commit extends the feature offered from EC codec.
>   platform/chrome: cros_ec: add common commands for EC codec
>
> The 5th commit changes the behavior of setting and getting DMIC gains.
>   ASoC: cros_ec_codec: read max DMIC gain from EC codec
>
> The 6th and 7th commit make cros_ec_codec support WoV.
>   ASoC: dt-bindings: cros_ec_codec: add SHM bindings
>   ASoC: cros_ec_codec: support WoV
>
> The 8th commit sets necessary registers on mt6358 to support WoV.
>   ASoC: mediatek: mt6358: support WoV
>
> The last 2 commit make machine driver mt8183-mt6358-ts3a227-max98357
> support WoV if ec-codec is in DTS.
>   ASoC: dt-bindings: mt8183: add ec-codec
>   ASoC: mediatek: mt8183: support WoV
>
> Changes from v1:
> - fix a compile error and make kbuild bot happy
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-October/156315.html
> Changes from v2:
> - rebase upon to "don't use snd_pcm_ops" series
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-October/156170.html
> - fix sparse errors
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-October/156328.html
> - use "reg" for SHM binding
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-October/156657.html
>
> Tzung-Bi Shih (10):
>   WIP: platform/chrome: cros_ec: remove unused EC feature
>   WIP: ASoC: cros_ec_codec: refactor I2S RX
>   WIP: ASoC: cros_ec_codec: extract DMIC EC command from I2S RX
>   WIP: platform/chrome: cros_ec: add common commands for EC codec
>   WIP: ASoC: cros_ec_codec: read max DMIC gain from EC codec
>   WIP: ASoC: dt-bindings: cros_ec_codec: add SHM bindings
>   WIP: ASoC: cros_ec_codec: support WoV
>   WIP: ASoC: mediatek: mt6358: support WoV
>   WIP: ASoC: dt-bindings: mt8183: add ec-codec
>   WIP: ASoC: mediatek: mt8183: support WoV

Ha..I noticed here are some "WIP" prefixes forgot to remove.  To not
generate too much flood, will fix in later versions.

>
>  .../bindings/sound/google,cros-ec-codec.txt   |   24 +-
>  .../sound/mt8183-mt6358-ts3a227-max98357.txt  |    3 +
>  drivers/platform/chrome/cros_ec_trace.c       |    5 +-
>  .../linux/platform_data/cros_ec_commands.h    |  285 ++++-
>  sound/soc/codecs/cros_ec_codec.c              | 1128 +++++++++++++----
>  sound/soc/codecs/mt6358.c                     |  105 ++
>  sound/soc/mediatek/Kconfig                    |    1 +
>  .../mt8183/mt8183-mt6358-ts3a227-max98357.c   |   70 +-
>  8 files changed, 1296 insertions(+), 325 deletions(-)
>
> --
> 2.23.0.700.g56cf767bdb-goog
>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
