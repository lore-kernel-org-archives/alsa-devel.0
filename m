Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78634C35242
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:20:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044AB20725
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 07:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fddlaq5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044AB20725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49AAA1695;
	Mon, 17 Feb 2020 08:19:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49AAA1695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581924023;
	bh=xT3p/OspRfs/d46mCzSoK8fXmBh/20rxwvMSKCjYt8s=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fddlaq5WVXTDBLKXRzuCfCbyALyHW6rg5HFI37E8EMP+LMVQrp4oarLWvwJuZBC0c
	 /DM97IGUe/vEdpGqijoELgpd4h0TBldgNcyBiJ1HfcEE0xoe3dLjpindWmdld0Vs/9
	 XWtyh2FxJLBVEL5DkbMoK7miHaZMvfwVF8Kt68l8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CAF76F800C4;
	Mon, 17 Feb 2020 08:19:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59DBEF801F5; Mon, 17 Feb 2020 08:19:31 +0100 (CET)
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3FDEAF800B6
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 08:19:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FDEAF800B6
Received: by mail-ed1-f68.google.com with SMTP id p23so19476918edr.5
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2020 23:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wKr+1RTfgQ42+vPKzJm3cC+KqIteJwDJeivtrGtPfY0=;
 b=ktmwnM41VGvkoQDbRaUvrmcpprl/OzkHvP2VaCSctOdA1kFINutO9DRYeQs9sp2j54
 jUfvEup5js4k9iYYW8kvcEB6RIK5CJ4zms3u30udta63VHVAxXyYgF2XkRJdBApH/oYy
 mMmzpBzfrFQE3TTZ/Paa2zW2iY3a6STNaw0TREtmuOCXUSOFKtzocwwUHp8lZiHtpmAi
 Zs9dPcKDIuThWyHXh2OPxfi5pzjDpNjSwNu3WLMLvgioA5qmzpZJJ7LAMFBiwx3JvwhC
 iPOElqap7O3aG1UHfQ5hNE9OxEcW+4Vu3SaLA1yAmrhNd/0YKTcXovAeljUNs7YUWypV
 L6BA==
X-Gm-Message-State: APjAAAWffPJxrahE6VV8iaHNZDvPUx7knah7JQ7FcBn3/xZvrqMdHAF4
 aWjvqwe8dYTEuI5TyULEuB4kyed5Ey4=
X-Google-Smtp-Source: APXvYqzBGdfKNbtcIBpnBEsMm0RVvoHUW44XO5Ng4W/7iEoccSPCgkESwcq2rqfkhEik5RtgMXwvEw==
X-Received: by 2002:a50:fb08:: with SMTP id d8mr12659896edq.79.1581923962083; 
 Sun, 16 Feb 2020 23:19:22 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com.
 [209.85.128.53])
 by smtp.gmail.com with ESMTPSA id z10sm810120ejn.16.2020.02.16.23.19.21
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2020 23:19:21 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id p9so15992114wmc.2
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2020 23:19:21 -0800 (PST)
X-Received: by 2002:a05:600c:10d2:: with SMTP id
 l18mr20205144wmd.122.1581923961163; 
 Sun, 16 Feb 2020 23:19:21 -0800 (PST)
MIME-Version: 1.0
References: <20200217021813.53266-1-samuel@sholland.org>
 <20200217021813.53266-7-samuel@sholland.org>
In-Reply-To: <20200217021813.53266-7-samuel@sholland.org>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 17 Feb 2020 15:19:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Te_DD5zVU4_qAja0hSzcW0=bQZzwiWaVNoRQ3ms_wrg@mail.gmail.com>
Message-ID: <CAGb2v66Te_DD5zVU4_qAja0hSzcW0=bQZzwiWaVNoRQ3ms_wrg@mail.gmail.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Luca Weiss <luca@z3ntu.xyz>, Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Maxime Ripard <mripard@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH 6/8] ASoC: sun50i-codec-analog: Make line
	out routes stereo
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

On Mon, Feb 17, 2020 at 10:18 AM Samuel Holland <samuel@sholland.org> wrote:
>
> This matches the hardware more accurately, and is necessary for
> including the (stereo) line out mute switch in the DAPM graph.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
