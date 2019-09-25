Return-Path: <SRS0=mf6l=XU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BF0C432C2
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:50:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DBF21D7E
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Sep 2019 14:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S809jGCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DBF21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 551E116FF;
	Wed, 25 Sep 2019 16:49:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 551E116FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569423033;
	bh=9B9BQuWYi3vl7QNOJntO8cWSZlvuVRXKkwnjfQJd24Q=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S809jGCXb9KR0R1SdTW3FtU5DbSROo4vwfT9UGNtTIhadEY7H/6oVDObElw+4xgt3
	 fMyQqKWrQTbJup8mULIXpltwZwFF3vEU7PziAdQLo3oO0sz57ncCAISSKsEMk3qtZH
	 PAm4QCjZXH8tfwYIurYMDUEg7FWxwEX1zfFTSawc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D89A8F80323;
	Wed, 25 Sep 2019 16:49:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4B78F8044C; Wed, 25 Sep 2019 16:49:41 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E47BF802BD
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2019 16:49:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E47BF802BD
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Sep 2019 07:49:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,548,1559545200"; d="scan'208";a="390232928"
Received: from igoley-mobl.amr.corp.intel.com (HELO [10.251.141.13])
 ([10.251.141.13])
 by fmsmga006.fm.intel.com with ESMTP; 25 Sep 2019 07:49:28 -0700
To: Daniel Baluta <daniel.baluta@gmail.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>
References: <CAEnQRZD6VsaKbjP1FaBMk5iT2jkk=baPUixVyWMNoqqRXM9hhw@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <af8332a5-83f3-27a3-8202-7e5fee9483c3@linux.intel.com>
Date: Wed, 25 Sep 2019 09:49:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEnQRZD6VsaKbjP1FaBMk5iT2jkk=baPUixVyWMNoqqRXM9hhw@mail.gmail.com>
Content-Language: en-US
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [alsa-devel] About soc_check_tplg_fes
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



On 9/25/19 8:25 AM, Daniel Baluta wrote:
> Hi all,
> 
> In function soc_check_tplg_fes (sound/soc/soc-core.c)
> there is this code:
> 
>      for_each_card_prelinks(card, i, dai_link) {
> 
>          /* ignore this FE */
>          if (dai_link->dynamic) {
>              dai_link->ignore = true;
>              continue;
>          }
>          dev_info(card->dev, "info: override FE DAI link %s\n",
>              card->dai_link[i].name);
> 
> So, we ignore any FE DAI link but then the info message says the contrary.
> 
> Any idea?

Yes, there a couple of such BE/FE inversions in comments, likely 
copy/paste and typos. I just saw some earlier this week in the trigger 
error messages, e.g.

	err = dpcm_be_dai_trigger(fe, stream, SNDRV_PCM_TRIGGER_STOP);
	if (err < 0)
		dev_err(fe->dev,"ASoC: trigger FE failed %d\n", err);


We should really look for all comments with 'FE' or 'BE' and clean this up.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
