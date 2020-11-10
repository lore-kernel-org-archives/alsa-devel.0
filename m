Return-Path: <SRS0=3oRA=EQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5714CC388F7
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 16:01:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1CF206E3
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 16:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sHzZJbZZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8DHjwqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1CF206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 005E216C5;
	Tue, 10 Nov 2020 17:00:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 005E216C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605024103;
	bh=RG/NgTihgLdA9a2pBThkDLJ4oix0s+fuIb+CdyGAfbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sHzZJbZZfVhwh2iBFUSiu02E1KbKuc0/wmhpuxt/xj2JMifzyoGWnHO8BBe5iT8Te
	 ttNPz5DXb48KeG91S7R5ocm9PgVLJbbhWUpMR4J6P/7/2VqC/81G2OVlkDN4RNMQ8I
	 2dN/ePfS3pWXKxFkb7jxN54gYv0+4JMjhvjj0FeY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82F76F801D5;
	Tue, 10 Nov 2020 17:00:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87B28F801EB; Tue, 10 Nov 2020 17:00:50 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10239F80059
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2020 17:00:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10239F80059
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Z8DHjwqk"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D7535207E8
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2020 16:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605024044;
 bh=RG/NgTihgLdA9a2pBThkDLJ4oix0s+fuIb+CdyGAfbg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Z8DHjwqkRfn0e7RHbqbZrapNBM8Xu7Kz79xi+VsLigXyvSukw22ekZ2KO3fGN3NvE
 g6ZV53DBp4+T7/h6rXBWlMUwITLGelAGeqg9NSEH3cSK9ju6VCFWKAm32QBLniP6KK
 8HBzANg2zqU1V7onj1TGmna3QxLwZywCR+uML48k=
Received: by mail-ot1-f52.google.com with SMTP id 30so7230575otx.9
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2020 08:00:43 -0800 (PST)
X-Gm-Message-State: AOAM5313hjlYB/DYejHF71iX2kU/mRSnsBVQ8rxF7uSR4D8HcXE30RrC
 NEXAuQepW0A4cjyBUH6RYrWXeT4rSbPgI0O1JQ==
X-Google-Smtp-Source: ABdhPJzha/4fhemzFLUDyArlzFbgeQPDzeNA2v1DrUvZ4YO4PLgq/Upa3Zm81wPaXlzdUSWTJ33FQAKGy+fnze9zuNw=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr13486984oti.107.1605024043019; 
 Tue, 10 Nov 2020 08:00:43 -0800 (PST)
MIME-Version: 1.0
References: <1604390378-23993-1-git-send-email-jiaxin.yu@mediatek.com>
 <1604390378-23993-8-git-send-email-jiaxin.yu@mediatek.com>
 <20201104185651.GB3946406@bogus>
In-Reply-To: <20201104185651.GB3946406@bogus>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 10 Nov 2020 10:00:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJAhWtK6G6vLt=H+PK3=JvDuY8JgP9+mdWuFbtFxONnCg@mail.gmail.com>
Message-ID: <CAL_JsqJAhWtK6G6vLt=H+PK3=JvDuY8JgP9+mdWuFbtFxONnCg@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] dt-bindings: mediatek: mt8192: add audio afe
 document
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Tzung-Bi Shih <tzungbi@google.com>, Bicycle.Tsai@mediatek.com,
 Takashi Iwai <tiwai@suse.com>, Shane Chien <shane.chien@mediatek.com>,
 Mark Brown <broonie@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Trevor.Wu@mediatek.com, Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
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

On Wed, Nov 4, 2020 at 12:56 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 03 Nov 2020 15:59:36 +0800, Jiaxin Yu wrote:
> > This patch adds mt8192 audio afe document.
> >
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > ---
> > This patch depends on following series that has not been accepted:
> > https://patchwork.kernel.org/cover/11752231
> > (dt-bindings/clock/mt8192-clk.h is included in it.)
> > https://patchwork.kernel.org/patch/11755895
> > (dt-bindings/power/mt8192-power.h is included in it.)
> > https://lore.kernel.org/patchwork/patch/1321118
> > (dt-bindings/reset-controller/mt8192-resets.h is included in it.)
> >
> >  .../bindings/sound/mt8192-afe-pcm.yaml        | 100 ++++++++++++++++++
> >  1 file changed, 100 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> >
>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml:10:4: [warning] wrong indentation: expected 2 but found 3 (indentation)
> ./Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml:15:7: [warning] wrong indentation: expected 4 but found 6 (indentation)
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/sound/mt8192-afe-pcm.example.dts:19:18: fatal error: dt-bindings/clock/mt8192-clk.h: No such file or directory
>    19 |         #include <dt-bindings/clock/mt8192-clk.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Now linux-next is broken because this dependency is not yet merged.
That needs to land soon or this be reverted.

Rob
