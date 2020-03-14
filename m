Return-Path: <SRS0=f902=47=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FE4C0044D
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:38:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18F82074C
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RJ5MPIuG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVk77Jz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18F82074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22DAC1857;
	Sat, 14 Mar 2020 10:37:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22DAC1857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584178707;
	bh=4qu5N3PqY5BgI9g8zu2PknjJuxF/zRwuO0rgOTzkgEM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RJ5MPIuG5HpWT+yGgwUl2pVnZiWD9B0ptU5kCoVUrsQpMMLeiJZ3xBZOL/5PdsNSP
	 Tb+LHbY/5EYQ6kqgc3fGT6lDdytd6o7j09XjW8Z5FnXklUrhEUy2BhZwl+lmXfbHDP
	 DXDSAE9RAX0fwDL2bdzVVjY5oyu6XWxrC2FLH1N0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74227F8013C;
	Sat, 14 Mar 2020 10:37:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD062F801D9; Sat, 14 Mar 2020 10:37:34 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71846F80086
 for <alsa-devel@alsa-project.org>; Sat, 14 Mar 2020 10:37:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71846F80086
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XVk77Jz+"
Received: from localhost (unknown [122.167.115.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 43A492074C;
 Sat, 14 Mar 2020 09:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584178648;
 bh=4qu5N3PqY5BgI9g8zu2PknjJuxF/zRwuO0rgOTzkgEM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XVk77Jz+h13lPC03uUI7M20gd8OTeqM6qz/w7ZBx71f427ElJGFqIRlAnKwFKTHem
 ajJoyacTWPmbmvW8vm8k1LoIHRlJlDxoz9htVdhc5+UHWD1EEOsHAON8LYT6SbmwLl
 x4QCIV3TUAKHtmrhRjYDG5rJNjSmef/NzPWtA2q4=
Date: Sat, 14 Mar 2020 15:07:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 3/6] ASoC: Intel: common: add match tables
 for ICL w/ SoundWire
Message-ID: <20200314093717.GO4885@vkoul-mobl>
References: <20200110222530.30303-1-pierre-louis.bossart@linux.intel.com>
 <20200110222530.30303-4-pierre-louis.bossart@linux.intel.com>
 <d5e15895-7d10-7255-692c-c5c89d3ae1be@perex.cz>
 <b49c010b-5b90-4ad6-58b8-9e43f9fc949f@linux.intel.com>
 <e8df8119-d88b-69b7-fd7a-890f1eb06dbf@perex.cz>
 <20200311090706.GJ4885@vkoul-mobl>
 <5195f1e1-45c9-7b24-2f78-212093976dba@linux.intel.com>
 <20200313114444.GC4885@vkoul-mobl>
 <cce7a018-bbe3-dfb2-076e-1f9c5e1d9185@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cce7a018-bbe3-dfb2-076e-1f9c5e1d9185@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org,
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

On 13-03-20, 11:28, Pierre-Louis Bossart wrote:
> 
> > > The question was "any ETA to start merging Intel patches"...
> > 
> > Ah, sorry I missed that part, but again that is for Pierre to answer. Am
> > ready to merge if the series satisfies all the questions :)
> 
> The ball is in your court Vinod. I replied to all your suggestions and
> showed they cannot possibly be implemented without functionality loss or
> re-inventing pm_runtime.

Sorry to disagree, I would not like to see Intel specific change in
core. That is my only premise.

Would you have this issue if you had a standalone sdw controller(s) ?

-- 
~Vinod
