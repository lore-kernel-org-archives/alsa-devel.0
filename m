Return-Path: <SRS0=6VrY=KF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22742C433ED
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 10:58:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F7A6193A
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 10:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F7A6193A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F1BD16AF;
	Mon, 10 May 2021 12:57:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F1BD16AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620644318;
	bh=C9/I6oo9YBSSwKMkNh+iJ/6j0FeHUURLYK0GalZi72A=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c39EOUTLn86hf4fI8MZ78bNPxYE3OYYqyRGz3yG6t7y37dal7SH5TrLD4C4uwDghI
	 H6DsoyyJz09f5m6L8rqiBVeysToXVvvjCC7salqsXInNrfzxzRFwsjrdZRNjVAzvsN
	 KFYWE57cpEVFD01MVoocvkQLW/7ocamKGVkApZ6s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0D02F8020C;
	Mon, 10 May 2021 12:57:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4608F80240; Mon, 10 May 2021 12:57:45 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8698BF800B4
 for <alsa-devel@alsa-project.org>; Mon, 10 May 2021 12:57:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8698BF800B4
IronPort-SDR: AFhym31i9H8xzwE3u6KfwcagAyaW/4LMBEERgJjszisYsBxrGarg9CcRnCQZAp4HV17UFeE15i
 iDOAZxxpc7Ug==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="284649497"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; d="scan'208";a="284649497"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 03:57:32 -0700
IronPort-SDR: HnHmct7TUh4WaPUmbcRG7vgw6BcBlsPuR0mT4B95J8XeZ9oh4pJGNB4Gf6D7UzQrvUXcQX+VdQ
 ykg+vNymJLqQ==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; d="scan'208";a="436094109"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.237.180.87])
 ([10.237.180.87])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 03:57:31 -0700
Subject: Re: [PATCH] ALSA: hda: generic: Remove redundant assignment to dac
 and dacs[i]
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, perex@perex.cz
References: <1620643295-130162-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Message-ID: <959dfc79-cac1-0bb6-e725-874e7f7af0cf@linux.intel.com>
Date: Mon, 10 May 2021 12:57:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1620643295-130162-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org
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

On 5/10/2021 12:41 PM, Jiapeng Chong wrote:
> Variable dac and dacs[i] is set to zero, but this value is never read as
> it is overwritten or not used later on, hence it is a redundant assignment
> and can be removed.
> 
> Clean up the following clang-analyzer warning:
> 
> sound/pci/hda/hda_generic.c:1436:4: warning: Value stored to 'dac' is
> never read [clang-analyzer-deadcode.DeadStores].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   sound/pci/hda/hda_generic.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
> index b638fc2..cce1bf7 100644
> --- a/sound/pci/hda/hda_generic.c
> +++ b/sound/pci/hda/hda_generic.c
> @@ -1433,7 +1433,6 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
>   			path = snd_hda_add_new_path(codec, dac, pin, 0);
>   		}
>   		if (!path) {
> -			dac = dacs[i] = 0;
>   			badness += bad->no_dac;
>   		} else {
>   			/* print_nid_path(codec, "output", path); */
> 

Not entirely true... dacs is passed by pointer, so value assigned to it 
can be used somewhere else.
