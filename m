Return-Path: <SRS0=FVIg=OV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150F9C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 04:25:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2160B61A40
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Oct 2021 04:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2160B61A40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AEB416E2;
	Fri,  1 Oct 2021 06:24:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AEB416E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633062304;
	bh=yPLO6sbNbrqRSdQVyGY0+tjRtqQaJKTwoi57bTd853k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p2inCkvTEBSiPRLUKIMP8+HePCiGNa8q0NBIDF0FK0JACN8MID1l0BlPCiMksvdna
	 FavmDr/aPdLf2yPWqkr7fRbVliQ7JxflQNq1EsDTLiX6fE+nM1ZdFSL2oSJYVqMXtQ
	 df9fx2dLsgq3wo+L9pBYpFKm4f76kYTz8PvO8y0A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CDA7F80227;
	Fri,  1 Oct 2021 06:24:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32880F80245; Fri,  1 Oct 2021 06:24:11 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F05BAF800F3
 for <alsa-devel@alsa-project.org>; Fri,  1 Oct 2021 06:24:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F05BAF800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="e0XOw8ZT"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83DD3619F8;
 Fri,  1 Oct 2021 04:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633062239;
 bh=yPLO6sbNbrqRSdQVyGY0+tjRtqQaJKTwoi57bTd853k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e0XOw8ZTUdtwwELC3AtLEiizytz7XGc5A3HDFi8RP8mGO6UVkZ5KCwfYHyRm8jzRU
 GFwAmXSsYsJg6sBmtAgxB7rSRZXaEclMZ/M6JgysifZXxzoiUndBFY8MiiW+m+HZkv
 3532b3ikJLxYD/RNfMuw14fqgX9XEKe/Ndk8AAdzc8hu1iHhKwheYmn3bY8mPfXS3O
 usZIWOIsgQVz8A/qa4E/WbMgW4baaTKAMxjI2MMO939ZOJycnL14jPQwfOd7sRoVQl
 hxc2I0Q/rvObtYKZZGCO/Lh+9kRY2O8FytqxPIF+fDwPzhF0yzjciqR5stM4WSVYIC
 e23JeTzP+hBEQ==
Date: Fri, 1 Oct 2021 09:53:55 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2] soundwire: debugfs: use controller id and link_id for
 debugfs
Message-ID: <YVaNW1MuotWqakyK@matsya>
References: <20210907105332.1257-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907105332.1257-1-srinivas.kandagatla@linaro.org>
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

On 07-09-21, 11:53, Srinivas Kandagatla wrote:
> link_id can be zero and if we have multiple controller instances
> in a system like Qualcomm debugfs will end-up with duplicate namespace
> resulting in incorrect debugfs entries.
> 
> Using bus-id and link-id combination should give a unique debugfs directory
> entry and should fix below warning too.
> "debugfs: Directory 'master-0' with parent 'soundwire' already present!"

Applied, thanks

-- 
~Vinod
