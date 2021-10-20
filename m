Return-Path: <SRS0=Jips=PI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE5CC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Oct 2021 15:26:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6723361359
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Oct 2021 15:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6723361359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A10EA168F;
	Wed, 20 Oct 2021 17:25:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A10EA168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634743563;
	bh=4at9laVcHUrA2VynzjrHKUHCmy2i6sSQIhtzKA3Gtr0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TFIUmApRJM1LQOypgF8Bay1LnjvSvFU9Nv97XandqD3L2qtL8caUzWd+rqHnJm6lp
	 InfeguPCSjXTgHlRcWnRbpYaCep3Ua5uncbzG3QPBTyoEbyx+xN5BHXiDcxMZqle/d
	 Ly6vMjn5mV38NPIaeWLta5WBrjbeOiQAIdGI2k9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4780AF80224;
	Wed, 20 Oct 2021 17:24:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97FD2F802DF; Wed, 20 Oct 2021 17:24:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F6DAF80224
 for <alsa-devel@alsa-project.org>; Wed, 20 Oct 2021 17:24:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F6DAF80224
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ha8tHPUk"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2EC061355;
 Wed, 20 Oct 2021 15:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634743471;
 bh=4at9laVcHUrA2VynzjrHKUHCmy2i6sSQIhtzKA3Gtr0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ha8tHPUkUoXsE7OF4EzLXaUq2+Oj+uD6MqGbVGphBKQqbnu8/YLI+Jqjk5DWEV6lo
 F2ZnpDpjTyS1FJjn3Cp+31ZqVIYsolNtASCGYmS8CgxGvXM2Q7UZokFG9DssH+ENKn
 LYTiDaJeHUMGefkaK0LKJEEMeCq5tuV/TVTK7Qdo0YVaLOd476mMtxtOUcXqQsbJaH
 mm+8nkYnDa4J9EAOc8gdbTGw/yR8Cbpi36o4CkYLag+VKLTABwzO6uwNzgOrqgk3Jm
 b0T5KjXyzNsvhVBhuALSg+57mB8eapOsiQco1BAls+deRSjVECEsH0xFJeThYao7mq
 8bUOYBsNWdVAQ==
Date: Wed, 20 Oct 2021 20:54:27 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] soundwire: qcom: add debugfs entry for soundwire
 register dump
Message-ID: <YXA0q+3ER3zFpyOw@matsya>
References: <20210907105636.3171-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907105636.3171-1-srinivas.kandagatla@linaro.org>
Cc: sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

On 07-09-21, 11:56, Srinivas Kandagatla wrote:
> For debug purposes add an entry in debugfs to dump Qualcomm
> SoundWire Controller registers.

Applied, thanks

-- 
~Vinod
