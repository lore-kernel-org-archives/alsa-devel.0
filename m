Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF91C34047
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:24:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BCD2173E
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="urdC7Ynf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BCD2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79277167A;
	Tue, 18 Feb 2020 21:23:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79277167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582057452;
	bh=GwyhkRUcZ6A3Zga4N/oeteeJ944XfngcqZbqD7zgeO8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=urdC7YnfAfJ7a/RJj63ms4jEHI+jQmjjFqeqh6zv+YT7onunqb967NDYcmkopRyfK
	 jS1rQ3zkU8kTX79p4nJG8yXnw43VgIHyAmv/ujxX+wvpVSdxapDLI3qC2RDXa7mVPS
	 3dklG/FymUVEgn4wJc/+B1R2bOZms+bLD7BZYRGI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04669F80145;
	Tue, 18 Feb 2020 21:23:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2BBDF80148; Tue, 18 Feb 2020 21:23:19 +0100 (CET)
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93CA4F80137
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 21:23:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93CA4F80137
Received: by mail-ot1-f68.google.com with SMTP id 77so20826819oty.6
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 12:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KXAg/34S3FvFzX0pQBHTJXGpiExV3W+ihyd1Dn2Mhvs=;
 b=FRNL7Oqs9w7H5D1lC5Fixb0HGUgoS5vlYB+R3OqH+ABG9GsoGo2Ysy3NHlg5n8dI1H
 exRU4RyUPheepsYhudWl/ADFpo85Bkpv2fu95+PvqADaSHJFhwSntaxSBVyCUzY4CU0b
 ECBq1dCPcoGVppTF7H3ZTM3VQkutzE76MhOV5l64S7rquwLY+24PDSzo7ZuiuswDhDPG
 FplGNS9L3ixpkKGGLSPjKBjBwpxiljkMPjMbUxPQZ8udgtZA/naAn3u4Higz05yBSP9o
 eoX6DoibH/jOP4Ib1w4bf8Yri/xXoZzmevB54sLgVlq+D/dc4PX7HJfpkWBvrJpWi+rG
 Bh7A==
X-Gm-Message-State: APjAAAVF5tvVtjdhOP8ecOBBMrQdDZ4629PigQWBcYpFF+C5cSeqz7Au
 h8i0Lvt7DktL0g4gUlz22A==
X-Google-Smtp-Source: APXvYqyzvxFzvOCeCS4HedEasKA6K6wnQhBPGg7dbaFVPmVQk7FQtsqWZXQE/aGzUFgd7ormvX924Q==
X-Received: by 2002:a9d:7305:: with SMTP id e5mr16273114otk.64.1582057390643; 
 Tue, 18 Feb 2020 12:23:10 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id r13sm1525277oic.52.2020.02.18.12.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 12:23:10 -0800 (PST)
Received: (nullmailer pid 4455 invoked by uid 1000);
 Tue, 18 Feb 2020 20:23:09 -0000
Date: Tue, 18 Feb 2020 14:23:09 -0600
From: Rob Herring <robh@kernel.org>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [RFC PATCH 30/34] ASoC: dt-bindings: Bump sound-dai-cells on
 sun8i-codec
Message-ID: <20200218202308.GA4022@bogus>
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-31-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217064250.15516-31-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Mark Brown <broonie@kernel.org>,
 =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org
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

On Mon, 17 Feb 2020 00:42:46 -0600, Samuel Holland wrote:
> The generic ASoC OF code supports a sound-dai-cells value of 0 or 1 with
> no impact to the driver. Bump sound-dai-cells to 1 to allow using the
> secondary DAIs in the codec.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.example.dt.yaml: audio-codec@1c22e00: #sound-dai-cells:0:0: 1 was expected

See https://patchwork.ozlabs.org/patch/1238984
Please check and re-submit.
