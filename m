Return-Path: <SRS0=zQEr=Y6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7904C5DF63
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 21:20:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8691217F4
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 21:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZPk0SzMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8691217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 380BA1616;
	Wed,  6 Nov 2019 21:54:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 380BA1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573073702;
	bh=s+5cWSqAjvTXugXJONu4PRwizYt2w7twNlU+Pu/XENg=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZPk0SzMeHqwHZQ9G38bSGbaczcDruK8S1Rq8fnSNanJWtEMoxaH3V9eeOXuFJvD3Z
	 NxYEmTPe770G8J5ckwNeTrfZyv2Ku+gyhPX9SFDMYXrLcpwCsZAXKshkk+NnG43YzE
	 plxQoCXxz/NylQjVBPwRnomGTt6qu3NcxBOowteI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8632F80321;
	Wed,  6 Nov 2019 21:54:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED5EAF803D0; Wed,  6 Nov 2019 21:54:09 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46D9AF8015B
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2019 21:54:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46D9AF8015B
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 12:54:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; d="scan'208";a="228688826"
Received: from cjense2x-mobl1.amr.corp.intel.com (HELO [10.251.130.63])
 ([10.251.130.63])
 by FMSMGA003.fm.intel.com with ESMTP; 06 Nov 2019 12:54:01 -0800
To: alsa-devel@alsa-project.org
References: <20191023211504.32675-1-pierre-louis.bossart@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <633d2d68-dabe-be97-260f-2914c7f386b3@linux.intel.com>
Date: Wed, 6 Nov 2019 14:54:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191023211504.32675-1-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 0/5] ASoC: SOF: Intel: Soundwire integration
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



On 10/23/19 4:14 PM, Pierre-Louis Bossart wrote:
> This patchset applies on top of the series "[PATCH 0/4] soundwire:
> update ASoC interfaces". The SOF/Intel code makes use of the
> interfaces defined for initialization.
> 
> Build support for SoundWire is not provided for now, all
> Soundwire-related code will be handled with a dummy fallback. We will
> enable SoundWire interfaces in the Kconfigs when the functionality is
> enabled in the soundwire tree.
> 
> In short, if the interfaces are agreed on, there is no risk with the
> integration of these patches on the ASoC side.

Mark, Vinod, any comments/objections on the suggested interfaces? I 
tried to make your life simpler with a clean separation between 
SoundWire and ASoC/SOF.

> 
> Pierre-Louis Bossart (5):
>    ASoC: SOF: Intel: add SoundWire configuration interface
>    ASoC: SOF: IPC: dai-intel: move ALH declarations in header file
>    ASoC: SOF: Intel: hda: add SoundWire stream config/free callbacks
>    ASoC: SOF: Intel: hda: initial SoundWire machine driver autodetect
>    ASoC: SOF: Intel: hda: disable SoundWire interrupts on suspend
> 
>   include/sound/sof/dai-intel.h    |  18 +--
>   sound/soc/sof/intel/hda-dsp.c    |   2 +
>   sound/soc/sof/intel/hda-loader.c |  13 ++
>   sound/soc/sof/intel/hda.c        | 230 ++++++++++++++++++++++++++++++-
>   sound/soc/sof/intel/hda.h        |  44 ++++++
>   5 files changed, 295 insertions(+), 12 deletions(-)
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
