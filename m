Return-Path: <SRS0=Ovzg=4N=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306FCC35DF9
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:28:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72FE20714
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lMKyM7i2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UszBqyn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72FE20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 087AB1655;
	Tue, 25 Feb 2020 11:27:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 087AB1655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582626516;
	bh=c11I1+aXz7I861UYGuPVDLiwVXB6TbdIH+RT/RHaxf8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lMKyM7i2q/26W5a1TksISEYRGWBmiQ97cDiTDYabovG7rIFI6htiQg4ysU8SlafPH
	 H9PfyPbHoBWrO22bqzRCHCQIwntIEGtxZwOXQGYnq3XU5MCv9VCI/dTq5HljvwtOfC
	 FWQ2FUFLuc3IIVJ8QUWVxUc6v/UOn3Kh5gIdplOQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C68CF8013E;
	Tue, 25 Feb 2020 11:27:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C71CAF80142; Tue, 25 Feb 2020 11:27:43 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DE30F800AD
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2020 11:27:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DE30F800AD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UszBqyn5"
Received: from localhost (unknown [122.167.120.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E2A1220714;
 Tue, 25 Feb 2020 10:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582626458;
 bh=c11I1+aXz7I861UYGuPVDLiwVXB6TbdIH+RT/RHaxf8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UszBqyn5y1O3RMhXxzYd9ILQv5H/sSSXmlq0iAC6KbeivREBvpzR4imZ4qfAjx9/I
 Z++3G+BqHAeKqaBSQ/FSXW2eHESMmfYQbOL4I20TyEVWi+7Q/o42N1ugel1BeMxFXm
 AThdATN3CaDXnYWB72W8o8sFgQFDalyzLX+lPbk0=
Date: Tue, 25 Feb 2020 15:57:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/10] soundwire: bus: fix race conditions, add
 suspend-resume
Message-ID: <20200225102734.GO2618@vkoul-mobl>
References: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
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

On 14-01-20, 18:08, Pierre-Louis Bossart wrote:
> The existing mainline code for SoundWire does not handle critical race
> conditions, and does not have any support for pm_runtime suspend or
> clock-stop modes needed for e.g. jack detection or external VAD.
> 
> As suggested by Vinod, these patches for the bus are shared first -
> with the risk that they are separated from their actual use in Intel
> drivers, so reviewers might wonder why they are needed in the first
> place.
> 
> For reference, the complete set of 90+ patches required for SoundWire
> on Intel platforms is available here:
> 
> https://github.com/thesofproject/linux/pull/1692
> 
> These patches are not Intel-specific and are likely required for
> e.g. Qualcomm-based implementations.
> 
> All the patches in this series were generated during the joint
> Intel-Realtek validation effort on Intel reference designs and
> form-factor devices. The support for the initialization_complete
> signaling is already available in the Realtek codecs drivers merged in
> the ASoC tree (rt700, rt711, rt1308, rt715)

Applied all, thanks

-- 
~Vinod
