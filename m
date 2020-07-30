Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72813C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 17:35:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3F0120838
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 17:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C+Zt1+k9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F0120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B0571665;
	Thu, 30 Jul 2020 19:34:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B0571665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596130507;
	bh=lkhL5TsQH/SzeNj1pChydwwJHRpfrILEGaAVHnV5iN0=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C+Zt1+k9Nfn8Nssg/xRGOnSn7f5K7rSmAP19WPF60nsXh3l5beP7IZIw/90Oa5h+l
	 QnTjQqvRucf+Sebx0MlaWXRhgrnl6daxObRPzL2VS6Nd3NlxsvOgE54ZqYLK9Rnwj9
	 f9irNF/uhmcros1zukhbRC/2JcYHhBSOQ/UCLKVk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE750F8021C;
	Thu, 30 Jul 2020 19:34:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29234F8021E; Thu, 30 Jul 2020 19:34:15 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60EA9F800C9
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2020 19:34:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60EA9F800C9
IronPort-SDR: UQ1PxzijpzHb4Vf7m9/txffdN5U77iGkQL42C67dH8F4FQwJEaflG4N2xxCsZjYErGx2ahjmjv
 TvySXbHvYeUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="139204269"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; d="scan'208";a="139204269"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2020 10:34:01 -0700
IronPort-SDR: PA2KwiO55ucpBMgxSl2Rj7m0+TDFnhrcY7zNyMdH9NHpqh/qGHXyvxovh4pXjpzpuRNYPe1Qx0
 gA0HfHXoqSmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; d="scan'208";a="274274181"
Received: from xueyanz1-mobl1.amr.corp.intel.com ([10.254.23.201])
 by fmsmga008.fm.intel.com with ESMTP; 30 Jul 2020 10:34:01 -0700
Message-ID: <89a066fa22fc5dd00782dfcdd7f6b2d36a5f8d67.camel@linux.intel.com>
Subject: Re: [PATCH] ALSA: hda: fix NULL pointer dereference during suspend
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Date: Thu, 30 Jul 2020 10:33:59 -0700
In-Reply-To: <s5hd04dcfss.wl-tiwai@suse.de>
References: <20200728231011.1454066-1-ranjani.sridharan@linux.intel.com>
 <s5hzh7iep8n.wl-tiwai@suse.de>
 <862d7184dac6dea172d94b83f2ca7dd29136d2df.camel@linux.intel.com>
 <s5hft9ae266.wl-tiwai@suse.de> <s5hd04dcfss.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 yong.zhi@intel.com
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

On Thu, 2020-07-30 at 15:07 +0200, Takashi Iwai wrote:
> On Wed, 29 Jul 2020 18:06:25 +0200,
> Takashi Iwai wrote:
> > On Wed, 29 Jul 2020 17:03:22 +0200,
> > Ranjani Sridharan wrote:
> > > On Wed, 2020-07-29 at 09:48 +0200, Takashi Iwai wrote:
> > > > On Wed, 29 Jul 2020 01:10:11 +0200,
> > > > Ranjani Sridharan wrote:
> > > > > When the ASoC card registration fails and the codec component
> > > > > driver
> > > > > never probes, the codec device is not initialized and
> > > > > therefore
> > > > > memory for codec->wcaps is not allocated. This results in a
> > > > > NULL
> > > > > pointer
> > > > > dereference when the codec driver suspend callback is invoked
> > > > > during
> > > > > system suspend. Fix this by returning without performing any
> > > > > actions
> > > > > during codec suspend/resume if the card was not registered
> > > > > successfully.
> > > > > 
> > > > > Reviewed-by: Pierre-Louis Bossart <
> > > > > pierre-louis.bossart@linux.intel.com>
> > > > > Signed-off-by: Ranjani Sridharan <
> > > > > ranjani.sridharan@linux.intel.com
> > > > 
> > > > The code changes look OK to apply, but I still wonder how the
> > > > runtime
> > > > PM gets invoked even if the device is not instantiated
> > > > properly?
> > > Hi Takashi,
> > > 
> > > Its not runtime PM suspend but rather the system PM suspend
> > > callback
> > > that is invoked when the system is suspended that ends up
> > > callling the
> > > the runtime PM callback. So, the sequence is:
> > > hda_codec_pm_suspend()
> > >    -> pm_runtime_force_suspend()
> > >           -> hda_codec_runtime_suspend()
> > 
> > OK, but the problem is still same.  The basic problem is that the
> > hda_codec_driver_probe() is called for the hda_codec object that
> > hasn't been initialized and bypasses to ext_ops.hdev_attach.
> > 
> > So, we can factor out the fundamental part of
> > snd_hda_codec_device_new() that is irrelevant with the card object
> > and
> > call it in hdac_hda_dev_probe().
> 
> I meant something like below (totally untested)
Thanks, Takashi. I can test this out and get back to you by next week.

Thanks,
Ranjani

