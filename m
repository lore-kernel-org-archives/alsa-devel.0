Return-Path: <SRS0=ik9t=YS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37584CA9EBC
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 18:03:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C51A205F4
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 18:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bgcCCInt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C51A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA4091888;
	Fri, 25 Oct 2019 20:02:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA4091888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572026608;
	bh=ROK9p9pT11K5vgtIGD4R3rkVkfxRXiva0DDHU6W1YgY=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bgcCCIntxpAAKk5icIbfJ1KdFpUSWtT5E0Y7XPE5yDdWHb6+jvDjjW3dZlpnV4Xk0
	 s1i6ij/hylN+nfCIhP5LEyoaSMWTV8WkPrWNBIoePssTWlyVz1SAiSmg2XE8AgLlki
	 DbXdM7+ay3SWyY+MuHIOUmm3wqdBP9fxs2mUlSpQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1076CF80368;
	Fri, 25 Oct 2019 20:02:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5A15F8036F; Fri, 25 Oct 2019 20:02:35 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3C2DF80112
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2019 20:02:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3C2DF80112
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 11:02:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; d="scan'208";a="228987859"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by fmsmga002.fm.intel.com with ESMTP; 25 Oct 2019 11:02:28 -0700
Date: Fri, 25 Oct 2019 21:02:27 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <12c5e861-dd78-99cc-b16f-5ddc2ad0e33b@perex.cz>
Message-ID: <alpine.DEB.2.21.1910252050230.16459@zeliteleevi>
References: <20191025123038.19728-1-perex@perex.cz>
 <s5hk18tuhio.wl-tiwai@suse.de>
 <bce57a56-99d0-62d7-1d53-099a75349341@perex.cz>
 <s5h36fgvs0m.wl-tiwai@suse.de>
 <9403a6a7-9b7e-c2a4-5acf-50d6cbaea7c7@perex.cz>
 <s5hwocsucfp.wl-tiwai@suse.de>
 <83e4dc16-07e7-aafb-db43-01a89e31270b@perex.cz> <s5heez0oleh.wl-tiwai@suse.de>
 <12c5e861-dd78-99cc-b16f-5ddc2ad0e33b@perex.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: change 'HDMI/DP, pcm=' to 'HDMI/DP,
 pcm=' Jack control names
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Jaroslav and all,

On Fri, 25 Oct 2019, Jaroslav Kysela wrote:

> the single user. Another problem is that we are not able to review all those
> mistakes at the merge time. It is not a complain but a true fact.

but the strings are in kernel patches, so even if all UCM files don't 
go through the list, we can always review when the strings are added 
in kernel, right?

> I would be really curious what will happen when we change those strings ;-)

I can share some experiences that happen on Linux distros with Pulseaudio:

- if mixer control name is changed/missing that us used in 
  a UCM enable sequence, the enable sequence will fail and PA will
  not choose that device
	-> e.g. when wrong HDMI control names are in the UCM file, HDMI 
	output stops working
- if mixer control for a Jack is changed, PA will not listen
  for ALSA kctl events
	-> HDMI connection is silently missed and HDMI is not listed
	as a possible output

.. i.e. in both cases HDMI is essentially broken if you update to 
a kernel that updates the strings but don't update user-space in sync.

I wonder if one option would be to expose "legacy string" aliases,
allowing to make changes but keep existing user-space happy. With my HDMI 
codec change, the controls are simply different, so this was not an 
option and I had to opt for keeping the whole driver around.

Br, Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
