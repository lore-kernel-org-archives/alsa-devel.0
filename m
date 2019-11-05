Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93C0C17460
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:24:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B3E217F5
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 14:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HXs4RhiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B3E217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9813816DC;
	Tue,  5 Nov 2019 15:23:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9813816DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572963879;
	bh=Vmfw5DaU08o2LolnC482uET6oyDCpeG4hJgPRxYRtS0=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HXs4RhiW8fvhflOQBapRmwz9js8gx4j2CgStXlRv5+6SR2psq/VtjqYFnogmdiWVP
	 /09nL//2Dhc18y8LBh8wPWOT9jmU+owO+ZYpx/16PcNaNd0hFT8jY6AnM/BJ/3y4oD
	 eayx8UPiFQkyIPwzOzbyUfuGVENV4VMhkDgKT0eg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B067F80446;
	Tue,  5 Nov 2019 15:23:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85492F8049B; Tue,  5 Nov 2019 15:23:47 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93C53F8015B
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 15:23:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93C53F8015B
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Nov 2019 06:23:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; d="scan'208";a="195833804"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by orsmga008.jf.intel.com with ESMTP; 05 Nov 2019 06:23:38 -0800
Date: Tue, 5 Nov 2019 16:23:37 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Yong Zhi <yong.zhi@intel.com>
In-Reply-To: <1572905399-22402-1-git-send-email-yong.zhi@intel.com>
Message-ID: <alpine.DEB.2.21.1911051611370.16459@zeliteleevi>
References: <1572905399-22402-1-git-send-email-yong.zhi@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 ryans.lee@maximintegrated.com, pierre-louis.bossart@linux.intel.com,
 broonie@kernel.org, sathyanarayana.nujella@intel.com, daniel.baluta@nxp.com
Subject: Re: [alsa-devel] [PATCH v2] ASoC: max98373: replace gpio_request
 with devm_gpio_request
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

Hi,

On Mon, 4 Nov 2019, Yong Zhi wrote:

> Use devm_gpio_request() to automatic unroll when fails and avoid
> resource leaks at error paths.

this is a bugfix still, so maybe reword as:

Fix resource leaks on error paths by using devm_gpio_request().

> Signed-off-by: Yong Zhi <yong.zhi@intel.com>
> ---
> v2 change:
> - use devm_gpio_request to avoid the goto statement based on review comments.

All in all, looks good, move to devm_ is even better!

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
