Return-Path: <SRS0=NYZN=LL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF12C49361
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 16:55:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB2F610A2
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 16:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB2F610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75A801754;
	Thu, 17 Jun 2021 18:54:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75A801754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623948905;
	bh=8eAgxyrokdFKiA0cRSwfNPcJVim95UEq/rHEH7PLsns=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kXMo5dp+yImGnPG64mk27nMsB+VPmmsxcmULbPx8qPZiKW58S6ltWdiu/GXYNlvI7
	 f7SNusWUISuAWGLT8hc9SDPgNib/O9m0QsmJtRPHxV2sGqtl5MA6iM3s1D/832z+Ds
	 xGo+fZ/yqSHrreQk17cxEF3S50smIQ1XwEkvvSQU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1348BF80148;
	Thu, 17 Jun 2021 18:54:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F2CBEF8025A; Thu, 17 Jun 2021 18:54:13 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05E8AF80148
 for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2021 18:54:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05E8AF80148
IronPort-SDR: oaaL3AnvrKadpDMHSFYJxS8YV3jMnOlE3lLhpaM1ZEo/BmfsNnBumJ+WaDOnE0+bA9PBtIADXa
 c0VlEVK/n/mw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="292040059"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; d="scan'208";a="292040059"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2021 09:54:01 -0700
IronPort-SDR: NOCxQ0VF4jinLQk0JADj6VWcCxnY3F/Fi34RqmSoq1N7o15xyYR04W3Qfa8uGilhRlZO1M3aul
 mSf+QDka0GkQ==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; d="scan'208";a="421929542"
Received: from kumarkir-mobl2.amr.corp.intel.com (HELO [10.212.96.56])
 ([10.212.96.56])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2021 09:54:00 -0700
Subject: Re: [PATCH] soundwire: stream: Use polling for DP Prepare completion
To: Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
 yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
References: <20210617153410.27922-1-rf@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1d340be7-2f21-73a5-bcc3-91372976dfb9@linux.intel.com>
Date: Thu, 17 Jun 2021 11:53:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210617153410.27922-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Thanks Richard for the patch, very interesting.
 
> sdw_prep_deprep_slave_ports() cannot use the port interrupt to signal
> CP_SM completion because it is called while holding the bus lock, which
> blocks the alert handler from running.
> 
> Change to polling the PREPARESTATUS register and remove the
> infrastructure that was implemented for the previous interrupt waiting.

I am afraid the entire PORT_READY support is completely untested at the moment: all the existing codecs use the simpler state machine, e.g. 		

dpn[i].simple_ch_prep_sm = true;

So my main question is: how did you test this change? Is this on a platform already supported upstream? yes/no answer is fine, no details necessary.

I am also not fully clear on the locking issue. 

Is the problem that sdw_handle_slave_status() uses a mutex_lock(&bus->bus_lock), which is already held in sdw_prepare_stream

int sdw_prepare_stream(struct sdw_stream_runtime *stream)
{
[...]
	sdw_acquire_bus_lock(stream);

[...]
	ret = _sdw_prepare_stream(stream, update_params);

	sdw_release_bus_lock(stream);
	return ret;
}

so dealing with an ALERT status while doing pre-deprep would cause a self-inflicted deadlock? 

If yes, that's a more general problem that would need to be fixed. this lock is taken in ALL stream operations, not just prepare/deprepare.

If e.g. a jack detection was signaled during any stream reconfiguration, we would also not be able to deal with the information, would we?

the purpose of the lock in sdw_handle_slave_status() was to check if devices attach or fall-off the bus before handling their status. The command/control protocol is always operational so nothing prevents the interrupt from being handled.

There's also something odd about directly polling on the status bits. The status bits will be used to signal the ALERT condition which is transmitted to the host during PING frames. This solution would result in the host noticing an interrupt: host controllers typically have a sticky status where all changes in PING frames are detected and used as a trigger for interrupt processing. In this case the interrupt would still be handled, but the sdw_handle_slave_status() would be deferred until the stream prepare is complete, and at that point the interrupt processing would not see any sources. It's not illegal but it's a bit odd to cause empty interrupts to be handled. 

It might be a better solution to fix conflicts between stream reconfiguration and interrupts. I don't have a turn-key proposal but the suggested patch feels like a work-around.
maybe using mutex_is_locked()?

If we can't figure something out, then at least the PORT_READY mask should not be set, i.e. this code would need to be removed:


int sdw_configure_dpn_intr(struct sdw_slave *slave,
			   int port, bool enable, int mask)
{
...
	/* Set/Clear port ready interrupt mask */
	if (enable) {
		val |= mask;
		val |= SDW_DPN_INT_PORT_READY;
	} else {
		val &= ~(mask);
		val &= ~SDW_DPN_INT_PORT_READY;
	}

	ret = sdw_update(slave, addr, (mask | SDW_DPN_INT_PORT_READY), val);
}

> A new configuration field 'ch_prep_poll_us' is added to struct
> sdw_dpn_prop so that the peripheral driver may select a polling interval.
> If this is left at zero a default interval of 500 usec is used.

we already have a 'ch_prep_timeout' that's defined, do you need to redefine a new field? why not just read once at the end of that timeout? It's a prepare operation, there's no requirement to be fast, is there?

Those properties were supposed to be populated in platform firmware btw, we should try and limit what properties need to be set in a codec driver.

> +		prep_timeout_us = dpn_prop->ch_prep_timeout * USEC_PER_MSEC;

I also just noticed that we don't have a default for ch_prep_timeout, that's a bug.

> +		if (dpn_prop->ch_prep_poll_us)
> +			prep_poll_us = dpn_prop->ch_prep_poll_us;
> +		else
> +			prep_poll_us = SDW_DEFAULT_DP_PREP_POLL_US;

Thanks
-Pierre
