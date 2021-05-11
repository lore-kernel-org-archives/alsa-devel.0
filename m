Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B33C43460
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 12:23:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5562C6191A
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 12:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5562C6191A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C83D217C4;
	Tue, 11 May 2021 14:22:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C83D217C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620735815;
	bh=X8uCfoXChvJt+A61wxP97/Duyh0eA1PLMqEuUrFJZmg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hBCQY6+yYPJKkkrgsvSdNVwvQvIIqfUrF0g/h52wB+yXJYulazEcglrSKqxVUQoCx
	 MBWfvctm9veQ+HKGBszt4tm3YKd0S5aFYrRQGH8uhiXYRJQwzt7+G/pn65V9yc4SAQ
	 XfXqI/HT85IzqdhOPteYoruYrnG/779PBNd4Mwnw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED951F80245;
	Tue, 11 May 2021 14:22:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28E9EF80279; Tue, 11 May 2021 14:22:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD2AAF80129
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 14:22:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD2AAF80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kJNvb65u"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A26D36188B;
 Tue, 11 May 2021 12:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620735758;
 bh=X8uCfoXChvJt+A61wxP97/Duyh0eA1PLMqEuUrFJZmg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kJNvb65uBKAwOunAlm64YwGcjt1VsoXbJy7plw3KN8BZIhu/GAbs2Fl3KVDzaVqzu
 ze5l3e1Dxv/AJywjnglBXsRa0Z3pMhx3HaRkeN87wDOi6l3jvl+k3Iexdyk4lT19sI
 K80HKSDNG8inxdjNi5qjzlOT6H9lcX+F1pDaydJMfh+uw+iv0nXCEFUgyyrXjbgOVZ
 lmBJJWF8/x981ZJeq6QGro7mgMQSDtrspB7WRnm8Dwk6XHqqjNFrFZXkoHzwZiCcTV
 NFELAoINlYkqFY0KXTVUEg2lUwumP393QaOU/SAzwiHN9Z0b7vF8qjdTTg41vudYZg
 ZIqUhrCi9nUKg==
Date: Tue, 11 May 2021 17:52:34 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [RESEND PATCH 0/4] soundwire: only use CLOCK_STOP_MODE0 and
 handle -ENODATA errors in clock stop/start sequences
Message-ID: <YJp3CvCLt/xWDxgr@vkoul-mobl.Dlink>
References: <20210511030048.25622-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511030048.25622-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 hui.wang@canonical.com, sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
 bard.liao@intel.com
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

On 11-05-21, 11:00, Bard Liao wrote:
> Existing devices and implementations only support the required
> CLOCK_STOP_MODE0. All the code related to CLOCK_STOP_MODE1 has not
> been tested and is highly questionable, with a clear confusion between
> CLOCK_STOP_MODE1 and the simple clock stop state machine.
> 
> This patch removes all usages of CLOCK_STOP_MODE1 - which has no
> impact on any solution - and fixes the use of the simple clock stop
> state machine. The resulting code should be a lot more symmetrical and
> easier to maintain.
> 
> Note that CLOCK_STOP_MODE1 is not supported in the SoundWire Device
> Class specification so it's rather unlikely that we need to re-add
> this mode later.
> 
> If a device lost sync and can no longer ACK a command, it may not be
> able to enter a lower-power state but it will still be able to resync
> when the clock restarts. In those cases, we want to continue with the
> clock stop sequence.
> 
> This patch modifies the behavior during clock stop sequences to only
> log errors unrelated to -ENODATA/Command_Ignored. The flow is also
> modified so that loops continue to prepare/deprepare other devices
> even when one seems to have lost sync.
> 
> When resuming the clocks, all issues are logged with a dev_warn(),
> previously only some of them were checked. This is the only part that
> now differs between the clock stop entry and clock stop exit
> sequences: while we don't want to stop the suspend flow, we do want
> information on potential issues while resuming, as they may have
> ripple effects.
> 
> For consistency the log messages are also modified to be unique and
> self-explanatory. Errors in sdw_slave_clk_stop_callback() were
> removed, they are now handled in the caller.

Applied, thanks

-- 
~Vinod
