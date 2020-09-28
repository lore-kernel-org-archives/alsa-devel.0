Return-Path: <SRS0=2Byq=DF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DA2C2D0A8
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 05:50:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19EA920774
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 05:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TFKchrw1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja+P0jxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19EA920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A9121AED;
	Mon, 28 Sep 2020 07:49:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A9121AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601272239;
	bh=DZwNX7Zm7AQR4iYmxgQo4rofJ2VIk5bvpkNSoYmOCxc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TFKchrw1Oza3BtrQT8XRI8N0CIbnnz8jqkSLAMvq/ChF31auUHOh2adLtrpMncixq
	 8J1KTvceenTgSZzn1ibDeNpH9D14iWE3cTLRDGgjn/ZAYjcgUAR8PU6tm2DMQslQjj
	 09wuI/fEv+ZIJ4dL3Mln7LLvUKYTcJvadVjhqI0Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8CB6F80115;
	Mon, 28 Sep 2020 07:49:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7DC5F801F9; Mon, 28 Sep 2020 07:49:47 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FCF9F800DF
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2020 07:49:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FCF9F800DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ja+P0jxP"
Received: from localhost (unknown [122.179.43.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1E17F2068E;
 Mon, 28 Sep 2020 05:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601272174;
 bh=DZwNX7Zm7AQR4iYmxgQo4rofJ2VIk5bvpkNSoYmOCxc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ja+P0jxPMmj/pz97W1p9rHlsI9o7u08LpR7gBW+v8unF3/b/FfgypDB2d/KRcmgX7
 ubZbVcvqrfGkcdsWSjoAHiCnGty5IfYCZNqOx7N2M9SJy6ybF4CjLrSuwaLO3FEV4C
 JGY8oAQfIpL3W0o7DIYGzd9JclAN+f74G6HbnMz0=
Date: Mon, 28 Sep 2020 11:19:22 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 0/2] soundwire: sysfs: expose device number and status
Message-ID: <20200928054922.GI2968@vkoul-mobl>
References: <20200924194430.121058-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924194430.121058-1-pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

On 24-09-20, 14:44, Pierre-Louis Bossart wrote:
> This patchset combines three contributions:
> 
> Srinivas Kandagalta suggested creating a device even it's detected on
> the bus but not described in platform firmware. I suggested adding the
> device number and status to show the difference with 'ghost' devices,
> described in firmware but not physically present. Vinod suggested a
> simpler way to report the status.
> 
> I did not keep Vinod's patch separate since it was using the same
> group attribute as the other properties, which prevents status and
> device number from being reported if there is no firmware and no
> driver.
> 
> These patches were tested on Qualcomm and Intel platforms.

Applied, thanks

-- 
~Vinod
