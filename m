Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7ACC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Nov 2021 03:13:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EF6E844;
	Tue, 23 Nov 2021 04:13:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EF6E844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637637234;
	bh=x2hw3oGQCKQYUHt6V/jeij7qOnZntnAL24E56nojTHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SdhhJppq5exGkZLrzY3y8NWNcqdGV2Tv4ABFL3AmV3ePQ52NE2FbE4u7XrYUJI5tV
	 viaw5xdtsxK1XuXUUtLTNzWVaYsXAEoxwR+WA0uTQaKLvHY5WzsxnKOnlzrdsB/UjK
	 eTB+gq0VjVqACPDPxRhNrCicghTZ1F5CsvW9CARs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A356FF80430;
	Tue, 23 Nov 2021 04:13:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF829F80087; Tue, 23 Nov 2021 04:13:01 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2D11F80087
 for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2021 04:12:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2D11F80087
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="gIujpSdt"
Received: by mail-pg1-x52b.google.com with SMTP id 200so16998363pga.1
 for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2021 19:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x2hw3oGQCKQYUHt6V/jeij7qOnZntnAL24E56nojTHg=;
 b=gIujpSdtAknKwM2DSCD5wuUpkhhrH097yVr1sWa5jsFkkwO6U/TMS7VEQfHoKjLGL6
 PtpPhqkX1Z7hbVNjcxu5DJd9GOmfEfVT6Y9r2uZvBxgEZPk7Hn1NmP/l+gM3W3dOBQ3x
 6vZ6SxFMdjJew9B39sgKA6TfPpnGdtqBqCme6ZdYPXOImU4zYFMu5EXhfTihw7hujNeo
 9yOb2ntl1hkTeiwd+VvHEFxRw5ul7ni5R36VPr5MjQDIDYi3ZHd6CNHZbM0+juKYrnj8
 BofEsJR2zzFmZGqrLL9fU3Fh8Bj/P/pFWHNsUpcISaU861PnqmjmVI5Y5+yWM0SqbgAW
 Sj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x2hw3oGQCKQYUHt6V/jeij7qOnZntnAL24E56nojTHg=;
 b=RfvDzGOFyMZ7fCNNM6Cvy2abjRlFxec6nD91fVdZ+bCsWdRHgDApFN1CP245MriaR9
 7EQ/7p/TaqaS7dj6uQ5TQZHtrXs3ICAfj0vsYC8PahAJlPZPP3ddnE51yXNYUiI4ncTm
 xWqQ0kLw6tWT0K1E4sSLU2ln/mb3jDVHr/0cwKOTRlTz99AxrrBOIcF8UM+fiVEK+kUs
 t3/vRJpDnoCblnIMnOKwSOgUMw4X8d82jNbxgi6ttWrhS/QytKmVFt+9upEBJtrgjtsQ
 Kw5Sg4fWRP4vWkKtV38nukmDsf1o9ttwHZ1QWrjg1cQke/uNNg3BiF/T17ObR2R66hoe
 nwgw==
X-Gm-Message-State: AOAM533p9ZPEVhXsqNibE8Lm4zaaF1ysuI/NAAwK9KGyT+kGj8mzAvJu
 c4DaXEKsid/aNyjEQscTeD6nNXI95tjcUcJLIhKYgA==
X-Google-Smtp-Source: ABdhPJwMXvJBc/Q+TZQf5i18d92jX/IrYo7Qd/Ip5lemBkmdtvpN1+Uh02bMi2Upj+gk5gH0ickdapbkQ+WCbMkkrCM=
X-Received: by 2002:a05:6a00:84c:b0:494:6d40:ed76 with SMTP id
 q12-20020a056a00084c00b004946d40ed76mr1974231pfk.65.1637637169565; Mon, 22
 Nov 2021 19:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20211122164644.19442-1-jiaxin.yu@mediatek.com>
 <20211122164644.19442-2-jiaxin.yu@mediatek.com>
In-Reply-To: <20211122164644.19442-2-jiaxin.yu@mediatek.com>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Tue, 23 Nov 2021 11:12:38 +0800
Message-ID: <CA+Px+wWeV=9DF7wdSyjaZKS=XCJjri1Dmpf-kfNVZOqm5fV33w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mt8192: remove unnecessary CONFIG_PM
To: Jiaxin Yu <Jiaxin.Yu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
 linux-kernel@vger.kernel.org, broonie@kernel.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
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

On Tue, Nov 23, 2021 at 12:48 AM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Tzung-Bi Shih <tzungbi@google.com>

Could you also submit another series for the cleanup?

At least for sound/soc/mediatek/:
$ rg --files-with-matches CONFIG_PM sound/soc/mediatek/
sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
sound/soc/mediatek/mt8173/mt8173-rt5650.c
sound/soc/mediatek/mt8173/mt8173-max98090.c
sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
