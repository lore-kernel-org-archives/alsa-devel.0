Return-Path: <SRS0=cEba=4V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6C5C3F2CD
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 07:08:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68818214D8
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 07:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bjzA38jB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68818214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B869C1607;
	Wed,  4 Mar 2020 08:07:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B869C1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583305694;
	bh=PbxG9xvBnSJEH4X33QodNWCMzsGCI3fjosXp6100P5k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bjzA38jBeQ6jxZv2eCzVFwbiis///I0X744Z4RMMVIvfcKNJkb8PhO/jO8s0fjGuN
	 gZFeIYgSv8yDO3Vs8/i/purif+mJejJf4+I/WRS+TcCba4i4fWkhtUlXJEqiLbU096
	 94R5JDGxR9IEjofHaky6yc8Cb4+dlaRBa/FteOYw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3647CF8011C;
	Wed,  4 Mar 2020 08:07:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EEEAF801ED; Wed,  4 Mar 2020 08:07:22 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17C5AF8011C
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2020 08:07:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17C5AF8011C
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Mar 2020 23:07:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,513,1574150400"; d="scan'208";a="439028720"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.249.39.20])
 by fmsmga005.fm.intel.com with ESMTP; 03 Mar 2020 23:07:12 -0800
Date: Wed, 4 Mar 2020 08:07:11 +0100
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Fix snd_sof_ipc_stream_posn()
Message-ID: <20200304070710.GA12003@ubuntu>
References: <20200303101858.ytehbrivocyp3cnf@kili.mountain>
 <alpine.DEB.2.21.2003031321410.2957@eliteleevi.tm.intel.com>
 <993233ff-1492-5a87-1026-09af76f6fc7f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993233ff-1492-5a87-1026-09af76f6fc7f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 kernel-janitors@vger.kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Slawomir Blauciak <slawomir.blauciak@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
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

On Tue, Mar 03, 2020 at 09:36:29AM -0600, Pierre-Louis Bossart wrote:
> 
> 
> > > We're passing "&posn" instead of "posn" so it ends up corrupting
> > > memory instead of doing something useful.
> > [...]
> > >   	/* send IPC to the DSP */
> > >   	err = sof_ipc_tx_message(sdev->ipc,
> > > -				 stream.hdr.cmd, &stream, sizeof(stream), &posn,
> > > +				 stream.hdr.cmd, &stream, sizeof(stream), posn,
> > >   				 sizeof(*posn));
> > 
> > ack, thanks, this is clearly wrong. This function is not used by current
> > platforms, so the bug has gone unnnoticed. Most platforms either rely on
> > direct MMIO queries of the DSP position, or the periodic position updates
> > DSPs send after each ALSA period. This function for host to query DSP
> > position via IPC is thus not used, although it's part of the generic audio
> > DSP IPC interface.
> > 
> > For the SOF folks in CC, I wonder should we keep this function at all?
> > 
> > Anyways, that's probably a longer discussion, so while it's there,
> > the code should be correct, so for the patch:
> > Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> 
> I checked all the way to 5.2 and it was never used, so indeed wondering what
> the purpose of this function was.

I actually have a patch, removing that function, which I noticed as being unused 
during my VirtIO work. I think it was used by compressed.c before.

Thanks
Guennadi
