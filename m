Return-Path: <SRS0=4Ztp=5E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5924C4332E
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:18:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FFA72098B
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="opL8YIjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFA72098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4BA571761;
	Thu, 19 Mar 2020 14:17:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4BA571761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584623918;
	bh=D44rv6U13MUX4QhdQFGle9zPa2E15i/cY+1IqY4mMLI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=opL8YIjUP6MdZJSnzOrOhGII7sopuLVcFY4nQtzJYe+tateZjy0OQb9WYBQQKVdPQ
	 IpHqhtSUdLzxd5f/RGNJrMOI0cQLlBAIrCb6RN6kKmiKMAQLj5PEsErNYSQGBH0HVr
	 DizjN8U1grdvSZzjzhoBb206XGQ0BsTCLyrZmcTI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7F7FF80217;
	Thu, 19 Mar 2020 14:17:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 416FAF8022B; Thu, 19 Mar 2020 14:17:45 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0BDFF8012F
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2020 14:17:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0BDFF8012F
IronPort-SDR: gt3JloJGR1wG00vFx8eHkoXgCbtKHyoFzQfU1RpGvNntKICiuQO6DB92QhcNiqYYU+1IrIY6Pe
 nRT85frF2utw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2020 06:17:39 -0700
IronPort-SDR: 13+14NwKfODm3LUqECGN0X6N4/JeF1gSWFftIsTQQaHgh6TqEtdjX59Tpkus1Jmuk7BqQuHJLS
 B3SRkzWbrNrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,571,1574150400"; d="scan'208";a="245157334"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.128.140])
 ([10.249.128.140])
 by orsmga003.jf.intel.com with ESMTP; 19 Mar 2020 06:17:36 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To: Dominik Brodowski <linux@dominikbrodowski.net>,
 kuninori.morimoto.gx@renesas.com
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
 <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
 <20200319130049.GA2244@light.dominikbrodowski.net>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <4eb2859f-d1a9-e99b-28c3-54a9dc6f9d17@intel.com>
Date: Thu, 19 Mar 2020 14:17:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319130049.GA2244@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, curtis@malainey.com,
 linux-kernel@vger.kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
 tiwai@suse.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 liam.r.girdwood@linux.intel.com, broonie@kernel.org
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

On 2020-03-19 14:00, Dominik Brodowski wrote:
> On Wed, Mar 18, 2020 at 11:20:55PM +0100, Cezary Rojewski wrote:

>>
>> Thanks for quick reply. Revert of said commit fixes stream==NULL issue for
>> me. See if there were any changes in dmesg.
>> Will ask technicians to assist me on site tomorrow.
> 
> Have some good news now, namely that a bisect is complete: That pointed to
> 1272063a7ee4 ("ASoC: soc-core: care .ignore_suspend for Component suspend");
> therefore I've added Kuninori Morimoto to this e-mail thread.
> 
> Additionally, I have tested mainline (v5.6-rc6+ as of 5076190daded) with
> *both* 64df6afa0dab (which you suggested yesterday) and 1272063a7ee4
> reverted. And that works like a charm as well.
> 
> Hope this helps!
> 
> Thanks,
> 	Dominik
> 

To make everyone not miss a bit - I believe we had 2 issues here, even 
though that one may seem harmless from user perspective:

 From IPC logs indeed it looks like a redundant (additional) stream 
initialization has occurred - said redundant stream is destroyed right 
after it has been created, and only to be recreated yet again.. Can 
share the logs if required.

While hw_params() handled doubled init nicely, _reset and _free
did not (during on pcm_close()) -> secondary invokes attempted to RESET
and FREE stream despite it being destroyed long ago. With revert of
patch I had mentioned, no lines:

!!!	haswell-pcm-audio haswell-pcm-audio: warning: stream is NULL, no
stream to reset, ignore it.
!!!	haswell-pcm-audio haswell-pcm-audio: warning: stream is NULL, no
stream to free, ignore it.

should appear.

I'll focus now on the commits you found offending during your bisect. 
Thank you Dominik!

Czarek
