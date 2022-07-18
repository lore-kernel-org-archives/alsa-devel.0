Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5CDC43334
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jul 2022 05:44:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FA83173A;
	Mon, 18 Jul 2022 07:43:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FA83173A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658123075;
	bh=8BtyTe4sNVL2w0ntx6AQKvZa+6/Vk6UGPounqoCrpzY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TqVMp882MLnZWAmK2xGckTKVV1v2MW5074OoM4kcA6of+SXmGpHxPo5JycU0Ao0R2
	 4gbZ78GCOX3MYm0celDSIymxbiGFn4yG90/oJtz6NIzmEdSVJhQgvdsl8Kn2k17whf
	 Y8NliBJVPvbje6wHKY5N/XKyECcm8Piqbsmc5XOA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03719F80430;
	Mon, 18 Jul 2022 07:43:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52A1FF80508; Mon, 18 Jul 2022 07:43:43 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 009B4F800F5
 for <alsa-devel@alsa-project.org>; Mon, 18 Jul 2022 07:43:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 009B4F800F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Vs/9XArQ"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A769AB80EC1;
 Mon, 18 Jul 2022 05:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF7BC341C8;
 Mon, 18 Jul 2022 05:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658123014;
 bh=8BtyTe4sNVL2w0ntx6AQKvZa+6/Vk6UGPounqoCrpzY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vs/9XArQKK8pyqa6WpINT2ck4onBuCbxxyeGf5ZXvAVXoK0JV30kmyIQ5SZ05hUbD
 xUOqAFcu84t0c+fXefhVuwB1SfYiqjeI/JNJIFhQUcto6M4iCPMBX6KkyCDuHTZJ+C
 3Mew5ALBowFQ5LyT38xo6XIo/2D2QknOZl2kI35Bo+w2/JY3qJvRyCDM69ZfS23pl2
 PQEw87iLMVC3c+6r9zRQhZzYvGm6+P4tcjSBU/wB23F3NCqE2F8DxTb8nZvkAftszV
 ja6ZwEQspvSL+mXySywszePSH+qKNt1J8tmQhHP4BOFZWIoU6n7kBTVuLqhVAwyDnM
 MV4fYX+MoFDBQ==
Date: Mon, 18 Jul 2022 11:13:29 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: codecs: show PING status on resume failures
Message-ID: <YtTzAS+lflz6tk1Z@matsya>
References: <20220714011043.46059-1-yung-chuan.liao@linux.intel.com>
 <20220714011043.46059-5-yung-chuan.liao@linux.intel.com>
 <YtBs1jwgop756z6T@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtBs1jwgop756z6T@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>, bard.liao@intel.com
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

Hey Mark,

On 14-07-22, 20:21, Mark Brown wrote:
> On Thu, Jul 14, 2022 at 09:10:43AM +0800, Bard Liao wrote:
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > 
> > This helper should help identify cases where devices fall off the bus
> > and don't resync.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> 
> If this is applied to the Soundwire tree it might be good to get a pull
> request in case of conflicts, though I guess they are relatively
> unlikely here.

It is bit late for sdw tree (we are closed for this cycle now), if you
are okay, pls feel free to take thru ASoC tree:

You may use:
git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.20-rc1

-- 
~Vinod
