Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6763BC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Dec 2021 20:33:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3529520A6;
	Thu, 16 Dec 2021 21:32:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3529520A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639686787;
	bh=ZrgxPGHRfrNSlgVBv3l9EwAnPu8fMQWyIItIPigy/QQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X3OfETB4u3k2q1d41JPFKvOaYmkBjQh7egM/lddu7X3Mp6qh4qmPP5V6wfEFL2qCv
	 Q6L3RFTw7MOtaZbjyGydQaxBv9JRGlKtOALLrN/7q5GlfH8giUqcWea7vzbXhw0qjh
	 qmK8m2CcUxpYOvayB4AlxhdQNWGS/CmX5LxeI9zk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9F28F80116;
	Thu, 16 Dec 2021 21:32:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EBB7F8014C; Thu, 16 Dec 2021 21:32:13 +0100 (CET)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 023B0F800F4
 for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2021 21:32:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 023B0F800F4
Received: by mail-oi1-f176.google.com with SMTP id r26so589987oiw.5
 for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2021 12:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=umUy1uYNyZY1VykdghF7eMiCi+OMbNsH6C13bj0a6Fc=;
 b=7+zXzhLSJp/4cLfBmlHI0JQXHLGLTqZZMkTdQXWYRGE6I+q/HV2R/OfcxSD7mx6S9k
 gtqGavehwUaHwsanis/AUHbLURkOG/138oM0uDdOq9LWUv80fd0U5GhjpNNbUFnTnW2w
 esIAS937CnfrLiWcY6bz2bZBlvaKBRJCKF8flivr1M08PNjIbQttf9r7aNJ306u69sUy
 12CWQVelMgtd//Iiwh9hQEBVwCvyj7hr8/fzN2W+EaUaeIrw2e+QOuGhZjQsgSPlOffi
 EL6hLozhL6NIdcYobF2WY1HHxr/yPcWoLoa5nk2GoiFw7CBkjSD7guo+EIO9v7FaFE1q
 b8Ug==
X-Gm-Message-State: AOAM530EwsFoxOUED6N/WCZTn2otgBWpao1C29ZrXlT4k1RXHXkgj85q
 YX8CIm42B4eUOEi6ZeME3pR3Ofkt3Q==
X-Google-Smtp-Source: ABdhPJxIuAAHF4Tu1T2g8nQ4SAIbKIMuI9BFSu3AAU+8GI3F/9OLT+gd1yGk5ZdTgRQLItyFR0C7sQ==
X-Received: by 2002:aca:58c4:: with SMTP id m187mr5311388oib.113.1639686724022; 
 Thu, 16 Dec 2021 12:32:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id bi20sm1322787oib.29.2021.12.16.12.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Dec 2021 12:32:03 -0800 (PST)
Received: (nullmailer pid 706190 invoked by uid 1000);
 Thu, 16 Dec 2021 20:32:02 -0000
Date: Thu, 16 Dec 2021 14:32:02 -0600
From: Rob Herring <robh@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: audio-graph-port: enable both
 flag/phandle for bitclock/frame-master
Message-ID: <YbuiQpu/pbEjWDfc@robh.at.kernel.org>
References: <20211216000018.2641925-1-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216000018.2641925-1-kuninori.morimoto.gx@renesas.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
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

On Thu, 16 Dec 2021 09:00:18 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> snd_soc_daifmt_parse_clock_provider_raw() is handling both
> bitclock/frame-master, and is supporting both flag/phandle.
> Current DT is assuming it is flag style.
> This patch allows both case.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
> 	- anyOf -> oneOf
> 
>  .../devicetree/bindings/sound/audio-graph-port.yaml      | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
