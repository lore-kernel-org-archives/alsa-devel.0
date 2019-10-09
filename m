Return-Path: <SRS0=0KZO=YC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F176ECE58C
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:19:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573E1206B6
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Oct 2019 19:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rvMsczDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573E1206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF4691607;
	Wed,  9 Oct 2019 21:19:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF4691607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570648793;
	bh=vXLkQ0km1y2d7DDEhxlU/zEOj5TfEDkpIJbkn1vcTrs=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rvMsczDX5gw5gOVgss5Syk071fKSL92T9hqpNbmPybq9rTVRif8xizme9cPfur4oP
	 +LF9ei2EaTbL5xDdPNb8yFVKzNYps7/kThNCkk06TA1W2AWRmI2PdqFc++GOa2EKSx
	 j84uyTgmk/W7CCewqmjwNLwrhkh5Uhssg2JsTXEw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C1F1F802BD;
	Wed,  9 Oct 2019 21:19:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27698F802BE; Wed,  9 Oct 2019 21:19:01 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67E11F800AE
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2019 21:18:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67E11F800AE
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Oct 2019 12:18:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,277,1566889200"; d="scan'208";a="345456225"
Received: from dmahalin-mobl.amr.corp.intel.com (HELO [10.252.134.224])
 ([10.252.134.224])
 by orsmga004.jf.intel.com with ESMTP; 09 Oct 2019 12:18:55 -0700
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
References: <20191009181356.GO2036@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e6539727-429d-8cd0-af01-d23a4b8af89b@linux.intel.com>
Date: Wed, 9 Oct 2019 14:16:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009181356.GO2036@sirena.org.uk>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Curtis Malainey <cujomalainey@google.com>
Subject: Re: [alsa-devel] [ANNOUNCE] 2019 Linux Audio miniconference
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



On 10/9/19 1:13 PM, Mark Brown wrote:
> Hi,
> 
> As in previous years we're going to have an audio miniconference so we can
> get together and talk through issues, especially design decisions, face to
> face.  This year's event will be held on October 31st in Lyon, France,
> the day after ELC-E.  This will be held at the Lyon Convention Center (the
> ELC-E venue) and will be free of charge to attend, generously
> sponsored by Intel.
> 
> Thus far for the agenda we have:
> 
>   - Use case management enhancements (Curtis)
>   - DSP framework integration (Liam?)
>   - Soundwire status (Pierre?)

I am unfortunately not going to make it this year due to conflicts.

I will repost the 50-odd SoundWire patches we have when Vinod is back at 
his desk. For now we have most of the issues ironed out, with all known 
race conditions sorted out and with audio streaming to/from SoundWire 
links on CometLake, IceLake and TigerLake, with 4 different codecs from 
Realtek supported. We are trying to clean-up the last suspend/resume 
issues in collaboration with Realtek.

The latest code is here if anyone is interested:

https://github.com/thesofproject/linux/tree/integration/soundwire-latest

The only big topic is the multi-cpu support. We will need to support 
playback synchronized on multiple amplifiers/speakers, and our plan was 
to create a dailink that connect 2 CPU dais (possibly dealing with 
different links) to 2 codec DAIs.

The other interesting topic is the likely mix of SoundWire, I2S and yes 
HDaudio links for some platforms. This will make the autodetection a bit 
complex, not to mention all the possible topology variants. Ideally we 
should limit this complexity by exposing different cards for the 
different links with Ranjani's work on MFD.

We are also planning to try and use the Up Extreme board which exposes 2 
SoundWire links on the 40-pin connector, this will make it simpler for 
developers to get access to an open SoundWire-enabled platform and 
extend the pool of codecs supported, as we did with Minnow and Up boards.

-Pierre
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
