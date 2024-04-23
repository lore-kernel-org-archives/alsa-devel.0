Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3173AC10F15
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Apr 2024 11:59:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4772CFAA;
	Tue, 23 Apr 2024 13:59:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4772CFAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1713873592;
	bh=ecusU43kPP6McqPCLCaUhQIuhV95CTwsnf4v93S0sjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jE/ECjZd7nCu4ddUc5FH4qLmN7nZ9HyGWLCiaGhtaYIto+NW5RxEWHa/Z7Ydn2I2C
	 UXxNcS43RYjPgMFGTgjF7Egobf5n4zKXyFxHN/MC5Am5GjZJj1ocpKYYSobWoVqrYO
	 rMaqXTZBApV6WWnFyOmce6UoDd4ZyrRmQ8akChrI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2CBB2F805AD; Tue, 23 Apr 2024 13:59:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D888F805AA;
	Tue, 23 Apr 2024 13:59:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E5A5AF80423; Tue, 23 Apr 2024 13:59:13 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D7570F8003A
	for <alsa-devel@alsa-project.org>; Tue, 23 Apr 2024 13:59:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7570F8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OQjQw67U
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 375F4CE102E;
	Tue, 23 Apr 2024 11:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55606C116B1;
	Tue, 23 Apr 2024 11:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713873543;
	bh=nN7zGFg9PFQMqcmKgEdJAU83WoXJ9A3csJuwYHCvDXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQjQw67U5QJS+GP8IG6Aech13cnh+ug8QkQhgdHfNEL85oXMk7qfT8doa+NR5fI5f
	 9fciWr0nRNiCnoquahI6tM92VkM+4vMw+o9OYYBbKVf0n1GN6WC+RAB5wLuE+TxbgA
	 ps4/jVTajB2yXo/kA7r+WXBbD4rOTFX6VzFheWgpryJZEwJFETyTQOdfUMOlygIflx
	 dyJ7bPdDIU/qeUmM/M8dYX6j2aZyAZ5+++cla4R/2Dg8sTkraYcJiF+SnaKOSd5IOb
	 RMeQTZPHQ3n2u3YcSPabaJbsicg7hN+iSueRoJcNJ8VQwMtl6APFGc2aXXaRWR2sWJ
	 I7aI6XDSBQSxQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rzEnd-000000005Mk-1kZS;
	Tue, 23 Apr 2024 13:59:01 +0200
Date: Tue, 23 Apr 2024 13:59:01 +0200
From: Johan Hovold <johan@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v2 0/4] ASoC: qcom: display port changes
Message-ID: <ZieihZRKe7OtP-nV@hovoldconsulting.com>
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
Message-ID-Hash: 6MNKHFMG6OKL2KQGKGFVDWXDMNRDPYMK
X-Message-ID-Hash: 6MNKHFMG6OKL2KQGKGFVDWXDMNRDPYMK
X-MailFrom: johan@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6MNKHFMG6OKL2KQGKGFVDWXDMNRDPYMK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, Apr 22, 2024 at 02:43:50PM +0100, Srinivas Kandagatla wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> This patchset adds support for.
> 	1. parse Display Port module tokens from ASoC topology
> 	2. add support to DP/HDMI Jack events.
> 	3. fixes a typo in function name in sm8250
> 
> Verified these patches on X13s along with changes to tplg in 
> https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/tree/topic/x13s-dp?ref_type=heads
> and ucm changes from https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/topic/x13s-dp

It looks like your UCM changes are still muxing the speaker and *each*
displayport output so that you can only use one device at a time (i.e.
only Speaker or DP1 or DP2 can be used).

As we discussed off list last week, this seems unnecessarily limited and
as far as I understood is mostly needed to work around some
implementation details (not sure why DP1 and DP2 can't be used in
parallel either).

Can you please describe the problem here so that we can discuss this
before merging an unnecessarily restricted solution which may later be
harder to change (e.g. as kernel, topology and ucm may again need to be
updated in lock step).

>From what I could tell after a quick look, this series does not
necessarily depend on muxing things this way, but please confirm that
too.

Johan
