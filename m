Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F85C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Apr 2022 04:18:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1CC4A1703;
	Tue,  5 Apr 2022 06:17:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1CC4A1703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649132300;
	bh=KCPGLPVeH6NYTKvdtiGBtcJRWw93SSF1I3156qmZZSM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FRXtKLmmZEvnugK4SQ7obbvzYbisE+Vg+NeG/MYPiC879OBUZDAnEec1jl6QBvxKc
	 gbwFoGWZArxPMSBqb/axXBMjraIC8F+N0+J54d3xwzv9gASp/Yqk5jA1AR3qvqPYOb
	 IXAKhOT86hbo1V31NMH7DX0pB1DVKspHXlGEEmUY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B18A7F8014B;
	Tue,  5 Apr 2022 06:17:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96B81F8016B; Tue,  5 Apr 2022 06:17:27 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12121F8016A
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2022 06:17:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12121F8016A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QVwAnVKd"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DE950B81B7D;
 Tue,  5 Apr 2022 04:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCF7C340F0;
 Tue,  5 Apr 2022 04:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649132242;
 bh=KCPGLPVeH6NYTKvdtiGBtcJRWw93SSF1I3156qmZZSM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QVwAnVKdmrWaK0a/L7PZoNplSCX1Y7xJ2q3ES1fA6a+owx43D7XQ80+BCiWLUUPrn
 ph3OJTwN+MqWw85S+HQXSJ4rOrTIPan2Uaymd64QPTpjNqFnOWJ5dMuE2ns+/1WEo2
 nl62VqxlWyc4YKy82ppGGnQZd2idxD6Y5BKjueAd11a2sgURGMZi+GAMOKsEeXZvIT
 m6MHO6FTUFPjsj97zkEx/UsySW5csN6hBW2s6fxcZSMdGNDQUiFvzixym59uKjeOJS
 FaFYt819xFCAGo8wJG8aaeA+Q5aovyeVNODa+oL2d9Z0Sa41zoetW+NgVEB3HiUs9O
 0x26KECI1U2kA==
Date: Tue, 5 Apr 2022 09:47:18 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] soundwire: qcom: fix an error message in
 swrm_wait_for_frame_gen_enabled()
Message-ID: <YkvCzlU5/KuKE1rS@matsya>
References: <20220307125814.GD16710@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307125814.GD16710@kili>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <agross@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

On 07-03-22, 15:58, Dan Carpenter wrote:
> The logical AND && is supposed to be bitwise AND & so it will sometimes
> print "connected" instead of "disconnected".

Applied, thanks

-- 
~Vinod
