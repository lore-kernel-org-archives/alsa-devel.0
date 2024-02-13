Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82F2C48260
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Feb 2024 17:56:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF271DFA;
	Tue, 13 Feb 2024 18:55:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF271DFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1707846966;
	bh=fkt9NvcefWq6HaVXS1+B/buBOjL8fqSRphpLKPoAspM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NyS/4mhinMB2zbgua5Rn64udXN2kRqhz3xBv22HwPN6lyJsMao4VUV5vhd4iEcY5U
	 AgIJ6FJXlRCjTtWyHFnBsn5lWb23++8eDjd5jVJ6zUlwjPw/C+/vKAUbRiyn/nnuRg
	 n9Q9qxZZI0wZ09dPbiRaU7vkBekWciUmJxCnIACc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DBCDEF805E2; Tue, 13 Feb 2024 18:55:10 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C245F805F2;
	Tue, 13 Feb 2024 18:55:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D078F805D8; Tue, 13 Feb 2024 18:55:06 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 031AAF805C6
	for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2024 18:55:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 031AAF805C6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org
 header.a=rsa-sha256 header.s=korg header.b=O4XYoG2G
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 89F44CE1DB0;
	Tue, 13 Feb 2024 17:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F8FC433A6;
	Tue, 13 Feb 2024 17:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707846899;
	bh=fkt9NvcefWq6HaVXS1+B/buBOjL8fqSRphpLKPoAspM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4XYoG2G3bRZ9UGOeRWlDOxTABe8Ay6u2udCejTrfM42tFVdg1brUE+5Ga2DFaE/6
	 LfmKImpTKVW29yOZkb8+NNQRIjOsvmxD0HWkF57RgtP5klXnX93q94jEsJnlBcN8s9
	 PcFZIPUoFCh1A3ccE6BOYdOs6tPkEa0DrccJjXVA=
Date: Tue, 13 Feb 2024 18:29:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: bus_type: make sdw_bus_type const
Message-ID: <2024021351-observing-concerned-38cf@gregkh>
References: <20240213-bus_cleanup-soundwire-v1-1-3878b00f6f57@marliere.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-soundwire-v1-1-3878b00f6f57@marliere.net>
Message-ID-Hash: 64J45WMZ3OG6HF255YGCBHW7RUC4LHCL
X-Message-ID-Hash: 64J45WMZ3OG6HF255YGCBHW7RUC4LHCL
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/64J45WMZ3OG6HF255YGCBHW7RUC4LHCL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Feb 13, 2024 at 11:36:56AM -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct
> bus_type a const *"), the driver core can properly handle constant
> struct bus_type, move the sdw_bus_type variable to be a constant
> structure as well, placing it into read-only memory which can not be
> modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
