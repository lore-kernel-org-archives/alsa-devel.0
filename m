Return-Path: <SRS0=bL7i=LQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713A4C48BE5
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 14:32:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE862611CA
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 14:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE862611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7DB5166E;
	Tue, 22 Jun 2021 16:31:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7DB5166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624372351;
	bh=/xzVUxZEVGoNNZdJVXFkQok0QbF06KuCy0sSKSAxA1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TZUyFozmAJ+S+FeLhxh5C0Hxf8ilLO4TFGfTut/hrrS2Ly5HLabVTFk4ib8MO8Hwo
	 EgiCHvQXPF/BuzR39PxFoieAOS85IaiXEFoa0vHzerc7HIYe4HmFStIVnHWMJiptKJ
	 hmSaTt8h8GTvPjMMUPPcFCd+vB5Aw+SKq7XjSPaE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A279F8025F;
	Tue, 22 Jun 2021 16:31:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1912AF80268; Tue, 22 Jun 2021 16:31:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6703F80161
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 16:31:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6703F80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="NPMFOS47"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E57161361
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 14:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624372288;
 bh=/xzVUxZEVGoNNZdJVXFkQok0QbF06KuCy0sSKSAxA1s=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=NPMFOS47uEg4is0L7KCXOVM8DRQs9LvxtMGJ7OzXKhCMMeEm19J7kbKGEKphl3mjS
 oNyl4Qg8YkxsAAY1/nHIBgzcTQEv5t4KB4N2pKFerws+/5X6OSQ7s18sUo28jlZm9w
 Abl/IhOcCdSFr9fuHc78GqvOs5FNcBudseUgKW/y6yoJ6XzyQaTKgJ9yPzK7P6EOHj
 960LhL5UxUIRscr5hK+7fB8orL4H8lsS148U6zzUCLQ5Yqf0BgE5kaHRw+dG2BwH4o
 YyavAypqcoqS/xT0jZQJrLy8apRKdiBh8zIy1g+Q0o3bKMGshp6k97p81YMt9yHX3Y
 jFiq5Lwa/L8rg==
Received: by mail-ej1-f52.google.com with SMTP id my49so34776342ejc.7
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 07:31:28 -0700 (PDT)
X-Gm-Message-State: AOAM533J9mONLz/+w1Njsm1PJvCw85mhYnGCcBBW3BF9Qjy0DklVF1m/
 gJvlxGmqpg3O3W9+hq71M/+N7nMrIvaj70fS5A==
X-Google-Smtp-Source: ABdhPJxqK2jUzB7zO7J83ZtbDLGq2Lbo7WlW/2TAPs6EqrhufwAz4iNAwSUK2IrDyFayv9QA+gxnEvuRlJ4qMlnQaG8=
X-Received: by 2002:a17:906:9419:: with SMTP id
 q25mr4288960ejx.341.1624372287082; 
 Tue, 22 Jun 2021 07:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <871r8u4s6q.wl-kuninori.morimoto.gx@renesas.com>
 <87zgvi3dlm.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zgvi3dlm.wl-kuninori.morimoto.gx@renesas.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 22 Jun 2021 08:31:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKXEEXYJyrbTp_mqgoJ6DGw42Zdz1YFYih0q+HDZ+q4PA@mail.gmail.com>
Message-ID: <CAL_JsqKXEEXYJyrbTp_mqgoJ6DGw42Zdz1YFYih0q+HDZ+q4PA@mail.gmail.com>
Subject: Re: [PATCH RFC 01/15] of: property: add port base loop
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
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

On Mon, Jun 21, 2021 at 7:14 PM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> We have endpoint base functions
>         - of_graph_get_next_endpoint()
>         - of_graph_get_endpoint_count()
>         - for_each_endpoint_of_node()
>
> for_each_endpoint_of_node() loop finds endpoint.
>
>         ports {
>                 port@0 {
> (1)                     endpoint {...};
>                 };
>                 port@1 {
> (2)                     endpoint {...};
>                 };
>                 ...
>         };
>
> In above case, for_each_endpoint_of_node() loop
> finds endpoint as (1) -> (2) -> ...

Wanting to iterate endpoints across ports like that is odd given the
ports represent different things. I think you will find there aren't
too many users as I tried to get rid of most of them some time ago.
(I'm sure more have slipped in)

> If we want to get port@0 -> port@1 -> ...
> instead of endpoint, we need do like below
>
>         for_each_endpoint_of_node(node, endpoint) {
>                 port = of_get_parent(endpoint);
>                 ...
>         }
>
> But port might have multi endpoints.
>
>         ports {
>                 port@0 {
> (1)                     endpoint@0 {...};
> (2)                     endpoint@1 {...};
>                 };
>                 port@1 {
> (3)                     endpoint {...};
>                 };
>                 ...
>         };
>
> In such case, people want to have "port base" loop
> instead of "endpoints base" loop.
> This patch adds such functions/macros.

As bindings should be defining what each port number represents, I
don't think iterating thru them without regard to port numbers is the
right model. Drivers should be requesting specific port numbers.

Rob
