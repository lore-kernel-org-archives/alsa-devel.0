Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC3FEB64D8
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jun 2023 10:55:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 149E1823;
	Wed, 21 Jun 2023 12:54:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 149E1823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687344925;
	bh=8b+uU3Bs2sYqRmJk9/fT6n7FW28WjMTbPY0E1GKJS1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uprxUtpAcP4KKTl4tBvcoPW+htQVGv/tFmBIF8d9baQ2uk1O95C1m8RISAIrH76Pe
	 tMAzbbq0hqerDxYRXPdHZG5lZ1smYFoZ3NFyXrSV6ve+o/V8VkeGKf48+GG35N3QlQ
	 zE+eMRU88dK2dH2CSa9QLRn6yqN8H6s1BvtyV3CA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8864BF80132; Wed, 21 Jun 2023 12:54:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1603CF80141;
	Wed, 21 Jun 2023 12:54:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EA1C9F80141; Wed, 21 Jun 2023 12:54:04 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DD707F80132
	for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2023 12:53:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD707F80132
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=gMF6LhlQ
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ACDE0614F0;
	Wed, 21 Jun 2023 10:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DEFC433C0;
	Wed, 21 Jun 2023 10:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687344834;
	bh=8b+uU3Bs2sYqRmJk9/fT6n7FW28WjMTbPY0E1GKJS1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMF6LhlQ8BB9kWB22e32blkxJkHYKdSnN11rulUgtPhi6lIpYQ5GY+v+qP1GwDNVS
	 AobbulHyeFXjObvKjs6whBlw2A87+z2ckauyf6gu46egCRue0gNn21iqItpjNmXQXG
	 FrUPT2O5nKVyv9rRr31X3tkKP1z8xnBtb188e+tSHJXpDQ7Hh2bw/0CMwX+qIIF1vh
	 ujJidCroEGOWsNy3mS7EUGGtTo6RlSw77kU7b6Ug+QRoLi9l4VQN+kSzxFAUPuZdev
	 FWauUE17DS5B/0PHHVu4JHfmECqb7W3jPBI/bOw8ORmEK97BRE/UE4ufKgUSCOgaht
	 /K4EfiN1xnDBw==
Date: Wed, 21 Jun 2023 16:23:49 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.intel.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] soundwire: bus: Prevent lockdep asserts when stream
 has multiple buses
Message-ID: <ZJLWvSRevDmdP/Cy@matsya>
References: <20230615141208.679011-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615141208.679011-1-rf@opensource.cirrus.com>
Message-ID-Hash: IS4ZBHSEJIB65RXWZSDOV74KHYJZNRDP
X-Message-ID-Hash: IS4ZBHSEJIB65RXWZSDOV74KHYJZNRDP
X-MailFrom: vkoul@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IS4ZBHSEJIB65RXWZSDOV74KHYJZNRDP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 15-06-23, 15:12, Richard Fitzgerald wrote:
> Give the bus_lock and msg_lock of each bus a different unique key
> so that it is possible to acquire the locks of multiple buses
> without lockdep asserting a possible deadlock.
> 
> Using mutex_init() to initialize a mutex gives all those mutexes
> the same lock class. Lockdep checking treats it as an error to
> attempt to take a mutex while already holding a mutex of the same
> class. This causes a lockdep assert when sdw_acquire_bus_lock()
> attempts to lock multiple buses, and when do_bank_switch() takes
> multiple msg_lock.

Applied both, thanks

-- 
~Vinod
