Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EE5C5519F
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 16:16:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BFF20936
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 16:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Xvq9GFC6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="llGhNUuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BFF20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB2AA17A6;
	Thu, 12 Nov 2020 17:15:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB2AA17A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605197796;
	bh=F+gcoIj4yektFMcpbgXVAAJo3evAy3thhHuS6cGiWGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xvq9GFC6uQz/ZNsOiJOJHuvt5Z9RlKObK7qeh2HQGgtEszDL36plN0z3KTC4CiYNr
	 rrNnMiY3CKZA4drznnw/FJhK5BmW6+pq1TQ5JzFVlIQEAHGw6IYDcI6OuNw23Xx9Tt
	 R7vRUdWwtUkuA0omd3NRUhBFzdI/pxRF15noenRo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DE6AF8007E;
	Thu, 12 Nov 2020 17:15:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5FF3F801D5; Thu, 12 Nov 2020 17:15:43 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50841F8007E
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 17:15:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50841F8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="llGhNUuH"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 52E4D22248
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605197734;
 bh=F+gcoIj4yektFMcpbgXVAAJo3evAy3thhHuS6cGiWGY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=llGhNUuHHJ1cZOa93pHbFGlgET5Ako9FEYpIcAzFW+F9QTfGi0WmzaCT7cifUA8yg
 X1XRdWCILClCkpSVjW6OAPBDYVHQyXOUtrecIei265zKYFLIhPtQ8iaeQeCEg6kifF
 ogwOlEMR6WmwBofpo2ZDcONw7O0+/aAt+spdtjOQ=
Received: by mail-qk1-f180.google.com with SMTP id y197so5724590qkb.7
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 08:15:34 -0800 (PST)
X-Gm-Message-State: AOAM532huS2avqOknZHKMuV7j8GxW0plZUW/fpOfN+TktO870+LAQbeu
 pNUTW0BY7Rbk+xpLgogU1JyxiYxTixdGRhKfAg==
X-Google-Smtp-Source: ABdhPJwc5ZhfLhx4nInnP6kIhq5fTs3ZM0G91SsTL6q6TAA4lRZBtLIPN8apKhz/mQugOLAjRcEybAs2pzvOty+1fTA=
X-Received: by 2002:a05:620a:148c:: with SMTP id
 w12mr455546qkj.311.1605197733415; 
 Thu, 12 Nov 2020 08:15:33 -0800 (PST)
MIME-Version: 1.0
References: <1605097613-25301-1-git-send-email-spujar@nvidia.com>
 <1605097613-25301-3-git-send-email-spujar@nvidia.com>
 <20201112160746.GA3681609@bogus>
In-Reply-To: <20201112160746.GA3681609@bogus>
From: Rob Herring <robh@kernel.org>
Date: Thu, 12 Nov 2020 10:15:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJOqXvHhazzZ9qFAOcdG5UrFrvThbX2D64Tk+c6f=Leqg@mail.gmail.com>
Message-ID: <CAL_JsqJOqXvHhazzZ9qFAOcdG5UrFrvThbX2D64Tk+c6f=Leqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: renesas,rsnd: Update audio graph references
To: Sameer Pujar <spujar@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

On Thu, Nov 12, 2020 at 10:07 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 11, 2020 at 05:56:53PM +0530, Sameer Pujar wrote:
> > Since audio graph schema is refactored now update the related
> > references here.
> >
> > Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
>
> This should be part of the first patch. Things break in between.
>
> >
> > diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> > index 51f4dca..fc2ae22 100644
> > --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> > +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> > @@ -112,12 +112,10 @@ properties:
> >          - pattern: '^clk_(a|b|c|i)$'
> >
> >    port:
> > -    description: OF-Graph subnode
> > -    $ref: "audio-graph-card.yaml#/properties/port"
> > +    $ref: /schemas/sound/audio-graph.yaml#/properties/port
> >
> >    ports:
> > -    description: multi OF-Graph subnode
> > -    $ref: "audio-graph-card.yaml#/properties/ports"
> > +    $ref: /schemas/graph.yaml#/properties/ports

Actually, with the graph.yaml dependency that doesn't work either. I
think this probably needs to be a ref to just audio-graph.yaml at the
top level and that should pick up port and ports schemas.

Rob
