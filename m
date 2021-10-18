Return-Path: <SRS0=JS7s=PG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321BFC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 15:06:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24AAE61212
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 15:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24AAE61212
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 759B517BF;
	Mon, 18 Oct 2021 17:05:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 759B517BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634569598;
	bh=ORABL7zgsb8rRI4uEwP4o7q5K7sO40QV/lUTaCVjwzM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eA975lkfgD+Q3KmDiObsX3OTEu4SFL/Y3P8lQklSfEw4jiz61/Kf49fd0+8cpa3Bq
	 A9e0eIZlqMsrq7AKrTlfhfMH8KztRb1TT3y2Ag6kPvPsy8gc2AirJ7Oih/qbOJ578c
	 CyQXaL0SyRIgLiXBd5VPsk5//27g2uWgrgQCvjPU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 115C7F80224;
	Mon, 18 Oct 2021 17:05:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D94CF80253; Mon, 18 Oct 2021 17:05:46 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6409F80217
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 17:05:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6409F80217
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="291735916"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; d="scan'208";a="291735916"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2021 08:05:35 -0700
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; d="scan'208";a="566099516"
Received: from dsardana-mobl.amr.corp.intel.com (HELO [10.209.189.174])
 ([10.209.189.174])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2021 08:05:35 -0700
Subject: Re: [PATCH v3 4/4] ASoC: SOF: Intel: add .ack support for HDaudio
 platforms
To: Takashi Iwai <tiwai@suse.de>
References: <20211015195932.224925-1-pierre-louis.bossart@linux.intel.com>
 <20211015195932.224925-5-pierre-louis.bossart@linux.intel.com>
 <s5hzgr85c6v.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <97cd3a79-bf2a-bb1a-7da1-89bc8bac2c13@linux.intel.com>
Date: Mon, 18 Oct 2021 10:05:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <s5hzgr85c6v.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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



>> From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>>
>> When we disable rewinds, then the .ack can be used to program SPIB
>> with the application pointer, which allows the HDaudio DMA to save
>> power by opportunistically bursting data transfers when the path to
>> memory is enabled (and conversely to shut it down when there are no
>> transfer requests).
>>
>> The SPIB register can only be programmed with incremental values with
>> wrap-around after the DMA RUN bits are set. For simplicity, we set the
>> INFO_NO_REWINDS flag in the .open callback when we already need to
>> program the SNDRV_PCM_INFO_EXPLICIT_SYNC flag.
> 
> Using this flag itself isn't wrong, but if we need to check only
> appl_ptr updates, a more appropriate flag is
> SNDRV_PCM_INFO_SYNC_APPLPTR.  This will still allow the mmap of status
> (i.e. hwptr update) while the mmap of control is disabled for
> appl_ptr.  SNDRV_PCM_INFO_EXPLICIT_SYNC flag disables both, instead.

I don't mind, but now we're officially out of INFO flags :-)

NO_REWINDS took the last available bit...
