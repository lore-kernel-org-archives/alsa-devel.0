Return-Path: <SRS0=75ci=BI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73251C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:04:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D1120809
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VlYRbddO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D1120809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57F9316EE;
	Wed, 29 Jul 2020 17:03:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57F9316EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596035072;
	bh=XhpkLVQMFDGVz2qoN/34o8q+R5jH6m9lizccqBqt4io=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VlYRbddOpWQ42KvreSIvO2ggjYAkInnpy7laVRsvjj4w+0UYez+vZtvirPTjcktNW
	 WQpC4U7fCSAVfVUPafdNu5CNzctMSO4DsgSuy2e5dTqeDOItikxIQkfqd+IXjdRQor
	 /Asd59crNl29yaRbgXuR9EuILOuumcKmAmuTan10=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E406DF80171;
	Wed, 29 Jul 2020 17:03:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C11A6F801A3; Wed, 29 Jul 2020 17:03:40 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6A70F800DE
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2020 17:03:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6A70F800DE
IronPort-SDR: pZCetBavc1qAK1FKp/obYuKFfNIEFM5AzcA91HwMd7dyqauo9ryPKoN6L8tLAr8OEOVYOiVkgS
 zhusniws2LTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="148888651"
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; d="scan'208";a="148888651"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2020 08:03:21 -0700
IronPort-SDR: ErIwcas1U+bdC9R+zI3cVyILruPsZ0z0iB+Qk5gglbUNGFZlzqhdW8H0ZMvqoM9sZUk/Upx4yN
 j0G6rGIKxErQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; d="scan'208";a="272642852"
Received: from jganesan-mobl.amr.corp.intel.com ([10.254.55.234])
 by fmsmga007.fm.intel.com with ESMTP; 29 Jul 2020 08:03:22 -0700
Message-ID: <862d7184dac6dea172d94b83f2ca7dd29136d2df.camel@linux.intel.com>
Subject: Re: [PATCH] ALSA: hda: fix NULL pointer dereference during suspend
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Date: Wed, 29 Jul 2020 08:03:22 -0700
In-Reply-To: <s5hzh7iep8n.wl-tiwai@suse.de>
References: <20200728231011.1454066-1-ranjani.sridharan@linux.intel.com>
 <s5hzh7iep8n.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: yong.zhi@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.com
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

On Wed, 2020-07-29 at 09:48 +0200, Takashi Iwai wrote:
> On Wed, 29 Jul 2020 01:10:11 +0200,
> Ranjani Sridharan wrote:
> > When the ASoC card registration fails and the codec component
> > driver
> > never probes, the codec device is not initialized and therefore
> > memory for codec->wcaps is not allocated. This results in a NULL
> > pointer
> > dereference when the codec driver suspend callback is invoked
> > during
> > system suspend. Fix this by returning without performing any
> > actions
> > during codec suspend/resume if the card was not registered
> > successfully.
> > 
> > Reviewed-by: Pierre-Louis Bossart <
> > pierre-louis.bossart@linux.intel.com>
> > Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
> > >
> 
> The code changes look OK to apply, but I still wonder how the runtime
> PM gets invoked even if the device is not instantiated properly?
Hi Takashi,

Its not runtime PM suspend but rather the system PM suspend callback
that is invoked when the system is suspended that ends up callling the
the runtime PM callback. So, the sequence is:
hda_codec_pm_suspend()
   -> pm_runtime_force_suspend()
          -> hda_codec_runtime_suspend()

Thanks,
Ranjani

