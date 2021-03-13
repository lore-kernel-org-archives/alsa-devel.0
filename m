Return-Path: <SRS0=P760=IL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07C8C433DB
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Mar 2021 20:26:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA1564ECE
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Mar 2021 20:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA1564ECE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ACA9D84D;
	Sat, 13 Mar 2021 21:25:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ACA9D84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615667189;
	bh=272CAvfdNnBRAEObGGz44xaMW40FGoutsX7xZRwN5z0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pEv/7tiZXRQDJjG9mJ+Z6H5fF9pPYPnL7/pocaiv6ysr03oslFBqdkKhmc5lT91i7
	 d/nhtbVpSl+M1gZ+yk0qKTQVQJbxcX+anRqA4oP9+rDwH9kgZu3qJ0HxBeTxpV9ywI
	 Ywnly/g3FlB0dfTiml/SJf0pxj/f+bTnMDDNE33s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1ABBF8019B;
	Sat, 13 Mar 2021 21:25:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32D8CF80227; Sat, 13 Mar 2021 21:25:24 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 429D9F8012A
 for <alsa-devel@alsa-project.org>; Sat, 13 Mar 2021 21:25:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 429D9F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="VrdHK7Tf"
Received: by mail-lf1-x12b.google.com with SMTP id u4so50908047lfs.0
 for <alsa-devel@alsa-project.org>; Sat, 13 Mar 2021 12:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=272CAvfdNnBRAEObGGz44xaMW40FGoutsX7xZRwN5z0=;
 b=VrdHK7TfbhnIMxJD7Rl/IHggv2rVfZGT0NhZkD0zhn/OTghueRl87jaj1ucW3av5Kv
 b4i7QheIJvExWec8x6+vWF1Z4tV8TkfNDP4Xpm/ccKQ8RsNbDEIDBEyOruakmBL2uRwG
 KLLO0FNTW1B5hfoSfGWmTfRPsWi8j9ti4pNANjPAZe1d9gJvVFbUubfaZ2e73gawoAZZ
 SIxSEyqUCrL9hbGKiwMh1A1i2qWc0c14oNf20TsT2qUzQa6mRZcWqVRNxCsBz0+/cNBr
 yIFDyMoReIqe7bOokkm6U0NAr+2Oh2HP30ci7TgkAB6VeT/kU1/55+Jqn1TtiBCFU1ST
 OSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=272CAvfdNnBRAEObGGz44xaMW40FGoutsX7xZRwN5z0=;
 b=XUPx53KuFv4WX3NsSaTNad/BBVoaAmfZMS3hDkQDQLnfQjKEqXI2t7zBKrXrpEdVWt
 1wOcgxzDcAQXGdLWiT2fazeGx0lTNVVXf0fbabH8JvCFgS6Z2kne/NK5UY/szCt1YiVI
 Q+exE/NjU5kZAHyfX+wYxPTBPEHQqOsClA+E+YkJQmM2u5gaEP1tXr6yA6+BcGhEx1/E
 6rd8j4ojdveDTGa3821tE6B8GsAkFqGOhXo0SUxMkV3ro4qYNdsWLISShmJLqUq9both
 E46liMyo0uo8zted6Al7RDLQQP9FqSqRgtgVpLKVrIglhIIOdKt/Vak3Cg9pMLyJoGtm
 StWA==
X-Gm-Message-State: AOAM5310HgVP5NvGCV6ycPEOTjSUHidYefF0ap/gX5PYL7qHew2Po0EI
 rrk2cfEHtMwYKVLCVm6rm77mTIYjxZaMuDc3lqY=
X-Google-Smtp-Source: ABdhPJydPIuew2E6A7FdCmpjZE/G3zO5v9jZ2tssDsxNcx5h9YFAkiNEfr6iRPZSikHMVAzbHlScQ4kRcXNFVVP4VEY=
X-Received: by 2002:ac2:520f:: with SMTP id a15mr3202535lfl.223.1615667113664; 
 Sat, 13 Mar 2021 12:25:13 -0800 (PST)
MIME-Version: 1.0
References: <1614848881-29637-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1614848881-29637-1-git-send-email-yang.lee@linux.alibaba.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 13 Mar 2021 17:25:01 -0300
Message-ID: <CAOMZO5B1syxnqfwkpRBOC3gsUUZFWfG5=fo5KW7QxJWRyKyLXA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: imx-hdmi: fix platform_no_drv_owner.cocci
 warnings
To: Yang Li <yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Sascha Hauer <kernel@pengutronix.de>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

Hi Yang,

On Thu, Mar 4, 2021 at 6:08 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> ./sound/soc/fsl/imx-hdmi.c:226:3-8: No need to set .owner here. The core
> will do it.
>
> Remove .owner field if calls are used which set it automatically
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
