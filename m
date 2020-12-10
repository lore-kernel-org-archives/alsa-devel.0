Return-Path: <SRS0=UiOR=FO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8D7C4361B
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 17:17:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48C6230FA
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 17:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48C6230FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C25B1666;
	Thu, 10 Dec 2020 18:16:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C25B1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607620633;
	bh=cWZRs79YJFgvWyr+RAeDNgu4T+hVr/HaghYJvJLW5E0=;
	h=References:In-Reply-To:From:Date:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SKBHTBtiXVSzAy/Rz8nt+EC1XGkRaNY8OvGeJ3PlHzU2NIM1hgyfDc1gg/6VxAyZA
	 oMXXt/XTm++4Bp3TWknRC7QC4IM4wO2X0Miq8fTeR5lEAphLPn1thEWL17F3zqJ8cl
	 fQ8xOHONeynbRpM4LBxMf5BnNJsd1iINPtygPVmc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70001F80164;
	Thu, 10 Dec 2020 18:16:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30F31F8016E; Thu, 10 Dec 2020 18:16:21 +0100 (CET)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6EE6F800E1
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 18:16:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6EE6F800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="mFuC2IVi"
Received: by mail-oi1-x244.google.com with SMTP id d27so6542530oic.0
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 09:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
 bh=1DhGc1yNSVnvbflwjjTm6H7Ift8ftskK41SQF5YbY8M=;
 b=mFuC2IViDM2sP6c1KSdjWfBMV/YHz8XR4kcAnOxpcRJ5lul3INm6pwWUmq/i04lIEm
 FhGagnQNBno/U6t9cbBSCE4n9x+Mzyz5irGL0ULbD7vF/ZsJVbiKWxN6KfnJ54yLvpA5
 vyJeopdI7LG4GS+ooRMqGh2/cMDRgVHD1hP3pCSGg1ftKbMhntcOMIhc3jWnmxuZEghh
 SvCbkuLR5Y5ssLNjWETwQpUrAVbTN6cAFLXQ9xdJ9zpk+afv6Xgv6hS5OkTlAf4/MlM1
 56UQ/0HGrlyL9vY9qtweiObH82RsHDndfGFWVdQWP3hl2AUXcmx5vW8kcs9gEQ4d2Jnn
 iqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:cc;
 bh=1DhGc1yNSVnvbflwjjTm6H7Ift8ftskK41SQF5YbY8M=;
 b=U0DSAoHofY5DY1bJ4xBYvEWwSv4cnGexn753ZNDJB00SPMn2OdZt9/4eHcMfjfb/6R
 0pqsQ590jQjr557POHbHm/Is4QN1c+4NbURZ1i3NHH1UNvY8S0RJCmbue4x7YzHXhHga
 IaAHgWlZiAkv/g9c12HtYLzsNfWDpJlE5N8cRomWra2WX9SIwq1zC0toRUjbMIdH6v4Q
 rmHVVLcTRtyfkQZTLLVEF6YySfiD5HUziOoe290LeSQNgcW0uAUk9o0A+GsL5NR1uxC5
 tuivRcPks1fZwhCkzETiOWAVw1HDT4HVe1xoxNsIe4RSE2BRKsBL803xAxCaaCwbiNos
 dgIQ==
X-Gm-Message-State: AOAM530K2FVOgtLqKjBr2vRewoEGNIJkkvhBRrPNRTd1bnhG11IPi5yz
 pQ7F3fU2DMbjD8PsjZDHJSaDNQMK40SIA3RjGbw=
X-Received: by 2002:aca:dfc2:: with SMTP id w185mt7112249oig.50.1607620571499; 
 Thu, 10 Dec 2020 09:16:11 -0800 (PST)
MIME-Version: 1.0
References: <20201208195223.424753-1-conmanx360@gmail.com>
 <20201208195223.424753-3-conmanx360@gmail.com>
In-Reply-To: <20201208195223.424753-3-conmanx360@gmail.com>
From: Connor McAdams <conmanx360@gmail.com>
Date: Thu, 10 Dec 2020 12:16:00 -0500
Message-ID: <CAM8Agx3ttO_RDgjQAxLYpVMVRhz+xgmg80f4iefXZNVrGcd0-g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ALSA: hda/ca0132 - Unmute surround when speaker
 output is selected.
Content-Type: text/plain; charset="UTF-8"
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>,
 stable@kernel.org
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

Woops, sent previous email on the first version of this patch.

This patch is a mistake. Not sure why I did this.

On Tue, Dec 8, 2020 at 2:52 PM Connor McAdams <conmanx360@gmail.com> wrote:
>
> Make sure GPIO pin for surround channel mute is set to 0 when speaker
> output is selected.
>
> Fixes: def3f0a5c7007 ("ALSA: hda/ca0132 - Add quirk output selection structures.")
> Cc: <stable@kernel.org>
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
