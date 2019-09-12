Return-Path: <SRS0=5I5Q=XH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C4AC4CEC6
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:31:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C59620830
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vnJ4QaKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C59620830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 878B91742;
	Thu, 12 Sep 2019 15:30:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 878B91742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568295062;
	bh=a//1+RRSaVC5rrV49JZgSZ4lOQXaB9AGpOBJlxc1wrk=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vnJ4QaKbRjCCk0Xk0OfBKFlg2S2161gx6m+Y0qNFKfKo1bcuW1enDfZPKQr7Vtw53
	 qmi9Jh/tpEgez7NTaEdItfvQ0EbfOj73PRzzaWww5qg3/eZdmCULug9PXNEwyyM0Lj
	 YuNEkL1S/5wlgOCsgXj/cfafGbkd9TnPIuw0occo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5FCFF80321;
	Thu, 12 Sep 2019 15:30:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D6C0F80368; Thu, 12 Sep 2019 15:30:09 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD9D0F80143
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2019 15:30:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD9D0F80143
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Sep 2019 06:30:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; d="scan'208";a="336572615"
Received: from linux.intel.com ([10.54.29.200])
 by orsmga004.jf.intel.com with ESMTP; 12 Sep 2019 06:30:01 -0700
Received: from vjyoung-mobl.amr.corp.intel.com (unknown [10.251.12.73])
 by linux.intel.com (Postfix) with ESMTP id E6F0658050C;
 Thu, 12 Sep 2019 06:30:00 -0700 (PDT)
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20190910182916.29693-1-kai.vehmanen@linux.intel.com>
 <20190910182916.29693-5-kai.vehmanen@linux.intel.com>
 <92a31430-824a-8b8a-cdb4-602184db7def@linux.intel.com>
 <alpine.DEB.2.21.1909121453350.16459@zeliteleevi>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f8d7448f-22bf-0202-c370-dda9f0f76264@linux.intel.com>
Date: Thu, 12 Sep 2019 08:29:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909121453350.16459@zeliteleevi>
Content-Language: en-US
Cc: tiwai@suse.de, libin.yang@intel.com, alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH v3 04/10] ASoC: SOF: Intel: add support for
 snd-hda-codec-hdmi
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 9/12/19 7:06 AM, Kai Vehmanen wrote:
> Hey,
> 
> On Tue, 10 Sep 2019, Pierre-Louis Bossart wrote:
>>> --- a/sound/soc/sof/intel/hda-codec.c
>>> +++ b/sound/soc/sof/intel/hda-codec.c
>>> @@ -84,6 +84,8 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int
> [...]
>>> +	/*
>>> +	 * if common HDMI codec driver is not used, codec load
>>> +	 * is skipped here and hdac_hdmi is used instead
>>> +	 */
>>> +	if ((mach_params && mach_params->common_hdmi_codec_drv) ||
>>> +	    (resp & 0xFFFF0000) != IDISP_VID_INTEL) {
>>>    		hdev->type = HDA_DEV_LEGACY;
>>>    		hda_codec_load_module(&hda_priv->codec);
>>
>> This part is might be problematic. For SoundWire stuff, I had to move all the
>> machine detection part out of hda_init_caps() and at the end of hda_dsp_probe.
>> It's not final since I am still trying to figure out what the earliest time I
>> can power-up the SoundWire IP is, but it would help if you don't make strong
>> assumptions on when mach_params is set. The fact that all this code is
>> currently in hda_init_caps() is not really by design, more because of
>> incremental code changes.
> 
> hmm. Currently the settings part of 'common_hdmi_codec_drv' is in in
> init_caps, just before call to hda_codec_probe_bus() (which uses the
> flag). There are also other fields set there (like
> mach_params->codec_mask), so issues should apply to codec_mask passing as
> well. I.e. if functionality is moved out from init_caps, the call to bus
> probe should be moved as well.
> 
> Other options to pass the flag do not seem good. We don't want to add hw
> specific stuff like this to snd_sof_dev or hdac_bus (latter used to pass
> "codec_mask"). If this becomes an issue, maybe we just need an explicit
> parameter to hda_codec_probe_bus(), and/or move the module parameter
> directly to intel/hda-codec.c. Both are a bit ugly, but at least contained
> in the "sof/intel/" subfolder.

never mind, with the SoundWire plumbing rework we can do all the machine 
driver checks in hda_init_caps. I split the ACPI scan, driver probe and 
startup in 3 steps so we have more freedom. Before this rework I was 
constrained to detect the ACPI stuff only when the hardware was powered, 
which was after init_caps.
In short don't worry about me/SoundWire.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
