Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56EDC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Feb 2022 14:45:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC36A1710;
	Mon, 28 Feb 2022 15:45:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC36A1710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646059556;
	bh=yEmpfiH9vDSQ5pM1PCmBr7B/0v0ne/vfCHN4/sRNG1U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gVERtauZRkFrUDbXHEF1cr4P4i4WEf+ice/4szpSqg2evIQR9WBlycbcFJOtT8N3R
	 XiHUARClLJuj3G4qpkAsQe5y8p+9CR20HUgIwqeu5WULuRK/3P/N9HNn3eS5/byhSb
	 IKKdY9DbDkI4mE9sOR13lY8SH7n2QvIVNqCSwIOE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79C38F80128;
	Mon, 28 Feb 2022 15:45:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BCF8BF8013C; Mon, 28 Feb 2022 15:45:04 +0100 (CET)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FA49F80125
 for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2022 15:44:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FA49F80125
Received: by mail-vs1-f53.google.com with SMTP id w4so13222094vsq.1
 for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2022 06:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LZf1H7GYaeLjTRdSqHGS1EgfqY4ooJ9YGpVnJ607bP4=;
 b=QpXWftEWBAGbFq2BiTVH5nv5gxaVpr9Ydqca82s+V1HOBivgBcQnhIraBFUDIQ4ksY
 F52RvjaekXZJamAl4qQI/BrMZB1WfB4hO8rVm24+o87CbpmBVDfUR9/bwl5vMLUwCGw+
 Q+pgS7H0JTtyLjX8gIOrEiLmGsf4K/7kOcd1twx8W7XVFhra2SQHxLMQ/JpPVYlMGagu
 vzbv/LENyx1po9KtDnrnGvEETtMOgoZFe13A7fUUS4S5WPlSszsld7WC3EEsXFjc5Kdy
 DG91GmBWZ6yRycyRBu2UCfj+9oVr8zyukTp8rIrg3hfFfM5ClvQShy+yv8+WriKrOMty
 ZKPw==
X-Gm-Message-State: AOAM5321Zvvw700QTLNwe7iIOlajxAZmYOu8RBNkE0XRzpYic1n+Ap6Z
 AiR1S19ck9xkxW0gRaB26KMxBkwLUZ9SPQ==
X-Google-Smtp-Source: ABdhPJzMTpnimoGhcFDIa82srD+o+5qDpdtAfKEPtLAzPCGVnCzQ4b2lIw9lg8nEB9TqoxxbtgobtQ==
X-Received: by 2002:a67:c396:0:b0:31b:73ab:ede1 with SMTP id
 s22-20020a67c396000000b0031b73abede1mr8545529vsj.46.1646059496788; 
 Mon, 28 Feb 2022 06:44:56 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com.
 [209.85.217.51]) by smtp.gmail.com with ESMTPSA id
 i2-20020a67e2c2000000b0031e9a4b556csm445025vsm.18.2022.02.28.06.44.56
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Feb 2022 06:44:56 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id d26so13254856vsh.0
 for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2022 06:44:56 -0800 (PST)
X-Received: by 2002:a67:af08:0:b0:31b:9451:bc39 with SMTP id
 v8-20020a67af08000000b0031b9451bc39mr7654839vsl.68.1646059496160; Mon, 28 Feb
 2022 06:44:56 -0800 (PST)
MIME-Version: 1.0
References: <20220227225633.28829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227225633.28829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Feb 2022 15:44:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXKtaCzPN-z6S01nLgYoTZKpXC6422ZsZd6=7++Tez_8A@mail.gmail.com>
Message-ID: <CAMuHMdXKtaCzPN-z6S01nLgYoTZKpXC6422ZsZd6=7++Tez_8A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: renesas,rz-ssi: Document RZ/V2L SoC
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Prabhakar <prabhakar.csengg@gmail.com>, Mark Brown <broonie@kernel.org>,
 Biju Das <biju.das.jz@bp.renesas.com>
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

On Sun, Feb 27, 2022 at 11:56 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document RZ/V2L SSI bindings. RZ/V2L SSI is identical to one found
> on the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rz-ssi" will be used as a fallback.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
