Return-Path: <SRS0=9b6r=YW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC96CA9EAE
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 17:18:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC8720830
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Oct 2019 17:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k6+g/sCF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC8720830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8092D223C;
	Tue, 29 Oct 2019 18:17:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8092D223C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572369478;
	bh=MlbJVVGC9kOhhNLKNti9XDRyH5BuUWPs+0FcL6ohGu0=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k6+g/sCF8XfxH0L3p+Gkeoy7EohezJVXdf/JQE4NmysFt9/yEQ32fN/Q4zTY+3Nit
	 5U9IrtUBJon0oQv2S7DMcAqyZGJlKJus72E2lXFJ+dreH8/Av9aQXYAhejloU5AWYo
	 nf8ogQftZgIWrNBgAZH2lFf72nrcmPXalWBfVT/w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C30F2F80269;
	Tue, 29 Oct 2019 17:57:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 861F1F80392; Tue, 29 Oct 2019 17:57:49 +0100 (CET)
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4DCBF80269
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2019 17:57:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4DCBF80269
Received: by mail-ot1-f65.google.com with SMTP id u13so10398957ote.0
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2019 09:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AzR50uFmoDCtnAJJfiGxTvyuBUS+uKVO9Sccr9LgN3A=;
 b=UosshcE+d5t5+QEbBhjnm+mX2Flwknk/2a5eVSDlgNHl4CNr9XEwTzZzxTHICPaWp+
 DQgy/Rgawjnm7BRSgQKr5ZJNedvalvrhJImMvBl7OMrsDGOawD7PbDBzR9vz0TWSKcRj
 I9NKzQ4YgrQIzEYC/oVsO6U8Mfe46lXE49Q4xZiZ7x3u6e1bB46M+zzyrJKlU+tS2x5k
 tkTQ+dQDeSnV2ITOMrLaVt8L0cCL0ht+a8RjOc1EKKiEKEGzjvcNW8tcmpQb0F5ugDx3
 LbAFxBqkof3Vaz1Hj39f/5yQOS7H7C4MK73pD8tOk1aYZztxiwt3w40nubDHKJFqpoSC
 JEgg==
X-Gm-Message-State: APjAAAV7sfp65BaJTou8r+DKA6IYUdYhvzKGWHBwUUIgslYxyfxBX6iQ
 AG6IBKWzwxnamntUkhe+cQ==
X-Google-Smtp-Source: APXvYqyA4q27jgqbyYHzCXs5l/JuoLIkpIFSmc+fTrrf3tbcL04DsgIowaA8Q0ofDaNVgZxnpP/5Jg==
X-Received: by 2002:a05:6830:1256:: with SMTP id
 s22mr19536485otp.308.1572368265215; 
 Tue, 29 Oct 2019 09:57:45 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id u1sm2055522oie.37.2019.10.29.09.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 09:57:43 -0700 (PDT)
Date: Tue, 29 Oct 2019 11:57:43 -0500
From: Rob Herring <robh@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Message-ID: <20191029165743.GA11562@bogus>
References: <20191022114505.196852-1-tzungbi@google.com>
 <20191022193301.3.I37696eb1321a21846f9e5a9eb14dfac7dbe10663@changeid>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191022193301.3.I37696eb1321a21846f9e5a9eb14dfac7dbe10663@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 cychiang@google.com, narmstrong@baylibre.com, allen.chen@ite.com.tw,
 dri-devel@lists.freedesktop.org, jonas@kwiboo.se, jernej.skrabec@siol.net,
 robh+dt@kernel.org, a.hajda@samsung.com, broonie@kernel.org,
 Laurent.pinchart@ideasonboard.com, tzungbi@google.com, dgreid@google.com
Subject: Re: [alsa-devel] [PATCH 3/6] ASoC: dt-bindings: mt8183: add a
 property "mediatek, hdmi-codec"
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

On Tue, 22 Oct 2019 19:45:02 +0800, Tzung-Bi Shih wrote:
> Add an optional property "mediatek,hdmi-codec".
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
>  .../bindings/sound/mt8183-mt6358-ts3a227-max98357.txt           | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
