Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8033C7EE25
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jun 2023 12:41:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24C306C0;
	Thu,  8 Jun 2023 14:40:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24C306C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686228058;
	bh=HEJCQXhlFU8K5G9MVGjIFc2v8j1rgUCTywnobuzpZVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tAu9DCFE5PGmTTZ68vXdB473uSHoLdFZyObppjdzVG+UwwYOC2SpI8KnF1R2Juuwm
	 JVPp/cc2I9mRO5pqUzDB/1CQE2CgYG6/fVOCPwCe5msXG034kv7jYRDbqJtOSWWtOM
	 7vaZ10oOZLBjiYuMiC8k6N1x/KlWG4WW7k0cphHA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9AB1F80254; Thu,  8 Jun 2023 14:40:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 242AAF80199;
	Thu,  8 Jun 2023 14:40:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4A38EF80199; Thu,  8 Jun 2023 14:40:03 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 516EFF80155
	for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2023 14:39:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 516EFF80155
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=L4Tmvmx4
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E07AC61272;
	Thu,  8 Jun 2023 12:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2CEC433D2;
	Thu,  8 Jun 2023 12:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686227991;
	bh=HEJCQXhlFU8K5G9MVGjIFc2v8j1rgUCTywnobuzpZVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4Tmvmx4JVDuDKYU3b8VRkiVQQaqeMOvkQ9h4UBOhnsN8dwHK/mXxsrAaByh4P32S
	 krRam9PmJqtxHU+dmOhx3eC2yHPCEKNX04pJ07DK5o4Tmj2TpzFH1xLGTpmFgBgMDJ
	 ZzskwNwWRAn4x2e+tfliRLbTqB54jXnXtciRXCS/5Esf1GhwOlntLJU1fliIRyfDNR
	 bW8wftX2cTn0Et36gVOIBdmMUA/pc7DtC7BzJbk9UVddevSQl2UXI3smuH8VnOUkUB
	 5r2RM19H8czcGpOywrTEkWIZBKdyJ1fKRYBU3ZmdVrLyx1LuOIDFAhSRP0zWKFO5bt
	 62vNW4yEWWMxA==
Received: from johan by xi.lan with local (Exim 4.94.2)
	(envelope-from <johan@kernel.org>)
	id 1q7Ew4-0006ep-0V; Thu, 08 Jun 2023 14:40:16 +0200
Date: Thu, 8 Jun 2023 14:40:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: vkoul@kernel.org, andersson@kernel.org, yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] soundwire: qcom: stablity fixes
Message-ID: <ZIHMMFtuDtvdpFAZ@hovoldconsulting.com>
References: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
 <ZH2l-UbMyLi5Uwph@hovoldconsulting.com>
 <5d6bcc6a-151e-ac21-2dd2-f72a91f562d5@linaro.org>
 <ZIGpYPrNYDlkRQIf@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIGpYPrNYDlkRQIf@hovoldconsulting.com>
Message-ID-Hash: MM6QGAJ3E6BPQIO7NCNE6ZUS4EHOWSJE
X-Message-ID-Hash: MM6QGAJ3E6BPQIO7NCNE6ZUS4EHOWSJE
X-MailFrom: johan@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MM6QGAJ3E6BPQIO7NCNE6ZUS4EHOWSJE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Jun 08, 2023 at 12:11:45PM +0200, Johan Hovold wrote:
> On Wed, Jun 07, 2023 at 10:36:40AM +0100, Srinivas Kandagatla wrote:

> No, not yet, but I just triggered the above once more after not having
> seen with my latest -rc5 branch for a while (e.g. 20 reboots?):
> 
> [   11.430131] qcom-soundwire 3210000.soundwire-controller: Qualcomm Soundwire controller v1.6.0 Registered
> [   11.431741] wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:4 (ops wcd938x_sdw_component_ops [snd_soc_wcd938x_sdw])
> [   11.431933] wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:3 (ops wcd938x_sdw_component_ops [snd_soc_wcd938x_sdw])
> [   11.435406] qcom-soundwire 3330000.soundwire-controller: Qualcomm Soundwire controller v1.6.0 Registered
> [   11.449286] qcom-soundwire 3250000.soundwire-controller: Qualcomm Soundwire controller v1.6.0 Registered
> [   11.450632] wsa883x-codec sdw:0:0217:0202:00:1: WSA883X Version 1_1, Variant: WSA8835_V2
> [   11.453155] wsa883x-codec sdw:0:0217:0202:00:1: WSA883X Version 1_1, Variant: WSA8835_V2
> [   11.456511] wsa883x-codec sdw:0:0217:0202:00:2: WSA883X Version 1_1, Variant: WSA8835_V2
> [   11.562623] q6apm-dai 3000000.remoteproc:glink-edge:gpr:service@1:dais: Adding to iommu group 23
> [   11.585766] snd-sc8280xp sound: ASoC: adding FE link failed
> [   11.585872] snd-sc8280xp sound: ASoC: topology: could not load header: -517
> [   11.586021] qcom-apm gprsvc:service:2:1: tplg component load failed-517
> [   11.586100] qcom-apm gprsvc:service:2:1: ASoC: error at snd_soc_component_probe on gprsvc:service:2:1: -22
> [   11.586530] snd-sc8280xp sound: ASoC: failed to instantiate card -22
> [   11.591831] snd-sc8280xp: probe of sound failed with error -22
> 
> I don't think I've ever seen it before dropping the runtime PM patch as
> you did in v2, and I hit it twice fairly quickly after dropping it. And
> now again.
> 
> I'm not saying that the runtime PM patch is necessarily correct, and
> perhaps it is just changes in timing that lead to the above, but we
> definitely have a bug here.

I searched my notes and realised that I have seen this once also with
the runtime pm patch. So the fact that happened to see it more often
after dropping it is likely due to changes in timing.

Looking at the above log it seems like we hit a probe deferral somewhere
as some resource is not available yet, and this is eventually turned
into a hard failure that breaks audio as the error is propagated up the
stack.

Johan
