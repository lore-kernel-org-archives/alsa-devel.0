Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FC1C2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 22:24:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58CC821527
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 22:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="T7sc8mJA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac8+TzZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CC821527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB9981709;
	Tue, 17 Nov 2020 23:23:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB9981709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605651841;
	bh=UOMmLEsbOiB9eY9rrTRFpnkk6CXuLWUYV3TnXp7Jrhs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T7sc8mJAGpHANTlyqbGvboA/3k3oBb5HTPXqi3yZFfStPeXEri/f4PmDVZjkgWVnW
	 TyZzMPE4plJ4bgQullcVPkFQExdWCl1OPaOnWki6Hcwxgj+upyRwDKb+Zmym5cBUZA
	 xsk8UZH21x3L2CrMr4IpS37ZpR2Kcc4XCC3jtz+g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D99BF800E2;
	Tue, 17 Nov 2020 23:23:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FEE9F801F5; Tue, 17 Nov 2020 23:23:10 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5C01F800E2
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 23:23:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5C01F800E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ac8+TzZH"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1262920678
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 22:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605651779;
 bh=UOMmLEsbOiB9eY9rrTRFpnkk6CXuLWUYV3TnXp7Jrhs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ac8+TzZHS49a4w2879awQLApYHZ0wDkB6ZZ3EdRqI7zI6sACM0nZZ5Per3yITTPWK
 oCJtdNRP4umIlSO7Xga7YcRShIVfx1N0P+lXt2hJUcFLJF+GSn+oNcVuo0vcCeCKPh
 qJyYvDIDdgnzNL7HTcfFkzFZZ79Fv/3gG5DNRRGQ=
Received: by mail-ot1-f46.google.com with SMTP id n89so21062312otn.3
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 14:22:59 -0800 (PST)
X-Gm-Message-State: AOAM533UzEyiydBsAuQQxqRMx5sLWmOhBo4SH7ZXCOeYlP3Srf9EoY9X
 gPaUKNJwWSSqW2l7qYLdkBskZmuNlcGhPkevLA==
X-Google-Smtp-Source: ABdhPJzB5Uk5jzkKnHFM23+73fbPZc7IGOmZol53WV5+VgHtvWFit7SdJOzZXZVIjsZRoFVPof12fv3HA0sGz0MzDq8=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr4335401oti.107.1605651778354; 
 Tue, 17 Nov 2020 14:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20201117013349.2458416-1-robh@kernel.org>
 <20201117013349.2458416-3-robh@kernel.org>
In-Reply-To: <20201117013349.2458416-3-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 17 Nov 2020 16:22:47 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+eOfhDzPV8A_hhGpkY3zpiVAuZ=Y353Ltn61ecCV2Dqg@mail.gmail.com>
Message-ID: <CAL_Jsq+eOfhDzPV8A_hhGpkY3zpiVAuZ=Y353Ltn61ecCV2Dqg@mail.gmail.com>
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: Use OF graph schema
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Sameer Pujar <spujar@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Lubomir Rintel <lkundrak@v3.sk>
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

On Mon, Nov 16, 2020 at 7:33 PM Rob Herring <robh@kernel.org> wrote:
>
> Now that we have an OF graph schema, let's use it for the
> audio-graph-port schema.
>
> There's no need to define 'ports' nodes as specific bindings must define
> that and port numbering of the child 'port' nodes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Note that graph.yaml is part of dtschema now intead of the kernel tree.
> ---
>  .../bindings/sound/audio-graph-port.yaml         | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)

Hold off on applying this. I think graph.yaml is going to need some
more refinement.

The rest should be able to be applied without this patch.

Rob
