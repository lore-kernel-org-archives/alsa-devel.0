Return-Path: <SRS0=Rjjp=GQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD21C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 08:40:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6EC123356
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 08:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EC123356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C8C016EA;
	Wed, 13 Jan 2021 09:39:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C8C016EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610527245;
	bh=gNk8YtfAr6BS/7aY8N9rTnfuqu++fHdTS821z4IB40Y=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rVnY18Vwa8pH7MjuaH1qaV+eZEYI4tZCHCraXhgCTUnvP3t+RwlXP/oYFL+DvF2hn
	 JHXMsVA1K0mVYyxbdsfI+L7JP2OAqm/xZZcxy4jV0zXw7M2k3QGkoBX0sfJK3WsyoV
	 //Xx050Q8/rz0TRIcwixwi09pNOotglF9+nydfQY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2688F8016D;
	Wed, 13 Jan 2021 09:39:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A0EAF8016D; Wed, 13 Jan 2021 09:39:49 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18F70F80085;
 Wed, 13 Jan 2021 09:39:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18F70F80085
IronPort-SDR: pGsAV7XEa8L6knMdYnNSbob51kOgiWc+2OXuF4/bn7fUGi3gN12U2r2qSiyVqGiukrfoL+/EWI
 klNC+ckFoC9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="178263621"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; d="scan'208";a="178263621"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 00:39:32 -0800
IronPort-SDR: y6c/uPMlHWU9i8L6dyLaduYNUjuU3S2kRoIXIr/sJfBiIbfWdEm4uJVPTAkDrACCwaLPpAaBUv
 FYPYQ0WaOB6A==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; d="scan'208";a="353374255"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 00:39:28 -0800
Date: Wed, 13 Jan 2021 10:36:25 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v4 3/3] ASoC: SOF: Intel: hda: Avoid checking jack on
 system suspend
In-Reply-To: <20210112181128.1229827-3-kai.heng.feng@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2101130932480.864696@eliteleevi.tm.intel.com>
References: <20210112181128.1229827-1-kai.heng.feng@canonical.com>
 <20210112181128.1229827-3-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: pierre-louis.bossart@linux.intel.com,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 kai.vehmanen@linux.intel.com, open list <linux-kernel@vger.kernel.org>,
 tiwai@suse.com, Keyon Jie <yang.jie@linux.intel.com>, lgirdwood@gmail.com,
 ranjani.sridharan@linux.intel.com, broonie@kernel.org,
 Payal Kshirsagar <payalskshirsagar1234@gmail.com>, daniel.baluta@nxp.com,
 Marcin Rajwa <marcin.rajwa@linux.intel.com>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE SOF DRIVERS"
 <sound-open-firmware@alsa-project.org>
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

Hi,

On Wed, 13 Jan 2021, Kai-Heng Feng wrote:

> System takes a very long time to suspend after commit 215a22ed31a1
> ("ALSA: hda: Refactor codec PM to use direct-complete optimization"):
[...]
> [  321.262505] snd_hda_codec_realtek ehdaudio0D0: Unable to sync register 0x2b8000. -5
> [  328.426919] snd_hda_codec_realtek ehdaudio0D0: Unable to sync register 0x2b8000. -5
> [  329.490933] ACPI: EC: interrupt blocked
> 
> That commit keeps the codec suspended during the system suspend. However,
> mute/micmute LED will clear codec's direct-complete flag by
> dpm_clear_superiors_direct_complete().

thanks Kai-Heng. This indeed explains why the regression is only seen on 
some systems (those with mute/micmute LED).

> This doesn't play well with SOF driver. When its runtime resume is
> called for system suspend, hda_codec_jack_check() schedules
> jackpoll_work which uses snd_hdac_is_power_on() to check whether codec

The commit explanation is a bit long, but this is indeed the problem. 
jackpoll_work() is common code (also used by snd-hda-intel) and SOF should 
align to snd-hda-intel and not call this directly to check jack status,
and especially not when going to system suspend.

There are a lot of details related to exact conditions when this problem 
triggers, but in the end, this is the main point.
 
> When direct-complete path is taken, snd_hdac_is_power_on() returns true
> and hda_jackpoll_work() is skipped by accident. So this is still not
> correct.

This doesn't really affect correctness of the patch, but I'm not sure if 
"accident" is the best characterization. This just explains why the bug 
was not hit in all cases.

snd_hdac_is_power_on() is called in a few places:
 - hda_jackpoll_work()
 - snd_hda_bus_reset_codecs()
 - snd_hda_update_power_acct()

In first two, the current logic seems appropriate (if runtime-pm is 
disabled, the action guarded by is_power_on() should not be taken). The 
third case seems suspicious and not sure if current is_power_on()
is appropriate.

So it's not quite clear whether hdaudio.h:snd_hdac_is_power_on() is
wrong or not. But that's now a separate discussion to have, and not 
related to this patchset anymore.

> Because devices suspend in reverse order (i.e. child first), it doesn't
> make much sense to resume an already suspended codec from audio
> controller. So avoid the issue by making sure jackpoll isn't used in
> system PM process.

The commit explanation is a bit long, but it is probably useful to have 
the background included. 

For the whole series:

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Br, Kai
