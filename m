Return-Path: <SRS0=kA1C=XM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC48BC4CEC9
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 14:31:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33EE820862
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 14:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="It4wLhZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EE820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADDC1844;
	Tue, 17 Sep 2019 16:30:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADDC1844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568730679;
	bh=dbQzFwJsUE029jNmlpBlP+qhGC8usQ+TrDxCU3tUCYo=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=It4wLhZvLERiOnxZqi62uEKq1sWlktdGTLPzVDiGyJyVRe1YQcNFuyF/Ov/IGamSm
	 1HzZcUXHoano9GqaJ5RPFHrSmv7OLmVrR70gCe8gZa//egijwZ3ESJ+leZqtFDBxQS
	 GTW63URHkYY+8AJR9cWNdQloGJwMlLJpM8RJdEqk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3735DF80146;
	Tue, 17 Sep 2019 16:30:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D0F9F80361; Tue, 17 Sep 2019 16:30:27 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F774F801DA
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2019 16:30:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F774F801DA
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Sep 2019 07:30:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,516,1559545200"; d="scan'208";a="216585460"
Received: from linux.intel.com ([10.54.29.200])
 by fmsmga002.fm.intel.com with ESMTP; 17 Sep 2019 07:30:15 -0700
Received: from pbossart-mac01.local (unknown [10.251.11.91])
 by linux.intel.com (Postfix) with ESMTP id AD906580258;
 Tue, 17 Sep 2019 07:30:14 -0700 (PDT)
To: Greg KH <gregkh@linuxfoundation.org>
References: <20190916212342.12578-1-pierre-louis.bossart@linux.intel.com>
 <20190916212342.12578-9-pierre-louis.bossart@linux.intel.com>
 <20190917055512.GE2058532@kroah.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ab06c0c9-6224-a7b8-51c2-01226f763b98@linux.intel.com>
Date: Tue, 17 Sep 2019 09:29:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190917055512.GE2058532@kroah.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 8/9] soundwire: intel: remove platform
 devices and provide new interface
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

On 9/17/19 12:55 AM, Greg KH wrote:
> On Mon, Sep 16, 2019 at 04:23:41PM -0500, Pierre-Louis Bossart wrote:
>> +/**
>> + * sdw_intel_probe() - SoundWire Intel probe routine
>> + * @parent_handle: ACPI parent handle
>> + * @res: resource data
>> + *
>> + * This creates SoundWire Master and Slave devices below the controller.
>> + * All the information necessary is stored in the context, and the res
>> + * argument pointer can be freed after this step.
>> + */
>> +struct sdw_intel_ctx
>> +*sdw_intel_probe(struct sdw_intel_res *res)
>> +{
>> +	return sdw_intel_probe_controller(res);
>> +}
>> +EXPORT_SYMBOL(sdw_intel_probe);
>> +
>> +/**
>> + * sdw_intel_startup() - SoundWire Intel startup
>> + * @ctx: SoundWire context allocated in the probe
>> + *
>> + */
>> +int sdw_intel_startup(struct sdw_intel_ctx *ctx)
>> +{
>> +	return sdw_intel_startup_controller(ctx);
>> +}
>> +EXPORT_SYMBOL(sdw_intel_startup);
> 
> Why are you exporting these functions if no one calls them?

They are used in the next series, see '[RFC PATCH 04/12] ASoC: SOF: 
Intel: add SoundWire configuration interface'

+int hda_sdw_startup(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hdev;
+	int ret;
+
+	hdev = sdev->pdata->hw_pdata;
+
+	ret = sdw_intel_startup(hdev->sdw);
+	if (ret < 0)
+		return ret;
+	hda_sdw_int_enable(sdev, true);
+
+	return ret;
+}

These 4 functions sdw_intel_acpi_scan, sdw_intel_probe, 
sdw_intel_startup and sdw_intel_exit are the interface between the ASoC 
world and the Soundwire/Intel module.

I split the patches in two series to make the review and integration 
easier on maintainers. The first one is strictly contained within the 
driver/soundwire directory while will impact the soundwire and ASoC trees.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
