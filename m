Return-Path: <SRS0=9ZFY=Z4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CA2C43603
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:52:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BE924659
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UNseAZzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BE924659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B7C01675;
	Fri,  6 Dec 2019 16:51:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B7C01675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575647552;
	bh=lDiXCljxtbCapD+ybbkKdvILta0itcXKtRubePrzrAA=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UNseAZzqU3qGBDy/A19QTXncLKmL2yMor3jk3vNMAwvGYMMyfMGRwP3FCuPVxNS6z
	 XPYuFDi3+jAqbBAKkM8FroxewpT30a368SDpn0IG7pZ+7pTKf51bnakxBRk03pHpqU
	 k1nmoMJhthaSLOZhA756h7SwwFDoxFBhyKF9DBqI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ECC59F801D9;
	Fri,  6 Dec 2019 16:51:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 240A1F801EC; Fri,  6 Dec 2019 16:51:41 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 177DEF80135
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2019 16:51:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 177DEF80135
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Dec 2019 07:51:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,285,1571727600"; d="scan'208";a="202138058"
Received: from ooparaji-mobl1.amr.corp.intel.com (HELO [10.254.45.27])
 ([10.254.45.27])
 by orsmga007.jf.intel.com with ESMTP; 06 Dec 2019 07:51:35 -0800
To: Mohan Prasath Ramamoorthy <mohan.prasath@vvdntech.in>,
 alsa-devel@alsa-project.org
References: <CAMM7-fe=NAH_tEFsE+RV-eA1KLkhaim_3w4YK3wjqDYea_2TtA@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d4f21304-d5b0-5acd-2595-4cb7aa684da3@linux.intel.com>
Date: Fri, 6 Dec 2019 09:27:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAMM7-fe=NAH_tEFsE+RV-eA1KLkhaim_3w4YK3wjqDYea_2TtA@mail.gmail.com>
Content-Language: en-US
Subject: Re: [alsa-devel] Playback issue while recording simultaneously
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



On 12/5/19 11:22 PM, Mohan Prasath Ramamoorthy wrote:
> Dear All,
> 
> We are working on external modules of microphone and speaker and we
> are using the kernel version 3.10.96

wow, that is one ancient kernel EOL'ed in 2017...

> 
> We are recording with commands like arecord and aplay for recording
> and playback respectively.
> 
> While doing the below experiments we could able to observe an issue as below,
> 
> 1. With only recording and not playback we haven't faced any issues.
> 2. With only playback and not recording we haven't faced any issues.
> 
> 3. By starting an infinite recording in the background and by doing a
> playback of the audio file(30seconds, the sampling rate of 22050, the
> channel is stereo), after some iterations, we are facing a below error
> and we could not able to listen to the audio.
> 
> Error: aplay: pcm_write:1940: write error: Input/output error
> 
> Below are the respective commands for recording and playback,
> 
> 1. arecord -D hw:0,0 -c 2 -f s16_le -r 8000 /home/ubuntu/mic_testing.wav &
> 2. aplay -D hw:0,3 audio_22k_c2.wav
> 
> But when the issues come, we just stopped recording and restarted the
> recording in the background. After this, the playback is working fine.
> 
> Also, during the issue came, we have checked for the below properties,
> 
> 1. I2S has been enabled. Checked under the file:
> /sys/kernel/debug/clock/clock_tree
> 2. Driver callbacks have been called. (Checked with the kernel logs[dmesg])
> 
> We would like to know the reason behind this error.?

Sounds typical of an interference between the playback and record 
programming flows, e.g. when changing a shared register. Not all I2S 
tolerate dynamic changes from RX or TX only to full-duplex.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
