Return-Path: <SRS0=eswj=3E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3547EC32771
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:15:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B295122522
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="W6ZvWzGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B295122522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3A9E17A4;
	Wed, 15 Jan 2020 23:14:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3A9E17A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579126501;
	bh=wVKTCpDTtACpeqXIplbylGX542zvGNwcu3Bu4KeSIB4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W6ZvWzGAYtAv5nzaAkVZ7xT7Cs3pYIeaCYFTZDv6/XBYQiOr8T4jgdJNngi0+Cv33
	 zJLddnOSQW1WfoLWYcltJVzpEr3jbuJYf2Clyk1Da00GcXWvCLpTFk5nuo9B7KxpPw
	 DcJx6ZwT8nT0fB8UV7omyGcGU7jzBzj4a6QqJ1JM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35C1DF801EB;
	Wed, 15 Jan 2020 23:14:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8AC1F801EB; Wed, 15 Jan 2020 23:14:08 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77D67F800E9
 for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2020 23:14:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77D67F800E9
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Jan 2020 14:14:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; d="scan'208";a="257028943"
Received: from sbreyer-mobl.amr.corp.intel.com (HELO [10.255.228.18])
 ([10.255.228.18])
 by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2020 14:13:59 -0800
To: Bard liao <yung-chuan.liao@linux.intel.com>, broonie@kernel.org,
 tiwai@suse.de
References: <20200114175152.3291-1-yung-chuan.liao@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a1d68a98-adab-32e6-c837-165c135f83ef@linux.intel.com>
Date: Wed, 15 Jan 2020 16:13:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114175152.3291-1-yung-chuan.liao@linux.intel.com>
Content-Language: en-US
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org,
 bard.liao@intel.com, kuninori.morimoto.gx@renesas.com
Subject: Re: [alsa-devel] [PATCH RFC v2 0/4] ASoC: Add Multi CPU DAI support
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



On 1/14/20 11:51 AM, Bard liao wrote:
> As discussed in [1], ASoC core supports multi codec DAIs
> on a DAI link. However it does not do so for CPU DAIs.
> 
> So, add support for multi CPU DAIs on a DAI Link by adding
> multi CPU DAI in Card instantiation, suspend and resume
> functions, PCM ops, stream handling functions and DAPM.

Maybe a tangential question, but I am a bit confused on the code cleanups.

After this series of patches is applied, we have this in soc.h:

	struct snd_soc_dai *codec_dai;
	struct snd_soc_dai *cpu_dai;

	struct snd_soc_dai **codec_dais;
	unsigned int num_codecs;

	struct snd_soc_dai **cpu_dais;
	unsigned int num_cpus;

What is the intent behind keeping the two fields codec_dai and cpu_dai?

Shouldn't we use the multi-dai structures in all cases, possible 
degraded to a single element rather than maintaining what looks like 
duplicate ways of accessing the same element?

If removing these fields across all drivers is just too invasive for 
now, shouldn't we start defining access macros so that those fields can 
be deprecated and removed at a later time, platform-by-platform?

Thanks
-Pierre
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
