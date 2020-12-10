Return-Path: <SRS0=UiOR=FO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F61AC4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 17:02:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E58207A2
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 17:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E58207A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D856F1663;
	Thu, 10 Dec 2020 18:01:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D856F1663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607619736;
	bh=ZDKSOKcEOMAZNX622JZAcO0P3LwLGD/SvftkjPrjPYo=;
	h=References:In-Reply-To:From:Date:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RB90u/yfq0/zxtQ3b4B3eVXEB+GyuSY5zSoegGo4jEOdwaT1rjhLdIthDpF3kcKSR
	 emsXdYFr8c8QXq0rnLtpiNWiYszNBiZsOFjd3VHXvvofFSVwatnILWDpTNBM/P3S2/
	 +12yz9GVrQ6nd3tHu6c9GH/oA2/1pRLvER4Tv9Pk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26003F80164;
	Thu, 10 Dec 2020 18:01:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D241AF8016E; Thu, 10 Dec 2020 18:01:23 +0100 (CET)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57161F800EF
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 18:01:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57161F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="td1A1r7g"
Received: by mail-oi1-x244.google.com with SMTP id d189so6442104oig.11
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 09:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
 bh=U0QCNM5KhsFPlcnPsOFo/BoOZiFJluT00PipTNkVB0Y=;
 b=td1A1r7g1wq1i9r6xaID8Yi6bJNgXJbquHv8nB4OfmOy3HXX3w9UPiCDKtQ+UrLTrs
 avsd39ECJheH9OQAgScvpcItddmYCeaj0Nc5Ft4VLxFCl8ZlNNHhSgvhNEGFnaorY5W4
 xdc2fruQfQMPsq51qbmFD1+Lqq0xTO1w5ZM9Fsh+f4s1rxJ+xNQH0gNDd8Vsm4hOfMSL
 qFQ5+emolKF5RbQXCdAB7V/AIwPubikcAuaKS5BPMYvqopIoGyx9/vvSHmxs865dNl1v
 EOARcUaSAR9PNw5AuoxS9UE7P/GMw5GBO53S7+WnRMn2qhqo5Yj8GwXcCDVpPY9TV3Kw
 A3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:cc;
 bh=U0QCNM5KhsFPlcnPsOFo/BoOZiFJluT00PipTNkVB0Y=;
 b=XTqzvGMp2homh0Jco3xYaCUkJFyYMujHYYWP/S1Dk1/wTLhT4rAu5bcETaH1iOBdIk
 rMXXx3Gp0khrwc6r5HlGCt4FnTM8jw7iRhO2hlJuRGjVSi5vc2ULWuv6PhNbJ9hvjcP3
 sLTZrdSjVPD5zQC+SG8teizlR+3iWzqbH8WCUy/iJa3CrMkXN1xyk1JNpo7vclaWLxJB
 pdv1sUIbChHyWLF2LielMSLx3i0Z6xz00JV8mIE9hk55c5QtVHjdiRsnHUT8Qm2z4xT9
 m+kEVxdZhd/ioh6ZJZAuSRjOtnrbwlPW5nsLucioTmr1CftV9EN5aqbCHpfU2Z5vgDF7
 Rlkw==
X-Gm-Message-State: AOAM530us6ng2KESQx1sgBNTMk1cdffE8zPyBGzIFwV0vZyPnXCFQmu/
 ePywsWZIba8ZsA6rgIhqlD1NinJAe6ki/Sb1pv4=
X-Received: by 2002:aca:44d:: with SMTP id 74mt6873789oie.4.1607619675083;
 Thu, 10 Dec 2020 09:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20201207084616.411531-1-conmanx360@gmail.com>
 <20201207084616.411531-3-conmanx360@gmail.com>
In-Reply-To: <20201207084616.411531-3-conmanx360@gmail.com>
From: Connor McAdams <conmanx360@gmail.com>
Date: Thu, 10 Dec 2020 12:01:04 -0500
Message-ID: <CAM8Agx1wF4W=wQuod5-awNzOppe-4h2xD-h4EDZFoaD0pxd0bw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ALSA: hda/ca0132 - Unmute surround when speaker
 output is selected.
Content-Type: text/plain; charset="UTF-8"
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>
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

Apologies, this patch seems to be a mistake.

I don't know why I thought this was the case.

On Mon, Dec 7, 2020 at 3:46 AM Connor McAdams <conmanx360@gmail.com> wrote:
>
> Make sure GPIO pin for surround channel mute is set to 0 when speaker
> output is selected.
>
> Signed-off-by: Connor McAdams <conmanx360@gmail.com>
> ---
>  sound/pci/hda/patch_ca0132.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> index 793dc5d501a5..6d647d461eab 100644
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> @@ -1390,7 +1390,7 @@ static const struct ca0132_alt_out_set_quirk_data quirk_out_set_data[] = {
>                   .has_hda_gpio     = false,
>                   .mmio_gpio_count  = 3,
>                   .mmio_gpio_pin    = { 2, 3, 5 },
> -                 .mmio_gpio_set    = { 1, 1, 0 },
> +                 .mmio_gpio_set    = { 1, 0, 0 },
>                   .scp_cmds_count   = 0,
>                   .has_chipio_write = false,
>                 },
> --
> 2.25.1
>
