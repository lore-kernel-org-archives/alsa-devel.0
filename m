Return-Path: <SRS0=duqq=OS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3B7C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 15:12:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2393A6120C
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 15:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2393A6120C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BCCDA16A9;
	Tue, 28 Sep 2021 17:11:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BCCDA16A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632841967;
	bh=CnlKBndL1d+fl/hFiaBex7m2s76m6BDVgC15VxSbedE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aMCsX+L0H5EdtKeS5ZIHzga7I+z/fvwewEhGx5rTc3NK8bWn0y0AE6Yheq7eEjzMQ
	 o1YHWDA4GqkNmTZD/mgM7ggdtqM2BZAeY3gLEZ+HYEjWSaOZtYSFUkHC/i8kbmw11F
	 gX4jbxi5fAUtBg1C7l6tr6HYaruRk+4kd96mHBVU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59A88F8032C;
	Tue, 28 Sep 2021 17:11:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30209F804D2; Tue, 28 Sep 2021 17:11:26 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42476F8032C
 for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2021 17:11:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42476F8032C
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="222832453"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; d="scan'208";a="222832453"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 08:00:35 -0700
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; d="scan'208";a="438102624"
Received: from ppahwa-mobl1.amr.corp.intel.com (HELO [10.212.48.236])
 ([10.212.48.236])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 08:00:34 -0700
Subject: Re: [PATCH] ALSA: hda: Reduce udelay() at SKL+ position reporting
To: Takashi Iwai <tiwai@suse.de>
References: <20210910141002.32749-1-tiwai@suse.de>
 <db973c6d-3fb3-6c1b-f4cd-3e77baf8bd31@linux.intel.com>
 <s5htuipjaak.wl-tiwai@suse.de>
 <203381d5-b3ce-c5ab-b96e-bd38d27cf813@linux.intel.com>
 <s5hmtnxnkea.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a5fa93e1-189f-df83-c1b4-deed4d3f29be@linux.intel.com>
Date: Tue, 28 Sep 2021 10:00:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <s5hmtnxnkea.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <axboe@kernel.dk>, alsa-devel@alsa-project.org
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


>> I think what you need to use is use azx_get_pos_posbuf(chip, azx_dev);
>> unconditionally, both for capture and playback, and remove the use of
>> the skylake specific stuff and the delay.
> 
> When I measured, I saw a slight difference between values in DPIB and
> posbuf, so I wonder which is actually more accurate.  The latter is
> sometimes a bit behind the former.
> 
> If the posbuf is more correct in the sense for the PCM pointer, we can
> simply move back to the posbuf like other platforms.

DPIB registers are known to be updated 'too early' in the case of VC1
traffic, the recommendation is to use posbuf as a 'safer' alternative.
And it's certainly 'more correct' that the current work-arounds which
apply different solutions on capture and playback for no apparent reason.
