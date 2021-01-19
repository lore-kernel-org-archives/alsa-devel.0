Return-Path: <SRS0=kxA9=GW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63933C433E6
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jan 2021 14:53:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CA72312E
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jan 2021 14:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CA72312E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94CFD18A0;
	Tue, 19 Jan 2021 15:52:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94CFD18A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611068013;
	bh=rw/mxQTxKjzM1IS9HMGj4yUmYRQZgEBUAvLh9y86vqk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=taSL5cvJE1U/L1pS8Q6UxD7IjVYFV6gl+yLunG9AqdLWzvc7oXxVSSwh1iHjhhRL2
	 sEh/sJ1I28zlKAe4xHe9iLegn87HLQ9tW7Z18fe1QBO1AO3DpMugP5CHQKGBMiwSrO
	 05jOC9L3+UtPcC5+6D5TIP0QqtJtslGbID0BTI78=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 767CFF804C2;
	Tue, 19 Jan 2021 15:52:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6837CF804C3; Tue, 19 Jan 2021 15:52:32 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1D0EF802BE
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2021 15:52:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1D0EF802BE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="K74/TcaN"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51FD220DD4;
 Tue, 19 Jan 2021 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611067946;
 bh=rw/mxQTxKjzM1IS9HMGj4yUmYRQZgEBUAvLh9y86vqk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K74/TcaNS0ofDl+B4nzdtA6Wp4i05o78R3yak6X+99V6+bHJo9EY1HOJjgKicEOem
 H3hsbojZ68Eoz33O7jArZNyn94fqogYXFdGnHqYYrgHC7bbE0nwsvFMJQeJCqFCfv5
 zr0bhO3aXsyQq8ZmBEfa/uZ3aAOumXqb8eBIoiJfyClIK23k3F00ElUu2/HYxTf7Er
 0mM6CtNrc5oj2j9zwTjfCFuQOzXc6ep8fuifOOJu39B8l//hTf8dkTVtWYJQvL/yI9
 QiM7cJjwthPR6wvrBm3dqWhPAyDtPvYvzUV4EKjRRoFK9iAxI4SRdo1czmu6cG3wkz
 wP7tLP1Lv7kzQ==
Date: Tue, 19 Jan 2021 20:22:20 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
Message-ID: <20210119145220.GS2771@vkoul-mobl>
References: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
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

On 15-01-21, 16:25, Srinivas Kandagatla wrote:
> link_id can be zero and if we have multiple controller instances
> in a system like Qualcomm debugfs will end-up with duplicate namespace
> resulting in incorrect debugfs entries.
> 
> Using id should give a unique debugfs directory entry and should fix below
> warning too.
> "debugfs: Directory 'master-0' with parent 'soundwire' already present!"

Yeah id is guaranteed to be unique so this will work.

Applied, thanks

-- 
~Vinod
