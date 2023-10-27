Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C252BC25B47
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Oct 2023 11:53:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5754AE9;
	Fri, 27 Oct 2023 13:52:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5754AE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698407589;
	bh=F9LC6GHBHY7uAatNHDSxSic7rHVxZ1n+xDOqhkfiSWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ftTTThejIg+9TuOZejIEdomJe8n1XbStRl/wTYqreRsqyxopt6exMXDh42EXx46ir
	 qRk783WPykCW6tfwCLFu1bUb0LPgwPn772GudG9HW0I+VGL4PVKNArGfT5wVnXLJea
	 ZgAF8tGYgPJ1i+I6OcHGhsBAHhdrTgSKrXKtRij0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8146FF8028D; Fri, 27 Oct 2023 13:51:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C84A7F8010B;
	Fri, 27 Oct 2023 13:51:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F40FF8019B; Fri, 27 Oct 2023 13:51:53 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 72CA6F8010B
	for <alsa-devel@alsa-project.org>; Fri, 27 Oct 2023 13:51:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72CA6F8010B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lN6z7kMb
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 9552FB81F14;
	Fri, 27 Oct 2023 11:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F2CC433C7;
	Fri, 27 Oct 2023 11:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698407506;
	bh=F9LC6GHBHY7uAatNHDSxSic7rHVxZ1n+xDOqhkfiSWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lN6z7kMbFfGnHS0I+C5BALxSNL3/YKgwnGYJo2rNUXMYJNxbh5Ae/FcsrXCicyyqE
	 RAYVpqwZCpGGWRqfC7YXS1W38K3bDdoTGy+Xpli+nFdDYGvRF8+iD5VyxHvElv58Dx
	 aiNEgHnleSU1bVRRPnMcSf8oPmHlx0jpMIjVEWBrKVNdCsgCpBuZBEJ4MYha5QHPur
	 onrewUlId/MpBMbXo14gig4je18qT7GQQelVo7GKQEFxel+yTibWRvG37QKFLxt+ec
	 ao78gN0PYkNi1L+639uiFC9Q7X6WyNxN+pL1I4AqktE8QnlL/4FVWLzi16l1XnUjj1
	 fB+dXfUCMJRkA==
Received: from johan by xi.lan with local (Exim 4.96)
	(envelope-from <johan@kernel.org>)
	id 1qwLNr-0005u7-1z;
	Fri, 27 Oct 2023 13:52:11 +0200
Date: Fri, 27 Oct 2023 13:52:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [RFC PATCH 0/2] ASoC: soc-dai: add flag to mute and unmute
 stream during trigger.
Message-ID: <ZTukaxUhgY4WLgEs@hovoldconsulting.com>
References: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
Message-ID-Hash: RKI5KNN4FEDFFSLYDU4BLFB4BTCAMHBI
X-Message-ID-Hash: RKI5KNN4FEDFFSLYDU4BLFB4BTCAMHBI
X-MailFrom: johan@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RKI5KNN4FEDFFSLYDU4BLFB4BTCAMHBI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Oct 27, 2023 at 11:57:45AM +0100, Srinivas Kandagatla wrote:
> Click/Pop Noise was a long pending issue with WSA Codecs which are prone
> to accumlate DC when ports are active but without any data streams.
> There are multiple places in the current setup, where this could happen
> in both startup as well as shutdown path.
> 
> This patchset adds a new flag mute_unmute_on_trigger to dai_ops to let
> generic code do the mute/unmute on trigger.
> 
> This patches help fix those issues by making sure the PA is Muted/Unmuted
> inline with the stream start/stop events.
>
> Srinivas Kandagatla (2):
>   ASoC: soc-dai: add flag to mute and unmute stream during trigger
>   ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag

I've verified that this fixes the pop sounds when starting and stopping
a stream on the X13s, even if the click sound when killing pulseaudio
(e.g. on reboot) is still there (as with the previous fixes).

Tested-by: Johan Hovold <johan+linaro@kernel.org>

If these are accepted, can we get them backported to 6.5 as well?

Johan
