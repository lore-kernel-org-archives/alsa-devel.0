Return-Path: <SRS0=kwE8=HI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27217C433DB
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 10:27:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D9A64E30
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Feb 2021 10:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D9A64E30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E03089F6;
	Sat,  6 Feb 2021 11:26:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E03089F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612607266;
	bh=T+7tJ8N28DhBC0FiHzy9b548DcuDktyP9XhUL1tWkYo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FLDM6UbufeW9pEta0kSOvLFW8TvC6g0sTKH0hLK5ItCpqSgI2FDlKKzsDANXAdNBG
	 nklk/6fs5hhFMmNnG3ssz9a5FIrlCXkHgkBIFginSP4UzSq5B8OdJE/mBsP2VO1pkC
	 ObIThLBFV+/RosQzs459kbPhqPVQ60gbM0P5w/C0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5BE43F80095;
	Sat,  6 Feb 2021 11:26:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2F3C7F80171; Sat,  6 Feb 2021 11:26:54 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A93AFF80095
 for <alsa-devel@alsa-project.org>; Sat,  6 Feb 2021 11:26:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A93AFF80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="J/XcP4g/"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CF7B64E30;
 Sat,  6 Feb 2021 10:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612607209;
 bh=T+7tJ8N28DhBC0FiHzy9b548DcuDktyP9XhUL1tWkYo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J/XcP4g/U9mFvg324pexE9yyBaNcn+AX0V2hEa3UcbfSPCsvgmyH5xCpDu3nut+hL
 d4Zp9fhtqx1ieRP2AH7g7A/v1/cxfNckyq9cjYV1mP8Prq1wqAlC3TcRsuWXGmVMNe
 c9bStB+KS3ukTrm7U0BB9RqTkBWpd8LOgSNU/7cFvaAAv25Hbt6LbdhWtNpLf4nBhS
 pJNcISwFvMIso4J5IFFc2P8z6t8qiOF3gmDlGgIMUtyhHc/QEt76DXj6B0VCjRYS4E
 0s3m+s++d9o/TJ9219EpOE2KoTfEqVtCTnZ2OWhjoZkqsvodF/hQ0WSB4nKaKf+PZt
 h6Pdkz7nsSuag==
Date: Sat, 6 Feb 2021 15:56:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [RESEND PATCH v2 0/9] soundwire/regmap: use _no_pm routines
Message-ID: <20210206102644.GN2656@vkoul-mobl.Dlink>
References: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

On 22-01-21, 15:06, Bard Liao wrote:
> When a Slave device is resumed, it may resume the bus and restart the
> enumeration. And Slave drivers will wait for initialization_complete
> complete in their resume function, however initialization_complete will
> complete after sdw_update_slave_status function is finished and codec
> driver usually call some IO functions in the update_status callback
> function.
> It will become a deadlock if we use regular read/write routines during
> the resuming process.

Applied all sdw patches, thanks
-- 
~Vinod
