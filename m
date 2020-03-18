Return-Path: <SRS0=W6oB=5D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD76C10DCE
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 15:30:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97B420724
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Mar 2020 15:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qKIYVS9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97B420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3688172E;
	Wed, 18 Mar 2020 16:29:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3688172E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584545418;
	bh=Lcz7PncRRvyUqX/qmDBYCIJamL6Zy22m/tAhfMZI8iU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qKIYVS9kMicY1jV71xRhl/5r0Xmwtk36/XuETES01f1c/2psMp+ROEki+/fYwFPPH
	 sI/Z/P9WO9QUHmhHksoUOrcwQMrko7TvrtlQAChYUUYhvH0MLV4EKLZAD7VX2ktye8
	 VIYnwUoVBwIMl0slPks3R17PWR/+l/enV1OTxc9c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B4C5F80162;
	Wed, 18 Mar 2020 16:28:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 47341F80058; Wed, 18 Mar 2020 16:28:31 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B7F3F80058
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2020 16:28:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B7F3F80058
IronPort-SDR: 4Hh3+2UfJ5FdkFyOzX6romk/3RTBkUvzXGLS11D64//BEBhI8YYbd+AwNUjGVgeqTpkjjncOW7
 bFpyrjUu48tw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2020 08:28:20 -0700
IronPort-SDR: g95JJKA7+7TG6WKZl/SiDDh/sHxUBdTx6vEJqHelvUjXtuVFfJIGubIXgY3vru0vjeqq0pZ4xU
 JHQ6NHbONJfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; d="scan'208";a="417985182"
Received: from nali1-mobl3.amr.corp.intel.com (HELO [10.255.33.194])
 ([10.255.33.194])
 by orsmga005.jf.intel.com with ESMTP; 18 Mar 2020 08:28:19 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To: Dominik Brodowski <linux@dominikbrodowski.net>,
 Keyon Jie <yang.jie@linux.intel.com>
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
Date: Wed, 18 Mar 2020 10:13:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200318123930.GA2433@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: cezary.rojewski@intel.com, alsa-devel@alsa-project.org, curtis@malainey.com,
 tiwai@suse.com, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
 broonie@kernel.org
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



>>> While 5.5.x works fine, mainline as of ac309e7744be (v5.6-rc6+) causes me
>>> some sound-related trouble: after boot, the sound works fine -- but once I
>>> suspend and resume my broadwell-based XPS13, I need to switch to headphone
>>> and back to speaker to hear something. But what I hear isn't music but
>>> garbled output.

It's my understanding that the use of the haswell driver is opt-in for 
Dell XPS13 9343. When we run the SOF driver on this device, we have to 
explicitly bypass an ACPI quirk that forces HDAudio to be used:

https://github.com/thesofproject/linux/commit/944b6a2d620a556424ed4195c8428485fcb6c2bd

Have you tried to run in plain vanilla HDAudio mode?

