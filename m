Return-Path: <SRS0=3CTx=DO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8779C41604
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:44:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528A0206BE
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WEyy86Zb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528A0206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 228B216CB;
	Wed,  7 Oct 2020 18:43:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 228B216CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602089036;
	bh=Zi21e3lFPGQmHN3kupBq1PluqPEh6Unn018cWCe57q4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WEyy86ZbSDnN7va+3nIcQyjmAkHZ1eVtfQj00FOs2NSGOfIw+XjiQjpepNtujL/xR
	 ayG42QvxTd3ij4L0nqwp0WXb7Wz5UC97NSSH/6g2rGvXY45/0OykzzVBf9AVdsEwR+
	 Ril7IOkiESWS4rUUtZZMv9VGbCDPSl8n2j52Ldlk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE241F80090;
	Wed,  7 Oct 2020 18:42:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C3D2F8016D; Wed,  7 Oct 2020 18:42:47 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CCFDCF80128
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2020 18:42:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CCFDCF80128
IronPort-SDR: 2hIcxsTLcz+oV4y736BupSZVsNzREN44xPnTNO5QEKba2oiuV9xc3ZP4X56/et1nmSSXtmjBDw
 vEiPHAJT8Pyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="144398663"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; d="scan'208";a="144398663"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2020 09:42:30 -0700
IronPort-SDR: UFXGdHsYPIRIyk1795uoKnQYBLg1V+gAwtUWg0EZLMRsdsO+HRA4YzpfgVjIfMVGj/0+1SRl2v
 KzAPsBED5bAg==
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; d="scan'208";a="528044888"
Received: from npurusho-mobl.amr.corp.intel.com (HELO [10.212.194.22])
 ([10.212.194.22])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2020 09:42:28 -0700
Subject: Re: [PATCH 0/6] Ancillary bus implementation and SOF multi-client
 support
To: Mark Brown <broonie@kernel.org>, Dan Williams <dan.j.williams@intel.com>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
 <20201001071403.GC31191@kroah.com>
 <DM6PR11MB2841742651F535F0826326CDDD310@DM6PR11MB2841.namprd11.prod.outlook.com>
 <20201003090855.GD114893@kroah.com>
 <c09c7efa75d7ea7c65ba1ac4bbb35f033ee4a9bf.camel@intel.com>
 <20201005112547.GA401816@kroah.com>
 <CAPcyv4gWc4B9U9+RcEgmbFWiZ7VpDK+kFXnhGcOUkDhVc609vQ@mail.gmail.com>
 <20201007091443.GA822254@kroah.com>
 <CAPcyv4hLVF4AdRLq2mTGJ9NBwRHm=_ANerUu0OuUPKk2XBSu_w@mail.gmail.com>
 <20201007162251.GB5030@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <10048d4d-038c-c2b7-2ed7-fd4ca87d104a@linux.intel.com>
Date: Wed, 7 Oct 2020 11:42:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007162251.GB5030@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "tiwai@suse.de" <tiwai@suse.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Sridharan,
 Ranjani" <ranjani.sridharan@intel.com>, "parav@nvidia.com" <parav@nvidia.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "Ertman,
 David M" <david.m.ertman@intel.com>
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


>>> "virtual" here means "not real" :)
> 
>> Which of these aux device use cases is not a real device? One of my
>> planned usages for this facility is for the NPEM (Native PCIE
>> Enclosure Management) mechanism that can appear on any PCIE
>> bridge/endpoint. While it is true that the NPEM register set does not
>> get its own PCI-b:d:f address on the host bus, it is still
>> discoverable by a standard enumeration scheme. It is real auxiliary
>> device functionality that can appear on any PCIE device where the
>> kernel can now have one common NPEM driver for all instances in the
>> topology.
> 
> Some if not all of the SOF cases are entirely software defined by the
> firmware downloaded to the audio DSPs.

Correct for DSP processing/debug stuff. In some cases though, the 
firmware deals with different IOs (HDMI, I2C) and having multiple 'aux' 
devices helps expose unrelated physical functions in a more modular way.

The non-SOF audio case I can think of is SoundWire. We want to expose 
SoundWire links as separate devices even though they are not exposed in 
the platform firmware or PCI configs (decision driven by Windows). We 
currently use platform devices for this, but we'd like to transition to 
this 'aux' bus
