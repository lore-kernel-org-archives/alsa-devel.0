Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7928AC433E2
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:02:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF46A20709
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NCIxKD1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF46A20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D59018C8;
	Thu,  3 Sep 2020 11:01:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D59018C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599123766;
	bh=tuyHARKxmppQ8fk4UK+8CE7c4LLYkoD6uDJRlTfcMeg=;
	h=To:From:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NCIxKD1YyHIjnbxcJ8q/OjaK3yQLCiOvLXNleyIoWMZAVorzLLT7lO2Ah6mXJhGAa
	 EnQ2cobaGpuid1p1+I4BAGagEfzDSG76HP1L6yaTDYckDK+J0xtAbVnREpRrc9aBUM
	 Cbk52ZXBAsfLZ5Cfn/rPDQMRU7OLyYZqbxOaJEYc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C172BF800BA;
	Thu,  3 Sep 2020 11:01:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3EDDF80217; Thu,  3 Sep 2020 11:01:53 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78240F801DA
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 11:01:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78240F801DA
IronPort-SDR: Q4bdr9w69+/gfdPl9mCJg2BssC0NhCx/FPqetcPM5tbgVWVVfLFZg/K2daHny+ofWHc2/s6sUp
 Yh613wBUu7cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="242360829"
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; d="scan'208";a="242360829"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 02:01:43 -0700
IronPort-SDR: WPgHbA/wsE6IDh1DxYFVtmSk20c/2aPwoRvBCPhz5U6YKHGHjM7T3oelh6SsP6KD9ic0G0B0PN
 UIUTXcnkow8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; d="scan'208";a="502988169"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.10.75])
 ([10.213.10.75])
 by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2020 02:01:42 -0700
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [RFC] dpcm_fe_dai_do_trigger: implicit removal of _DRAIN cmd since
 v5.4
Message-ID: <2eea3479-1efb-ec82-32f2-e89614998aaa@intel.com>
Date: Thu, 3 Sep 2020 11:01:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Hello,

Till v5.4 dpcm_fe_dai_do_trigger was supporting all pcm cmds as each 
case: SND_SOC_DPCM_TRIGGER_PRE/ _POST/ _BESPOKE was simply passing cmd's 
value to appropriate variant of _trigger().

Since the addition of:
	acbf27746ecfa96b290b54cc7f05273482ea128a
	ASoC: pcm: update FE/BE trigger order based on the command

additional filters have been introduced for _PRE and _POST cases:

	switch (cmd) {
	case SNDRV_PCM_TRIGGER_START:
	case SNDRV_PCM_TRIGGER_RESUME:
	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
		ret = dpcm_dai_trigger_fe_be(substream, cmd, true);
		break;
	case SNDRV_PCM_TRIGGER_STOP:
	case SNDRV_PCM_TRIGGER_SUSPEND:
	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
		ret = dpcm_dai_trigger_fe_be(substream, cmd, false);
		break;
	default:
		ret = -EINVAL;
		break;
	}

effectively removing support for _DRAIN command - all requests will 
yield -EINVAL. _BESPOKE was left alone so support remained there.

Now, is DPCM no longer supporting _DRAIN and that's how things should be 
-or- DPCM still intends to support _DRAIN and mentioned change is 
unintended regression?

Czarek
