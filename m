Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327BAC4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 06:31:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1681360F4B
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 06:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1681360F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7662417CF;
	Mon,  2 Aug 2021 08:30:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7662417CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627885862;
	bh=vcbP7Vu0a+iv1Vktl+nPyhlOrAMgiLFmPGDZ2sL0qhU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bv9u8jL7PFqIaRggf/s6gUErSlRgS8Ngl9TjmFE86vL0+LxcA0FdQu5EDP37qsZW7
	 kASF63mUJfERcCZOGpSxhllVVwKmVJe1f4xXFR6R7EW8xd+DML06YSv+gk1liGyqoq
	 kdLX2oz6mtaBERxUvkRQecPT2oL+TDh03nftV05A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B8FF8F801F7;
	Mon,  2 Aug 2021 08:30:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D54C8F8025F; Mon,  2 Aug 2021 08:29:47 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3390AF800BF
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 08:29:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3390AF800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pdZO+93d"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DBBC61050;
 Mon,  2 Aug 2021 06:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627885771;
 bh=vcbP7Vu0a+iv1Vktl+nPyhlOrAMgiLFmPGDZ2sL0qhU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pdZO+93dihw2AZwZOHL5mK7DtxwsF7lY6RTv7HNaDP4Ec9o4ty+RL/AjJ2UPBUif/
 eQSG6mbdQtwK6rD+kgmnc2hEJfjyykvcDD6Ev3eTHKoz/lb2WHV9lxsohKZPnGxHIg
 JX8jSuRa9/6Fro5tMRng9R0jGJlYG5WU3vehVoN3A1g6yn3W9ZD8YqH4JoKZZvdK07
 BCHMYvtieKlOI+NXIKxAWebjkLWWoNhqQTQ1+Ud3P35GEVA8CKTqYiCCd+2BhY7rb1
 WRcPSh879h3pqXPtlzE7n8jLldOmRDlMMXMypra3cAhJprSlBbkVEiT17Ca/SWPuBn
 y3dh6qA/ab0qw==
Date: Mon, 2 Aug 2021 11:59:26 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] soundwire: intel: trap TRIGGER_SUSPEND in .trigger
 callback
Message-ID: <YQeQxj7Ejh14jIoc@matsya>
References: <20210727053256.29949-1-yung-chuan.liao@linux.intel.com>
 <s5h8s1sfevg.wl-tiwai@suse.de>
 <a25d47a6-2599-7101-cd93-e5304b271948@linux.intel.com>
 <YQd2BM3wGzKpfZn1@matsya> <s5hpmuwz98o.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hpmuwz98o.wl-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
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

On 02-08-21, 07:49, Takashi Iwai wrote:
> On Mon, 02 Aug 2021 06:35:16 +0200,
> Vinod Koul wrote:
> > 
> > On 27-07-21, 09:12, Pierre-Louis Bossart wrote:
> > > Thanks Takashi for the review.
> > > 
> > > 
> > > >> This patch provides both a simplification of the suspend flows and a
> > > >> better balanced operation during suspend/resume transition.
> > > >>
> > > >> The exiting code relies on a convoluted way of dealing with suspend
> > > >> signals. Since there is no .suspend DAI callback, we used the
> > > >> component .suspend and marked all the component DAI dmas as
> > > >> 'suspended'. The information was used in the .prepare stage to
> > > >> differentiate resume operations from xrun handling, and only
> > > >> reinitialize SHIM registers and DMA in the former case.
> > > >>
> > > >> While this solution has been working reliably for about 2 years, there
> > > >> is a much better solution consisting in trapping the TRIGGER_SUSPEND
> > > >> in the .trigger DAI ops. The DMA is still marked in the same way for
> > > >> the .prepare op to run, but in addition the callbacks sent to DSP
> > > >> firmware are now balanced.
> > > >>
> > > >> Normal operation:
> > > >> hw_params -> intel_params_stream
> > > >> hw_free   -> intel_free_stream
> > > >>
> > > >> suspend    -> intel_free_stream
> > > >> prepare    -> intel_params_stream
> > > >>
> > > >> This balanced operation was not required with existing SOF firmware
> > > >> relying on static pipelines instantiated at every boot. With the
> > > >> on-going transition to dynamic pipelines, it's however a requirement
> > > >> to keep the use count for the DAI widget balanced across all
> > > >> transitions.
> > > > 
> > > > The trigger callback is handled in the stream lock atomically, and are
> > > > you sure that you want to operate a possibly heavy task there?
> > > 
> > > It's a good objection that we didn't think of.
> > 
> > Doesn't Intel use non atomic trigger to send IPCs which anyway involve
> > code which can sleep..?
> 
> sof_sdw.c doesn't seem setting it?

Yes I think init_dai_link() should set it. Maybe Pierre/Bard would know
why.

-- 
~Vinod
