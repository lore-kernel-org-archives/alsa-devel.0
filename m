Return-Path: <SRS0=+eNr=5T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015AEC43331
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:05:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750312073B
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tFM9qRed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750312073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D48741680;
	Fri,  3 Apr 2020 13:04:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D48741680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585911914;
	bh=4r3bmwEMzBOYQd9TOrOufeiHZFFVLt/al5nAaPwE320=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tFM9qRedlXIlSEVIBZWRrJVSwGwz6eZj+LHxgRCiQRiXDaKWSPTVY7FXMd1vEPC2C
	 JrJAAl4d2HnoDy3o1/YNNw8GRJzjcpL2jUPNvB/ZdtIIracd19r7mZwexqnjs0Mtyo
	 b7n7jDd2m4srcp2tDuogyfnmAYCuErnTiyiFIl7k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BC49F801A3;
	Fri,  3 Apr 2020 13:04:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34425F8014C; Fri,  3 Apr 2020 13:04:20 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12CFCF800C2;
 Fri,  3 Apr 2020 13:04:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12CFCF800C2
IronPort-SDR: 4pABcA140vpmp2FXx7iwKSivnzBEdkJBeMj4R3g+NZ+tr6FbnYHpipJnYtc08Nsah+1w0UqNDE
 hzCXO4ExHTcg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2020 04:04:10 -0700
IronPort-SDR: ccQGmgLdIJF5Q6z61vL6NhY2131KieHbgJnFqAuKVXqP7DMxIhbWJD2YN/ohwsBJDHJy1VMqXN
 /Fc8IWIUGyCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,339,1580803200"; d="scan'208";a="329134316"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu)
 ([10.249.36.113])
 by orsmga001.jf.intel.com with ESMTP; 03 Apr 2020 04:04:06 -0700
Date: Fri, 3 Apr 2020 13:04:05 +0200
From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/12] [RESEND] ASoC: SOF DSP virtualisation
Message-ID: <20200403110404.GA23734@ubuntu>
References: <20200403091406.22381-1-guennadi.liakhovetski@linux.intel.com>
 <20200403092842.GB4286@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403092842.GB4286@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 sound-open-firmware@alsa-project.org
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

Hi Mark,

On Fri, Apr 03, 2020 at 10:28:42AM +0100, Mark Brown wrote:
> On Fri, Apr 03, 2020 at 11:13:54AM +0200, Guennadi Liakhovetski wrote:
> > This patch series extends the SOF driver to add support for DSP
> > virtualisation to ASoC. It is built on top of VirtIO, contains a
> > guest driver and a vhost in-kernel guest driver. This version
> > supports a single playback and a single capture interface on the
> > guest. The specific guest audio topology is supplied by the host
> 
> I've asked a couple of times for documentation of the protocol here but
> don't think I've seen anything yet?

Sorry, we were thinking about the best way to reply. I think Liam will 
provide more procise information. The API we are using is the same as 
what is already used by SOF to communicate with the DSP firmware. With 
VirtIO we re-use the same IPC messages as those, used with the DSP, 
they are just transmitted over Virtual Queues. Additionally to existing 
IPC messages the SOF VirtIO implementation defines 3 more message types 
for topology loading and DSP power management. IPC message types are 
defined in include/sound/sof/header.h, IPC overview is available in 
https://thesofproject.github.io/latest/developer_guides/linux_driver/architecture/sof_driver_arch.html#ipc-processing 
but I'm not aware of a formal SOF IPC protocol documentation.

Thanks
Guennadi
