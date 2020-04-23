Return-Path: <SRS0=JLiH=6H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6EAC2BA19
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:03:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F3B22084D
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Vs1yfjhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3B22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D90CB168F;
	Thu, 23 Apr 2020 12:02:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D90CB168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587636195;
	bh=+XXteDLgurQ1y9mxT/o+a+imn5nfuclWzyZwUQoqn4M=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vs1yfjhMWccM1B/w3FNV7PQLW646U5nqmlsSdoVMDf48r3/ESEcnsB/MM45G8goOc
	 JusruiF9o0cdHB4bUnGLNB/i/cDsVHziMdA5yCnA4bPT6lAl+7Zb79WZZRFgF3ioIn
	 +oScCITCqt9tD0LDSjPdDM6xFEwJ+TlqVpDh2wgs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 620D3F8014A;
	Thu, 23 Apr 2020 12:02:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0A55F801EC; Thu, 23 Apr 2020 12:02:22 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9DF0F800FF
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2020 12:02:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9DF0F800FF
IronPort-SDR: zrvatOLMYN1Dwepjz+DJ5qZRFOMzi5BUFGtC0+ltVxjC0KzHzaqgpQwYXleTYtD1UeLeJ0txX3
 qrofyQNFwCBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2020 03:02:11 -0700
IronPort-SDR: Vqsf2Avgr6Wfgi4rsenScR4Wg0TvR4pCD5wR49N0kqpgdY0pC5aGkId9Ys9+sgB0A2K0EkSeII
 FuhHKI0ENMJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,306,1583222400"; d="scan'208";a="301179237"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by FMSMGA003.fm.intel.com with ESMTP; 23 Apr 2020 03:02:10 -0700
Date: Thu, 23 Apr 2020 13:02:09 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: hda: Always use jackpoll helper for jack update
 after resume
In-Reply-To: <s5hblnjxn7i.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.21.2004231245470.2957@eliteleevi.tm.intel.com>
References: <20200422203744.26299-1-tiwai@suse.de>
 <s5hblnjxn7i.wl-tiwai@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
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

Hey,

On Wed, 22 Apr 2020, Takashi Iwai wrote:

> On Wed, 22 Apr 2020 22:37:44 +0200, Takashi Iwai wrote:
> Also, Kai, it'd be appreciated if you can test whether it causes
> regression on Intel HDMI audio.  Currently I have no enough test
> machines due to lockdown, unfortunately.

sure thing. I did tests on a few machines with snd_hda_intel and also gave 
a test spin with SOF and seems to hold up just fine with both.

Br, Kai
