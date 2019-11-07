Return-Path: <SRS0=BIVw=Y7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBD6C43331
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 23:29:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C692178F
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 23:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HTRh4Hne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C692178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94253166F;
	Fri,  8 Nov 2019 00:28:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94253166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573169374;
	bh=5fJvBpHd030S9Vwzch/08uXiQC4KaotZJIJffQ5O3fk=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HTRh4Hne1+x8VOz2mz0ulKVdVwNJl2sHARTeSlZQEVFtTUehPmwiwvnzohxykf+z0
	 qqAtA/xPXRyG8xIVIF7RJ6rkyNtx4WCYXCwF40JAzelvqKPsXs2UA+YHDfnqXKEOXW
	 6Enhww4oFYnhYP/Y4iyEVChybM5X2x2d610Sf/So=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1930DF80446;
	Fri,  8 Nov 2019 00:28:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC041F8049B; Fri,  8 Nov 2019 00:28:40 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75940F800F3
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2019 00:28:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75940F800F3
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Nov 2019 15:28:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,279,1569308400"; d="scan'208";a="213124556"
Received: from mabreu-mobl1.amr.corp.intel.com (HELO [10.252.134.231])
 ([10.252.134.231])
 by fmsmga001.fm.intel.com with ESMTP; 07 Nov 2019 15:28:30 -0800
To: Ross Zwisler <zwisler@google.com>, Bard Liao <bardliao@realtek.com>,
 Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>,
 Mark Brown <broonie@kernel.org>
References: <CAGRrVHz0LZOXWprAqR+_e59k+NQwiax7je4dSHf85yeHepHV+g@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c8816679-bbf2-acc1-afa5-57f1436bdaf0@linux.intel.com>
Date: Thu, 7 Nov 2019 17:28:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAGRrVHz0LZOXWprAqR+_e59k+NQwiax7je4dSHf85yeHepHV+g@mail.gmail.com>
Content-Language: en-US
Cc: Curtis Malainey <cujomalainey@google.com>, alsa-devel@alsa-project.org,
 Jacob Rasmussen <jacobraz@google.com>,
 Fletcher Woodruff <fletcherw@google.com>
Subject: Re: [alsa-devel] issue with jack detect using rt5645
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



On 11/7/19 4:31 PM, Ross Zwisler wrote:
> We are trying to get a piece of Google hardware which uses the rt5645
> driver working correctly with newer kernels (currently one based on
> the latest v4.14 stable), and noticed that the following commit:
> 
> commit 6b5da66322c5 ("ASoC: rt5645: read jd1_1 status for jd detection")
> 
> broke jack support for our device.  Basically with that patch we never
> correctly see a jack insertion event, and audio is never routed to the
> headphones.
> 
> With just that one patch reverted, things work correctly on our
> system.  The revert applies cleanly to linus/master.
> 
> Here is the series where that patch was originally upstreamed:
> 
> https://www.spinics.net/lists/alsa-devel/msg64331.html
> 
> If we reverted that patch upstream, would it break other devices (the
> "GDP Win" device?) that use the rt5645 driver?  If so, how would you
> recommend proceeding?
> 
> Does anyone have one of the "GDP Win" devices so we can test that and
> our device and make sure whatever solution we end up coming up with
> works for everyone?

there are all kinds of DMI quirks in sound/soc/codecs/rt5645.c, 4 
directly applicable to Chromebooks ('buddy', 'strago', 'Google Chrome', 
'Google Setzer')

Can you check if your device is listed in those quirks? it could be that 
either the settings are wrong or that we never supported it.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
