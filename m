Return-Path: <SRS0=IN0D=YE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D18C47404
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:21:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44E23206A1
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Oct 2019 15:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DCcIexZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E23206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 837AA1615;
	Fri, 11 Oct 2019 17:20:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 837AA1615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570807291;
	bh=xIx7Fz5bm9cgNwYX8/ym7B3exR7vLtqrXDdz0BjJTz4=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DCcIexZGVwhF/qIkTbNGAyWg54LVu62SvkCVs0R4BkOylad64utsccWOM9xcd8Leg
	 iPnUIeQQxyajZWyyHkSjfeRmVT6ETIiB5DzcuzBF1o+Ix/Nh57UG95JTtRHYwgRWn+
	 VxLRQEpjwDy7+43A3vGi3hJFqP2Anv0Ef1/A598E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E2EEF80113;
	Fri, 11 Oct 2019 17:20:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95AC4F802BE; Fri, 11 Oct 2019 17:20:39 +0200 (CEST)
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F107F80113
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2019 17:20:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F107F80113
Received: by mail-oi1-f196.google.com with SMTP id i185so8276763oif.9
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2019 08:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zwS8rnb6Pul2Tj4IPe9QhJRNl+DNx3RdlplLF9pczuk=;
 b=J+hcs6xAZ4JWSPtDudwSXyqk8S2rsNduQINkYkmBVdWkgydQkm1h2s6rJ0sGj7w0vW
 kCiCMjIL7Ags+YqD+d5q7jg9o19WOIyTmjzT33d0RRqpX0UJp78C2+RdSMSFRbcTHGyX
 +xMRfs9fBQ7vc44q1h2CAbOg0N8igI13h11VvQMmzuGrg1SpboOosJ/KHuztAmLZmrdm
 Hd4JWKJ+G0cJjK6eE3MAPZByrbxE0K/4Z8wsyGuqp619WNB54Scp1wfOzGt3h3AyMPy8
 GCCs+4SiFOCKHs71iizMZDbi6+MVOrp0MwmAG4Qvl7f1GfnwmA0qmEPNZjUEGwA/zNh+
 zIXQ==
X-Gm-Message-State: APjAAAX1FmpKztCaSqVo7Ws9KogG+e12t/MR+hbxfUXpweLs+tGCFxp3
 3xKePs0lWRYEU/RCijTtng==
X-Google-Smtp-Source: APXvYqxeMfb0jpX/cZhqRDivEunM6dWUjFbeka9g66lQDFOgGGwSJoMxBm/KHFglSYdf+wWw96sJEQ==
X-Received: by 2002:a54:4481:: with SMTP id v1mr12176488oiv.152.1570807231287; 
 Fri, 11 Oct 2019 08:20:31 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id i5sm2638917otk.10.2019.10.11.08.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 08:20:30 -0700 (PDT)
Date: Fri, 11 Oct 2019 10:20:29 -0500
From: Rob Herring <robh@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Message-ID: <20191011152029.GA18877@bogus>
References: <20191005085509.187179-1-tzungbi@google.com>
 <20191005164320.09.Iec97a3f137148cdf316056612590b3e0b302f5f3@changeid>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191005164320.09.Iec97a3f137148cdf316056612590b3e0b302f5f3@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: gwendal@google.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 cychiang@google.com, drinkcat@google.com, broonie@kernel.org,
 enric.balletbo@collabora.com, bleung@google.com, dgreid@google.com
Subject: Re: [alsa-devel] [PATCH v2 09/10] ASoC: dt-bindings: mt8183: add
	ec-codec
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

On Sat, Oct 05, 2019 at 04:55:08PM +0800, Tzung-Bi Shih wrote:
> Add an optional property "ec-codec".  If specified, mt8183 could use the
> "wake on voice" feature offered by EC codec.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
>  .../bindings/sound/mt8183-mt6358-ts3a227-max98357.txt          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt b/Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt
> index 17ff3892f439..decaa013a07e 100644
> --- a/Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt
> +++ b/Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt
> @@ -6,12 +6,15 @@ Required properties:
>  
>  Optional properties:
>  - mediatek,headset-codec: the phandles of ts3a227 codecs
> +- mediatek,ec-codec: the phandle of EC codecs.
> +                     See google,cros-ec-codec.txt for more details.

Not the best designed audio binding here. We really should just have 
links to codecs and then you can look at the codec nodes to determine 
the type.

>  
>  Example:
>  
>  	sound {
>  		compatible = "mediatek,mt8183_mt6358_ts3a227_max98357";

Don't you need to add EC codec to this? Just kidding. Just highlighting 
the weirdness of this binding.

>  		mediatek,headset-codec = <&ts3a227>;
> +		mediatek,ec-codec = <&ec_codec>;
>  		mediatek,platform = <&afe>;
>  	};
>  
> -- 
> 2.23.0.581.g78d2f28ef7-goog
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
