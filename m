Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0187DC43334
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Jul 2022 16:46:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74EC8164E;
	Wed,  6 Jul 2022 18:45:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74EC8164E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657125998;
	bh=UexN+rlmJSiLQCAdT+rimBN77NKCwmVWbryXHRMEbgw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jvo9nKY6dQV7ycCdNeVgdDOrzgxTZaOJsClc2UA283md5e/nArrmIa2Hcx7YZdrPq
	 xyEoWfse5VXGdHrXSBIkiivAPFQXrxaBof6prY+RHPStOb3W1X6/oDMr5aqLAvjaEv
	 F4/GlN75nLmktvDOP1dFdvEA6O24H8GfqsBaAApc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 12F21F8012A;
	Wed,  6 Jul 2022 18:45:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1703CF80104; Wed,  6 Jul 2022 18:45:47 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D04F8F8012A
 for <alsa-devel@alsa-project.org>; Wed,  6 Jul 2022 18:45:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D04F8F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lWVzK7xj"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3B2E561D65;
 Wed,  6 Jul 2022 16:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E07C3411C;
 Wed,  6 Jul 2022 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657125939;
 bh=UexN+rlmJSiLQCAdT+rimBN77NKCwmVWbryXHRMEbgw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lWVzK7xjaV5efxKrA8ESlKU5Z2Gzp5DmgvYQjW9Dv1W/G+ukRRc6SYv6tL/rAXOWS
 EHbtTesPZctKLcXAvNyoJkx2wss1tSORhEzdhFinzOZ0yZC4qwlUtDWpNjvuZvd2KJ
 mTS0Q9MSnMlzM3sOGR6va4Xzwq/uQWBzCToB4DmwL046nZnNlPxBE1vB62Xqqawd+H
 cAbTBHfRS9oHpvM9aVmJ3EryElfNzKVPAVhPbpQZVXpb+S0uXRnufdsbqFvXz9Bbxz
 jV7ghZ+9FSfyMUbnDO31aAmJc4RdFnLO6Kvy+wj+xuEFROMUR7zSyf9UIgHJoi+bDB
 dP6xy2F97CdMA==
Date: Wed, 6 Jul 2022 22:15:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] soundwire: qcom: Check device status before reading devid
Message-ID: <YsW8Lnhu19Wn2fZJ@matsya>
References: <20220706095644.5852-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706095644.5852-1-srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 stable@vger.kernel.org
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

On 06-07-22, 10:56, Srinivas Kandagatla wrote:
> As per hardware datasheet its recommended that we check the device
> status before reading devid assigned by auto-enumeration.
> 
> Without this patch we see SoundWire devices with invalid enumeration
> addresses on the bus.

Applied, thanks

-- 
~Vinod
