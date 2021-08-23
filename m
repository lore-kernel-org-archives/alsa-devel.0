Return-Path: <SRS0=lo3o=NO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50CDC4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 12:14:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5276138F
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 12:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DB5276138F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0FC21616;
	Mon, 23 Aug 2021 14:13:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0FC21616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629720870;
	bh=rXa58bEpK1TJTYaskl8eajtA23xdKsOQ8KdDNB4UIi4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E8H9BgbtnAC4QYcBn2R4cGmIJT+v9m3xepJrYMc/ssMUwTcx1kbHhrXsLqnGWH4Ul
	 O6r3UnNSWuoukpvpBVDXEyiIGoInSiZ5jKdA4d1o4BolgMH2p7H/7m0A5F74oQprw1
	 Gttq3D2noEiSMVoAMCBYQS6pl2arWMB8G+M9+Spg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFCC8F80240;
	Mon, 23 Aug 2021 14:13:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 831CAF80424; Mon, 23 Aug 2021 14:13:11 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 214ACF800B6
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 14:13:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 214ACF800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="At2fhNL3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB4236137F;
 Mon, 23 Aug 2021 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629720779;
 bh=rXa58bEpK1TJTYaskl8eajtA23xdKsOQ8KdDNB4UIi4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=At2fhNL3DlA6ciYyIrmGX5vZ/Zgsqv+G0RarW3YcBcxat64UzdzoKTZWaKxQEIO6+
 XBRV/QB08brgm8qUGlX9QpwY9/rmFHF2ZgISRFvPJTOYoSfLuL7/oGB/SawLMGtdoT
 ntANYVR9K7Kd3AgWNFzZjmrafQRgS+7ez79IcJ47MmbYEq1JFE/JDkKrQpAEFmz8+I
 GP+sM94ht9Mao6aAyRHHu29Tzw5kYpmXO2+8uuB6oes1FCznQssVKtuwBOgr6/tqum
 hpcp9Xo+aX+lcXWa1Okx100oT/Xpxg45y8pdc5y0QFGoXOAp7VsOcwxW0sNhVUjjPL
 QpASYVXPRrSvg==
Date: Mon, 23 Aug 2021 17:42:54 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: cadence: do not extend reset delay
Message-ID: <YSOQxk7qHaj184J1@matsya>
References: <20210818030130.17113-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818030130.17113-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 sanyog.r.kale@intel.com, bard.liao@intel.com
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

On 18-08-21, 11:01, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The duration of the hw_reset is defined as 4096 cycles. The Cadence IP
> allows for an additional delay which doesn't seem necessary in
> practice: the actual reset sequence duration is defined by the sync_go
> mechanism, not by the IP itself.

Applied, thanks

-- 
~Vinod
