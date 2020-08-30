Return-Path: <SRS0=QqOT=CI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CF3C433E2
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Aug 2020 15:22:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E62E20738
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Aug 2020 15:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FQy3yj4u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ivbFmx19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E62E20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBAF418F8;
	Sun, 30 Aug 2020 17:21:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBAF418F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598800968;
	bh=C/WsARuFR0qtzlqOWwgT1hVfI40NgZtdYCR2pGP6L6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FQy3yj4uagJ6WAXFmg+QZaJjOyrpMs+buQhQVmwdn6eD1G3Qm049vHtd2+9saNB1P
	 d1mEUpktCikIKkgqdz4oFehfwJBC4ZbUwth2Pe2vo7nghIWDG3TaPXDAsQ050lwIj2
	 8SpU5xF3XqEhaZb1YyuozB4aMig7v1TBElmlUHak=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A73A3F8012E;
	Sun, 30 Aug 2020 13:06:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23422F8020D; Sun, 30 Aug 2020 13:06:22 +0200 (CEST)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6ACCEF8012E
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2020 13:06:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6ACCEF8012E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="ivbFmx19"
Received: by mail-wr1-f67.google.com with SMTP id z4so407425wrr.4
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2020 04:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+gapKvtqVL4A5DDW8eESdE7vLROc6PFHC2USxeOexv0=;
 b=ivbFmx19jzkrujZR22GqxHw8+yCLuysq7xSMQ8dBB2CT2t3FfoBKWj4jr8hBQdbEpA
 9KipZlMkP21Kau2w749MNR6EeVd04EEiDEeqsksTPR+XY9z4VO46rGbgny8GlzIP3JQC
 AVCDSR5Y4DodbAVPHQwPNYNJe5JJI/R5M+6H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+gapKvtqVL4A5DDW8eESdE7vLROc6PFHC2USxeOexv0=;
 b=hu+/hZzgecw5feBvBRyPEFXPs3ZumJY/svwHB1ncc5qflNIDNZ/2eQFZ/tLRIVlrM1
 A+VydMIdAwYRRdVIfYl8fNvEGp7aLPLDXGnEqrtAr6/Xwo/TCE7cicECF9fRlvahXCU6
 uliLJ9ktjDnhJ2NvFv9OLWp/sj59c+V10fk08oLjlhlvVHCZ+zl4DWsqbwovc3gwX1AW
 t6rJf9YgZhoV3N5naUC7X+kDLQQw238x0MoBNwj91Eiunbj0rK4rwOG+OLEJ9SdiRiSt
 DP7cEs7GSLWllHQ5HVz/0goR9XuI0G4KJq/hPbDan8jEDDm80mW3aGOQ6y8QRfX3HS5j
 CIuw==
X-Gm-Message-State: AOAM531l64KcCu7yeFcK1BvedmNYmWa+zzb/nQQiGLAcKqFOsZzRLbqG
 WAeydDFji7OGmTR2KT/p8Tj59RQbHKDMXcfHy0MkyQ==
X-Google-Smtp-Source: ABdhPJz6S7KlVIQ+jF4DcOJClBsVEG+nqn+q+JFI/KzLmRup7UV+T1RYuwmr8EEore1ZJB3BAb+4Rnc+4gTbFVY/PdQ=
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr6954453wrt.159.1598785508966; 
 Sun, 30 Aug 2020 04:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200828162005.1.I4f67f494c4f759b0e5c7f487e040dfdcf16e0876@changeid>
In-Reply-To: <20200828162005.1.I4f67f494c4f759b0e5c7f487e040dfdcf16e0876@changeid>
From: Cheng-yi Chiang <cychiang@chromium.org>
Date: Sun, 30 Aug 2020 19:04:42 +0800
Message-ID: <CAFv8NwL-s0c_nFWKHmBKgPVeLXwGWdgV+fUtw8MLBJw2D3ox1w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rt5682: Prefer async probe
To: Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Oder Chiou <oder_chiou@realtek.com>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
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

On Sat, Aug 29, 2020 at 7:20 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> The probe of rt5682 is pretty slow.  A quick measurement shows that it
> takes ~650 ms on at least one board.  There's no reason to block all
> other drivers waiting for this probe to finish.  Set the flag to allow
> other drivers to probe while we're probing.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> NOTE: I haven't done any analysis of the driver to see _why_ it's so
> slow, only that I have measured it to be slow.  Someone could
> certainly take the time to profile / optimize it, but in any case it
> still won't hurt to be async.


Hi Doug, thank you for the fix.

There are multiple usleep in the probe of rt5682 driver.
The major one is a 300 ms sleep after the regulator turns on.
There are other sleeps for several tens of ms.
>
>
> This is a very safe flag to turn on since:
>
> 1. It's not like our probe order was defined by anything anyway.  When
> we probe is at the whim of when our i2c controller probes and that can
> be any time.
>
> 2. If some other driver needs us then they have to handle the fact
> that we might not have probed yet anyway.


Agree.
soc-core already handled this by returning -EPROBE_DEFER when a
component is not found.
So the machine driver can probe again.
Even in the current behavior, we already see machine driver probe
again when the codec driver is not ready,
so I think adding this async flag will not affect the machine driver.

>
>
> 3. There may be other drivers probing at the same time as us anyway
> because _they_ used async probe.
>
> While I won't say that it's impossible to tickle a bug by turning on
> async probe, I would assert that in almost all cases the bug was
> already there and needed to be fixed anyway.
>
>  sound/soc/codecs/rt5682-i2c.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
> index 85aba311bdc8..6b4e0eb30c89 100644
> --- a/sound/soc/codecs/rt5682-i2c.c
> +++ b/sound/soc/codecs/rt5682-i2c.c
> @@ -294,6 +294,7 @@ static struct i2c_driver rt5682_i2c_driver = {
>                 .name = "rt5682",
>                 .of_match_table = rt5682_of_match,
>                 .acpi_match_table = rt5682_acpi_match,
> +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,


One thing I am wondering is that there has not been any usage in codec
driver for this.
I think every codec driver can use this, and take the benefit of a
possible faster boot time ?

>
>         },
>         .probe = rt5682_i2c_probe,
>         .shutdown = rt5682_i2c_shutdown,
> --
> 2.28.0.402.g5ffc5be6b7-goog
>
