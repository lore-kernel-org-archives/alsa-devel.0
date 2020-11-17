Return-Path: <SRS0=TkwG=EX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44DDC2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 17:41:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DD32465E
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Nov 2020 17:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GEsWcg4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DD32465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50A961767;
	Tue, 17 Nov 2020 18:40:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50A961767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605634870;
	bh=xjNEyu+NMcNrqXN1ekpoCv6iiNpwthQ1Dcza5GF2pWk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GEsWcg4Y4NY3MJUD1O45yvK0FAwBUOl5mXaov9g7Le8gCKzEnCkdLlOaZTaOECOOq
	 nrbWFU+A2tnMCvOtMs75/Z+pU/toD74ViynDvsey4045RNPLj4RRzQedKjRFZD50o2
	 EpSSRaE2CgaUuSXyxLVYTBI3DowysmYbl1Pxhxjs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 232C2F8020B;
	Tue, 17 Nov 2020 18:40:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 005AFF80247; Tue, 17 Nov 2020 18:40:06 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0E1DF800FE
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2020 18:40:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0E1DF800FE
IronPort-SDR: cTepAoppt6qOCXG3rkMQnZx7HP55n1iTOuO51LSRkO0MtcZt5axqD48cWwKPp0vOEmJeHQgNoU
 TWdTtQn3ITwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="255684723"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; d="scan'208";a="255684723"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2020 09:39:51 -0800
IronPort-SDR: Eacy/WOs/rZkB67HG33EtfT5G7kw3EpsCUZAa+fgRkpV660Q8fEuoy7CGJ6OhFyO4ZQ5VXwcGN
 s1DXSBNYUs5Q==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; d="scan'208";a="533898102"
Received: from timmcdon-mobl1.amr.corp.intel.com (HELO [10.209.69.233])
 ([10.209.69.233])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2020 09:39:50 -0800
Subject: Re: [PATCH 06/14] ASoC: Intel: byt/cht: set pm ops dynamically
To: Mark Brown <broonie@kernel.org>
References: <20201112223825.39765-1-pierre-louis.bossart@linux.intel.com>
 <20201112223825.39765-7-pierre-louis.bossart@linux.intel.com>
 <20201117171842.GF5142@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <da03823b-baa0-91b6-c2b0-85733192af68@linux.intel.com>
Date: Tue, 17 Nov 2020 11:39:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117171842.GF5142@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, tiwai@suse.de,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Rander Wang <rander.wang@linux.intel.com>
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



On 11/17/20 11:18 AM, Mark Brown wrote:
> On Thu, Nov 12, 2020 at 04:38:17PM -0600, Pierre-Louis Bossart wrote:
> 
>> +	/* set pm ops */
>> +	if (sof_parent)
>> +		pdev->dev.driver->pm = &snd_soc_pm_ops;
> 
> This might need revisiting in future since we should be able to have the
> driver PM ops be static const and hence unwritable but that's more of a
> robustness thing for the time being given that only a limited set of
> systems have this hardware and we know that there can't be multiple
> devices.

FWIW it's been done in other places, e.g.

drivers/net/wireless/ti/wlcore/main.c:  wl->dev->driver->pm = 
&wlcore_pm_ops;
drivers/net/wireless/ti/wlcore/main.c:  wl->dev->driver->pm = NULL;

The alternative would be to add an .ops whose callbacks conditionally 
call snd_soc_suspend/resume/poweroff. Not much cleaner, is it?

The check on the 'sof_parent' was not present in initial versions, I had 
an additional 'machine parameter' set by the SOF driver. But early 
reviewers suggested a check on the parent name was enough. It achieves 
the same thing in the end, make sure that we don't change anything for 
power management when the Atom/SST driver is used.
