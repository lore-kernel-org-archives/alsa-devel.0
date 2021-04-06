Return-Path: <SRS0=qvmA=JD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D09C433ED
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 04:56:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7246E613B8
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 04:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7246E613B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B63B16CB;
	Tue,  6 Apr 2021 06:55:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B63B16CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617684964;
	bh=3oXESt8oQgiKW/qAWnzICznc5KQKnQJ+Fw+d+XpBiUE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JofVEqLr1rIaRsADDaD56NxBGCSaqIDtdhAQF8M6xCQNhFlvlhc0gqdoWocD5LPxA
	 r+iyvgysGopgwoIgSj7Mu3VlIz+bDhIllOJSqCysMbE5a2Zoxuw3RvOgGwbMR0tdQX
	 SYxMY+eWoNvKtTyS83D0lbHlECouoiygljkYS4ns=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C65FF8020B;
	Tue,  6 Apr 2021 06:54:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B4F1F80258; Tue,  6 Apr 2021 06:54:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7B1BF80124
 for <alsa-devel@alsa-project.org>; Tue,  6 Apr 2021 06:54:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7B1BF80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ISUXBIjE"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DC88613B7;
 Tue,  6 Apr 2021 04:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617684875;
 bh=3oXESt8oQgiKW/qAWnzICznc5KQKnQJ+Fw+d+XpBiUE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ISUXBIjEtAuFGdfzBV8TvLh/0Kd1Xv1bB2XY2PGlKDxOsfdHlAnpU13cJv1hBDpf2
 6DXbaixwTlj+LaGvXqwFrmJt9fXOO/9GeZ5T8fBhYMF6jl/xeCiPvAmfsL5aLunqYW
 PKJVZIQQWXv4t9r50kUqv1KXByTR8fdk77i1TKlP51MWi5TlYwii6DK0J/LBKT0ofO
 G3rcF/be7Rqz8GmBkdUDKfoQ7fBGJjGXOFPxxbhSDBnYVg5eNO2muYbdIqUS9Zh0DN
 2APB0OrjOxkHOqZjCWHemaiBgiZv/KnIXwJTXBlWWCDIjQWiYXgTu5ls3CtpZI/Z62
 QwRWYfMPjtecg==
Date: Tue, 6 Apr 2021 10:24:31 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2] soundwire: qcom: wait for fifo space to be available
 before read/write
Message-ID: <YGvph03m7w5DbATC@vkoul-mobl.Dlink>
References: <20210401090058.24041-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401090058.24041-1-srinivas.kandagatla@linaro.org>
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

On 01-04-21, 10:00, Srinivas Kandagatla wrote:
> If we write registers very fast we can endup in a situation where some
> of the writes will be dropped without any notice.
> 
> So wait for the fifo space to be available before reading/writing the
> soundwire registers.

Applied, thanks

-- 
~Vinod
