Return-Path: <SRS0=9THl=4Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCF5C3F2CD
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:48:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F569246B4
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Feb 2020 21:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pdbex8mw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F569246B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8615816E2;
	Fri, 28 Feb 2020 22:47:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8615816E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582926482;
	bh=Ry2uwOswUspIY63p3IyTRf34MsoZBEXEHuccS28PIEo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pdbex8mwE1VsbamHnfX2w4hUYkQt2ND+JdtiOT/05yQzX3IGOo6A3F0nV86z+G+3M
	 kEpHBDY2lfw+ULBxRqHD+5I1Ezjs5Ar2we0aGSkxOREixTz6SH5wgbeHMu980RZ7/B
	 o3dA294h9H92WG+8EgqlaccLS84HE7f/oRUHeTcg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 183B7F801F2;
	Fri, 28 Feb 2020 22:46:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73146F8014E; Fri, 28 Feb 2020 22:46:08 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD1CAF80089
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2020 22:46:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD1CAF80089
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Feb 2020 13:46:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400"; d="scan'208";a="411532257"
Received: from spackerm-mobl2.amr.corp.intel.com (HELO [10.255.231.253])
 ([10.255.231.253])
 by orsmga005.jf.intel.com with ESMTP; 28 Feb 2020 13:46:00 -0800
Subject: Re: [PATCH 2/8] soundwire: intel: transition to
 sdw_master_device/driver support
To: Greg KH <gregkh@linuxfoundation.org>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
 <20200227223206.5020-3-pierre-louis.bossart@linux.intel.com>
 <20200228073416.GC2898712@kroah.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <dd163b7f-0a12-6f99-942b-a098551b3354@linux.intel.com>
Date: Fri, 28 Feb 2020 10:01:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228073416.GC2898712@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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



On 2/28/20 1:34 AM, Greg KH wrote:
> On Thu, Feb 27, 2020 at 04:32:00PM -0600, Pierre-Louis Bossart wrote:
>> +static struct sdw_master_driver intel_sdw_driver = {
>> +	.driver = {
>> +		.name = "intel-master",
>> +		.owner = THIS_MODULE,
> 
> Nit, setting .owner isn't needed anymore, as the core code handles this
> for you, right?

Ah, yes indeed, the following code takes care of it. Thanks for spotting 
this!

I can remove this assignment in a follow-up patch if that's alright with 
Vinod.

+#define sdw_register_master_driver(drv) \
+	__sdw_register_master_driver(drv, THIS_MODULE)

+/**
+ * __sdw_register_master_driver() - register a SoundWire Master driver
+ * @mdrv: 'Master driver' to register
+ * @owner: owning module/driver
+ *
+ * Return: zero on success, else a negative error code.
+ */
+int __sdw_register_master_driver(struct sdw_master_driver *mdrv,
+				 struct module *owner)
+{
+	mdrv->driver.bus = &sdw_bus_type;
+
+	if (!mdrv->probe) {
+		pr_err("driver %s didn't provide SDW probe routine\n",
+		       mdrv->driver.name);
+		return -EINVAL;
+	}
+
+	mdrv->driver.owner = owner;
