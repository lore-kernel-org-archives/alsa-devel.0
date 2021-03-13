Return-Path: <SRS0=P760=IL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB132C433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Mar 2021 20:27:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A9764ECD
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Mar 2021 20:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A9764ECD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CEE31750;
	Sat, 13 Mar 2021 21:26:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CEE31750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615667243;
	bh=nXwzLOYKpkiq1CLhD7qyOG97MFYVynskpPPG4YAoxy4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gx/ricxe2WoaIkyQJfGa2GGmgjktKJsWPIa40Fg4DzEJXOunfXkZ/+uxd66SROiUb
	 MJ7FnYAutlpNGZDgAYPZ1MfQUsQfzw5iu/qMEg16qByAqlXgA/TmXJEHSWSHqSE+fT
	 LzSeEScc2G9EqqJIjEq7ji7nRI3eIl9ntkUyRqj8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F084F802E7;
	Sat, 13 Mar 2021 21:26:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4BF0CF80227; Sat, 13 Mar 2021 21:26:06 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 954CEF8012A
 for <alsa-devel@alsa-project.org>; Sat, 13 Mar 2021 21:25:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 954CEF8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="K0kEop7C"
Received: by mail-lj1-x232.google.com with SMTP id u10so161159lju.7
 for <alsa-devel@alsa-project.org>; Sat, 13 Mar 2021 12:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nXwzLOYKpkiq1CLhD7qyOG97MFYVynskpPPG4YAoxy4=;
 b=K0kEop7CHc8u9qijPjvgU2L1W3jO1BD3jpACZXK2KiSoFCiGPk9zchyq5/6YfLjrG+
 ppGZUecH/5ysyVwQVIRK/QEWq3zmDSt5d1P6UDAhCNtLR7no89kZvstWKfs8NqLCOePu
 P/OJimCXQF/TPHY8AeLKs+F5aRJf8d4pJJWVARHv+P0W1r5dAcnQc8YbEv78z7GBAKZH
 DdI8swCdgYvNSkFIY4nlgEcwI/D8n5BsLJDfhK8AT+6Uun3WGhxOARrUDSO58qhuigKC
 W58suNOeVWIWk2hBC0OBl5zJqU1yHrgtfQV6sOKWjooi5UHOcAWpjEpQGVCnL7E/DVt/
 5bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nXwzLOYKpkiq1CLhD7qyOG97MFYVynskpPPG4YAoxy4=;
 b=Yhrb4jlXULAk/iyIZP+x7Zhcohz2neAYEMKnnycM4rBYXFQucgoATkSyPQFdTmfTge
 j21BXxNuIIUhlzhepu2BnUMvRsHSH9ijNFHUx00qbe7jL9sQuuoqHEzK0YcFiPnsYXl4
 TEejm/XDTzHM7dfgKqGtJWK7Mkazn3XaxBERXParxsC85ySYh5eq2iIaGZPJcLiXjd/s
 woTbkzXUgCqTaodfLvlvhCiwDSlc+zH/JsJWMgE/bZYlnkzPjzMZMaJ8ZjftbE8tEhvz
 z9pzQbXvD4XPa/U0S+nZvFT0Er6/aLlJKq7LilQmS235jy7NLsIS635mmzGS1OWFx5Bk
 k+5Q==
X-Gm-Message-State: AOAM532AFAl527hw/zopCHPq2y3zIZ285UwKc9iwBkJV4btpwjy3Mrqf
 yTnyKy4e1Qzg2n0rTWtrkX7aZaa+d0AWJqeHF8Q=
X-Google-Smtp-Source: ABdhPJw7Ss7EWBxQBvdRZ94nulcY04ujzJ00fZWur8s/HypB+wsz+o6b9J0bYTqO61ZQY6vOrDbXOXoteVmmI7NrjvE=
X-Received: by 2002:a2e:b8c3:: with SMTP id s3mr5944317ljp.264.1615667156726; 
 Sat, 13 Mar 2021 12:25:56 -0800 (PST)
MIME-Version: 1.0
References: <1615623820-16592-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1615623820-16592-1-git-send-email-wangqing@vivo.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 13 Mar 2021 17:25:44 -0300
Message-ID: <CAOMZO5BSxSo3TRAeZNhFiiF1r5PxecUGJc5p0ekF6709U3x_NQ@mail.gmail.com>
Subject: Re: [PATCH] sound: soc: fsl: Remove unnecessary THIS_MODULE
To: Wang Qing <wangqing@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Shengjiu Wang <shengjiu.wang@gmail.com>,
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

Hi Wang,

On Sat, Mar 13, 2021 at 5:25 AM Wang Qing <wangqing@vivo.com> wrote:
>
> As THIS_MODULE has been set in module_platform_driver(), so remove it.
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Thanks for the patch, but someone else has already sent the same.
