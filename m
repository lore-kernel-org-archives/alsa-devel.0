Return-Path: <SRS0=qqgH=3Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DB8C2D0DB
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:49:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A2622527
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 15:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UdMDK+Zl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A2622527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 81C5D10E;
	Mon, 27 Jan 2020 16:48:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 81C5D10E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580140170;
	bh=TD2sOsv5Pe6BZdsU8bzZMnA7Z4u1Vl11fDiF85pwHdg=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UdMDK+ZlUm1u8bCrFNRC09CJbcUAnTpbppsYjaZOUQuGebVdVRaIX48pEuChdXDfU
	 VcuRrs4Luw6OR/+TiuPI4BCBTF1nkI8zYOWjQwBO4ZGwYOfrwgDYoQ7Z3LiOOzNYhL
	 u2kOz1gXOgCOFYOOdTbHKnTDB9ADgJ8VV88UOh38=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F2C52F80218;
	Mon, 27 Jan 2020 16:48:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20F20F8021E; Mon, 27 Jan 2020 16:48:38 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D51BF80085
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2020 16:48:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D51BF80085
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jan 2020 07:38:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,370,1574150400"; d="scan'208";a="223273245"
Received: from vvaddepa-mobl.amr.corp.intel.com (HELO [10.252.204.5])
 ([10.252.204.5])
 by fmsmga008.fm.intel.com with ESMTP; 27 Jan 2020 07:38:02 -0800
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
References: <20200120160117.29130-1-kai.vehmanen@linux.intel.com>
 <20200120160117.29130-4-kai.vehmanen@linux.intel.com>
 <s5hpnfe2hvb.wl-tiwai@suse.de> <20200120171718.GG6852@sirena.org.uk>
 <alpine.DEB.2.21.2001201936540.2957@eliteleevi.tm.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <35b2748b-661b-3e63-eb71-fc44fced0deb@linux.intel.com>
Date: Mon, 27 Jan 2020 09:38:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001201936540.2957@eliteleevi.tm.intel.com>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>, cujomalainey@chromium.org,
 alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH v2 3/3] ALSA: hda/hdmi - add retry logic to
 parse_intel_hdmi()
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 1/20/20 11:43 AM, Kai Vehmanen wrote:
> Hi,
> 
> On Mon, 20 Jan 2020, Mark Brown wrote:
> 
>> On Mon, Jan 20, 2020 at 05:49:12PM +0100, Takashi Iwai wrote:
>>
>>> It seems that this felt out of Mark's hands, so I picked up now to my
>>> tree, as this doesn't seem depending on other changes.
>>
>> He only sent it on Thursday and Pierre hasn't reviewed any of this stuff
>> yet.
> 
> sorry for the confusion guys. I checked with Pierre and he preferred for
> this to be picked up by Mark directly. I noticed some rebase needed when
> applying on top of Mark's, so thus I resent the patches as v2.
> 
> We did have initial review at (although no approvals):
> https://github.com/thesofproject/linux/pull/1713
> 
> Maybe in future, better not to combine ASoC/SOF and generic HDA patches in
> same series, but rather send in pieces via the proper subtrees...?

Sorry about the confusion, I thought Takashi took all of the 3 patches, 
so didn't chime in, but only this one was applied while the 2 others are 
still in the review queue, so for the series

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
