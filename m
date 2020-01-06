Return-Path: <SRS0=qF1Q=23=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA364C32767
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jan 2020 05:33:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC78215A4
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jan 2020 05:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AMW05gi4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhGYzVtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC78215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B9341711;
	Mon,  6 Jan 2020 06:32:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B9341711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578288816;
	bh=RoaDNJFkzBi8fN8zZO2evt9/xdL9VAC9H1iu1EMl/xc=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AMW05gi4gBL7jG9hN6NIrTaZM3mVJAprSIsbr2w20kvpL/RTLp6J2OlZ2ZFI9VQ5S
	 6yxNn6vR46ucQjKvKG3IuRuANqF2TpFcAd3gy47ICPGhgz50b54JqGYq69USn2de0l
	 Tn0+/3xTo4TulJHDR4jNCqKK562Tojg0uyAOuNxo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08E03F80149;
	Mon,  6 Jan 2020 06:32:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AAF85F80159; Mon,  6 Jan 2020 06:32:44 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A255BF8010C
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2020 06:32:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A255BF8010C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PhGYzVtI"
Received: from localhost (unknown [117.99.94.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 24DEF215A4;
 Mon,  6 Jan 2020 05:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578288759;
 bh=ec9ZGMCF/7dfhER2aWnXsCMCvBv3Cw5Zbedx2vWhQ7U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PhGYzVtIn/DFhU30uV0fPfiiyIb3S+jFzuVyumq1Qzyg+9fMWa9IoR2Q8B12Rv2Sp
 0kha2EpCTe88rlkV225h4stHBySL8NJdkEir+Fmivx7NyzAuNSm/z7UNN+wWByBdX/
 qfmLZJXns85b1Do1rj8LQdY5lkaZ5N2vXfrq3oZA=
Date: Mon, 6 Jan 2020 11:02:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20200106053234.GM2818@vkoul-mobl>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
 <20191217210314.20410-9-pierre-louis.bossart@linux.intel.com>
 <20191227071433.GL3006@vkoul-mobl>
 <1922c494-4641-8c40-192d-758b21014fbc@linux.intel.com>
 <20191228120930.GR3006@vkoul-mobl>
 <820dbbcd-1401-4382-f5a2-9cdba1d6fcd5@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <820dbbcd-1401-4382-f5a2-9cdba1d6fcd5@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v5 08/17] soundwire: add initial
 definitions for sdw_master_device
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

On 02-01-20, 11:36, Pierre-Louis Bossart wrote:

> Would this work for you if we used the following names:
> 
> sdw_slave (legacy shortcut for sdw_slave_device, which could be removed in a
> a future cleanup if desired).
> sdw_slave_driver
> sdw_master_device
> sdw_master_driver
> 
> and all the 'md' replaced by the full 'master_device'.

That does sound nicer, thanks

-- 
~Vinod
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
