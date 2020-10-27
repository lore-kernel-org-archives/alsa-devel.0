Return-Path: <SRS0=gpx6=EC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3418AC388F9
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:42:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D1B20735
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="veqdrI3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D1B20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6365B168A;
	Tue, 27 Oct 2020 12:41:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6365B168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603798921;
	bh=x5vBDAQA3vwASRaDE2A+sxJdjP48ablZBQzpW7Xycpo=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=veqdrI3iJZVrjmolQOyBGAisRXDRcdtA4IKKrDjfKO5XTS37vpbRXowsDTiMQJkqT
	 Yubjsg/Asf5tAcoW+mdOR1b7OgbH592nnHDxlhHdSj3DmNT9pFON3NR2b4wRvguloo
	 EZXs939OFi6wvCBCi4QWmTdbiMhX3JPg0j1ZXdqQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B276BF801D8;
	Tue, 27 Oct 2020 12:41:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23098F8020D; Tue, 27 Oct 2020 12:41:10 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EDB15F80086
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 12:41:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EDB15F80086
IronPort-SDR: Iw+7oGkvZ7Z9LXWjE49PWehU1+tP3oVOzdg9yiQg4pPH4RmKFQhKkd5RlwmqAMO3RQ5A7XYAiO
 j9ATMdERUzHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168163656"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; d="scan'208";a="168163656"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2020 04:41:04 -0700
IronPort-SDR: SUivjGOGsc0c2mmPKR5lmGTTCBFs/D170rHhrqy8P1w337Ch8cRtlYiR/V0I4x/W5Fu9YN0bCY
 IdkxspCNIPuA==
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; d="scan'208";a="525856545"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2020 04:41:02 -0700
Date: Tue, 27 Oct 2020 13:38:56 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2 3/4] ALSA: hda: Separate runtime and system suspend
In-Reply-To: <20201027054001.1800-4-kai.heng.feng@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2010271317430.864696@eliteleevi.tm.intel.com>
References: <20201027054001.1800-1-kai.heng.feng@canonical.com>
 <20201027054001.1800-4-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, tiwai@suse.com,
 kai.vehmanen@linux.intel.com, linux-kernel@vger.kernel.org
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

thanks, this looks like a good improvement! Some minor notes:

On Tue, 27 Oct 2020, Kai-Heng Feng wrote:

> Both pm_runtime_force_suspend() and pm_runtime_force_resume() have
> some implicit checks, so it can make code flow more straightfoward if we
> separate runtime and systemd suspend callbacks.

straightforward -> straightforward

and systemd? Maybe just "system suspend"? :)

> While at it, also remove AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP, as the
> original bug commit a6630529aecb ("ALSA: hda: Workaround for spurious
> wakeups on some Intel platforms") solves doesn't happen with this
> patch.

Hmm, so this was gone already with the v1 version (so not related to 
programming the WAKEEN when going to system suspend)?

> @@ -143,6 +143,7 @@ struct azx {
>  	unsigned int align_buffer_size:1;
>  	unsigned int region_requested:1;
>  	unsigned int disabled:1; /* disabled by vga_switcheroo */
> +	unsigned int prepared:1;

I wonder if "pm_prepared" would be better as ALSA API has a prepare method 
as well and this is not related. OTOH, if ok to Takashi, ok for me as 
well. 

> +	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &
> +		   ~STATESTS_INT_MASK);

This would fit to one line now. 

Br, Kai
