Return-Path: <SRS0=58lj=CZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF216C2BB84
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:50:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CE22225F
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hU/3oQgY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rk0IbZhm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CE22225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA621850;
	Wed, 16 Sep 2020 16:49:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA621850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600267797;
	bh=xciECLeowjq9oRm5zSpSaLEMfjQl3cjS16SOJpmO/h4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hU/3oQgYjj2rNQItVEsW2t9fZ8xt2AXVCiQ2xjKhaoJ4j1Ff5lKpZJOKOSdwPQkYZ
	 wQbtkqFh1AzQkCs5LEHwU7EBrpZcV8taEp7tg8lsx/195hOfMzOhz8kXUEURCf7AxZ
	 QyjpzF3yUo4+olWReaEgvVstciu82yOXZqv6SCus=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3792DF80150;
	Wed, 16 Sep 2020 16:49:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72DA9F8015A; Wed, 16 Sep 2020 16:49:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C7D0F800BB
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2020 16:49:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C7D0F800BB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rk0IbZhm"
Received: from localhost (unknown [122.172.186.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4389F206B6;
 Wed, 16 Sep 2020 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600267741;
 bh=xciECLeowjq9oRm5zSpSaLEMfjQl3cjS16SOJpmO/h4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rk0IbZhmcjCCVrlZD0ocwFS4EDzxXZOajRd7LCMMZBzcOOU7iQStzKL4xNIogEJQB
 CZvsgOQ6+TLv8BVcwb18Ade8Stb1tL2cp3NnrxqKRQ7ENW2DQWJnFMUHGGygMSqZGB
 6VeqVJcZKJ5tMl4/nKvY5rD0Dl2aZcP0bUeI3Nbc=
Date: Wed, 16 Sep 2020 20:18:52 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/3] soundwire: qcom: clear BIT FIELDs before value set.
Message-ID: <20200916144852.GS2968@vkoul-mobl>
References: <20200916092125.30898-1-srinivas.kandagatla@linaro.org>
 <20200916092125.30898-2-srinivas.kandagatla@linaro.org>
 <20200916124634.GM2968@vkoul-mobl>
 <24401c7c-b12c-0924-9d8f-fde633d15918@linux.intel.com>
 <20200916142929.GR2968@vkoul-mobl>
 <42bbf464-2bc9-2b13-5f08-a19ad1848277@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42bbf464-2bc9-2b13-5f08-a19ad1848277@linux.intel.com>
Cc: yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On 16-09-20, 09:36, Pierre-Louis Bossart wrote:
> 
> 
> On 9/16/20 9:29 AM, Vinod Koul wrote:
> > On 16-09-20, 08:18, Pierre-Louis Bossart wrote:
> > > 
> > > > > According to usage (bitfields.h) of REG_FIELDS,
> > > > > Modify is:
> > > > >     reg &= ~REG_FIELD_C;
> > > > >     reg |= FIELD_PREP(REG_FIELD_C, c);
> > > 
> > > 
> > > if this is indeed the case, all the code in cadence_master.c is also broken,
> > > e.g:
> > > 
> > > 	dpn_config = cdns_readl(cdns, dpn_config_off);
> > > 
> > > 	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_WL, (p_params->bps - 1));
> > > 	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_PORT_FLOW, p_params->flow_mode);
> > > 	dpn_config |= FIELD_PREP(CDNS_DPN_CONFIG_PORT_DAT, p_params->data_mode);
> > 
> > This should be replaced with u32_replace_bits(), i am sending the fix
> 
> wondering if we should replace all uses of FIELD_PREP with either
> u32_insert_bits() or u32_encode_bits() then?

That might be overkill as in the rest of the cases we have

        foo = FIELD_PREP();
        foo |= FIELD_PREP();

so the first one would set the bitfield and clear the rest

Thanks
-- 
~Vinod
