Return-Path: <SRS0=KPAB=BG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33FBC433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:33:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404152073E
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ONTV4rxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404152073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD5621699;
	Mon, 27 Jul 2020 17:32:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD5621699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595863984;
	bh=jVYPXyl1UvbHHRftNlO6dLTG3tvjeLtpTLNLtWQ0fi8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ONTV4rxe+lyD0kfuIT+JLsE32a43d4vUg0p+5ogGkgZkbQ4nDryaqEXVmz/fyd0JL
	 u8V/meazehIcbpr7/HZKMGCflmAZ7dNqVkFolhWOO9AxLsTjrKTJX/f/gfDobZ1sfI
	 n9I8ZcsD+PqjF5oBdUDB9Qy+1+pzwwsghf4pwGOU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3EFC7F80171;
	Mon, 27 Jul 2020 17:32:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD53DF801D9; Mon, 27 Jul 2020 17:32:12 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57870F8013C
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 17:32:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57870F8013C
IronPort-SDR: YFHeDkem1gqW7+SKFo9U3ccqyyNtrWNoOLBatibRQsvUsrgcBbiQsYglFdPEh1Qbp71fzirqdo
 qowTJOF1zncQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="169154637"
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; d="scan'208";a="169154637"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2020 08:31:59 -0700
IronPort-SDR: Kym2xbdqrRFyklcNQIA6wGe9KaMBLbQw4shEg/IB13YOgTm3UFBoLS/wxAhlBYTD01Izv8f6mk
 WgPFz2caVWGg==
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; d="scan'208";a="464099679"
Received: from pdewan-mobl1.amr.corp.intel.com (HELO [10.255.228.220])
 ([10.255.228.220])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2020 08:31:58 -0700
Subject: Re: [PATCH v3 00/10] ASoC: qdsp6: add gapless compressed audio support
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org
References: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5f3e6f81-965e-d7e2-bd93-edb54f72e478@linux.intel.com>
Date: Mon, 27 Jul 2020 10:24:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, tiwai@suse.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, vkoul@kernel.org
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



On 7/27/20 4:37 AM, Srinivas Kandagatla wrote:
> This patchset adds gapless compressed audio support on q6asm.
> Gapless on q6asm is implemented using 2 streams in a single q6asm session.
> 
> First few patches such as stream id per each command, gapless flags
> and silence meta data are for preparedness for adding gapless support.
> Last patch implements copy callback to allow finer control over buffer offsets,
> specially in partial drain cases.
> 
> This patchset is tested on RB3 aka DB845c platform.
> 
> This patchset as it is will support gapless however QDSP can also
> support switching decoders on a single stream. Patches to support such feature
> are send in different patchset which involves adding generic interfaces.
> 
> Thanks,
> srini

I've run out of comments :-)

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> Changes since v2:(mostly suggested by Pierre)
> - removed unnessary kernel style comments,
> - moved TIMESTAMP flag to respective patch.
> - move preparatory code from gapless support patch to new one.
> - fix subject prefix of one patch.
> - add comments to clarify valid stream_ids
> 
> Srinivas Kandagatla (10):
>    ASoC: q6asm: rename misleading session id variable
>    ASoC: q6asm: make commands specific to streams
>    ASoC: q6asm: use flags directly from q6asm-dai
>    ASoC: q6asm: add length to write command token
>    ASoC: q6asm: add support to remove intial and trailing silence
>    ASoC: q6asm: add support to gapless flag in q6asm open
>    ASoC: q6asm-dai: add next track metadata support
>    ASoC: q6asm-dai: prepare set params to accept profile change
>    ASoC: q6asm-dai: add gapless support
>    ASoC: q6asm-dai: add support to copy callback
> 
>   sound/soc/qcom/qdsp6/q6asm-dai.c | 414 +++++++++++++++++++++++--------
>   sound/soc/qcom/qdsp6/q6asm.c     | 169 +++++++++----
>   sound/soc/qcom/qdsp6/q6asm.h     |  49 ++--
>   3 files changed, 469 insertions(+), 163 deletions(-)
> 
