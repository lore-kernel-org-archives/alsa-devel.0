Return-Path: <SRS0=NmsS=EY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1734DC5519F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 06:39:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE60624655
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 06:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="A51J8Jhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE60624655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BEC11674;
	Wed, 18 Nov 2020 07:38:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BEC11674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605681583;
	bh=lBuS2tDIdGTb/fQxn6fB/oCb7deDJq2ZwxTMYlGmMLM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A51J8JhfALJEgba1GOpQa05iR04EnkzVNwhOEtEGmOKXV0vZbBtsTwX2+DzNnWwOI
	 pfgtNwGux7tVs+brGNFL47Q+8Lwjr/Qdw1wsVp9QMIg3zFbmNKzkCqXG2D2/ejy2+j
	 bJIyGLIO9sQfI98CK1ISu8SKISmG50nq8LWF3WQ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 091FFF80168;
	Wed, 18 Nov 2020 07:38:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7DB10F8016C; Wed, 18 Nov 2020 07:38:51 +0100 (CET)
Received: from shell.v3.sk (mail.v3.sk [167.172.186.51])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6B9CF800EE
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 07:38:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6B9CF800EE
Received: from localhost (localhost.localdomain [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 38C32DF8A5;
 Wed, 18 Nov 2020 06:35:58 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id NqEWOd0Kgx6T; Wed, 18 Nov 2020 06:35:57 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 079A0E0190;
 Wed, 18 Nov 2020 06:35:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 2RffOTGIp8l2; Wed, 18 Nov 2020 06:35:56 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
 by zimbra.v3.sk (Postfix) with ESMTPSA id B17DDDF8A5;
 Wed, 18 Nov 2020 06:35:56 +0000 (UTC)
Date: Wed, 18 Nov 2020 07:38:36 +0100
From: Lubomir Rintel <lkundrak@v3.sk>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: dt-bindings: marvell,mmp-sspa: Use
 audio-graph-port schema
Message-ID: <20201118063836.GA5540@demiurge.local>
References: <20201117013349.2458416-1-robh@kernel.org>
 <20201117013349.2458416-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117013349.2458416-4-robh@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Sameer Pujar <spujar@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>,
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

On Mon, Nov 16, 2020 at 07:33:48PM -0600, Rob Herring wrote:
> Now that we have a graph schema, reference it from the marvell,mmp-sspa
> schema.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Lubomir Rintel <lkundrak@v3.sk>

Thank you
Lubo

> ---
>  .../bindings/sound/marvell,mmp-sspa.yaml      | 25 +++----------------
>  1 file changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/marvell,mmp-sspa.yaml b/Documentation/devicetree/bindings/sound/marvell,mmp-sspa.yaml
> index 6d20a24a2ae9..234f64a32184 100644
> --- a/Documentation/devicetree/bindings/sound/marvell,mmp-sspa.yaml
> +++ b/Documentation/devicetree/bindings/sound/marvell,mmp-sspa.yaml
> @@ -9,6 +9,9 @@ title: Marvel SSPA Digital Audio Interface Bindings
>  maintainers:
>    - Lubomir Rintel <lkundrak@v3.sk>
>  
> +allOf:
> +  - $ref: audio-graph-port.yaml#
> +
>  properties:
>    $nodename:
>      pattern: "^audio-controller(@.*)?$"
> @@ -58,29 +61,9 @@ properties:
>          type: object
>  
>          properties:
> -          remote-endpoint: true
> -
> -          frame-master:
> -            type: boolean
> -            description: SoC generates the frame clock
> -
> -          bitclock-master:
> -            type: boolean
> -            description: SoC generates the bit clock
> -
>            dai-format:
> -            $ref: /schemas/types.yaml#/definitions/string
> -            description: The digital audio format
>              const: i2s
>  
> -        required:
> -          - remote-endpoint
> -
> -    required:
> -      - endpoint
> -
> -    additionalProperties: false
> -
>  required:
>    - "#sound-dai-cells"
>    - compatible
> @@ -112,8 +95,6 @@ examples:
>        port {
>          endpoint {
>            remote-endpoint = <&rt5631_0>;
> -          frame-master;
> -          bitclock-master;
>            dai-format = "i2s";
>          };
>        };
> -- 
> 2.25.1
> 
