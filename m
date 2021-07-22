Return-Path: <SRS0=+9Uh=MO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8038C6377D
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 14:03:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3659F61244
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 14:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3659F61244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 095A216D4;
	Thu, 22 Jul 2021 16:02:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 095A216D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626962601;
	bh=fCx34pyy5zhmiATs8iVFTMlaCZDb84ZObEWxKW0AAUQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EyY8qFAKXaOMpvnHafweXD7dQJJxWHEfVgbpwg1LlvZdsvbArVsk0CEQ4F1mbdQB9
	 0oYGo06+2fVe55Mww+CaeV3Rbwgoe77hzpZBtLdu6jiVDEv/1e6ChffFg49hIGynDS
	 mSTZ3bvH/mnRzHpI3R2WPaeybz3AQi7iA3i2A0o4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0719F80218;
	Thu, 22 Jul 2021 16:02:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE409F80227; Thu, 22 Jul 2021 16:02:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99754F800DA
 for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2021 16:02:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99754F800DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FjK4UErk"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8F6F61244;
 Thu, 22 Jul 2021 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626962539;
 bh=fCx34pyy5zhmiATs8iVFTMlaCZDb84ZObEWxKW0AAUQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FjK4UErk5KiaCr1k0Iz75UMpe3LVTAPpRuOZqq58OwTFnlnXMJLbAKpfMTEeckvso
 aANEF2pp/rXkpV+NU/3/nrbzGYJuL1wRxEdBAKigHekkZMPtuPjyjdnAVyGvKqM+xc
 wFofBj0i/PqE7U4ioAQnI9guySY3HXc1e5dXlNA0cQXHDLFETCB1LyhxFdML8UjHzd
 TH7PiJqG3mS5PnPqpnf48Ze9hfS9iqsyaJTUsbLicyogs1r5G2OUdIubeA7GhtkDGp
 J+FHY3cv/SE95/umuUE5uQ+S2XeNnm5WGSDS3VUBwg2WHCeQPi1vtHrLneAN1pWlA5
 IbxZs89C/Z5NA==
Date: Thu, 22 Jul 2021 19:32:15 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] soundwire: dmi-quirks: add quirk for Intel 'Bishop
 County' NUC M15
Message-ID: <YPl6Z+jqR9gnTw05@matsya>
References: <20210719233248.557923-1-pierre-louis.bossart@linux.intel.com>
 <20210719233248.557923-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719233248.557923-2-pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 tiwai@suse.de, gregkh@linuxfoundation.org, Rander Wang <rander.wang@intel.com>,
 broonie@kernel.org, Bard liao <yung-chuan.liao@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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

On 19-07-21, 18:32, Pierre-Louis Bossart wrote:
> The same quirk is used for LAPBC510 and LAPBC710 skews who use the
> same audio design.
> 
> These devices have the same BIOS issues inherited from the Intel
> reference, add the same _ADR remap previously used on HP devices.

This fails to apply on rc1, pls rebase or if there are any dependencies,
do spell them out

-- 
~Vinod
