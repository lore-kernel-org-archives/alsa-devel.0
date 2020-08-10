Return-Path: <SRS0=hypa=BU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A4DC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:50:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B8E2080C
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y1ueVIhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B8E2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E543515F2;
	Mon, 10 Aug 2020 16:49:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E543515F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597071003;
	bh=z/qTRKpRhTokcNBCLrbXBZT5J5DkllLkdp3b5YFlTlc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y1ueVIhF8u6wZ1lnPcY0aB2wJ3PgrgvXwqTfDdb9QbUhHc+ylPrhm44k0kvWHMkwO
	 vgbBnfNiMweN3yrcf3AKjofFWAWqFIGnEFro5hD3L0RuyxKQq2EmFOeIKW/IZnHIo1
	 9NZOuroIQWdZHSNKfnfMNcoIdqV4zxLCvfbBg/I0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D869F800BC;
	Mon, 10 Aug 2020 16:49:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 257B5F8022B; Mon, 10 Aug 2020 16:49:11 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1712BF800BC
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2020 16:48:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1712BF800BC
IronPort-SDR: RUKqho47nMZ9MIveYLUhIRGMJaC0mOgpLHYhRWqNxkMPDHQCnue1XRhDIKgGZQCKeRzVcOu0ml
 3haXMrvnDefg==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="152757966"
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; d="scan'208";a="152757966"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 07:48:57 -0700
IronPort-SDR: sPxhP5EIq10KFl0PorOKef3k1jAAGJ4jpy2IkSFLRG03riif2UVQ1/Ga+OCA7EnIz2IXGhUMIC
 P/8Fz30HBmsA==
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; d="scan'208";a="438717754"
Received: from schen8-mobl.amr.corp.intel.com (HELO [10.212.235.58])
 ([10.212.235.58])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 07:48:56 -0700
Subject: Re: [PATCH] ASoC: SOF: delete repeated words in comments
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <20200808012156.10827-1-rdunlap@infradead.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <695a40ef-c7e3-d0dd-2604-3f8a1144b0a3@linux.intel.com>
Date: Mon, 10 Aug 2020 09:28:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200808012156.10827-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
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



On 8/7/20 8:21 PM, Randy Dunlap wrote:
> Drop the repeated words {that, the} in comments.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Randy.

> ---
>   sound/soc/sof/intel/cnl.c |    2 +-
>   sound/soc/sof/sof-audio.c |    2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20200807.orig/sound/soc/sof/intel/cnl.c
> +++ linux-next-20200807/sound/soc/sof/intel/cnl.c
> @@ -202,7 +202,7 @@ static int cnl_ipc_send_msg(struct snd_s
>   	 * IPCs are sent at a high-rate. mod_delayed_work()
>   	 * modifies the timer if the work is pending.
>   	 * Also, a new delayed work should not be queued after the
> -	 * the CTX_SAVE IPC, which is sent before the DSP enters D3.
> +	 * CTX_SAVE IPC, which is sent before the DSP enters D3.
>   	 */
>   	if (hdr->cmd != (SOF_IPC_GLB_PM_MSG | SOF_IPC_PM_CTX_SAVE))
>   		mod_delayed_work(system_wq, &hdev->d0i3_work,
> --- linux-next-20200807.orig/sound/soc/sof/sof-audio.c
> +++ linux-next-20200807/sound/soc/sof/sof-audio.c
> @@ -29,7 +29,7 @@ bool snd_sof_dsp_only_d0i3_compatible_st
>   				continue;
>   
>   			/*
> -			 * substream->runtime being not NULL indicates that
> +			 * substream->runtime being not NULL indicates
>   			 * that the stream is open. No need to check the
>   			 * stream state.
>   			 */
> 
