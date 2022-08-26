Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2670EECAAD4
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Aug 2022 14:27:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A7D31658;
	Fri, 26 Aug 2022 16:26:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A7D31658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661524020;
	bh=EagHLuYyy/D4ZjO0QalG/OMeTF32exa9+75PSttsxWg=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YEWQNJ+80y/6nD4lYbIwbntMqSBMdfK11Yso+e/hDGx1gEF6zT9fjYYDpc3oo3hnw
	 OFF0Cu+p1OIuIWnOO1108aQ5pAcdHy+jiYwDVMaMLVPbpFAfml9XOitslFHcC4fGpE
	 kHi2irfJCXll47YxOIVxa2jFdnU55rADU0muZlLI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBA62F8014B;
	Fri, 26 Aug 2022 16:26:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 562DFF80238; Fri, 26 Aug 2022 16:26:08 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9BBC8F80105
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2022 16:26:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BBC8F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="D2UL+Qwl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1661523962; x=1693059962;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=EagHLuYyy/D4ZjO0QalG/OMeTF32exa9+75PSttsxWg=;
 b=D2UL+QwlCzOy7m8rZyzpQAxBm2Mzmfro6/NGTxm1HgRo+T0HFWUcWbKP
 ++sbsCPQihgSLt5xCPy19ejpmBE4YDI7KgWGEuklHCkNzHA/XmniZGTJ6
 ZSPJubcgkK8RuF9/p8RmJvzAVO3c/wrdGFlcDj37NYlGm5i7cZZKeLexE
 RKx37Y7/XOx8HFG4qRTsCyQKEhdb6L97LRvEL1Fo1PuPvuPu28w4+a0K+
 ZhTQlI54VlzNp00xrlNLxx+g8CXPaM3tM+fxRydl1uCZOhkol9z1caoFy
 6zf2GyywGP3bmbFX1Nwn9mx5OQAOPym6NQE0kTw6qmUjfy8Lf2/DC/ryU A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295294693"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; d="scan'208";a="295294693"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2022 07:25:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; d="scan'208";a="610579760"
Received: from plecluse-mobl2.ger.corp.intel.com (HELO [10.252.52.28])
 ([10.252.52.28])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2022 07:25:40 -0700
Message-ID: <01e03c55-1fcf-1e33-78e8-398a50b622ce@linux.intel.com>
Date: Fri, 26 Aug 2022 10:06:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] soundwire: bus: Fix lost UNATTACH when re-enumerating
Content-Language: en-US
To: Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
 yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
References: <20220825122241.273090-1-rf@opensource.cirrus.com>
 <20220825122241.273090-4-rf@opensource.cirrus.com>
 <adfdf06a-e1a3-e47c-a71f-5e5dccef6fd0@linux.intel.com>
 <e9deb2fb-458a-8136-5ba7-a9e2b0f2d174@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <e9deb2fb-458a-8136-5ba7-a9e2b0f2d174@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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



>> On 8/25/22 14:22, Richard Fitzgerald wrote:
>>> Rearrange sdw_handle_slave_status() so that any peripherals
>>> on device #0 that are given a device ID are reported as
>>> unattached. The ensures that UNATTACH status is not lost.
>>>
>>> Handle unenumerated devices first and update the
>>> sdw_slave_status array to indicate IDs that must have become
>>> UNATTACHED.
>>>
>>> Look for UNATTACHED devices after this so we can pick up
>>> peripherals that were UNATTACHED in the original PING status
>>> and those that were still ATTACHED at the time of the PING but
>>> then reverted to unenumerated and were found by
>>> sdw_program_device_num().
>>
>> Are those two cases really lost completely? It's a bit surprising, I do
>> recall that we added a recheck on the status, see the 'update_status'
>> label in cdns_update_slave_status_work
>>
> 
> Yes they are. We see this happen extremely frequently (like, almost
> every time) when we reset out peripherals after a firmware change.
> 
> I saw that "try again" stuff in cdns_update_slave_status_work() but
> it's not fixing the problem. Maybe because it's looking for devices
> still on #0 but that isn't the problem.
> 
> The cdns_update_slave_status_work() is running in one workqueue thread,
> child drivers in other threads. So for example:
> 
> 1. Child driver #1 resets #1
> 2. PING: #1 has reverted to #0, #2 still ATTACHED
> 3. cdns_update_slave_status() snapshots the status. #2 is ATTACHED
> 4. #1 has gone so mark it UNATTACHED
> 5. Child driver #2 gets some CPU time and reset #2
> 5. PING: #2 has reset, both now on #0 but we are handling the previous
> PING
> 6. sdw_handle_slave_status() - snapshot PING (from step 3) says #2 is
> attached
> 7. Device on #0 so call sdw_program_device_num()
> 8. sdw_program_device_num() loops until no devices on #0, #1 and #2
> are both reprogrammed, return from sdw_handle_slave_status()
> 10. PING: #1 and #2 both attached
> 11. cdns_update_slave_status() -> sdw_handle_slave_status()
> 12. #1 has changed UNATTACHED->ATTACHED, but we never got a PING with
>     #2 unattached so its slave->status==ATTACHED, "it hasn't changed"
>     (wrong!)
> 
> Now, at step 10 the Cadence IP may have accumlated both UNATTACH and
> ATTACH flags, and perhaps it should be smarter about deciding what
> to report if there are multiple states. HOWEVER.... that's the behaviour
> of Cadence IP, other IP may be different so it's probably unwise to
> assume that the IP has "remembered" the UNATTACH state before it was
> reprogrammed.
> 
> If we reprogrammed it, it was definitely UNATTACHED so let's say that.

Thanks for the detailed answer, this sequence of events will certainly
defeat the Cadence IP and the way sticky bits were handled.

The UNATTACHED case was assumed to be a really rare case of losing sync,
i.e. a SOFT_RESET in SoundWire parlance.

If you explicitly do a device reset, that would be a new scenario that
was not considered before on any of the existing SoundWire commercial
devices. It's however something we need to support, and your work here
is much appreciated.

I still think we should re-check the actual status from a PING frame, in
order to work with more current data than the sticky bits taken at an
earlier time, but that would only be a minor improvement.

I also have a vague feeling that additional work is needed to make sure
the DAIs are not used before that second enumeration and all firmware
download complete. I did a couple of tests last year where I used the
debugfs interface to issue a device reset command while streaming audio,
and the detach/reattach was not handled at the ASoC level.

I really don't see any logical flaws in your patch as is, so

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

