Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BA2C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 12:04:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F036198B
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 12:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F036198B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC73E86F;
	Mon, 22 Mar 2021 13:03:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC73E86F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616414673;
	bh=mwKIvD3m2a8udoDntSattWkpAVmBGFOPr8WfGq95e5w=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YfPkYBGz1Z+I2fYkFNxtfUOCycXanb5Kc/1MyrwYjOCA1fUBtUm4GCrkoLqTuESb1
	 iX+jWMTAKY7acLWJrJyVDGqm6GX1W7LlZeqjPQ5nEJ2PMa1M4vSOdTbCdL2j91jkVo
	 CT3+6U6hHn/HN5gzYi9zQ9/YluJw0uZilyDxHeLk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FFEDF80107;
	Mon, 22 Mar 2021 13:03:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64DD4F8016B; Mon, 22 Mar 2021 13:03:42 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2F01F80107
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 13:03:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2F01F80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TsCHUKqb"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32F1761998;
 Mon, 22 Mar 2021 12:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616414609;
 bh=mwKIvD3m2a8udoDntSattWkpAVmBGFOPr8WfGq95e5w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TsCHUKqbad1Wh33Bea4g9m/NbKCxtd0quqqHcu+kxT+7QvQ3dHmQ8Ut0hWZKV0V5U
 zwhVGlyg2LmKZzFmMwgYNeSy1gzQ+BGxQrIdeDMGMrrEogIujd39vg18ABIiduyh96
 /LyoBX/DHB+ihdsJOF+kmqERg1HFARqqoKBLj+otOdGwT3Rx8BjhCxL/BDMBDVVAwo
 qxV3aWJr8toqzRFfEvNH2cWL9N67BL+2hv467A4hHpe0RjI3yJxVGrbKgH0lVPq+ig
 h9BApB998sTSVGnQM+9hJYqca/hvcEFAwDoNSmGcl4Z8jtvmxc49NCj31XbjWoA0Si
 uhu4mYL/P88XA==
Date: Mon, 22 Mar 2021 17:33:24 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2 0/3] soundwire: add DMI quirks for overridind addr
Message-ID: <YFiHjPawbh8dId7h@vkoul-mobl.Dlink>
References: <20210302075105.11515-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302075105.11515-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

On 02-03-21, 15:51, Bard Liao wrote:
> Platform firmware may have incorrect _ADR values causing the driver
> probes to fail. Adding the override_ops allows people to override the
> addr values.

Applied, thanks

-- 
~Vinod
