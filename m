Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0153C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 05:16:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BE2821734
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 05:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bfedWjSb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo5bnUt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE2821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4EA01676;
	Fri, 21 Aug 2020 07:16:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4EA01676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597987016;
	bh=BUlBuhrUIzgdlM6CsQC2icLzscNAp8yP2BfnWG3Aqh0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bfedWjSb/PdC0EYUNf/yY8EEjh/jaGO+QrOuDabuHEKnJhjcPTastuhnEpTfWKgQ0
	 SwJvjbCutP/pqSDDCF8Wz8m5uSdvFExuOJhc2KZzK0ChQB3h+uZBRGNtEMqByFNyGG
	 xtGHGwpuBTL9TFWcuQOO8X5cBtUgkcjOj0BgDVlE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B5DAF80216;
	Fri, 21 Aug 2020 07:16:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 25686F80218; Fri, 21 Aug 2020 07:16:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E881EF800D3
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 07:15:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E881EF800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Mo5bnUt+"
Received: from localhost (unknown [122.171.38.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8EBEA2076E;
 Fri, 21 Aug 2020 05:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597986956;
 bh=BUlBuhrUIzgdlM6CsQC2icLzscNAp8yP2BfnWG3Aqh0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Mo5bnUt+zVypr40sJ4tRpLEYqC2tGxyZWbuSD7NVCAHHrUu0B03u91Jjw3uXiDADi
 tT5VoFQ6SH6eQZ8owXT1uaV8vpWWn2u9z9zpPpokLb7CvSVhuyE4/80RLj3Po4yB8K
 QpYlET/asE2ZETLdSIaIU5w0quEOM17Q9MSBbI2g=
Date: Fri, 21 Aug 2020 10:45:52 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/2] soundwire: fix port_ready[] dynamic allocation in
 mipi_disco and ASoC codecs
Message-ID: <20200821051552.GK2639@vkoul-mobl>
References: <20200817174727.15139-1-yung-chuan.liao@linux.intel.com>
 <20200817174727.15139-3-yung-chuan.liao@linux.intel.com>
 <20200818063659.GW2639@vkoul-mobl>
 <e9f12e13-49e0-5306-a975-b1b854baef02@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9f12e13-49e0-5306-a975-b1b854baef02@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, broonie@kernel.org, srinivas.kandagatla@linaro.org,
 jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>, rander.wang@linux.intel.com,
 bard.liao@intel.com
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

On 18-08-20, 07:09, Pierre-Louis Bossart wrote:
> 
> 
> On 8/18/20 1:36 AM, Vinod Koul wrote:
> > On 18-08-20, 01:47, Bard Liao wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > 
> > > The existing code allocates memory for the total number of ports.
> > > This only works if the ports are contiguous, but will break if e.g. a
> > > Devices uses port0, 1, and 14. The port_ready[] array would contain 3
> > > elements, which would lead to an out-of-bounds access. Conversely in
> > > other cases, the wrong port index would be used leading to timeouts on
> > > prepare.
> > > 
> > > This can be fixed by allocating for the worst-case of 15
> > > ports (DP0..DP14). In addition since the number is now fixed, we can
> > > use an array instead of a dynamic allocation.
> > > 
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
> > > Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> > > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > ---
> > >   drivers/soundwire/mipi_disco.c  | 18 +-----------------
> > >   drivers/soundwire/slave.c       |  4 ++++
> > >   include/linux/soundwire/sdw.h   |  2 +-
> > >   sound/soc/codecs/max98373-sdw.c | 15 +--------------
> > >   sound/soc/codecs/rt1308-sdw.c   | 14 +-------------
> > >   sound/soc/codecs/rt5682-sdw.c   | 15 +--------------
> > >   sound/soc/codecs/rt700-sdw.c    | 15 +--------------
> > >   sound/soc/codecs/rt711-sdw.c    | 15 +--------------
> > >   sound/soc/codecs/rt715-sdw.c    | 33 +--------------------------------
> > 
> > This looks fine, but the asoc changes are not dependent, so maybe we
> > should split them up and then can go thru Mark. Or Mark acks, either way
> > would work for me
> 
> There are 3 dependencies that we tracked between SoundWire and ASoC
> subsystems:
> 
> a) addition of SDCA control macro (needed before SDCA codec drivers can be
> shared)
> b) this series - we could indeed submit the codec changes to Mark's tree
> separately, but then the SoundWire tree would be broken: the codec drivers
> would still try to allocate dynamically what is now a fixed-size array.
> c) configuration of the interrupt masks in codec drivers instead of
> hard-coded in bus driver + spurious parity error workaround (not posted yet
> but ready).
> 
> The changes in ASoC codecs are really only on the initialization part
> (either removing a dynamic allocation or setting masks), there's no
> functional change otherwise.
> 
> I think the simplest to avoid multiple back-and-forth is to have these small
> interface/initialization changes merged through the SoundWire subsystem,
> then merged by Mark from a single immutable tag. Would this work for
> everyone?

That would work for me, but you need to split the asoc, regmap, sdw
patches. I am sure looking at patch tag, other maintainers would have
skipped these patches..

> In addition, there's a WIP change to regmap to add support for SoundWire 1.2
> MBQ-based register access, but this only affects regmap and ASoC trees, all
> handled by Mark.
> 
> I don't think we have any other cross-tree changes planned for now, the SDCA
> infrastructure plumbing is still rather open.

-- 
~Vinod
