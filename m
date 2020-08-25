Return-Path: <SRS0=+Hcd=CD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99DDC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 22:10:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1966520706
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 22:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G0SV1hGa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1966520706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9465116CB;
	Wed, 26 Aug 2020 00:09:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9465116CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598393406;
	bh=ndV4ZGnO/S3AhKm7yeEijlB56nc+UegdTrVWe1zZOPY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G0SV1hGa9YL8/Cx02XJbvXU1RGYOxGmfmg12CKHsai6EI8U8Y/PBGypWaTjvB9Oh8
	 shO0uq3Aja/gzErjvt48wh3nHQuvHTRRMA/42TSNnoxxHMPgEeknguvHpAnAFNSunj
	 7blqX4yCcZtwoy4tejH9ximEtkTB3CDgtvd8Y4oM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F375DF80143;
	Wed, 26 Aug 2020 00:09:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B01EEF8025A; Wed, 26 Aug 2020 00:09:14 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9922F80143
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 00:09:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9922F80143
IronPort-SDR: JORcs2FjQtmUobgccc5T1ARuPA5hUUb+r3gVqfv13MBB+diGrnSIN6y9Njh/IHfgwrDtkYWlAb
 DnrZcSyg1d6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="136266182"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; d="scan'208";a="136266182"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 15:08:58 -0700
IronPort-SDR: 1IyWrskjuUgB/aKrFItHb4VFvFk/xesFg5h3f0N52YRPlwC+AzLH96nET5w5P1DJgsDfHzXzWf
 WW57odA9zbmw==
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; d="scan'208";a="322935683"
Received: from lmirelex-mobl.amr.corp.intel.com (HELO [10.209.158.229])
 ([10.209.158.229])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 15:08:57 -0700
Subject: Re: [PATCH 1/4] regmap: sdw: move to -EOPNOTSUPP
To: Mark Brown <broonie@kernel.org>
References: <20200825171656.75836-2-pierre-louis.bossart@linux.intel.com>
 <20200825214858.GK5379@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6f7e5830-4dd8-1ecc-20c3-df75bc9ef265@linux.intel.com>
Date: Tue, 25 Aug 2020 17:08:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825214858.GK5379@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
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


>> -ENOTSUPP is not a valid error code, use recommended value instead.
> 
> What makes you say this - it's what regmap uses internally for
> unsupported operations?

This was flagged by scripts/checkpatch.pl (must be a new addition).

# ENOTSUPP is not a standard error code and should be avoided in new 
patches.
# Folks usually mean EOPNOTSUPP (also called ENOTSUP), when they type 
ENOTSUPP.
# Similarly to ENOSYS warning a small number of false positives is expected.
		if (!$file && $line =~ /\bENOTSUPP\b/) {
			if (WARN("ENOTSUPP",
				 "ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP\n" . 
$herecurr) &&
			    $fix) {
				$fixed[$fixlinenr] =~ s/\bENOTSUPP\b/EOPNOTSUPP/;
			}
		}

I was just blindly making checkpatch happy and tried to keep 
regmap-sdw.c and regmap-sdw-mbq aligned.

