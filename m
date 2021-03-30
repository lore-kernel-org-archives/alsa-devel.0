Return-Path: <SRS0=2x8D=I4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D01C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 17:26:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D35619D0
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 17:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D35619D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 61DD41675;
	Tue, 30 Mar 2021 19:25:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 61DD41675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617125196;
	bh=ePSuJ8ma3WpYWbEYHTIMeW/KYbq45titohW1Q7tiVr0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fmmMOadQMNO5XqnHtZ7lI01lp5CUO9ztPl7EvM8Hw8fU+LjsWt5E701D8RqKaG4Xs
	 KVZghnck3fjrqOo3KiIc4CG4pGDOgcMGQr0bdz1BNbZl1GoQME4sVKLM+BkU6wPUBk
	 ipM5gLgEJDhbW+VU2ryeP4aUxKt3WoSjCOOIcDmo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF383F80240;
	Tue, 30 Mar 2021 19:25:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5BB5F8026B; Tue, 30 Mar 2021 19:25:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 570DAF800B9
 for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2021 19:25:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 570DAF800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KwuUtHZb"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4607619CD;
 Tue, 30 Mar 2021 17:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617125137;
 bh=ePSuJ8ma3WpYWbEYHTIMeW/KYbq45titohW1Q7tiVr0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KwuUtHZbz2yvKjdswt8BJBz5YKVW90Dd9TM+Qru9XS+lpxpq9ycmk90bgvwRpgpDS
 lk+Tf6NXTZz6naWbv2IrWmnWHgOcwDKR+iiS0gtp94UwVRX4ryiiVRqA1v9uSUJNNG
 P2FLglHf/TyN1L1pnJt5GUCSVQHLTgePMFrtYMN7CFTPn61tDCtd8QiDfp61+hCpYl
 lT9WdmLgzL6nXRusfag2jJ6sk+oyRgMXqTIqLCCS5ZP/UywrUHs3ofVLtnpxxEPy2+
 +R/hS+cbsN0uNDQbxZrZNlU5BpuybIskgafPQdzT58HUGUz9EGCf6SU66AAUi86vAo
 G99zYmJOY3GiQ==
Date: Tue, 30 Mar 2021 22:55:33 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v6 0/9] soundwire: qcom: various improvements
Message-ID: <YGNfDUV5GO/kYQ2R@vkoul-mobl.Dlink>
References: <20210330144719.13284-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330144719.13284-1-srinivas.kandagatla@linaro.org>
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
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

On 30-03-21, 15:47, Srinivas Kandagatla wrote:
> Thanks for reviewing v5 of this patchset!
> 
> During testing SoundWire controller on SM8250 MTP, we found
> few issues like all the interrupts are not handled,
> all transport parameters are not read from device tree.
> Patch to add Auto Enumeration supported by the controller
> is also part of this series.
> 
> Other major issue was register read/writes which was interrupt based
> was an overhead and puts lot of limitation on context it can be used from.
> 
> With previous approach number of interrupts generated
> after enumeration are around 130:
> $ cat /proc/interrupts  | grep soundwire
> 21: 130 0 0 0 0 0 0 0 GICv3 234 Edge      soundwire
>     
> after this patch they are just 3 interrupts
> $ cat /proc/interrupts  | grep soundwire
> 21: 3 0 0 0 0 0 0 0 GICv3 234 Edge      soundwire
> 
> So this patchset add various improvements to the existing driver
> to address above issues.
> 
> Tested it on SM8250 MTP with 2x WSA881x speakers, HeadPhones on
> WCD938x via lpass-rx-macro and Analog MICs via lpass-tx-macro.
> Also tested on DragonBoard DB845c with 2xWSA881x speakers.

Applied, thanks

-- 
~Vinod
