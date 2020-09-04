Return-Path: <SRS0=A1sP=CN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E58C43461
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:22:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A4420770
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HAVANRoh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeOGLj7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A4420770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C235916BF;
	Fri,  4 Sep 2020 11:21:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C235916BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599211358;
	bh=Uov920rjggCvYvSHnag6kknZPh9YIjInm05otcT8li8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HAVANRohLwk4BWo9u8fWpvkz87l1C1w4dZjYb+1eNINJBF0W0AgE4zl34Dr4bMhpJ
	 gEwbT8L5UyU8YMLWQxwuhDAMiIJBx3F/BMqGrwJ2838mVyxKQfSH8yNjQt2kWEaVCq
	 Qj6LvuRZyk57cgX74PWRl8AjTN5OvxEeFa7MjCGI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 614CFF800F0;
	Fri,  4 Sep 2020 11:21:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7584BF8024A; Fri,  4 Sep 2020 11:21:47 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7388AF801DA
 for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2020 11:21:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7388AF801DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QeOGLj7I"
Received: from localhost (unknown [122.182.253.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1743120770;
 Fri,  4 Sep 2020 09:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599211300;
 bh=Uov920rjggCvYvSHnag6kknZPh9YIjInm05otcT8li8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QeOGLj7IoYNesH1dl//AFVm4t4un4mRiYV0epBQ3cFVUl1+POkVmoZKpvBWwhpBJP
 xVjHV2DG/dXJcyOOO6Hnx7geln7Q5Mros1J1fGexFxS2RDVkPHlzPqI9mG1Kedvs9l
 vnu76oFTeGRVLMyg2wo+KXo/aDt2Y7CEjBVhpJro=
Date: Fri, 4 Sep 2020 14:51:35 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2 0/4] soundwire: Remove sdw stream operations from Intel
Message-ID: <20200904092135.GY2639@vkoul-mobl>
References: <20200903204739.31206-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903204739.31206-1-yung-chuan.liao@linux.intel.com>
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

On 04-09-20, 04:47, Bard Liao wrote:
> Sdw stream operation APIs can be called once per stream. Move these
> operations to dailink ops. The linked series is "ASoC: Add sdw stream
> operations to dailink ops".

Applied all, thanks

-- 
~Vinod
