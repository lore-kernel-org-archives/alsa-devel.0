Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D342C54E76
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Jan 2023 17:11:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D19E46AFF;
	Tue, 17 Jan 2023 18:10:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D19E46AFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673975464;
	bh=PKfVZA6Y+jGLD+yvKM7jtjfmj+Ws40Nmee3pJ5QOsKw=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=UMKtiPopjmcuhilGnRCSIEYmLEivUfCPcD1y9GvJnP9PKcmSTOFHma2DpKsnJPlPn
	 190TImf2gIYoygT3uCrn5imbonru2jMI6xwj4P71Ft9GSzDaW9RT4jgS87d1o36OLB
	 0XNa4gB1TXE56Mm09+4Q3zIOZUv4Na8Jyh1+TV2I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B927F804E6;
	Tue, 17 Jan 2023 18:09:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0C23F80083; Tue, 17 Jan 2023 18:09:48 +0100 (CET)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com
 [209.85.161.51])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41D9CF80083
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2023 18:09:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41D9CF80083
Received: by mail-oo1-f51.google.com with SMTP id
 b10-20020a4a9fca000000b004e6f734c6b4so8129094oom.9
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2023 09:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBt6OwEc7aWzfw3HNqGtJVkR6yiTPViGz+8y019qzbo=;
 b=O1XEKf+OMu6OnaNUqi88dUqPtpnk0/MVkdddNJNjbS8ch27dyC/YWKGoBoN8cHIRgW
 397MiVjzXW6b8EqGj3lC514qisfOftpbIrUeTjHySNYhLqdedOlIiwFjUZv768VvEWMD
 laql6Wo1DXZjgkS45bEGca7a9mCtjaElzCovLZ/iGyOj+Fkx59rL1gDX9fVcPov8N+f6
 OV8bvWFxLkHD572darBigksooS03hY3f0YbE4iDuBc38GalRIgJ3RAuYKvRYSanyKGLQ
 x3OG9yHNjiuJVrOnffQV/5RjtuW9Y4ELaadUz289wTPZ69G6+GGM163DCuVMGuznwrJO
 YyPw==
X-Gm-Message-State: AFqh2koI8V/nJE7AZQsHbnJ0knuCuv/ke4kStuHKWcfy6HIrZiEfpPQj
 +pkqPejm+Wnjsj/mJxterQ==
X-Google-Smtp-Source: AMrXdXuoCd2emcRioMWSkuiL5UJXYiiL7j05Xg3FB4TAOariAaf9grOg2xUsCHaHs0HnjFZPhOVlFg==
X-Received: by 2002:a05:6820:150a:b0:4f2:875:5252 with SMTP id
 ay10-20020a056820150a00b004f208755252mr12029257oob.3.1673975383168; 
 Tue, 17 Jan 2023 09:09:43 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 r5-20020a4a83c5000000b0049ee88e86f9sm15310809oog.10.2023.01.17.09.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jan 2023 09:09:42 -0800 (PST)
Received: (nullmailer pid 3250793 invoked by uid 1000);
 Tue, 17 Jan 2023 17:09:42 -0000
Date: Tue, 17 Jan 2023 11:09:42 -0600
From: Rob Herring <robh@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v2 03/10] ASoC: dt-bindings: audio-graph-port: add
 missing mclk-fs
Message-ID: <20230117170942.GA3244879-robh@kernel.org>
References: <87358hj2ub.wl-kuninori.morimoto.gx@renesas.com>
 <87y1q9ho56.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1q9ho56.wl-kuninori.morimoto.gx@renesas.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, Jan 11, 2023 at 01:10:29AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> audio-graph-port is missing "mclk-fs" on ports/port,
> it is used not only endpoint. It is already defined on simple-card.
> This patch fixup it.
> Without this patch, we will get below warning.
> 
> ${LINUX}/arch/arm64/boot/dts/renesas/r8a77951-ulcb-kf.dtb: audio-codec@44: ports: 'mclk-fs' does not match any of the regexes: '^port@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 	From schema: ${LINUX}/Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml

IMO, the warning is correct. 'ports' should not be anything but a 
container of 'port' nodes. If something applies to all ports, then it 
should probably be in the device node (or implicit).

Rob
