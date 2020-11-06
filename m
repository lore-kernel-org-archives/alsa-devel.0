Return-Path: <SRS0=gYtK=EM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066C9C2D0A3
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2020 22:32:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC192071A
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2020 22:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vLcvjZk2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fn6oKQaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC192071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78BA8168C;
	Fri,  6 Nov 2020 23:32:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78BA8168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604701972;
	bh=uB/Oj+Oj5km57AYy2yaswjARG7FK+EOWgqEe2cVv4qY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vLcvjZk2A1mQhQ06d5xPsktI2S/qxtzdXwisLKFJFC+dbvH4ZV5iGawWaEfq0LqUF
	 QUE7x3m9na8orrhNBlonSuZ7yjvjLP5fsGh3OV7T8dMvSd7nzHW1gQk4HEhNrYPbVX
	 9nylwPxVQYBxR7b+A/Px9L3IDfbE0Gw5eddcws9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE31FF80247;
	Fri,  6 Nov 2020 23:31:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76ED3F80234; Fri,  6 Nov 2020 23:31:57 +0100 (CET)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE61AF80150;
 Fri,  6 Nov 2020 23:31:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE61AF80150
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="Fn6oKQaK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=uKFp6ndH5gt97JZMTQlnD2RC9vnO3OIFv4HmGm7a2e4=; b=Fn6oKQaK7vWLVZGa5Y+vMLjcC3
 Xd70zDJFJ1djl7SvZL0cpf9YV4Z3sTJaUBJVnp9MKc3omKtXSOa98pCk1CgKbfE0utgIJXPAXkCxV
 zMU6Ysxye5xQxqZq7w6U4li7hRMgZyThYBrkSVST/mrI0gWGHzEI9eviMrsyzgMaywUbpRosFlXrH
 7lHmfCkjCf5ymOap1etR2B9Htkha0CX+/ABFWji7i4Wrqmy+1qpM+PtluPjE7eOJ4ePvQlA/AuVQR
 VmhaDw1kHAvfFkTcnbDHOsl8VdonN8e88XmWbQiKquXhSHv4bU+U2hmr3KVKNxfBXgsPFxeF86v1v
 FXzVntrA==;
Received: from [2601:1c0:6280:3f0::a1cb]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbAGn-0007ZG-BZ; Fri, 06 Nov 2020 22:31:45 +0000
Subject: Re: [Sound-open-firmware] linux-next: Tree for Nov 6
 (sound/soc/sof/sof-pci-dev.o)
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20201106171834.64e4d6d5@canb.auug.org.au>
 <0a66a2b1-85b6-3515-47f4-2e861b991386@infradead.org>
 <7505ed68-f12b-d1d9-12e5-f8ae34a74ebd@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0e8f0a8b-60c4-d146-90a2-a972d1748a4c@infradead.org>
Date: Fri, 6 Nov 2020 14:31:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7505ed68-f12b-d1d9-12e5-f8ae34a74ebd@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Baluta <daniel.baluta@nxp.com>, sound-open-firmware@alsa-project.org
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

On 11/6/20 12:53 PM, Pierre-Louis Bossart wrote:
> 
>> on x86_64:
>>
>> ld: sound/soc/sof/sof-pci-dev.o: in function `sof_pci_probe':
>> sof-pci-dev.c:(.text+0x5c): undefined reference to `snd_intel_dsp_driver_probe'
>>
>>
>> Full randconfig file is attached.
> 
> Nice catch, thanks Randy! Looks like we put the select SND_INTEL_DSP_CONFIG in the wrong place, it's not dependent on the HDaudio link being selected. Clearly a bug we've had for a while.
> 
> The diff below makes the error go away but I have to run it past folks who are already enjoying their week-end. Will follow-up next week with a proper fix.

Works for me. You can have an Ack if you use this patch.
Thanks.
Acked-by: Randy Dunlap <rdunlap@infradead.org>

> diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
> index a066e08860cb..5bfc2f8b13b9 100644
> --- a/sound/soc/sof/intel/Kconfig
> +++ b/sound/soc/sof/intel/Kconfig
> @@ -271,6 +271,7 @@ config SND_SOC_SOF_JASPERLAKE
> 
>  config SND_SOC_SOF_HDA_COMMON
>         tristate
> +       select SND_INTEL_DSP_CONFIG
>         select SND_SOC_SOF_INTEL_COMMON
>         select SND_SOC_SOF_HDA_LINK_BASELINE
>         help
> @@ -330,7 +331,6 @@ config SND_SOC_SOF_HDA
>         tristate
>         select SND_HDA_EXT_CORE if SND_SOC_SOF_HDA_LINK
>         select SND_SOC_HDAC_HDA if SND_SOC_SOF_HDA_AUDIO_CODEC
> -       select SND_INTEL_DSP_CONFIG
>         help
>           This option is not user-selectable but automagically handled by
>           'select' statements at a higher level
> 
> 


-- 
~Randy
