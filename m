Return-Path: <SRS0=2Byq=DF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C551C2D0A8
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:36:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87702075A
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZdJREhK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87702075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 592EB18A1;
	Mon, 28 Sep 2020 16:35:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 592EB18A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601303759;
	bh=U0WoFw0S9nIEaPDAxiIAa5dr00oo9BFKco/zOIPwT/0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZdJREhK0zg44b/4WXf8t8M+G37yLX8Zswp/px9T7zyekP0apYi7PjAjlySwQrFp78
	 s78ADOII7lWBK6qcD+Yx0wlWI7M68aXPWj/hIlynpTycNRfiVf/HWdP5tKe4yiOhLT
	 YFtBdNmxHHuuc8JlSgMYW6wzgMiJ6soauoULyXVY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A231F80115;
	Mon, 28 Sep 2020 16:35:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3E92F801ED; Mon, 28 Sep 2020 16:35:06 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A326CF800DF
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2020 16:34:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A326CF800DF
IronPort-SDR: PyxwlI7c5hG4qmyDCR21SUt/jCUm006TlWLx933/Yj2VxmRW8FGv4dQ/dGdZrKpMQzmGkkEYMn
 5d9xcIhMCXGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="159383710"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; d="scan'208";a="159383710"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 07:34:50 -0700
IronPort-SDR: 7SUAblgj8WAzM5aWqlyy/thr8Y4yTgEnwsO0n7p4igrbtvtql7OcVfi4xV65GT4y2W3gxMf368
 TThZFXTGOl6g==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; d="scan'208";a="311809845"
Received: from itanwani-mobl.amr.corp.intel.com (HELO [10.252.134.40])
 ([10.252.134.40])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2020 07:34:48 -0700
Subject: Re: [PATCH] ALSA: compress: allow pause and resume during draining
To: Jaroslav Kysela <perex@perex.cz>, Gyeongtaek Lee <gt82.lee@samsung.com>,
 vkoul@kernel.org
References: <CGME20200928105009epcas2p4a65d50d9d09800281395a490d1844ef3@epcas2p4.samsung.com>
 <000c01d69585$228db6b0$67a92410$@samsung.com>
 <7ba714ce-8b33-1b64-7503-6b155bf43909@perex.cz>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <eaa35431-01f4-f858-0673-cc3b4ddf1c5a@linux.intel.com>
Date: Mon, 28 Sep 2020 09:34:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7ba714ce-8b33-1b64-7503-6b155bf43909@perex.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, khw0178.kim@samsung.com, kimty@samsung.com,
 tiwai@suse.com, lgirdwood@gmail.com, hmseo@samsung.com, tkjung@samsung.com,
 pilsun.jang@samsung.com, s47.kang@samsung.com
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



On 9/28/20 6:13 AM, Jaroslav Kysela wrote:
> Dne 28. 09. 20 v 12:50 Gyeongtaek Lee napsal(a):
>> With a stream with low bitrate, user can't pause or resume the stream
>> near the end of the stream because current ALSA doesn't allow it.
>> If the stream has very low bitrate enough to store whole stream into
>> the buffer, user can't do anything except stop the stream and then
>> restart it from the first.
>> If pause and resume is allowed during draining, user experience can be
>> enhanced.
> 
> It seems that we need a new state to handle the pause + drain condition for
> this case.
> 
> With this proposed change, the pause state in drain is invisible.

Indeed it's be much nicer to have a new state, e..g 
SNDRV_PCM_STATE_DRAINING_PAUSED.

One concern is that states are defined in uapi/sound/asoc.h, so wouldn't 
this have impacts on userspace as well? We'd change the value of 
SNDRV_PCM_STATE_LAST.
