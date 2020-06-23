Return-Path: <SRS0=bSXK=AE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAB3C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:22:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D07FB2072E
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kc+LGjcQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JKAbx5yQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07FB2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55B1A173C;
	Tue, 23 Jun 2020 10:21:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55B1A173C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592900540;
	bh=MeMZNjown3IlXAyy3TjMo/5W5LFSEYuG7wvrXbkDEYc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kc+LGjcQPbApsEg4nPfOIydWto3ALE+urYZd7I9xpwiVQuqIFpJknLiAz+0GVgX0+
	 AOUA8Tr/foVphs8QJK+nTzHK08IyURznz25Ni623itoy5gbBgq8lQGf6sFKbPUO5Db
	 k4roC4yfGjDumyk6dkWu5XdKrZ8qdjRUJade+PnQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E640F8023E;
	Tue, 23 Jun 2020 10:20:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C4E1F8012F; Tue, 23 Jun 2020 10:20:37 +0200 (CEST)
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5547F8012F
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 10:20:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5547F8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com
 header.b="JKAbx5yQ"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id 05N8KEpx004721
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 17:20:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 05N8KEpx004721
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1592900415;
 bh=2TgpWQTruL68H7/iYdgebre7YRp3EgzuK6hYjj7Ri1E=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=JKAbx5yQ2PFuDPV65HCXXGdLSyT/cYeUFMuvKDWOZvCcHk5emJIfKiV+v55otpg/S
 qz45yinqZdTgFnU8fhCqhMGu2f9pLXtmEMXqBD380IXHr+wDYayis8+V/DH7+OP6jn
 1YR/Yvx+HgxJx7zjL5NFWW6/oD6kPQGq7mGbc7KlWX4zRsigl8qImXpjtcYnaCZ2i6
 sDoC3Dp8oJcjMazSq7rCO8AUEY45oKkCOksVMua2Abp9kY5Cx1VUE0KVygIVXi9bvh
 MEv2JyPRKlcwhLDkQcaAPaMySlxLpT/aoLzmR/fMRSEmilLZgetISEQJt/5OCoYbVa
 ZbmLrJCWwDVbg==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id g14so747102ual.11
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 01:20:15 -0700 (PDT)
X-Gm-Message-State: AOAM532F4QgenlnaDuiHYtr+cHycMNCGFdGRCxcnmsK64AX+fT/4wq5i
 F0uP5euo5EbndE5Gz81p1EyCgHI2GU3Nq0kuJJs=
X-Google-Smtp-Source: ABdhPJy69sOd6U4zZ0b7Utt3iuVR5XBWumRclatWKTtVIvHx4q9Id+gbDjsNKoKm0ZAb2I8MM8C5vAqDDZEvI7oie8M=
X-Received: by 2002:ab0:156d:: with SMTP id p42mr14402383uae.121.1592900413813; 
 Tue, 23 Jun 2020 01:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200622120320.454535-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200622120320.454535-1-yamada.masahiro@socionext.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 23 Jun 2020 17:19:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNASqJZ2oJwxmvObcYGn2srwjENzc6nHSGHULyqWONbTWVA@mail.gmail.com>
Message-ID: <CAK7LNASqJZ2oJwxmvObcYGn2srwjENzc6nHSGHULyqWONbTWVA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ASoC: Convert UniPhier EVEA codec to
 json-schema
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: - <alsa-devel@alsa-project.org>, Katsuhiro Suzuki <katsuhiro@katsuster.net>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Mon, Jun 22, 2020 at 9:04 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Convert the UniPhier EVEA sound codec binding to DT schema format.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

'additionalProperties: false' is emitting a warning.

I will add patternProperties
to take care of sub-nodes.

I will submit v2.




-- 
Best Regards
Masahiro Yamada
