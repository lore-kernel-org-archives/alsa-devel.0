Return-Path: <SRS0=N3b0=HJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E7EC433DB
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Feb 2021 10:40:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A58D564E49
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Feb 2021 10:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58D564E49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 209A31698;
	Sun,  7 Feb 2021 11:39:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 209A31698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612694412;
	bh=ap599Dj3UpmjlEExN+HPHzrzAs5oC97knPOjfcxhqlY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hNT3HMFNMekgKLLg+FZX5k/46rNrM+iTHLafe4aaIiGIa5mIynfaVcJM3gkI/ATbe
	 bCisjzbw0ersxeyhGUCQ0TiRQ5D+1hlmGphbUBg4cf2VAR8/2O/Q8hpGE4Ya524nNN
	 PpeBsJ6OBhBZmZYPjgxqGsbCVf7YBPQaovUlm04Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CAC0FF801EB;
	Sun,  7 Feb 2021 11:38:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7464AF8025F; Sun,  7 Feb 2021 11:38:03 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1639BF8013A
 for <alsa-devel@alsa-project.org>; Sun,  7 Feb 2021 11:37:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1639BF8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="noTNyG5d"
Received: by mail-qk1-x72c.google.com with SMTP id o193so2079854qke.11
 for <alsa-devel@alsa-project.org>; Sun, 07 Feb 2021 02:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ap599Dj3UpmjlEExN+HPHzrzAs5oC97knPOjfcxhqlY=;
 b=noTNyG5dIpQ78mlmDpVRKXocG/8cU9E2dPSLHCT5u/6AM93GxMkWseSTmtZluCtC1u
 yE5ODBsUkFhPI+cAMajSBteIYEvsPPYS2ZOtmyoTeKzwGhR7jp9fcNyFARH6i5nGTgpM
 dXIUcSDU2sqxPlveeuN7AeubyOYqy1+xDMckILo7G5EztOQHSa2bumrX7mmH8ejtOICW
 XS95baFArQRo5qKEytXkao+wg+G9gdoie0IJ0DfySUx7NitTkJDB6K8qIQmqJgQy9EoB
 obvTdTIw4DgJAEPX0FRe4xg6xXY8KwR5bXv2W6RpikxELGJHmk5gHyO3qR8Ly8FQACVJ
 ns7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ap599Dj3UpmjlEExN+HPHzrzAs5oC97knPOjfcxhqlY=;
 b=WgfpcKHaCv7NKetXNQilkXOI/hd+2W/8pwmJzXY5DnslzfOjeUHk6lcF0J2yV0tryZ
 7Q6Ro6F+VUwf0PFIMEZPIjBdGNgfD/JGejU2lrQhfQTwGYtftgaK7GUobxS+kNnhwVBH
 QZdxxTne2nFocFpNL367x3AHNHun/0lcF0i5sdpOl/GF9KnvCOuHzbGCCWp6GI+3FcNi
 ECxSFicsnUF+iqagEHJPo15jPaNqzrAUoDKfn/hO3l3B/ISisHESk3eV5EVeV/rdy9Bo
 EJtgCESfUha1fFpgYcLFNBnXrDIgxVVj+Y4ognBxDcLM2NE/4XRQT+uWgtojVsgb0L1M
 apdQ==
X-Gm-Message-State: AOAM531/xHv1/kf4uZIDB6AVRGN6v0kaNpO8gSSvPm/Mn/RQlQSzCsCV
 yaBkm0YyQTPwrLqJe4t13MnMkMJVeZli9x7y29c=
X-Google-Smtp-Source: ABdhPJwOiqCntMvtBeLH6QTT4MVjMi7lbWFN3oPd96+54QjdFnCmwrjWuqmBTwR2S2IpLCGHI53PWyxqwimbdTER1/I=
X-Received: by 2002:a37:a955:: with SMTP id s82mr12230755qke.121.1612694274969; 
 Sun, 07 Feb 2021 02:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20210206225849.51071-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20210206225849.51071-1-rikard.falkeborn@gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Sun, 7 Feb 2021 18:37:44 +0800
Message-ID: <CAA+D8AP4gfZ2FzTH2LOB7H0SRCYR0TBrAKLZPgpTUYq=bp0M9Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: constify static snd_soc_dai_ops structs
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
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

On Sun, Feb 7, 2021 at 6:58 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> The only usage of these is to assign their address to the 'ops' field in
> the snd_soc_dai_driver struct, which is a pointer to const. Make them
> const to allow the compiler to put them in read-only memory.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
