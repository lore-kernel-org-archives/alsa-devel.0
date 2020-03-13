Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FC8C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 11:46:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4670B20691
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 11:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YRKlE6do";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSAkFa3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4670B20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3DA717D6;
	Fri, 13 Mar 2020 12:45:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3DA717D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584100004;
	bh=mpJ1nkM5NgOU3oFETBpyGe1ES9KgqZCoQMnolZSNa1E=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YRKlE6do6cokBALXOlzM10Fd7rNOeakhRjpqigaMMMq2O3E5VY8H67RJ7JLliy8NQ
	 b+1WI/zLlw1MO1pTRx/7veAuEy6Y0SkllSTDcV8jkjp3hL/2pAzm+xSaqbaP1nKyN1
	 FZsw3XO7HRsNFZ6Ii7Riy7rCmueHyWXytbr/4ykE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2EDAAF801A3;
	Fri, 13 Mar 2020 12:45:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B2425F801EB; Fri, 13 Mar 2020 12:45:18 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B46E6F80090
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 12:44:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B46E6F80090
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pSAkFa3U"
Received: from localhost (unknown [171.76.107.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 338D320691;
 Fri, 13 Mar 2020 11:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584099891;
 bh=mpJ1nkM5NgOU3oFETBpyGe1ES9KgqZCoQMnolZSNa1E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pSAkFa3UvkXrh1ii+4PKwi4oevZeuaZ9Nxo6y5fCIDwp1bslxvjpZaEwCvxnhaYAq
 VPKxXKMBtXVQkjI/laFkTcBhQfvDb0a4aRllYonvNfxK2sx2yUpHL1Uq96/xTb/EUs
 2GupdnEloZstRvLW4CxmzytqyHv/z2NkiTOeSMXU=
Date: Fri, 13 Mar 2020 17:14:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [alsa-devel] [PATCH 3/6] ASoC: Intel: common: add match tables
 for ICL w/ SoundWire
Message-ID: <20200313114444.GC4885@vkoul-mobl>
References: <20200110222530.30303-1-pierre-louis.bossart@linux.intel.com>
 <20200110222530.30303-4-pierre-louis.bossart@linux.intel.com>
 <d5e15895-7d10-7255-692c-c5c89d3ae1be@perex.cz>
 <b49c010b-5b90-4ad6-58b8-9e43f9fc949f@linux.intel.com>
 <e8df8119-d88b-69b7-fd7a-890f1eb06dbf@perex.cz>
 <20200311090706.GJ4885@vkoul-mobl>
 <5195f1e1-45c9-7b24-2f78-212093976dba@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5195f1e1-45c9-7b24-2f78-212093976dba@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On 11-03-20, 09:47, Pierre-Louis Bossart wrote:
> On 3/11/20 4:07 AM, Vinod Koul wrote:
> > On 11-03-20, 07:39, Jaroslav Kysela wrote:
> > > Dne 11. 03. 20 v 2:35 Pierre-Louis Bossart napsal(a):
> > > > 
> > > > 
> > > > On 3/10/20 5:12 PM, Jaroslav Kysela wrote:
> > > > > Dne 10. 01. 20 v 23:25 Pierre-Louis Bossart napsal(a):
> > > > > > From: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > > > > 
> > > > > > The two configurations are with the Realtek 3-in-1 board requiring all
> > > > > > 4 links to be enabled, or basic configuration with the on-board RT700
> > > > > > using link0.
> > > > > > 
> > > > > > Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > > > > Signed-off-by: Pierre-Louis Bossart
> > > > > > <pierre-louis.bossart@linux.intel.com>
> > > > > 
> > > > > Hi,
> > > > > 
> > > > >      I just looking to this code and I miss the Kconfig selection for RT
> > > > > codecs in the SOF SDW driver. How we can enable this driver without
> > > > > selecting SND_SOC_ALL_CODECS ?
> > > > > 
> > > > >      I believe that those changes should be in sync with the machine
> > > > > description.
> > > > 
> > > > Sorry Jaroslav, I don't fully understand your question.
> > > > 
> > > > These tables are just used to
> > > > a) select a firmware file
> > > > b) select a topology file
> > > > c) select a machine driver.
> > > > 
> > > > The codec selections are not made in this module but handled by the
> > > > machine drivers in sound/soc/intel/boards/. It's the same mechanism as
> > > > for all other machine drivers.
> > > > 
> > > > One caveat is that the SOF parts and machine drivers for SoundWire have
> > > > not been provided upstream just yet, since they would not build without
> > > > patches in drivers/soundwire. GregKH mentioned the patches are 'sane'
> > > > and provided his Reviewed-by tag. Vinod Koul still has objections to our
> > > > proposals but has yet to make proposals that would work for Intel, so if
> > > > you need SoundWire support in the near-term you will need to have a
> > > > conversation with Vinod. The code is ready and fully-tested.
> > > > 
> > > > If you want to look at the machine drivers for SOF+Realtek drivers, see
> > > > 
> > > > https://github.com/thesofproject/linux/blob/topic/sof-dev/sound/soc/intel/boards/sdw_rt711_rt1308_rt715.c
> > > > 
> > > > and the Kconfig that selects the relevant codec drivers is here:
> > > > 
> > > > https://github.com/thesofproject/linux/blob/d05959d5021cefbbd841773ee25f6c7387e6bfd9/sound/soc/intel/boards/Kconfig#L556
> > > 
> > > Ohh, it explains all. I was looking for the 'select SND_SOC_RT711_SDW' lines
> > > in Kconfig. It's really bad to merge those pieces randomly to the ASoC tree,
> > > because this code in the patch is dead without the machine driver code.
> > > 
> > > Vinod, any ETA? It seems that the Intel's soundwire hardware is reaching the
> > > market.
> > 
> > That would be question for Pierre, I no longer work for Intel.
> 
> We don't discuss product schedules or releases here.
> 
> The question was "any ETA to start merging Intel patches"...

Ah, sorry I missed that part, but again that is for Pierre to answer. Am
ready to merge if the series satisfies all the questions :)

-- 
~Vinod
