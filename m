Return-Path: <SRS0=8DMN=4I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD2AC11D0C
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:30:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7817F208CD
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 20:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="p4v9pki5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7817F208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2FA91683;
	Thu, 20 Feb 2020 21:29:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2FA91683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582230641;
	bh=fNNsB5ino+La+/VeE+Cq/VqWJOnIIE5Z8PRYl3wsYkE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p4v9pki5HJD+ipGLnKoR5qWPMHp5bKvZg+/lLF9ZhZjgXHf9KVJ07iY86Si3lbUMd
	 mkwlWNsdpyZorn2VHF4Yb2lAgaaZfVPVLnwnc/aFsrv4obFQE8Q4cAjUf6eU+ioXhi
	 G2dzQHvnynif7v+MheWSKm2T6ONcNFU3WIhHX0b8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 343AEF8011D;
	Thu, 20 Feb 2020 21:29:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2427CF80148; Thu, 20 Feb 2020 21:29:47 +0100 (CET)
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4793F8011D
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2020 21:29:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4793F8011D
Received: by mail-ot1-f68.google.com with SMTP id r16so4970951otd.2
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2020 12:29:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4y11Rw9Quj6ChkrwsaKBH1Q0T5iRPrjR3ZQy3ZsS7xA=;
 b=jQn0R6hBg2joHQZEzDVjuHLn7cpQsEvaqW1vvbjqI3JblpogRaGlvPBD8hoqVbQVH6
 rIvQ9M2ELal+TuIwIXefJo4AdyA19CZKsIB++7kPhi8XJrH3iBX+ETt6u1ZpsjPIeXol
 BbFYq5BhTxaAbZkuj6ZJ351b+DDdmux5G4TBHW9KmBoEUilcoPBmLxIYE5XAXtX4Kzi7
 zs+JoZ09NajicW2gNOhFHYyOOmdlP0QAW0ZaYBkmL3LBtWJYw82ReJqFkjRQBnPEp8ID
 Y0KMBq5x1ZTxB+s+I+umVO/DLxNPZPUEQvhqs8E17CdCDmAZwub5hqGrDlD+XA32jJVZ
 62cQ==
X-Gm-Message-State: APjAAAX6RHIXWF8GfWzFhpWVZvSQG4hg3E656FoYOgq2qZ9BrdRUBoRR
 smWcB9iatfGQ9eUjh1PDMA==
X-Google-Smtp-Source: APXvYqxqNmvtY+8v4lmPFwBx32CjiYTpN6LA3c1fXpwH+kIAQ9BKjTQ21m1UkbGpGxeL1RGLpLDftw==
X-Received: by 2002:a05:6830:1d7b:: with SMTP id
 l27mr23581373oti.251.1582230581148; 
 Thu, 20 Feb 2020 12:29:41 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l207sm128716oih.25.2020.02.20.12.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 12:29:40 -0800 (PST)
Received: (nullmailer pid 7275 invoked by uid 1000);
 Thu, 20 Feb 2020 20:29:39 -0000
Date: Thu, 20 Feb 2020 14:29:39 -0600
From: Rob Herring <robh@kernel.org>
To: Olivier Moysan <olivier.moysan@st.com>
Subject: Re: [PATCH v3] ASoC: dt-bindings: stm32: convert sai to json-schema
Message-ID: <20200220202939.GA6480@bogus>
References: <20200219161733.9317-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219161733.9317-1-olivier.moysan@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: mark.rutland@arm.com, robh@kernel.org, alsa-devel@alsa-project.org,
 olivier.moysan@st.com, alexandre.torgue@st.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
 broonie@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
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

On Wed, 19 Feb 2020 17:17:33 +0100, Olivier Moysan wrote:
> Convert the STM32 SAI bindings to DT schema format using json-schema.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
> Changes in v2:
> - use pattern for compatible of child nodes
> - rework dmas and clocks properties
> - add "additionalProperties"
> 
> Changes in v3:
> - move clocks properties for st,stm32h7-sai compatible, to 'else' clause
> ---
>  .../bindings/sound/st,stm32-sai.txt           | 107 ----------
>  .../bindings/sound/st,stm32-sai.yaml          | 193 ++++++++++++++++++
>  2 files changed, 193 insertions(+), 107 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/st,stm32-sai.example.dt.yaml: sai@4400a000: 'clock-names', 'clocks' do not match any of the regexes: '^audio-controller@[0-9a-f]+$', 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1240792
Please check and re-submit.
