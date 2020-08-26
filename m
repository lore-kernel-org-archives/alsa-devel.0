Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F86C433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:47:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797592071E
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mA19at/+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dih5vfgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797592071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC5811706;
	Wed, 26 Aug 2020 10:46:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC5811706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598431657;
	bh=HoUnL2q1WxrGMZkSItOoLBcbNE9id2blFCNhr5ujsSo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mA19at/+L/bpkHmp624TyLY3FAHR0P0DLQzaw651F0l2EAwe5nOgdwUv/01bFT6fM
	 gTbiSy+o/dJvwy2A3MpDWREKjUfRN1q99PKqxtIMsJFzxSs+wTSa3tuLRpG97tp030
	 x/HASgYL+1McYJbFm1vb5kG5dyLAYjHfiY3OSY3A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83B23F8016F;
	Wed, 26 Aug 2020 10:46:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 99FBBF801D9; Wed, 26 Aug 2020 10:46:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21F9FF80143
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 10:46:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21F9FF80143
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dih5vfgd"
Received: from localhost (unknown [122.171.38.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 33F552071E;
 Wed, 26 Aug 2020 08:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598431600;
 bh=HoUnL2q1WxrGMZkSItOoLBcbNE9id2blFCNhr5ujsSo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dih5vfgd2MSYnjNKJIwqN2EcDZjiYbs4WmUSide/Pmx/pPy68SGTT5MpMvQ2wpIqw
 TISsDTMzie7mChKUidct21AZ1AMPSbh/sYoup4B07jNaMmQhG5QvGAQx436EGER4yw
 DnqW7haaYdXOpEL3cHpWNavOYSSeRzpJojzVu8fQ=
Date: Wed, 26 Aug 2020 14:16:35 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2] soundwire: intel: fix intel_suspend/resume defined
 but not used warning
Message-ID: <20200826084635.GX2639@vkoul-mobl>
References: <20200824133234.28115-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200824133234.28115-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
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

On 24-08-20, 21:32, Bard Liao wrote:
> When CONFIG_PM_SLEEP is not defined, GCC throws compilation warnings:
> 
> drivers/soundwire/intel.c:1799:12: warning: ‘intel_resume’ defined but not
> used [-Wunused-function]
>  static int intel_resume(struct device *dev)
>             ^~~~~~~~~~~~
> drivers/soundwire/intel.c:1683:12: warning: ‘intel_suspend’ defined but not
> used [-Wunused-function]
>  static int intel_suspend(struct device *dev)
>             ^~~~~~~~~~~~~
> 
> Fix by using __maybe_unused macro.

Applied, thanks

-- 
~Vinod
